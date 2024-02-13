package social.boast.dto.user;

import java.util.Date;
import java.util.List;

public record UserProfileDTO(
        Long userId,
        Date createdOn,
        String name,
        String username,
        int follower,
        int following,
        String relationStatus,
        List<Long> posts
) {
}
