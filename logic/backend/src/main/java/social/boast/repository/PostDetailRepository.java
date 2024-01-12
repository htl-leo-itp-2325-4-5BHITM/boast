package social.boast.repository;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.dto.post.type.text.Text_PostDetailDTO;
import social.boast.model.post.Post;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.poll.Poll_PostAnswer;
import social.boast.model.post.type.poll.Poll_PostDetail;
import social.boast.model.post.type.text.Text_Post;
import social.boast.model.post.type.text.Text_PostDetail;
import social.boast.model.user.BoastUser;

@ApplicationScoped
public class PostDetailRepository {

    @Inject
    EntityManager entityManager;

    //<editor-fold desc="POLL">
    public void addPollPostDetails(Poll_PostDetailDTO postDetailDTO) {
        BoastUser user = entityManager.find(BoastUser.class, postDetailDTO.getCreatorId());
        Poll_Post post = entityManager.find(Poll_Post.class, postDetailDTO.getPostId());
        Poll_PostAnswer postAnswer = entityManager.find(Poll_PostAnswer.class, postDetailDTO.getPoll_answerId());
        if (user == null || post == null || postAnswer == null) throw new IllegalArgumentException();

        Poll_PostDetail postDetail = new Poll_PostDetail(postDetailDTO, user, post, postAnswer);

        post.addPostDetail(postDetail);

        entityManager.persist(postDetail);
    }
    //</editor-fold>

    //<editor-fold desc="TEXT">
    public void addTextPostDetails(Text_PostDetailDTO postDetailDTO) {
        BoastUser user = entityManager.find(BoastUser.class, postDetailDTO.getCreatorId());
        Text_Post post = entityManager.find(Text_Post.class, postDetailDTO.getPostId());
        if (user == null || post == null) throw new IllegalArgumentException();

        Text_PostDetail postDetail = new Text_PostDetail(postDetailDTO, user, post, postDetailDTO.getText());

        post.addPostDetail(postDetail);

        entityManager.persist(postDetail);
    }
    //</editor-fold>
}
