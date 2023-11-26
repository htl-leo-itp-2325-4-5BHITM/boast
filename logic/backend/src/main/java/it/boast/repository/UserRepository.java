package it.boast.repository;

import it.boast.dto.user.UserDTO;
import it.boast.model.user.BoastUser;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

@ApplicationScoped
public class UserRepository {

    @Inject
    EntityManager entityManager;

    public UserDTO getUser(Long id) {
        BoastUser user = entityManager.find(BoastUser.class, id);
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.getUserId(), user.getCreatedOn(), user.getUsername(), user.getEmail());
    }
}
