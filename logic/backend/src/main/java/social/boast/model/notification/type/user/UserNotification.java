package social.boast.model.notification.type.user;

import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import social.boast.dto.notification.type.user.UserNotificationDTO;
import social.boast.model.notification.Notification;
import social.boast.model.notification.NotificationType;
import social.boast.model.user.BoastUser;

import java.util.Date;

@Entity
public class UserNotification extends Notification {
    @ManyToOne
    @JoinColumn(name = "sending_userId")
    public BoastUser sendingUser;


    public UserNotification(BoastUser receivingUser, String description, BoastUser sendingUser) {
        super(new Date(), receivingUser, description, NotificationType.USER);
        this.sendingUser = sendingUser;
    }

    public UserNotification() {

    }


    public static void createUserNotification(BoastUser receivingUser, String description, BoastUser sendingUser) {
        UserNotification notification = new UserNotification(receivingUser, description, sendingUser);
        persist(notification);
    }

    public static UserNotificationDTO getNotificationDTO(UserNotification notification) {
        return new UserNotificationDTO(notification.notificationId,
                notification.createdOn,
                notification.description,
                notification.notificationType.name(),
                notification.sendingUser.userId,
                notification.sendingUser.username);
    }

}
