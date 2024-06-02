package social.boast.dto.notification;

import jakarta.persistence.*;
import social.boast.model.notification.NotificationType;
import social.boast.model.user.BoastUser;
import social.boast.service.DateService;

import java.util.Date;

public class NotificationDTO {
    Long notificationId;
    Date createdOn;
    String description;
    String notificationType;
    boolean read;

    public NotificationDTO(Long notificationId, Date createdOn, String description, String notificationType, boolean read) {
        this.notificationId = notificationId;
        this.createdOn = createdOn;
        this.description = description;
        this.notificationType = notificationType;
        this.read = read;
    }

    public NotificationDTO() {
    }

    public String getCreatedOn() {
        return DateService.formatDate(createdOn);
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

    public boolean isRead() {
        return read;
    }

    public void setRead(boolean read) {
        this.read = read;
    }
}
