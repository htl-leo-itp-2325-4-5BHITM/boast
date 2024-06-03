package social.boast.model.post;

import jakarta.persistence.*;
import social.boast.dto.post.WinnerRankingDTO;
import social.boast.model.notification.type.congratulation.CongratulationNotification;
import social.boast.model.user.BoastUser;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class RankingPost extends Post{

    public static final String FIRST_RESPONSE = "CONGRATULATION YOU WON!";
    public static final String SECOND_RESPONSE = "You are 2nd!";
    public static final String THIRD_RESPONSE = "You are 3rd!";

    @OneToMany(mappedBy = "post", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    public List<Ranking> rankings;

    public RankingPost(Date createdOn, String title, String definition, BoastUser creator, PostStatus status, PostType postType) {
        super(createdOn, title, definition, creator, status, postType);
    }

    public RankingPost() {
    }

    public WinnerRankingDTO getWinnerRankingDTO() {
        return new WinnerRankingDTO(
                    this.rankings.stream().filter(ranking -> ranking.place == 1).map((ranking) -> ranking.user.userId).toArray(Long[]::new),
                    this.rankings.stream().filter(ranking -> ranking.place == 2).map((ranking) -> ranking.user.userId).toArray(Long[]::new),
                    this.rankings.stream().filter(ranking -> ranking.place == 3).map((ranking) -> ranking.user.userId).toArray(Long[]::new));
    }

    public static List<Long> addWinners(Long postId, WinnerRankingDTO winners) {
        RankingPost post = RankingPost.findById(postId);
        if (post == null) throw new IllegalArgumentException();
        List<Long> winnerIds = new LinkedList<>();
        for (Long winner: winners.first()) {
            winnerIds.add(winner);
            addRanking(post, winner, 1, FIRST_RESPONSE);
        }
        for (Long winner: winners.second()) {
            winnerIds.add(winner);
            addRanking(post, winner, 2, SECOND_RESPONSE);
        }
        for (Long winner: winners.third()) {
            winnerIds.add(winner);
            addRanking(post, winner, 3, THIRD_RESPONSE);
        }
        return winnerIds;
    }

    private static void addRanking(RankingPost post, Long winner, int place,String response) {
        BoastUser user = BoastUser.findById(winner);
        if (user == null) throw new IllegalArgumentException();
        post.rankings.add(new Ranking(post, user, place));
        CongratulationNotification.createCongratulationNotification(user, post.title, response, post);
    }

    public List<Ranking> getRankings() {
        return rankings;
    }

    public void setRankings(List<Ranking> rankings) {
        this.rankings = rankings;
    }
}
