package social.boast.resource;

import social.boast.dto.post.type.poll.Poll_PostDTO;
import social.boast.dto.post.type.text.Text_PostDTO;
import social.boast.model.post.PostStatus;
import social.boast.repository.PostRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/posts")
public class PostResource {

    @Inject
    PostRepository postRepository;

    @GET
    @Path("/{id}")
    @Transactional
    public Response getPost(@PathParam("id") Long id) {
        try {
            return Response.ok(postRepository.getPost(id)).build();
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
            postRepository.removePost(id);
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
            postRepository.updateStatus(id, status);
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
        return postRepository.getPostIds();
    }

    //<editor-fold desc="POLL">
    @POST
    @Path("/poll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response createPollPost(Poll_PostDTO postDTO) {
        try {
            postRepository.createPollPost(postDTO);
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
            postRepository.createTextPost(postDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }
    //</editor-fold>

}
