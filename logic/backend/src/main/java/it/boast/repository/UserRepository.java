package it.boast.repository;

import it.boast.dto.user.UserDTO;
import it.boast.model.user.BoastUser;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

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
}
