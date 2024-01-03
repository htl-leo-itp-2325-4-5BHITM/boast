package social.boast.dto.post.type.text;

import social.boast.dto.post.PostDetailDTO;

import java.util.Date;

public class Text_PostDetailDTO extends PostDetailDTO {
    String text;

    public Text_PostDetailDTO(Long postDetailsId, Date createdOn, Long creator, String creatorName, Long postId, String text) {
        super(postDetailsId, createdOn, creator, creatorName, postId);
        this.text = text;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
