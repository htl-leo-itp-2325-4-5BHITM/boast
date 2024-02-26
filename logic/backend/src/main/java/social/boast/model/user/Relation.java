package social.boast.model.user;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import jakarta.persistence.*;

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

    public static RelationStatus getRelationStatus(Long reqUserId, Long targetUserId) {
        BoastUser reqUser = BoastUser.findById(reqUserId);
        BoastUser targetUser = BoastUser.findById(targetUserId);
        if (reqUser == null || targetUser == null) throw new IllegalArgumentException();
        RelationId relationId = new RelationId(reqUser, targetUser);
        Relation relation = find("id", relationId).firstResult();
        if (relation == null) return RelationStatus.NO_RELATION;
        return relation.relationStatus;
    }

    public static RelationStatus createRelation(Long reqUserId, Long targetUserId, RelationStatus relationStatus) {
        if (reqUserId.equals(targetUserId)) throw new IllegalArgumentException();
        BoastUser reqUser = BoastUser.findById(reqUserId);
        BoastUser targetUser = BoastUser.findById(targetUserId);
        if (reqUser == null || targetUser == null) throw new IllegalArgumentException();
        RelationId relationId = new RelationId(reqUser, targetUser);
        Relation relation = find("id", relationId).firstResult();

        if (relationStatus == RelationStatus.NO_RELATION) {
            deleteById(relationId);
            return RelationStatus.NO_RELATION;
        }

        if (relationStatus == RelationStatus.FRIEND && !targetUser.isPublic) {
            relationStatus = RelationStatus.REQUEST;
        }

        if (relation == null) {
            relation = new Relation(relationId, relationStatus);
            reqUser.addReqRelation(relation);
            targetUser.addTargetRelation(relation);
            persist(relation);
        } else {
            relation.relationStatus = relationStatus;
        }
        deleteById(relationId);
        return relationStatus;
    }

    public static void acceptRelation(Long reqUserId, Long targetUserId) {
        BoastUser reqUser = BoastUser.findById(reqUserId);
        BoastUser targetUser = BoastUser.findById(targetUserId);
        RelationId relationId = new RelationId(reqUser, targetUser);
        Relation relation = find("id", relationId).firstResult();
        if (relation.relationStatus == RelationStatus.REQUEST) relation.relationStatus = RelationStatus.FRIEND;
    }

    public static List<Relation> getRelationsToReqUser(Long reqUserId) {
        return list("id.reqUser.id", reqUserId);
    }

    public static List<Relation> getRelationsToTargetUser(Long targetUserId) {
        return list("id.targetUser.id", targetUserId);
    }

    public static List<Long> getFollower(Long userId) {
        return getRelationsToTargetUser(userId).stream()
                .filter(r -> r.relationStatus == RelationStatus.FRIEND)
                .map(r -> r.id.reqUser.userId).toList();
        //.map(r -> BoastUser.getUserDTO(r.id.reqUser.userId)).toList(); // for possible future use
    }

    public static List<Long> getFollowing(Long userId) {
        return getRelationsToReqUser(userId).stream()
                .filter(r -> r.relationStatus == RelationStatus.FRIEND)
                .map(r -> r.id.targetUser.userId).toList();
    }

    public static List<Long> getRequests(Long userId) {
        return getRelationsToReqUser(userId).stream()
                .filter(r -> r.relationStatus == RelationStatus.REQUEST)
                .map(r -> r.id.reqUser.userId).toList();
    }
}
