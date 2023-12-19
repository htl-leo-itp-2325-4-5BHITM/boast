package social.boast.model.post;

import social.boast.model.user.BoastUser;
import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class PostDetail implements Serializable {
    @Id
    @GeneratedValue
    private Long postDetailsId;

    private Date createdOn;

    @ManyToOne
    @JoinColumn(name = "creator_userId")
    private BoastUser creator;

    public PostDetail(Date createdOn, BoastUser creator) {
        this.createdOn = (createdOn != null) ? createdOn : new Date();
        this.creator = creator;
    }

    public PostDetail() {

    }

    //<editor-fold desc="getter & setter">

    public Long getPostDetailsId() {
        return postDetailsId;
    }

    public void setPostDetailsId(Long postDetailsId) {
        this.postDetailsId = postDetailsId;
    }

    public BoastUser getCreator() {
        return creator;
    }

    public void setCreator(BoastUser creator) {
        this.creator = creator;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    //</editor-fold>
}
