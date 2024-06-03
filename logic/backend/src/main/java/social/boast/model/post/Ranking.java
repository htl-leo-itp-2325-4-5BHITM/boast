package social.boast.model.post;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import social.boast.model.user.BoastUser;

@Entity
public class Ranking extends PanacheEntityBase {
    @Id
    @GeneratedValue
    public Long rankingId;

    @ManyToOne
    @JoinColumn(name = "postId")
    public RankingPost post;

    @ManyToOne
    public BoastUser user;

    public int place;

    public Ranking(RankingPost post, BoastUser user, int place) {
        this.post = post;
        this.user = user;
        this.place = place;
    }

    public Ranking() {
    }

    public Long getRankingId() {
        return rankingId;
    }

    public void setRankingId(Long rankingId) {
        this.rankingId = rankingId;
    }

    public RankingPost getPost() {
        return post;
    }

    public void setPost(RankingPost post) {
        this.post = post;
    }

    public BoastUser getUser() {
        return user;
    }

    public void setUser(BoastUser user) {
        this.user = user;
    }

    public int getPlace() {
        return place;
    }

    public void setPlace(int place) {
        this.place = place;
    }
}
