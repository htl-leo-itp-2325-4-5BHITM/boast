package social.boast.dto.user;

import java.util.Date;
import java.util.List;

public class UserDTO {
    Long userId;
    Date createdOn;
    String username;
    String email;
    List<Long> posts;

    public UserDTO(Long userId, Date createdOn, String username, String email) {
        this.userId = userId;
        this.createdOn = createdOn;
        this.username = username;
        this.email = email;
    }

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

    public List<Long> getPosts() {
        return posts;
    }

    public void setPosts(List<Long> posts) {
        this.posts = posts;
    }
}
