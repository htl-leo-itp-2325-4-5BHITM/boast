package social.boast.resource;

import social.boast.repository.UserRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/users")
public class UserResource {

    @Inject
    UserRepository userRepository;

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getUser(@PathParam("id") Long id) {
        try {
            return Response.ok(userRepository.getUser(id)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }

    @GET
    @Path("/login/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getUser(@PathParam("username") String username) {
        try {
            return Response.ok(userRepository.loginUser(username)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }
}
