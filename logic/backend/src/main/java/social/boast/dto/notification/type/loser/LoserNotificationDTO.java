package social.boast.dto.notification.type.loser;

import social.boast.dto.notification.NotificationDTO;

import java.util.Date;

public class LoserNotificationDTO extends NotificationDTO {
    String header;
    Long postId;

    public LoserNotificationDTO(Long notificationId, Date createdOn, String title, String notificationType, boolean read, String header, Long postId) {
        super(notificationId, createdOn, title, notificationType, read);
        this.header = header;
        this.postId = postId;
    }

    public LoserNotificationDTO() {
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }
}
