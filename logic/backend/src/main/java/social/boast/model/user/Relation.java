package social.boast.model.user;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
public class Relation implements Serializable {

    @EmbeddedId
    private RelationId id;

    @Enumerated(EnumType.STRING)
    private RelationStatus relationStatus;

    public Relation(RelationId relationId, RelationStatus relationStatus) {
        this.id = relationId;
        this.relationStatus = relationStatus;
    }

    public Relation() {
    }

    public RelationId getId() {
        return id;
    }

    public void setId(RelationId id) {
        this.id = id;
    }

    public RelationStatus getRelationStatus() {
        return relationStatus;
    }

    public void setRelationStatus(RelationStatus relationStatus) {
        this.relationStatus = relationStatus;
    }

}
