package it.boast.model.post.type.poll;

import jakarta.persistence.*;

@Entity
public class Poll_PostAnswer {
    @Id
    @GeneratedValue
    Long poll_answerId;

    @ManyToOne
    @JoinColumn(name = "pollPost_postId")
    Poll_Post pollPost;

    String title;

    public Poll_PostAnswer(Poll_Post pollPost, String title) {
        this.pollPost = pollPost;
        this.title = title;
    }

    public Poll_PostAnswer() {
    }

    //<editor-fold desc="getter & setter">
    public Long getPoll_answerId() {
        return poll_answerId;
    }

    public void setPoll_answerId(Long poll_answerId) {
        this.poll_answerId = poll_answerId;
    }

    public Poll_Post getPollPost() {
        return pollPost;
    }

    public void setPollPost(Poll_Post pollPost) {
        this.pollPost = pollPost;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    //</editor-fold>
}
