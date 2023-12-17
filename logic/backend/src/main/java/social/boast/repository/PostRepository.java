package social.boast.repository;

import social.boast.dto.post.PostDTO;
import social.boast.dto.post.type.poll.Poll_PostAnswerDTO;
import social.boast.dto.post.type.poll.Poll_PostDTO;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.dto.post.type.poll.Poll_TypeInfoDTO;
import social.boast.model.Status;
import social.boast.model.post.Post;
import social.boast.model.post.PostType;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.poll.Poll_PostAnswer;
import social.boast.model.post.type.poll.Poll_PostDetail;
import social.boast.model.user.BoastUser;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

import java.util.LinkedList;
import java.util.List;

@ApplicationScoped
public class PostRepository {

    @Inject
    EntityManager entityManager;

    public PostRepository(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void removePost(Long postId) {
        try {
            entityManager.remove(entityManager.find(Post.class, postId));
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException();
        }

    }

    public PostDTO getPost(Long postId) {
        Post post = entityManager.find(Post.class, postId);
        if (post != null) {
            switch (post.getPostType()) {
                case POLL -> {
                    List<Poll_PostAnswerDTO> postAnswerDTOS = new LinkedList<>();
                    for (Poll_PostAnswer postAnswer : ((Poll_Post) post).getPollAnswers()) {
                        postAnswerDTOS.add(new Poll_PostAnswerDTO(postAnswer.getPoll_answerId(), postAnswer.getTitle()));
                    }
                    Poll_TypeInfoDTO typeInfoDTO = new Poll_TypeInfoDTO(postAnswerDTOS);
                    List<Poll_PostDetailDTO> postDetailDTOS = new LinkedList<>();
                    for (Poll_PostDetail postDetail : ((Poll_Post) post).getPostDetails()) {
                        postDetailDTOS.add(new Poll_PostDetailDTO(
                                postDetail.getPostDetailsId(),
                                postDetail.getCreatedOn(),
                                postDetail.getCreator().getUserId(),
                                post.getPostId(),
                                postDetail.getPollAnswer().getPoll_answerId()));
                    }
                    return new Poll_PostDTO(
                            post.getPostId(),
                            post.getCreatedOn(),
                            post.getTitle(),
                            post.getDefinition(),
                            post.getCreator().getUserId(),
                            post.getStatus().name(),
                            PostType.POLL.name(),
                            typeInfoDTO,
                            postDetailDTOS);
                }
            }
        }
        throw new IllegalArgumentException();
    }

    public List<PostDTO> getPostsAsList() {
        try {
            List<Long> postIds = entityManager.createQuery("select p.id from Post p", Long.class).getResultList().stream().toList();
            List<PostDTO> posts = new LinkedList<>();
            for (Long id : postIds) {
                posts.add(this.getPost(id));
            }
            return posts;
        } catch (Exception e) {
            throw new IllegalArgumentException();
        }

    }

    public void updateStatus(Long id, Status status) {
        try {
            Post post = entityManager.find(Post.class, id);
            post.setStatus(status);
        } catch (Exception e) {
            throw new IllegalArgumentException();
        }
    }

    //<editor-fold desc="POLL">
    public void createPollPost(Poll_PostDTO postDTO) {
        try {
            BoastUser user = entityManager.find(BoastUser.class, postDTO.getCreator());
            if (user == null) throw new IllegalArgumentException();

            Poll_Post post = new Poll_Post(postDTO, user);
            List<Poll_PostAnswer> postAnswers = new LinkedList<>();
            for (Poll_PostAnswerDTO postAnswerDTO : postDTO.getTypeInfo().getPollAnswers()) {
                Poll_PostAnswer postAnswer = new Poll_PostAnswer(post, postAnswerDTO.getTitle());
                postAnswers.add(postAnswer);
                entityManager.persist(postAnswer);
            }
            entityManager.persist(post);
        } catch (Exception e) {
            throw new IllegalArgumentException();
        }

    }
    //</editor-fold>
}
