package it.boast.model.post;

import it.boast.dto.post.PostDTO;
import jakarta.ws.rs.POST;

import java.util.List;

public interface PostType<PostDetail> {
    public List<PostDetail> getPostDetails();
    public void setPostDetails(List<PostDetail> postDetails);
    public void addPostDetail(PostDetail postDetail);
    public void removePostDetail(PostDetail postDetail);
}
