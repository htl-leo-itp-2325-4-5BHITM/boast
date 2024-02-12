package social.boast.model.user;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import social.boast.dto.user.UserDTO;
import social.boast.dto.user.UserPreviewDTO;
import social.boast.dto.user.UserProfileDTO;
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
    public String name;

    @Column(length = 50)
    public String username;

    @Column(length = 320)
    public String email;

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    public List<Post> posts;

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    public List<PostDetail> postDetails;

    @OneToMany(mappedBy = "id.reqUser", cascade = CascadeType.ALL)
    public List<Relation> reqRelations;

    @OneToMany(mappedBy = "id.targetUser", cascade = CascadeType.ALL)
    public List<Relation> targetRelations;

    public void addPost(Post post) {
        this.posts.add(post);
    }

    public void removePost(Post post) {
        this.posts.add(post);
    }

    public void addPostDetail(PostDetail postDetail) {
        this.postDetails.add(postDetail);
    }

    public void removePostDetail(PostDetail postDetail) {
        this.postDetails.remove(postDetail);
    }

    public void addReqRelation(Relation relation) {
        this.reqRelations.add(relation);
    }

    public void removeReqRelation(Relation relation) {
        this.reqRelations.remove(relation);
    }

    public void addTargetRelation(Relation relation) {
        this.targetRelations.add(relation);
    }

    public void removeTargetRelation(Relation relation) {
        this.targetRelations.remove(relation);
    }

    public BoastUser() {

    }

    public BoastUser(UserDTO userDTO) {
        this.email = userDTO.email();
        this.name = userDTO.name();
        this.username = userDTO.username();
        this.createdOn = (userDTO.createdOn() != null) ? userDTO.createdOn() : new Date();
    }

    public static UserDTO createUser(UserDTO userDTO) {
        BoastUser user = new BoastUser(userDTO);
        persist(user);
        return new UserDTO(user.userId, user.createdOn, user.name, user.username, user.email);
    }

    public static UserDTO getUserDTO(Long id) {
        BoastUser user = findById(id);
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.userId, user.createdOn, user.name, user.username, user.email);
    }

    public static UserPreviewDTO getUserPreviewDTO(Long id) {
        BoastUser user = findById(id);
        if (user == null) throw new IllegalArgumentException();
        return new UserPreviewDTO(user.userId, user.name, user.username);
    }

    public static UserProfileDTO getUserProfileDTO(Long id) {
        BoastUser user = findById(id);
        if (user == null) throw new IllegalArgumentException();
        return new UserProfileDTO(user.userId, user.createdOn, user.name, user.username, user.targetRelations.size(), user.reqRelations.size(),user.posts.stream().map(p -> p.postId).toList());
    }

    public static UserDTO loginUser(String username) {
        BoastUser user = find("username", username).firstResult();
        if (user == null) throw new IllegalArgumentException();
        return new UserDTO(user.userId, user.createdOn, user.name, user.username, user.email);
    }
}
