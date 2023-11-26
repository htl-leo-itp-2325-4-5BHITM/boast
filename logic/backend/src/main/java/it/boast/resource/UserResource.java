package it.boast.resource;

import it.boast.dto.user.UserDTO;
import it.boast.repository.UserRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/user")
public class UserResource {

    @Inject
    UserRepository userRepository;

    @GET
    @Path("/get/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public UserDTO getUser(@PathParam("id") Long id) {
        try {
            return userRepository.getUser(id);
        } catch (Exception e) {
            return null;
        }
    }
}
