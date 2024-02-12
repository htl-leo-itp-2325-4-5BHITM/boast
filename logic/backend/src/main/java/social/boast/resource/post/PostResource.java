package social.boast.resource.post;

import social.boast.dto.post.type.poll.Poll_PostDTO;
import social.boast.dto.post.type.text.Text_PostDTO;
import social.boast.model.post.Post;
import social.boast.model.post.PostStatus;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.text.Text_Post;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/posts")
public class PostResource {

    @GET
    @Path("/{id}")
    @Transactional
    public Response getPost(@PathParam("id") Long id) {
        try {
            return Response.ok(Post.getPostDTO(id)).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(404).build();
        }
    }

    @DELETE
    @Path("/{id}")
    @Transactional
    public Response removePost(@PathParam("id") Long id) {
        try {
            Post.removePost(id);
            return Response.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(404).build();
        }
    }

    @POST
    @Path("/{id}/status/{status}")
    @Transactional
    public Response updateStatus(@PathParam("id") Long id, @PathParam("status") PostStatus status) {
        System.out.printf("update Status: " + id + " Set: " + status.name());
        try {
            Post.updateStatus(id, status);
            return Response.ok().build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(404).build();
        }
    }

    @GET
    @Path("")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public List<Long> getPostIds() {
        return Post.getPostIds();
    }

    @GET
    @Path("/friends/{userId}")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public List<Long> getFriendPostIds(@PathParam("userId") Long userId) {
        return Post.getFriendPostIds(userId);
    }

    //<editor-fold desc="POLL">
    @POST
    @Path("/poll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createPollPost(Poll_PostDTO postDTO) {
        try {
            Poll_Post.createPollPost(postDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }
    //</editor-fold>

    //<editor-fold desc="TEXT">
    @POST
    @Path("/text")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createTextPost(Text_PostDTO postDTO) {
        try {
            Text_Post.createTextPost(postDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }
    //</editor-fold>

}
