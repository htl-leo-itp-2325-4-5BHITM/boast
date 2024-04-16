package social.boast.dto.post.type.poll;

import social.boast.dto.post.PostDTO;
import social.boast.dto.post.type.PostTypeDTO_Interface;

import java.util.Date;
import java.util.List;

public class Poll_PostDTO extends PostDTO implements PostTypeDTO_Interface<Poll_PostDetailDTO> {
    Poll_TypeInfoDTO typeInfo;
    List<Poll_PostDetailDTO> postDetails;

    public Poll_PostDTO(Long postId, Date createdOn, String title, String definition, Long creator, String creatorName, String status, String type, Long winnerId, String winnerName, Poll_TypeInfoDTO typeInfo, List<Poll_PostDetailDTO> postDetails) {
        super(postId, createdOn, title, definition, creator, creatorName, status, type, winnerId, winnerName);
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

    @Override
    public List<Poll_PostDetailDTO> getPostDetails() {
        return postDetails;
    }

    @Override
    public void setPostDetails(List<Poll_PostDetailDTO> postDetails) {
        this.postDetails = postDetails;
    }
}