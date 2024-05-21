package social.boast.model.post.type.text;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import social.boast.dto.post.type.text.Text_PostDetailDTO;
import social.boast.model.notification.type.user.UserNotification;
import social.boast.model.post.Post;
import social.boast.model.post.PostDetail;
import social.boast.model.user.BoastUser;

@Entity
public class Text_PostDetail extends PostDetail {

    @Column(length = 255, nullable = false)
    public  String text;

    @ManyToOne
    @JoinColumn(name = "postId")
    public Text_Post post;

    public Text_PostDetail(Text_PostDetailDTO postDetailDTO, BoastUser user, Text_Post post, String text) {
        super(postDetailDTO.createdOnDate(), user);
        this.post = post;
        this.text = text;
    }

    public Text_PostDetail() {}

    public static void addTextPostDetails(Text_PostDetailDTO postDetailDTO) {
        BoastUser user = BoastUser.findById(postDetailDTO.getCreatorId());
        Text_Post post = (Text_Post) Post.getPost(postDetailDTO.getPostId());
        if (user == null || post == null) throw new IllegalArgumentException();

        Text_PostDetail postDetail = new Text_PostDetail(postDetailDTO, user, post, postDetailDTO.getText());

        post.addPostDetail(postDetail);

        UserNotification.createUserNotification(post.creator, post.title + ": " + postDetail.text, user);

        persist(postDetail);
    }
}
