package social.boast.model.user;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import social.boast.dto.user.RelationDTO;

@Entity
public class Relation extends PanacheEntityBase {

    @EmbeddedId
    public RelationId id;

    @Enumerated(EnumType.STRING)
    public RelationStatus relationStatus;

    public Relation(RelationId relationId, RelationStatus relationStatus) {
        this.id = relationId;
        this.relationStatus = relationStatus;
    }

    public Relation() {
    }

    public static void createRelation(RelationDTO relationDTO) {
        if (relationDTO.getReqUserId().equals(relationDTO.getTargetUserId())) throw new IllegalArgumentException();
        BoastUser reqUser = BoastUser.findById(relationDTO.getReqUserId());
        BoastUser targetUser = BoastUser.findById(relationDTO.getTargetUserId());
        if (reqUser == null || targetUser == null) throw new IllegalArgumentException();
        RelationId relationId = new RelationId(reqUser, targetUser);
        Relation relation = find("id", relationId).firstResult();
        RelationStatus status = RelationStatus.valueOf(relationDTO.getRelationStatus());

        if (relation == null) {
            relation = new Relation(relationId, status);
            persist(relation);
        } else {
            relation.relationStatus = status;
        }
    }

}
