package social.boast.dto.post;

import java.util.Date;

public class PostDetailDTO {
    Long postDetailsId;
    Date createdOn;
    Long creator;
    Long postId;

    public PostDetailDTO(Long postDetailsId, Date createdOn, Long creator, Long postId) {
        this.postDetailsId = postDetailsId;
        this.createdOn = createdOn;
        this.creator = creator;
        this.postId = postId;
    }

    public PostDetailDTO() {
    }

    public Long getPostDetailsId() {
        return postDetailsId;
    }

    public void setPostDetailsId(Long postDetailsId) {
        this.postDetailsId = postDetailsId;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Long getCreator() {
        return creator;
    }

    public void setCreator(Long creator) {
        this.creator = creator;
    }

    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }
}
