package it.boast.model.post.type.poll;

import it.boast.dto.post.type.poll.Poll_PostDetailDTO;
import it.boast.model.post.PostDetail;
import it.boast.model.post.PostDetailType;
import it.boast.model.user.BoastUser;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Poll_PostDetail extends PostDetail implements PostDetailType<Poll_Post> {

    @ManyToOne
    Poll_PostAnswer pollAnswer;

    @ManyToOne
    @JoinColumn(name = "postId")
    Poll_Post post;

    public Poll_PostDetail(Poll_PostDetailDTO pollAnswer, BoastUser user, Poll_Post post, Poll_PostAnswer postAnswer) {
        super(pollAnswer.getCreatedOn(), user);
        this.post = post;
        this.pollAnswer = postAnswer;
    }

    public Poll_PostDetail() {
    }

    @Override
    public Poll_Post getPost() {
        return this.post;
    }

    @Override
    public void setPost(Poll_Post post) {
        this.post = post;
    }

    public Poll_PostAnswer getPollAnswer() {
        return pollAnswer;
    }

    public void setPollAnswer(Poll_PostAnswer pollAnswer) {
        this.pollAnswer = pollAnswer;
    }
}
