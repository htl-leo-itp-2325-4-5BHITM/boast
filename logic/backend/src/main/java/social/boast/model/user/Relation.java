package social.boast.model.user;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;
import social.boast.dto.user.RelationDTO;
import social.boast.dto.user.UserDTO;

import java.util.List;

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
        if (relationDTO.reqUserId().equals(relationDTO.targetUserId())) throw new IllegalArgumentException();
        BoastUser reqUser = BoastUser.findById(relationDTO.reqUserId());
        BoastUser targetUser = BoastUser.findById(relationDTO.targetUserId());
        if (reqUser == null || targetUser == null) throw new IllegalArgumentException();
        RelationId relationId = new RelationId(reqUser, targetUser);
        Relation relation = find("id", relationId).firstResult();
        RelationStatus status = RelationStatus.valueOf(relationDTO.relationStatus());

        if (relation == null) {
            relation = new Relation(relationId, status);
            persist(relation);
        } else {
            relation.relationStatus = status;
        }
    }

    public static List<Relation> getRelationsToReqUser(Long reqUserId) {
        return list("id.reqUser.id", reqUserId);
    }

    public static List<Relation> getRelationsToTargetUser(Long targetUserId) {
        return list("id.targetUser.id", targetUserId);
    }

    public static List<Long> getFriends(Long userId) {
        return getRelationsToTargetUser(userId).stream()
                .filter(r -> r.relationStatus == RelationStatus.FRIEND)
                .map(r -> r.id.reqUser.userId).toList();
                //.map(r -> BoastUser.getUserDTO(r.id.reqUser.userId)).toList(); // for possible future use
    }

    public static List<Long> getFollows(Long userId) {
        return getRelationsToReqUser(userId).stream()
                .filter(r -> r.relationStatus == RelationStatus.FRIEND)
                .map(r -> r.id.targetUser.userId).toList();
    }

}
