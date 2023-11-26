package it.boast.dto.post.type.poll;

public class Poll_PostAnswerDTO {
    Long poll_answerId;
    String title;

    public Poll_PostAnswerDTO(Long poll_answerId, String title) {
        this.poll_answerId = poll_answerId;
        this.title = title;
    }

    public Poll_PostAnswerDTO() {
    }

    public Long getPoll_answerId() {
        return poll_answerId;
    }

    public void setPoll_answerId(Long poll_answerId) {
        this.poll_answerId = poll_answerId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
