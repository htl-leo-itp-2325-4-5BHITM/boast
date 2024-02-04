package social.boast.repository.post;

import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.dto.post.type.text.Text_PostDetailDTO;
import social.boast.model.post.PostDetail;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.poll.Poll_PostAnswer;
import social.boast.model.post.type.poll.Poll_PostDetail;
import social.boast.model.post.type.text.Text_Post;
import social.boast.model.post.type.text.Text_PostDetail;
import social.boast.model.user.BoastUser;
import social.boast.repository.user.UserRepository;

@ApplicationScoped
public class PostDetailRepository implements PanacheRepository<PostDetail> {

    @Inject
    UserRepository userRepository;

    @Inject
    PostRepository postRepository;

    //<editor-fold desc="POLL">
    public void addPollPostDetails(Poll_PostDetailDTO postDetailDTO) {
        BoastUser user = userRepository.getUser(postDetailDTO.getCreatorId());
        Poll_Post post = (Poll_Post) postRepository.getPost(postDetailDTO.getPostId());
        Poll_PostAnswer postAnswer = getEntityManager().find(Poll_PostAnswer.class, postDetailDTO.getPoll_answerId());
        if (user == null || post == null || postAnswer == null) throw new IllegalArgumentException();

        Poll_PostDetail postDetail = new Poll_PostDetail(postDetailDTO, user, post, postAnswer);

        post.addPostDetail(postDetail);

        persist(postDetail);
    }
    //</editor-fold>

    //<editor-fold desc="TEXT">
    public void addTextPostDetails(Text_PostDetailDTO postDetailDTO) {
        BoastUser user = userRepository.getUser(postDetailDTO.getCreatorId());
        Text_Post post = (Text_Post) postRepository.getPost(postDetailDTO.getPostId());
        if (user == null || post == null) throw new IllegalArgumentException();

        Text_PostDetail postDetail = new Text_PostDetail(postDetailDTO, user, post, postDetailDTO.getText());

        post.addPostDetail(postDetail);

        persist(postDetail);
    }
    //</editor-fold>
}
