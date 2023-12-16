package social.boast.dto.post.type.poll;

import social.boast.dto.post.PostDetailDTO;

import java.util.Date;

public class Poll_PostDetailDTO extends PostDetailDTO {
    Long pollAnswerId;

    public Poll_PostDetailDTO(Long postDetailsId, Date createdOn, Long creator, Long postId, Long pollAnswerId) {
        super(postDetailsId, createdOn, creator, postId);
        this.pollAnswerId = pollAnswerId;
    }

    public Long getPollAnswerId() {
        return pollAnswerId;
    }

    public void setPollAnswerId(Long pollAnswerId) {
        this.pollAnswerId = pollAnswerId;
    }
}
