package social.boast.model.user;

import social.boast.model.post.Post;
import social.boast.model.post.PostDetail;
import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Entity
public class BoastUser implements Serializable {

    @Id
    @GeneratedValue
    private Long userId;

    private Date createdOn;

    @Column(length = 50)
    private String username;

    @Column(length = 320)
    private String email;

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    List<Post> posts;

    @OneToMany(mappedBy = "creator", cascade = CascadeType.ALL)
    List<PostDetail> postDetails;

    public BoastUser() {
    }

    //<editor-fold desc="getter & setter">
    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<Post> getPosts() {
        return posts;
    }

    public void setPosts(List<Post> posts) {
        this.posts = posts;
    }

    public List<PostDetail> getPostDetails() {
        return postDetails;
    }

    public void setPostDetails(List<PostDetail> postDetails) {
        this.postDetails = postDetails;
    }

    //</editor-fold>
}
