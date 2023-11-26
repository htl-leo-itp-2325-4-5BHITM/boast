package it.boast.resource;

import it.boast.dto.post.PostDTO;
import it.boast.dto.post.type.poll.Poll_PostDTO;
import it.boast.dto.post.type.poll.Poll_PostDetailDTO;
import it.boast.repository.PostRepository;
import jakarta.inject.Inject;
import jakarta.json.JsonObject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;

import java.util.List;

@Path("/post")
public class PostResource {

    @Inject
    PostRepository postRepository;

    @GET
    @Path("/ping")
    @Produces(MediaType.TEXT_PLAIN)
    public String ping() {
        return "pong";
    }

    @GET
    @Path("/get/{id}")
    @Transactional
    public PostDTO getPost(@PathParam("id") Long id) {
        return postRepository.getPost(id);
    }

    @GET
    @Path("/remove/{id}")
    @Transactional
    public void removePost(@PathParam("id") Long id) {
        System.out.printf("removePost: " + id);
        postRepository.removePost(id);
    }

    @GET
    @Path("/getPostsAsList")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public List<PostDTO> getPostsAsList() {
        System.out.println("Get Posts");
        return postRepository.getPostsAsList();
    }

    @POST
    @Path("/addPostDetail/poll")
    @Transactional
    public Response addPollPostDetail(Poll_PostDetailDTO postDetailDTO) {
        System.out.println("addPollPostDetail");
        try {
            postRepository.addPollPostDetails(postDetailDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }

    @POST
    @Path("/createPost/poll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response addPollPost(Poll_PostDTO postDTO) {
        System.out.println("addPollPost");
        try {
            postRepository.createPollPost(postDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }

}
