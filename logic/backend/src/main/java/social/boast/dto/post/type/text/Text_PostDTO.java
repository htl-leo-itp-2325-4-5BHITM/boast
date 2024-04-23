package social.boast.dto.post.type.text;

import social.boast.dto.post.PostDTO;
import social.boast.dto.post.type.PostTypeDTO_Interface;

import java.util.Date;
import java.util.List;

public class Text_PostDTO extends PostDTO implements PostTypeDTO_Interface<Text_PostDetailDTO> {
    List<Text_PostDetailDTO> postDetails;

    List<Long> winners;

    public Text_PostDTO(Long postId, Date createdOn, String title, String definition, Long creator, String creatorName, String status, String type, List<Long> winners, List<Text_PostDetailDTO> postDetails) {
        super(postId, createdOn, title, definition, creator, creatorName, status, type);
        this.winners = winners;
        this.postDetails = postDetails;
    }

    public Text_PostDTO() {}

    @Override
    public List<Text_PostDetailDTO> getPostDetails() {
        return postDetails;
    }

    @Override
    public void setPostDetails(List<Text_PostDetailDTO> postDetails) {
        this.postDetails = postDetails;
    }

    public List<Long> getWinners() {
        return winners;
    }

    public void setWinners(List<Long> winners) {
        this.winners = winners;
    }
}
