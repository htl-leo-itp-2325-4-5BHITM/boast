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

    public PostDetail(String bet, String creator) {
        this.setBet(bet);
        this.setCreator(creator);
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

    //</editor-fold>
}
