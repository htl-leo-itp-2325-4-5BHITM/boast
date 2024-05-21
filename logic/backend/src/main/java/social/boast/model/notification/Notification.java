package social.boast.model.notification;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import social.boast.dto.notification.NotificationDTO;
import social.boast.model.notification.type.congratulation.CongratulationNotification;
import social.boast.model.notification.type.user.UserNotification;
import social.boast.model.user.BoastUser;

import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Notification extends PanacheEntityBase {
    @Id
    @GeneratedValue
    public Long notificationId;

    public Date createdOn;

    @ManyToOne
    @JoinColumn(name = "receiving_userId")
    public BoastUser receivingUser;

    @Column(length = 80, nullable = false)
    public String description;

    @Enumerated(EnumType.STRING)
    public NotificationType notificationType;

    public Notification(Date createdOn, BoastUser receivingUser, String description, NotificationType notificationType) {
        this.createdOn = createdOn;
        this.receivingUser = receivingUser;
        this.description = description;
        this.notificationType = notificationType;
    }

    public Notification() {
    }

    public static List<Long> getNotificationIds(Long reqUserId) {
        return getEntityManager().createQuery("select notificationId from Notification where receivingUser.id = :reqUserId order by createdOn desc").setParameter("reqUserId", reqUserId).getResultList();
    }

    public static NotificationDTO getNotificationDTO(Long id, Long reqUserId) {
        Notification notification = findById(id);
        if (!notification.receivingUser.userId.equals(reqUserId)) throw new IllegalArgumentException();
        switch (notification.notificationType) {
            case USER -> {
                return UserNotification.getNotificationDTO((UserNotification) notification);
            }
            case CONGRATULATION -> {
                return CongratulationNotification.getNotificationDTO((CongratulationNotification) notification);
            }
        }
        throw new IllegalArgumentException();
    }
}
