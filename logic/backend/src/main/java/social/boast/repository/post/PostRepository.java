package social.boast.repository.post;

import io.quarkus.hibernate.orm.panache.PanacheRepository;
import social.boast.dto.post.PostDTO;
import social.boast.dto.post.type.poll.Poll_PostAnswerDTO;
import social.boast.dto.post.type.poll.Poll_PostDTO;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.dto.post.type.poll.Poll_TypeInfoDTO;
import social.boast.dto.post.type.text.Text_PostDTO;
import social.boast.dto.post.type.text.Text_PostDetailDTO;
import social.boast.model.post.PostStatus;
import social.boast.model.post.Post;
import social.boast.model.post.PostType;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.poll.Poll_PostAnswer;
import social.boast.model.post.type.poll.Poll_PostDetail;
import social.boast.model.post.type.text.Text_Post;
import social.boast.model.post.type.text.Text_PostDetail;
import social.boast.model.user.BoastUser;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import social.boast.repository.user.UserRepository;

import java.util.LinkedList;
import java.util.List;

@ApplicationScoped
public class PostRepository implements PanacheRepository<Post> {

    @Inject
    UserRepository userRepository;

    public void removePost(Long postId) {
        try {
            deleteById(postId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException();
        }

    }

    public Post getPost(Long id) {
        return findById(id);
    }

    public PostDTO getPostDTO(Long postId) {
        Post post = findById(postId);
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
                                postDetail.getCreator().getUsername(),
                                post.getPostId(),
                                postDetail.getPollAnswer().getPoll_answerId()));
                    }
                    return new Poll_PostDTO(
                            post.getPostId(),
                            post.getCreatedOn(),
                            post.getTitle(),
                            post.getDefinition(),
                            post.getCreator().getUserId(),
                            post.getCreator().getUsername(),
                            post.getStatus().name(),
                            PostType.POLL.name(),
                            typeInfoDTO,
                            postDetailDTOS);
                }
                case TEXT -> {
                    System.out.println(post.getPostId());
                    List<Text_PostDetailDTO> postDetailDTOS = new LinkedList<>();
                    for (Text_PostDetail postDetail : ((Text_Post) post).getPostDetails()) {
                        postDetailDTOS.add(new Text_PostDetailDTO(
                                postDetail.getPostDetailsId(),
                                postDetail.getCreatedOn(),
                                postDetail.getCreator().getUserId(),
                                postDetail.getCreator().getUsername(),
                                post.getPostId(),
                                postDetail.getText()));
                    }
                    return new Text_PostDTO(post.getPostId(),
                            post.getCreatedOn(),
                            post.getTitle(),
                            post.getDefinition(),
                            post.getCreator().getUserId(),
                            post.getCreator().getUsername(),
                            post.getStatus().name(),
                            PostType.TEXT.name(),
                            postDetailDTOS);
                }
            }
        }
        throw new IllegalArgumentException();
    }

    public List<Long> getPostIds() {
        return listAll().stream().map(Post::getPostId).toList();
    }

    public void updateStatus(Long id, PostStatus status) {
        Post post = findById(id);
        if (post == null) throw new IllegalArgumentException();
        post.setStatus(status);
    }

    //<editor-fold desc="POLL">
    public void createPollPost(Poll_PostDTO postDTO) {
        BoastUser user = userRepository.getUser(postDTO.getCreatorId());
        if (user == null) throw new IllegalArgumentException();

        Poll_Post post = new Poll_Post(postDTO, user);
        for (Poll_PostAnswerDTO postAnswerDTO : postDTO.getTypeInfo().getPollAnswers()) {
            Poll_PostAnswer postAnswer = new Poll_PostAnswer(post, postAnswerDTO.getTitle());
            getEntityManager().persist(postAnswer);
        }
        persist(post);
    }
    //</editor-fold>

    //<editor-fold desc="TEXT">
    public void createTextPost(Text_PostDTO postDTO) {
        BoastUser user = userRepository.getUser(postDTO.getCreatorId());
        if (user == null) throw new IllegalArgumentException();

        Text_Post post = new Text_Post(postDTO, user);
        persist(post);
    }
    //</editor-fold>
}
