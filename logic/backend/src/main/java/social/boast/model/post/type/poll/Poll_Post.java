package social.boast.model.post.type.poll;

import social.boast.dto.post.type.poll.Poll_PostDTO;
import social.boast.model.post.PostStatus;
import social.boast.model.post.Post;
import social.boast.model.post.type.PostType_Interface;
import social.boast.model.post.PostType;
import social.boast.model.user.BoastUser;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;

import java.util.List;

@Entity
public class Poll_Post extends Post implements PostType_Interface<Poll_PostDetail> {
    @OneToMany(mappedBy = "pollPost", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Poll_PostAnswer> pollAnswers;

    @OneToMany(mappedBy = "post", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Poll_PostDetail> postDetails;

    public Poll_Post(Poll_PostDTO postDTO, BoastUser user) {
        super(postDTO.createdOnDate(),
                postDTO.getTitle(),
                postDTO.getDefinition(),
                user,
                PostStatus.valueOf(postDTO.getStatus()),
                PostType.POLL);
    }

    public Poll_Post() {}

    //<editor-fold desc="getter & setter">
    @Override
    public List<Poll_PostDetail> getPostDetails() {
        return postDetails;
    }

    @Override
    public void setPostDetails(List<Poll_PostDetail> postDetails) {
        this.postDetails = postDetails;
    }

    @Override
    public void addPostDetail(Poll_PostDetail postDetail) {
        postDetails.add(postDetail);
    }

    @Override
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
