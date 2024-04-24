package social.boast.model.post.type.text;

import jakarta.persistence.*;
import social.boast.dto.post.type.text.Text_PostDTO;
import social.boast.dto.post.type.text.Text_PostDetailDTO;
import social.boast.model.post.PostStatus;
import social.boast.model.post.Post;
import social.boast.model.post.PostType;
import social.boast.model.post.type.PostType_Interface;
import social.boast.model.user.BoastUser;

import java.util.LinkedList;
import java.util.List;

@Entity
public class Text_Post extends Post implements PostType_Interface<Text_PostDetail> {

    @OneToMany(mappedBy = "post", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    public List<Text_PostDetail> postDetails;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    public List<BoastUser> winners;

    public Text_Post(Text_PostDTO postDTO, BoastUser user) {
        super(postDTO.createdOnDate(),
                postDTO.getTitle(),
                postDTO.getDefinition(),
                user,
                PostStatus.valueOf(postDTO.getStatus()),
                PostType.TEXT);
    }

    public Text_Post() {}

    @Override
    public void addPostDetail(Text_PostDetail postDetail) {
        postDetails.add(postDetail);
    }

    @Override
    public void removePostDetail(Text_PostDetail postDetail) {
        this.postDetails.remove(postDetail);
    }

    public void addWinner(BoastUser user) {
        if (!winners.contains(user)) winners.add(user);
    }

    public void removeWinner(BoastUser user) {
        winners.remove(user);
    }

    public static void createTextPost(Text_PostDTO postDTO) {
        BoastUser user = BoastUser.findById(postDTO.getCreatorId());
        if (user == null) throw new IllegalArgumentException();

        Text_Post post = new Text_Post(postDTO, user);
        persist(post);
    }

    public static void addWinners(Long postId, Long[] winners) {
        Text_Post post = Text_Post.findById(postId);
        if (post == null) throw new IllegalArgumentException();
        for (Long winner: winners) {
            BoastUser user = BoastUser.findById(winner);
            if (user == null) throw new IllegalArgumentException();
            post.addWinner(user);
        }
    }

    public static void removeWinners(Long postId, int[] winners) {
        Text_Post post = Text_Post.findById(postId);
        if (post == null) throw new IllegalArgumentException();
        for (int winner: winners) {
            BoastUser user = BoastUser.findById(winner);
            if (user == null) throw new IllegalArgumentException();
            post.removeWinner(user);
        }
    }

    public static Text_PostDTO getPostDTO(Text_Post post) {
        List<Text_PostDetailDTO> postDetailDTOS = new LinkedList<>();
        for (Text_PostDetail postDetail : post.postDetails) {
            postDetailDTOS.add(new Text_PostDetailDTO(
                    postDetail.postDetailsId,
                    postDetail.createdOn,
                    postDetail.creator.userId,
                    postDetail.creator.username,
                    post.postId,
                    postDetail.text));
        }
        return new Text_PostDTO(post.postId,
                post.createdOn,
                post.title,
                post.definition,
                post.creator.userId,
                post.creator.username,
                post.status.name(),
                PostType.TEXT.name(),
                post.winners.stream().map((BoastUser user) -> user.userId).toList(),
                postDetailDTOS);
    }
}
