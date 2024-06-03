package social.boast.model.notification.type.loser;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import social.boast.dto.notification.type.congratulation.CongratulationNotificationDTO;
import social.boast.dto.notification.type.loser.LoserNotificationDTO;
import social.boast.model.notification.Notification;
import social.boast.model.notification.NotificationType;
import social.boast.model.post.Post;
import social.boast.model.user.BoastUser;

import java.util.Date;

@Entity
public class LoserNotification extends Notification {
    @Column(length = 80, nullable = false)
    public String header;

    @ManyToOne
    @JoinColumn(name = "postId")
    public Post post;

    public LoserNotification(BoastUser receivingUser, String title, String header, Post post) {
        super(new Date(), receivingUser, title, NotificationType.LOSER);
        this.header = header;
        this.post = post;
    }

    public LoserNotification() {

    }

    public static LoserNotificationDTO getNotificationDTO(LoserNotification notification) {
        return new LoserNotificationDTO(notification.notificationId,
                notification.createdOn,
                notification.description,
                notification.notificationType.name(),
                notification.read,
                notification.header,
                notification.post.postId);
    }

    public static void createLoserNotification (BoastUser receivingUser, String description, String header, Post post) {
        LoserNotification notification = new LoserNotification(receivingUser, description, header, post);
        persist(notification);
    }
}
