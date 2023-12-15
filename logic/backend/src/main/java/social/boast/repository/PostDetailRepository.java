package social.boast.repository;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.model.post.Post;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.poll.Poll_PostAnswer;
import social.boast.model.post.type.poll.Poll_PostDetail;
import social.boast.model.user.BoastUser;

@ApplicationScoped
public class PostDetailRepository {

    @Inject
    EntityManager entityManager;

    //<editor-fold desc="POLL">
    public void addPollPostDetails(Poll_PostDetailDTO postDetailDTO) {
        try {
            BoastUser user = entityManager.find(BoastUser.class, postDetailDTO.getCreator());
            Post post = entityManager.find(Post.class, postDetailDTO.getPostId());
            Poll_PostAnswer postAnswer = entityManager.find(Poll_PostAnswer.class, postDetailDTO.getPollAnswer());
            if (user == null || post == null || postAnswer == null) throw new IllegalArgumentException();

            entityManager.persist(new Poll_PostDetail(postDetailDTO, user, (Poll_Post) post, postAnswer));
        } catch (Exception e) {
            throw new IllegalArgumentException();
        }
    }
    //</editor-fold>
}
