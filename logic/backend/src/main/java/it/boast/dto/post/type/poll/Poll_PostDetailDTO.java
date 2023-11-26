package it.boast.dto.post.type.poll;

import it.boast.dto.post.PostDetailDTO;

import java.util.Date;

public class Poll_PostDetailDTO extends PostDetailDTO {
    Long pollAnswer;

    public Poll_PostDetailDTO(Long postDetailsId, Date createdOn, Long creator, Long postId, Long pollAnswer) {
        super(postDetailsId, createdOn, creator, postId);
        this.pollAnswer = pollAnswer;
    }

    public Long getPollAnswer() {
        return pollAnswer;
    }

    public void setPollAnswer(Long pollAnswer) {
        this.pollAnswer = pollAnswer;
    }
}
