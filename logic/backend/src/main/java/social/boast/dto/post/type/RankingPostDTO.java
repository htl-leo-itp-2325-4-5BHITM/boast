package social.boast.dto.post.type;

import social.boast.dto.post.PostDTO;
import social.boast.dto.post.WinnerRankingDTO;

import java.util.Date;

public class RankingPostDTO extends PostDTO {

    WinnerRankingDTO winnerRanking;

    public RankingPostDTO(Long postId, Date createdOn, String title, String definition, Long creatorId, String creatorName, String status, String type, WinnerRankingDTO winnerRankingDTO) {
        super(postId, createdOn, title, definition, creatorId, creatorName, status, type);
        this.winnerRanking = winnerRankingDTO;
    }

    public RankingPostDTO() {
    }

    public WinnerRankingDTO getWinnerRanking() {
        return winnerRanking;
    }

    public void setWinnerRanking(WinnerRankingDTO winnerRanking) {
        this.winnerRanking = winnerRanking;
    }
}
