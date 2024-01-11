package social.boast.dto.post;

import social.boast.service.DateService;

import java.util.Date;

public class PostDetailDTO {
    Long postDetailsId;
    Date createdOn;
    Long creatorId;
    String creatorName;
    Long postId;

    public PostDetailDTO(Long postDetailsId, Date createdOn, Long creatorId, String creatorName, Long postId) {
        this.postDetailsId = postDetailsId;
        this.createdOn = createdOn;
        this.creatorId = creatorId;
        this.creatorName = creatorName;
        this.postId = postId;
    }

    public PostDetailDTO() {
    }

    //<editor-fold desc="getter & setter">
    public Long getPostDetailsId() {
        return postDetailsId;
    }

    public void setPostDetailsId(Long postDetailsId) {
        this.postDetailsId = postDetailsId;
    }

    public String getCreatedOn() {
        return DateService.formatDate(createdOn);
    }

    public Date createdOnDate() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }

    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }
    //</editor-fold>
}