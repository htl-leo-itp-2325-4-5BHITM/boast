package social.boast.repository.user;

import io.quarkus.hibernate.orm.panache.PanacheRepository;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import social.boast.dto.user.RelationDTO;
import social.boast.model.user.BoastUser;
import social.boast.model.user.Relation;
import social.boast.model.user.RelationId;
import social.boast.model.user.RelationStatus;

@ApplicationScoped
public class RelationRepository implements PanacheRepository<Relation> {

    @Inject
    UserRepository userRepository;

    public void createRelation(RelationDTO relationDTO) {
        if (relationDTO.getReqUserId().equals(relationDTO.getTargetUserId())) throw new IllegalArgumentException();
        BoastUser reqUser = userRepository.getUser(relationDTO.getReqUserId());
        BoastUser targetUser = userRepository.getUser(relationDTO.getTargetUserId());
        if (reqUser == null || targetUser == null) throw new IllegalArgumentException();
        RelationId relationId = new RelationId(reqUser, targetUser);
        Relation relation = find("id", relationId).firstResult();
        RelationStatus status = RelationStatus.valueOf(relationDTO.getRelationStatus());

        if (relation == null) {
            relation = new Relation(relationId, status);
            persist(relation);
        } else {
            relation.setRelationStatus(status);
        }
    }
}
