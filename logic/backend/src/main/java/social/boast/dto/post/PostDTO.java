package social.boast.dto.post;

import java.util.Date;
import java.util.List;

public class PostDTO {
    Long postId;
    Date createdOn;
    String title;
    String definition;
    Long creator;
    String status;

    String type;

    public PostDTO(Long postId, Date createdOn, String title, String definition, Long creator, String status, String type) {
        this.postId = postId;
        this.createdOn = createdOn;
        this.title = title;
        this.definition = definition;
        this.creator = creator;
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

    public Date getCreatedOn() {
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

    public Long getCreator() {
        return creator;
    }

    public void setCreator(Long creator) {
        this.creator = creator;
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

    //</editor-fold>
}
