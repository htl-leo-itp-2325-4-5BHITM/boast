package social.boast.model.post.type.text;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.OneToMany;
import social.boast.dto.post.type.text.Text_PostDTO;
import social.boast.model.Status;
import social.boast.model.post.Post;
import social.boast.model.post.PostType;
import social.boast.model.post.type.PostType_Interface;
import social.boast.model.user.BoastUser;

import java.util.List;

@Entity
public class Text_Post extends Post implements PostType_Interface<Text_PostDetail> {

    @OneToMany(mappedBy = "post", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    private List<Text_PostDetail> postDetails;

    public Text_Post(Text_PostDTO postDTO, BoastUser user) {
        super(postDTO.createdOnDate(),
                postDTO.getTitle(),
                postDTO.getDefinition(),
                user,
                Status.valueOf(postDTO.getStatus()),
                PostType.TEXT);
    }

    public Text_Post() {}

    @Override
    public List<Text_PostDetail> getPostDetails() {
        return postDetails;
    }

    @Override
    public void setPostDetails(List<Text_PostDetail> postDetails) {
        this.postDetails = postDetails;
    }

    @Override
    public void addPostDetail(Text_PostDetail postDetail) {
        postDetails.add(postDetail);
    }

    @Override
    public void removePostDetail(Text_PostDetail postDetail) {
        this.postDetails.remove(postDetail);
    }
}
