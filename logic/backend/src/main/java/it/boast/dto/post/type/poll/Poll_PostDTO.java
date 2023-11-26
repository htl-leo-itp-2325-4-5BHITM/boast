package it.boast.dto.post.type.poll;

import it.boast.dto.post.PostDTO;
import it.boast.model.post.type.poll.Poll_PostDetail;

import java.util.Date;
import java.util.List;

public class Poll_PostDTO extends PostDTO {
        Poll_TypeInfoDTO typeInfo;
        List<Poll_PostDetailDTO> postDetails;

        public Poll_PostDTO(Long postId, Date createdOn, String title, String definition, Long creator, String status, Poll_TypeInfoDTO typeInfo, List<Poll_PostDetailDTO> postDetails) {
                super(postId, createdOn, title, definition, creator, status);
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

