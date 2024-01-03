package social.boast.model.post.type;

import java.util.List;

public interface PostType_Interface<PostDetail> {
    public List<PostDetail> getPostDetails();
    public void setPostDetails(List<PostDetail> postDetails);
    public void addPostDetail(PostDetail postDetail);
    public void removePostDetail(PostDetail postDetail);
}
