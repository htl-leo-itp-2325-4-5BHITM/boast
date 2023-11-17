package it.boast.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import org.hibernate.annotations.Check;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;

@Entity
public class Post implements Serializable {
    @Id
    @GeneratedValue
    private Long postId;

    @Column(length = 80, nullable = false)
    private String title;

    @Column(length = 150, nullable = true)
    private String definition;

    @Column(length = 50, nullable = false)
    private String creator;

    @Column(length = 50, nullable = false)
    private String winner;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<PostDetail> postDetails;

    public Post(Long postId, String title, String definition, String creator, String winner) {
        this.postId = postId;
        this.title = title;
        this.definition = definition;
        this.creator = creator;
        this.winner = winner;
    }

    public Post(String title, String definition, String creator, String winner) {
        this.setTitle(title);
        this.setDefinition(definition);
        this.setCreator(creator);
        this.setWinner(winner);
        postDetails = new LinkedList<>();
    }

    public Post() {

    }

    public void addPostDetail(PostDetail postDetail) {
        this.postDetails.add(postDetail);
    }

    public void removePostDetail(PostDetail postDetail) {
        this.postDetails.remove(postDetail);
    }

    //<editor-fold desc="getter & setter">

    public Long getId() {
        return postId;
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

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getWinner() {
        return winner;
    }

    public void setWinner(String winner) {
        this.winner = winner;
    }

    public List<PostDetail> getPostDetails() {
        return postDetails;
    }

    public void setPostDetails(List<PostDetail> postDetails) {
        this.postDetails = postDetails;
    }

    //</editor-fold>
}
