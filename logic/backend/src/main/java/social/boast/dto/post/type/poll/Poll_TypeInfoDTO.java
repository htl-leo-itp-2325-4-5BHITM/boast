package social.boast.dto.post.type.poll;

import java.util.List;

public class Poll_TypeInfoDTO {
    List<Poll_PostAnswerDTO> pollAnswers;

    public Poll_TypeInfoDTO(List<Poll_PostAnswerDTO> pollAnswers) {
        this.pollAnswers = pollAnswers;
    }

    public Poll_TypeInfoDTO() {
    }

    public List<Poll_PostAnswerDTO> getPollAnswers() {
        return pollAnswers;
    }

    public void setPollAnswers(List<Poll_PostAnswerDTO> pollAnswers) {
        this.pollAnswers = pollAnswers;
    }
}
