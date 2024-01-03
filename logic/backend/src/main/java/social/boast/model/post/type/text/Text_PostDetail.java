package social.boast.model.post.type.text;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import social.boast.dto.post.type.text.Text_PostDetailDTO;
import social.boast.model.post.PostDetail;
import social.boast.model.post.type.PostDetailType_Interface;
import social.boast.model.user.BoastUser;

@Entity
public class Text_PostDetail extends PostDetail implements PostDetailType_Interface<Text_Post> {

    @Column(length = 255, nullable = false)
    private String text;

    @ManyToOne
    @JoinColumn(name = "postId")
    Text_Post post;

    public Text_PostDetail(Text_PostDetailDTO postDetailDTO, BoastUser user, Text_Post post, String text) {
        super(postDetailDTO.createdOnDate(), user);
        this.post = post;
        this.text = text;
    }

    public Text_PostDetail() {}

    @Override
    public Text_Post getPost() {
        return post;
    }

    @Override
    public void setPost(Text_Post post) {
            this.post = post;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
