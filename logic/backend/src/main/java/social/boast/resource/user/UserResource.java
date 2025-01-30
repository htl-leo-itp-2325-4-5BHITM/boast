package social.boast.resource.user;

import jakarta.ws.rs.*;
import social.boast.dto.user.UserDTO;
import social.boast.model.user.BoastUser;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

@Path("/users")
public class UserResource {

    /*
    @POST
    @Path("")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createUser(UserDTO user) {
        try {
            return Response.ok(BoastUser.createUser(user)).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }*/

    @GET
    @Path("/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getUser(@PathParam("id") Long id) {
        try {
            return Response.ok(BoastUser.getUserDTO(id)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }

    @GET
    @Path("/preview/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getUserPreview(@HeaderParam("reqUserId") Long reqUserId, @PathParam("id") Long id) {
        try {
            return Response.ok(BoastUser.getUserPreviewDTO(reqUserId, id)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }

    @GET
    @Path("/profile/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getUserProfile(@HeaderParam("reqUserId") Long reqUserId, @PathParam("id") Long id) {
        try {
            return Response.ok(BoastUser.getUserProfileDTO(reqUserId, id)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }

    @GET
    @Path("/profile/username/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getUserProfileByName(@HeaderParam("reqUserId") Long reqUserId, @PathParam("username") String username) {
        try {
            return Response.ok(BoastUser.getUserProfileDTOByUsername(reqUserId, username)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }

    /*
    @GET
    @Path("/login/{username}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getUser(@PathParam("username") String username) {
        try {
            return Response.ok(BoastUser.loginUser(username)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }*/

    @GET
    @Path("/search/{searchParam}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response searchUser(@HeaderParam("reqUserId") Long reqUserId, @PathParam("searchParam") String searchParam) {
        try {
            return Response.ok(BoastUser.searchUsers(reqUserId, searchParam)).status(200).build();
        } catch (Exception e) {
            return Response.status(404).build();
        }
    }
}
