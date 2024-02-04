package social.boast.repository.user;

import io.quarkus.hibernate.orm.panache.PanacheRepository;
import social.boast.dto.user.UserDTO;
import social.boast.model.user.BoastUser;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class UserRepository implements PanacheRepository<BoastUser> {

    public UserDTO getUserDTO(Long id) {
        BoastUser user = findById(id);
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.getUserId(), user.getCreatedOn(), user.getUsername(), user.getEmail());
    }

    public BoastUser getUser(Long id) {
        return findById(id);
    }

    public UserDTO loginUser(String username) {
        BoastUser user = find("username", username).firstResult();
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.getUserId(), user.getCreatedOn(), user.getUsername(), user.getEmail());
    }

    public UserDTO createUser(UserDTO userDTO) {
        BoastUser user = new BoastUser(userDTO);
        persist(user);
        return new UserDTO(user.getUserId(), user.getCreatedOn(), user.getUsername(), user.getEmail());
    }


}
