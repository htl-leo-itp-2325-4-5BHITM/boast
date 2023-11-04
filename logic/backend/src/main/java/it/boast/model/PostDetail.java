package it.boast.model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
public class PostDetail implements Serializable {
    @Id
    @GeneratedValue
    private Long postDetailsId;
    @Column(length = 100, nullable = false)
    private String bet;
    @Column(length = 50, nullable = false)
    private String creator;

    @ManyToOne
    @JoinColumn(name = "postId")
    private Post post;

    public PostDetail(Long postDetailsId, String bet, String creator, Post post) {
        this.postDetailsId = postDetailsId;
        this.setBet(bet);
        this.setCreator(creator);
        this.setPost(post);
    }

    public PostDetail() {

    }

    //<editor-fold desc="getter & setter">

    public Long getId() {
        return postDetailsId;
    }

    public String getBet() {
        return bet;
    }

    public void setBet(String bet) {
        this.bet = bet;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public Post getPost() {
        return post;
    }

    public void setPost(Post post) {
        this.post = post;
    }

    //</editor-fold>
}
