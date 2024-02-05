package social.boast.model.user;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Embeddable;
import jakarta.persistence.ManyToOne;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class RelationId extends PanacheEntityBase implements Serializable {
    @ManyToOne
    private BoastUser reqUser;

    @ManyToOne
    private BoastUser targetUser;

    public RelationId(BoastUser user1, BoastUser user2) {
        this.reqUser = user1;
        this.targetUser = user2;
    }

    public RelationId() {
    }

    public BoastUser getReqUser() {
        return reqUser;
    }

    public void setReqUser(BoastUser user1) {
        this.reqUser = user1;
    }

    public BoastUser getTargetUser() {
        return targetUser;
    }

    public void setTargetUser(BoastUser user2) {
        this.targetUser = user2;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RelationId that = (RelationId) o;
        return Objects.equals(reqUser, that.reqUser) && Objects.equals(targetUser, that.targetUser);
    }

    @Override
    public int hashCode() {
        return Objects.hash(reqUser, targetUser);
    }
}
