package social.boast.dto.user;

import java.util.Date;
import java.util.List;

public record UserDTO(Long userId,
                      Date createdOn,
                      String username,
                      String email) {

}