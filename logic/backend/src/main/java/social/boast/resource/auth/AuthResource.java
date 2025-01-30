package social.boast.resource.auth;

import com.auth0.jwt.interfaces.DecodedJWT;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.core.Response;
import social.boast.dto.user.UserDTO;
import social.boast.model.user.BoastUser;
import social.boast.service.AuthService;

import java.util.Calendar;
import java.util.Date;
import java.util.Map;

@Path("/auth")
public class AuthResource {

    @Inject
    AuthService authService;

    @GET
    @Path("/{jwt}")
    @Transactional
    public Response login(@PathParam("jwt") String auth0JWT) {
        System.out.println("LOGIN JWT: " + auth0JWT);
        try {
            DecodedJWT decodedJWT = authService.decodeJWT(auth0JWT);
            BoastUser user = BoastUser.findBySub(decodedJWT.getClaims());
            if (user == null) {
                return Response.status(401).build();
            }
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(Calendar.DAY_OF_MONTH, 1);
            String apiJWT = authService.getSignedToken(Map.of("reqUserId", user.userId.toString()), calendar.getTime());
            return Response.ok().entity(new UserDTO(apiJWT, user.userId, user.createdOn, user.isPublic, user.name, user.username, user.email)).build();
        } catch (Exception e) {
            System.out.println("LOGIN JWT ERROR: " + e.getMessage());
            e.printStackTrace();
            return Response.status(401).build();
        }
    }
}
