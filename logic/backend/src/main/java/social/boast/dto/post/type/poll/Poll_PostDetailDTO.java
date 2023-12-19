package social.boast.dto.post.type.poll;

import social.boast.dto.post.PostDetailDTO;

import java.util.Date;

public class Poll_PostDetailDTO extends PostDetailDTO {
    Long poll_answerId;

    public Poll_PostDetailDTO(Long postDetailsId, Date createdOn, Long creator, String creatorName, Long postId, Long pollAnswerId) {
        super(postDetailsId, createdOn, creator, creatorName, postId);
        this.poll_answerId = pollAnswerId;
    }

    public Long getPoll_answerId() {
        return poll_answerId;
    }

    public void setPoll_answerId(Long poll_answerId) {
        this.poll_answerId = poll_answerId;
    }
}
