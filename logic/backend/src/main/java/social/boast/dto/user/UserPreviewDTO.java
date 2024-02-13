package social.boast.dto.user;

import java.util.Date;

public record UserPreviewDTO(
        Long userId,
        String name,
        String username,
        String relationStatus
) {
}
