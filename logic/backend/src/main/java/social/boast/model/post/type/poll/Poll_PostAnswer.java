package social.boast.model.post.type.poll;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

@Entity
public class Poll_PostAnswer extends PanacheEntityBase {
    @Id
    @GeneratedValue
    public Long poll_answerId;

    @ManyToOne
    @JoinColumn(name = "pollPost_postId")
    public Poll_Post pollPost;

    public String title;

    public Poll_PostAnswer(Poll_Post pollPost, String title) {
        this.pollPost = pollPost;
        this.title = title;
    }

    public Poll_PostAnswer() {
    }
}
