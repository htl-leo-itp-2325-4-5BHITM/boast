package social.boast.dto.notification;

import jakarta.persistence.*;
import social.boast.model.notification.NotificationType;
import social.boast.model.user.BoastUser;

import java.util.Date;

public class NotificationDTO {
    Long notificationId;
    Date createdOn;
    Long receivingUserId;
    String receivingUserName;
    String description;
    String notificationType;

    public NotificationDTO(Long notificationId, Date createdOn, String description, String notificationType) {
        this.notificationId = notificationId;
        this.createdOn = createdOn;
        this.description = description;
        this.notificationType = notificationType;
    }

    public NotificationDTO() {
    }

    public Long getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(Long notificationId) {
        this.notificationId = notificationId;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(String notificationType) {
        this.notificationType = notificationType;
    }
}
