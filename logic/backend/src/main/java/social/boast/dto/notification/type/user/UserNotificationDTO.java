package social.boast.dto.notification.type.user;

import social.boast.dto.notification.NotificationDTO;

import java.util.Date;

public class UserNotificationDTO extends NotificationDTO{
    Long sendingUserId;
    String sendingUserName;

    public UserNotificationDTO(Long notificationId, Date createdOn, String description, String notificationType, Long sendingUserId, String sendingUserName) {
        super(notificationId, createdOn, description, notificationType);
        this.sendingUserId = sendingUserId;
        this.sendingUserName = sendingUserName;
    }

    public UserNotificationDTO() {
    }

    public Long getSendingUserId() {
        return sendingUserId;
    }

    public void setSendingUserId(Long sendingUserId) {
        this.sendingUserId = sendingUserId;
    }

    public String getSendingUserName() {
        return sendingUserName;
    }

    public void setSendingUserName(String sendingUserName) {
        this.sendingUserName = sendingUserName;
    }
}
