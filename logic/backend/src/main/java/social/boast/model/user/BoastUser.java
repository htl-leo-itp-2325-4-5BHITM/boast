package social.boast.model.user;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import social.boast.dto.user.UserDTO;
import social.boast.model.post.Post;
import social.boast.model.post.PostDetail;
import jakarta.persistence.*;

import java.util.Date;
import java.util.List;

@Entity
public class BoastUser extends PanacheEntityBase {

    @Id
    @GeneratedValue
    public Long userId;

    public Date createdOn;

    @Column(length = 50)
    public String username;

    @Column(length = 320)
    public String email;

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    public List<Post> posts;

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    public List<PostDetail> postDetails;

    public BoastUser () {

    }

    public BoastUser(UserDTO userDTO) {
        this.email = userDTO.email();
        this.username = userDTO.username();
        this.createdOn = (userDTO.createdOn() != null) ? userDTO.createdOn() : new Date();
    }

    public static UserDTO createUser(UserDTO userDTO) {
        BoastUser user = new BoastUser(userDTO);
        persist(user);
        return new UserDTO(user.userId, user.createdOn, user.username, user.email);
    }

    public static UserDTO getUserDTO(Long id) {
        BoastUser user = findById(id);
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.userId, user.createdOn, user.username, user.email);
    }

    public static UserDTO loginUser(String username) {
        BoastUser user = find("username", username).firstResult();
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.userId, user.createdOn, user.username, user.email);
    }
}
