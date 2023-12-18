package social.boast.dto.post.type.poll;

import social.boast.dto.post.PostDTO;

import java.util.Date;
import java.util.List;

public class Poll_PostDTO extends PostDTO {
    Poll_TypeInfoDTO typeInfo;
    List<Poll_PostDetailDTO> postDetails;

    public Poll_PostDTO(Long postId, Date createdOn, String title, String definition, Long creator, String creatorName, String status, String type, Poll_TypeInfoDTO typeInfo, List<Poll_PostDetailDTO> postDetails) {
        super(postId, createdOn, title, definition, creator, creatorName, status, type);
        this.typeInfo = typeInfo;
        this.postDetails = postDetails;
    }

    public Poll_PostDTO() {
    }

    public Poll_TypeInfoDTO getTypeInfo() {
        return typeInfo;
    }

    public void setTypeInfo(Poll_TypeInfoDTO typeInfo) {
        this.typeInfo = typeInfo;
    }

    public List<Poll_PostDetailDTO> getPostDetails() {
        return postDetails;
    }

    public void setPostDetails(List<Poll_PostDetailDTO> postDetails) {
        this.postDetails = postDetails;
    }
}

