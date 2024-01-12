package social.boast.resource;

import io.smallrye.openapi.runtime.io.mediatype.MediaTypeWriter;
import jakarta.ws.rs.*;
import social.boast.dto.user.RelationDTO;
import social.boast.dto.user.UserDTO;
import social.boast.repository.UserRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/users")
public class UserResource {

    @Inject
    UserRepository userRepository;

    @POST
    @Path("")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createUser(UserDTO user) {
        try {
            return Response.ok(userRepository.createUser(user)).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }

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

    // RELATIONS
    @POST
    @Path("/relations")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response relation (RelationDTO relationDTO) {
        try {
            userRepository.relation(relationDTO);
            return Response.ok().build();
        } catch (Exception e) {
            return Response.status(422).build();
        }
    }
}
