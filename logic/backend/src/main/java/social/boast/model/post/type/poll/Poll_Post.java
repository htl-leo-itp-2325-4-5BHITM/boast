package social.boast.model.post.type.poll;

import social.boast.dto.post.type.poll.Poll_PostAnswerDTO;
import social.boast.dto.post.type.poll.Poll_PostDTO;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.dto.post.type.poll.Poll_TypeInfoDTO;
import social.boast.model.post.PostStatus;
import social.boast.model.post.Post;
import social.boast.model.post.type.PostType_Interface;
import social.boast.model.post.PostType;
import social.boast.model.user.BoastUser;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;

import java.util.LinkedList;
import java.util.List;

@Entity
public class Poll_Post extends Post implements PostType_Interface<Poll_PostDetail> {
    @OneToMany(mappedBy = "pollPost", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    public List<Poll_PostAnswer> pollAnswers;

    @OneToMany(mappedBy = "post", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    public List<Poll_PostDetail> postDetails;

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
    public void addPostDetail(Poll_PostDetail postDetail) {
        postDetails.add(postDetail);
    }

    @Override
    public void removePostDetail(Poll_PostDetail postDetail) {
        this.postDetails.remove(postDetail);
    }

    public void addPostAnswer(Poll_PostAnswer postAnswer) {
        pollAnswers.add(postAnswer);
    }

    public void removePostAnswer(Poll_PostAnswer postAnswer) {
        pollAnswers.remove(postAnswer);
    }
    //</editor-fold>

    public static void createPollPost(Poll_PostDTO postDTO) {
        BoastUser user = BoastUser.findById(postDTO.getCreatorId());
        if (user == null) throw new IllegalArgumentException();

        Poll_Post post = new Poll_Post(postDTO, user);
        for (Poll_PostAnswerDTO postAnswerDTO : postDTO.getTypeInfo().getPollAnswers()) {
            Poll_PostAnswer postAnswer = new Poll_PostAnswer(post, postAnswerDTO.getTitle());
            getEntityManager().persist(postAnswer);
        }
        persist(post);
    }

    public static Poll_PostDTO getPostDTO(Poll_Post post) {
        List<Poll_PostAnswerDTO> postAnswerDTOS = new LinkedList<>();
        for (Poll_PostAnswer postAnswer : post.pollAnswers) {
            postAnswerDTOS.add(new Poll_PostAnswerDTO(postAnswer.poll_answerId, postAnswer.title));
        }
        Poll_TypeInfoDTO typeInfoDTO = new Poll_TypeInfoDTO(postAnswerDTOS);
        List<Poll_PostDetailDTO> postDetailDTOS = new LinkedList<>();
        for (Poll_PostDetail postDetail : post.postDetails) {
            postDetailDTOS.add(new Poll_PostDetailDTO(
                    postDetail.postDetailsId,
                    postDetail.createdOn,
                    postDetail.creator.userId,
                    postDetail.creator.username,
                    post.postId,
                    postDetail.pollAnswer.poll_answerId));
        }
        return new Poll_PostDTO(
                post.postId,
                post.createdOn,
                post.title,
                post.definition,
                post.creator.userId,
                post.creator.username,
                post.status.name(),
                PostType.POLL.name(),
                post.winner.userId,
                post.winner.username,
                typeInfoDTO,
                postDetailDTOS);
    }

}
