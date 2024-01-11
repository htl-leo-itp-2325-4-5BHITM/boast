package social.boast.dto.post;

import social.boast.service.DateService;

import java.util.Date;

public class PostDTO {
    Long postId;
    Date createdOn;
    String title;
    String definition;
    Long creatorId;
    String creatorName;
    String status;
    String type;

    public PostDTO(Long postId, Date createdOn, String title, String definition, Long creatorId, String creatorName, String status, String type) {
        this.postId = postId;
        this.createdOn = createdOn;
        this.title = title;
        this.definition = definition;
        this.creatorId = creatorId;
        this.creatorName = creatorName;
        this.status = status;
        this.type = type;
    }

    public PostDTO() {
    }

    //<editor-fold desc="getter & setter">
    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDefinition() {
        return definition;
    }

    public void setDefinition(String definition) {
        this.definition = definition;
    }

    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    //</editor-fold>
}