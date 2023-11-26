package it.boast.model.post.type.poll;

import it.boast.dto.post.type.poll.Poll_PostAnswerDTO;
import it.boast.dto.post.type.poll.Poll_PostDTO;
import it.boast.model.Status;
import it.boast.model.post.Post;
import it.boast.model.post.PostType;
import it.boast.model.post.PostTypes;
import it.boast.model.user.BoastUser;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;

import java.util.List;

@Entity
public class Poll_Post extends Post implements PostType<Poll_PostDetail> {
    @OneToMany(mappedBy = "pollPost", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Poll_PostAnswer> pollAnswers;

    @OneToMany(mappedBy = "post", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Poll_PostDetail> postDetails;

    public Poll_Post(Poll_PostDTO postDTO, BoastUser user) {
        super(postDTO.getCreatedOn(),
                postDTO.getTitle(),
                postDTO.getDefinition(),
                user,
                Status.valueOf(postDTO.getStatus()),
                PostTypes.POLL);
    }

    public Poll_Post(){

    }


    //<editor-fold desc="getter & setter">
    @Override
    public List<Poll_PostDetail> getPostDetails() {
        return postDetails;
    }

    @Override
    public void setPostDetails(List<Poll_PostDetail> postDetails) {
        this.postDetails = postDetails;
    }

    public void addPostDetail(Poll_PostDetail postDetail) {
        postDetails.add(postDetail);
    }

    public void removePostDetail(Poll_PostDetail postDetail) {
        this.postDetails.remove(postDetail);
    }

    public List<Poll_PostAnswer> getPollAnswers() {
        return pollAnswers;
    }

    public void setPollAnswers(List<Poll_PostAnswer> pollAnswers) {
        this.pollAnswers = pollAnswers;
    }

    public void addPostAnswer(Poll_PostAnswer postAnswer) {
        pollAnswers.add(postAnswer);
    }

    public void removePostAnswer(Poll_PostAnswer postAnswer) {
        pollAnswers.remove(postAnswer);
    }
    //</editor-fold>

}
