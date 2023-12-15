package social.boast.model.post;

import java.util.List;

public interface PostType<PostDetail> {
    public List<PostDetail> getPostDetails();
    public void setPostDetails(List<PostDetail> postDetails);
    public void addPostDetail(PostDetail postDetail);
    public void removePostDetail(PostDetail postDetail);
}
