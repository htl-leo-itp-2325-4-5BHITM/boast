package social.boast.model.post.type.poll;

import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.model.post.Post;
import social.boast.model.post.PostDetail;
import social.boast.model.user.BoastUser;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Poll_PostDetail extends PostDetail {

    @ManyToOne
    public Poll_PostAnswer pollAnswer;

    @ManyToOne
    @JoinColumn(name = "postId")
    public Poll_Post post;

    public Poll_PostDetail(Poll_PostDetailDTO postDetailDTO, BoastUser user, Poll_Post post, Poll_PostAnswer postAnswer) {
        super(postDetailDTO.createdOnDate(), user);
        this.post = post;
        this.pollAnswer = postAnswer;
    }

    public Poll_PostDetail() {
    }

    public static void addPollPostDetails(Poll_PostDetailDTO postDetailDTO) {
        BoastUser user = BoastUser.findById(postDetailDTO.getCreatorId());
        Poll_Post post = (Poll_Post) Post.getPost(postDetailDTO.getPostId());
        Poll_PostAnswer postAnswer = getEntityManager().find(Poll_PostAnswer.class, postDetailDTO.getPoll_answerId());
        if (user == null || post == null || postAnswer == null) throw new IllegalArgumentException();

        Poll_PostDetail postDetail = new Poll_PostDetail(postDetailDTO, user, post, postAnswer);

        post.addPostDetail(postDetail);

        persist(postDetail);
    }
}
