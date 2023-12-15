package social.boast.dto.post.type.poll;

import social.boast.dto.post.TypeInfoDTO;

import java.util.List;

public class Poll_TypeInfoDTO extends TypeInfoDTO {
    List<Poll_PostAnswerDTO> pollAnswers;

    public Poll_TypeInfoDTO(String type, List<Poll_PostAnswerDTO> pollAnswers) {
        super(type);
        this.pollAnswers = pollAnswers;
    }

    public List<Poll_PostAnswerDTO> getPollAnswers() {
        return pollAnswers;
    }

    public void setPollAnswers(List<Poll_PostAnswerDTO> pollAnswers) {
        this.pollAnswers = pollAnswers;
    }
}
