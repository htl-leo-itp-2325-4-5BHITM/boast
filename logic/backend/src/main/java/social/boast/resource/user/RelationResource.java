package social.boast.resource.user;

import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import social.boast.dto.user.RelationDTO;
import social.boast.model.user.Relation;
import social.boast.model.user.RelationStatus;

@Path("/relations")
public class RelationResource {

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createRelation(RelationDTO relationDTO) {
        try {
            return Response.ok(Relation.createRelation(relationDTO.reqUserId(), relationDTO.targetUserId(), RelationStatus.valueOf(relationDTO.relationStatus()))).build();
        } catch (Exception e) {
            return Response.status(422).build();
        }
    }

    @GET
    @Path("/followers/{targetUserId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getFollower(@HeaderParam("reqUserId") Long reqUserId, @PathParam("targetUserId") Long targetUserId) {
        return Response.ok(Relation.getFollower(targetUserId)).build();
    }

    @GET
    @Path("/following/{targetUserId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getFollows(@HeaderParam("reqUserId") Long reqUserId, @PathParam("targetUserId") Long targetUserId) {
        return Response.ok(Relation.getFollowing(targetUserId)).build();
    }

    @POST
    @Path("/follow/{targetUserId}")
    @Transactional
    public Response followUser(@HeaderParam("reqUserId") Long reqUserId, @PathParam("targetUserId") Long targetUserId) {
        System.out.println(targetUserId);
        try {
            return Response.ok(Relation.createRelation(reqUserId, targetUserId, RelationStatus.FRIEND)).build();
        } catch (Exception e) {
            return Response.status(422).build();
        }
    }

    @POST
    @Path("/block/{targetUserId}")
    @Transactional
    public Response blockUser(@HeaderParam("reqUserId") Long reqUserId, @PathParam("targetUserId") Long targetUserId) {
        try {
            return Response.ok(Relation.createRelation(reqUserId, targetUserId, RelationStatus.BLOCK)).build();
        } catch (Exception e) {
            return Response.status(422).build();
        }
    }

    @GET
    @Path("/requests")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public Response getRequests(@HeaderParam("reqUserId") Long reqUserId) {
        return Response.ok(Relation.getRequests(reqUserId)).build();
    }
}
