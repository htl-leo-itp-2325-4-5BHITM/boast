package it.boast.repository;

import it.boast.dto.post.PostDTO;
import it.boast.dto.post.type.poll.Poll_PostAnswerDTO;
import it.boast.dto.post.type.poll.Poll_PostDTO;
import it.boast.dto.post.type.poll.Poll_PostDetailDTO;
import it.boast.dto.post.type.poll.Poll_TypeInfoDTO;
import it.boast.model.post.Post;
import it.boast.model.post.PostTypes;
import it.boast.model.post.type.poll.Poll_Post;
import it.boast.model.post.type.poll.Poll_PostAnswer;
import it.boast.model.post.type.poll.Poll_PostDetail;
import it.boast.model.user.BoastUser;
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
        Post post = entityManager.find(Post.class, postId);
        entityManager.remove(post);
    }

    public PostDTO getPost(Long postId) {
        Post post = entityManager.find(Post.class, postId);
        switch (post.getPostType()) {
            case POLL -> {
                List<Poll_PostAnswerDTO> postAnswerDTOS = new LinkedList<>();
                for (Poll_PostAnswer postAnswer: ((Poll_Post) post).getPollAnswers()) {
                    postAnswerDTOS.add(new Poll_PostAnswerDTO(postAnswer.getPoll_answerId(), postAnswer.getTitle()));
                }
                Poll_TypeInfoDTO typeInfoDTO = new Poll_TypeInfoDTO(PostTypes.POLL.name(), postAnswerDTOS);
                List<Poll_PostDetailDTO> postDetailDTOS = new LinkedList<>();
                for (Poll_PostDetail postDetail: ((Poll_Post) post).getPostDetails()) {
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
                        typeInfoDTO,
                        postDetailDTOS);
            }
        }
        throw new IllegalArgumentException();
    }

    public List<PostDTO> getPostsAsList() {
        List<Long> postIds = entityManager.createQuery("select p.id from Post p", Long.class).getResultList().stream().toList();
        List<PostDTO> posts = new LinkedList<>();
        for (Long id :postIds) {
            posts.add(this.getPost(id));
        }
        return posts;
    }

    public void clearList() {
        entityManager.createQuery("delete from Post").executeUpdate();
        entityManager.createQuery("delete from PostDetail").executeUpdate();
    }

    //<editor-fold desc="POLL">
    public void createPollPost(Poll_PostDTO postDTO) {
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
    }

    public void addPollPostDetails(Poll_PostDetailDTO postDetailDTO) {
        BoastUser user = entityManager.find(BoastUser.class, postDetailDTO.getCreator());
        Post post = entityManager.find(Post.class, postDetailDTO.getPostId());
        Poll_PostAnswer postAnswer = entityManager.find(Poll_PostAnswer.class, postDetailDTO.getPollAnswer());
        if (user == null || post == null || postAnswer == null) throw new IllegalArgumentException();

        entityManager.persist(new Poll_PostDetail(postDetailDTO, user, (Poll_Post) post, postAnswer));
    }
    //</editor-fold>
}
