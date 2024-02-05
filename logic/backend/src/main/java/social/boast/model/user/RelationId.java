package social.boast.model.user;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.Embeddable;
import jakarta.persistence.ManyToOne;

import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class RelationId extends PanacheEntityBase implements Serializable {
    @ManyToOne
    public BoastUser reqUser;

    @ManyToOne
    public BoastUser targetUser;

    public RelationId(BoastUser user1, BoastUser user2) {
        this.reqUser = user1;
        this.targetUser = user2;
    }

    public RelationId() {
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
