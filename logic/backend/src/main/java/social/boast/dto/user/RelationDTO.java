package social.boast.dto.user;

public record RelationDTO(Long reqUserId,
                          Long targetUserId,
                          String relationStatus) {
}