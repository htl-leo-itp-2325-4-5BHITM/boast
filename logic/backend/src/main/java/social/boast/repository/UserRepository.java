package social.boast.repository;

import jakarta.persistence.Entity;
import social.boast.dto.user.RelationDTO;
import social.boast.dto.user.UserDTO;
import social.boast.model.user.BoastUser;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import social.boast.model.user.Relation;
import social.boast.model.user.RelationId;
import social.boast.model.user.RelationStatus;

@ApplicationScoped
public class UserRepository {

    @Inject
    EntityManager entityManager;

    public UserDTO getUser(Long id) {
        BoastUser user = entityManager.find(BoastUser.class, id);
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.getUserId(), user.getCreatedOn(), user.getUsername(), user.getEmail());
    }

    public UserDTO loginUser(String username) {
        TypedQuery<BoastUser> query = entityManager.createQuery("select u from BoastUser u where u.username = :username", BoastUser.class);
        BoastUser user = query.setParameter("username", username).getSingleResult();
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.getUserId(), user.getCreatedOn(), user.getUsername(), user.getEmail());
    }

    public UserDTO createUser(UserDTO userDTO) {
        BoastUser user = new BoastUser(userDTO);
        entityManager.persist(user);
        return new UserDTO(user.getUserId(), user.getCreatedOn(), user.getUsername(), user.getEmail());
    }
    
    public void relation(RelationDTO relationDTO) {
        if (relationDTO.getReqUserId().equals(relationDTO.getTargetUserId())) throw new IllegalArgumentException();
        BoastUser reqUser = entityManager.find(BoastUser.class, relationDTO.getReqUserId());
        BoastUser targetUser = entityManager.find(BoastUser.class, relationDTO.getTargetUserId());
        if (reqUser == null || targetUser == null) throw new IllegalArgumentException();
        RelationId relationId = new RelationId(reqUser, targetUser);
        Relation relation = entityManager.find(Relation.class, relationId);
        RelationStatus status = RelationStatus.valueOf(relationDTO.getRelationStatus());

        if (relation == null) {
            relation = new Relation(relationId, status);
            entityManager.persist(relation);
        } else {
            relation.setRelationStatus(status);
        }
    }
}
