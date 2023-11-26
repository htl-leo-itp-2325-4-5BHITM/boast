package it.boast.model.post;

import it.boast.model.Status;
import it.boast.model.user.BoastUser;
import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Post implements Serializable {
    @Id
    @GeneratedValue
    private Long postId;

    private Date createdOn;

    @Column(length = 80, nullable = false)
    private String title;

    @Column(length = 150, nullable = true)
    private String definition;

    @ManyToOne
    @JoinColumn(name = "creator_userId")
    private BoastUser creator;

    @Enumerated(EnumType.STRING)
    private Status status;

    @Enumerated(EnumType.STRING)
    private PostTypes postType;

    public Post(Date createdOn, String title, String definition, BoastUser creator, Status status, PostTypes postType) {
        this.createdOn = (createdOn != null) ? createdOn : new Date();
        this.title = title;
        this.definition = definition;
        this.creator = creator;
        this.status = status;
        this.postType = postType;
    }

    public Post() {

    }

    //<editor-fold desc="getter & setter">

    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDefinition() {
        return definition;
    }

    public void setDefinition(String definition) {
        this.definition = definition;
    }

    public BoastUser getCreator() {
        return creator;
    }

    public void setCreator(BoastUser creator) {
        this.creator = creator;
    }

    public Date getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public PostTypes getPostType() {
        return postType;
    }

    public void setPostType(PostTypes postType) {
        this.postType = postType;
    }

    //</editor-fold>
}
