package social.boast.dto.user;

public class RelationDTO {
    Long reqUserId;
    Long targetUserId;
    String relationStatus;

    public RelationDTO(Long reqUserId, Long targetUserId, String relationStatus) {
        this.reqUserId = reqUserId;
        this.targetUserId = targetUserId;
        this.relationStatus = relationStatus;
    }

    public Long getReqUserId() {
        return reqUserId;
    }

    public void setReqUserId(Long reqUserId) {
        this.reqUserId = reqUserId;
    }

    public Long getTargetUserId() {
        return targetUserId;
    }

    public void setTargetUserId(Long targetUserId) {
        this.targetUserId = targetUserId;
    }

    public String getRelationStatus() {
        return relationStatus;
    }

    public void setRelationStatus(String relationStatus) {
        this.relationStatus = relationStatus;
    }
}
