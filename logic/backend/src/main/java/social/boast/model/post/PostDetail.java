package social.boast.model.post;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import social.boast.model.user.BoastUser;
import jakarta.persistence.*;

import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class PostDetail extends PanacheEntityBase {
    @Id
    @GeneratedValue
    public Long postDetailsId;

    public Date createdOn;

    @ManyToOne
    @JoinColumn(name = "creator_userId")
    public BoastUser creator;

    public PostDetail(Date createdOn, BoastUser creator) {
        this.createdOn = (createdOn != null) ? createdOn : new Date();
        this.creator = creator;
    }

    public PostDetail() {

    }
}
