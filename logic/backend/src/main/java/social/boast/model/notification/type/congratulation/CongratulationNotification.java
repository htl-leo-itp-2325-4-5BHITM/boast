package social.boast.model.notification.type.congratulation;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import social.boast.dto.notification.type.congratulation.CongratulationNotificationDTO;
import social.boast.model.notification.Notification;
import social.boast.model.notification.NotificationType;
import social.boast.model.post.Post;
import social.boast.model.user.BoastUser;

import java.util.Date;

@Entity
public class CongratulationNotification extends Notification {
    @Column(length = 80, nullable = false)
    public String header;

    @ManyToOne
    @JoinColumn(name = "postId")
    public Post post;

    public CongratulationNotification(BoastUser receivingUser, String title, String header, Post post) {
        super(new Date(), receivingUser, title, NotificationType.CONGRATULATION);
        this.header = header;
        this.post = post;
    }

    public CongratulationNotification() {

    }

    public static CongratulationNotificationDTO getNotificationDTO(CongratulationNotification notification) {
        return new CongratulationNotificationDTO(notification.notificationId,
                notification.createdOn,
                notification.description,
                notification.notificationType.name(),
                notification.header,
                notification.post.postId);
    }

    public static void createCongratulationNotification (BoastUser receivingUser, String description, String header, Post post) {
        CongratulationNotification notification = new CongratulationNotification(receivingUser, description, header, post);
        persist(notification);
    }
}
