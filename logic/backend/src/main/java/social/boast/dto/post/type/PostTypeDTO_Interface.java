package social.boast.dto.post.type;

import social.boast.dto.post.PostDetailDTO;

import java.util.List;

public interface PostTypeDTO_Interface<PostDetailDTO> {
    public List<PostDetailDTO> getPostDetails();
    public void setPostDetails(List<PostDetailDTO> postDetails);
}
