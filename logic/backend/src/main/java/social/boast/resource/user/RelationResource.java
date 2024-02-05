package social.boast.resource.user;

import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import social.boast.dto.user.RelationDTO;
import social.boast.model.user.Relation;

@Path("/relations")
public class RelationResource {

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createRelation(RelationDTO relationDTO) {
        try {
            Relation.createRelation(relationDTO);
            return Response.ok().build();
        } catch (Exception e) {
            return Response.status(422).build();
        }
    }

    @GET
    @Path("/friends/{userId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getFriends(@PathParam("userId") Long userId) {
        return Response.ok(Relation.getFriends(userId)).build();
    }

    @GET
    @Path("/follows/{userId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getFollows(@PathParam("userId") Long userId) {
        return Response.ok(Relation.getFollows(userId)).build();
    }
}
