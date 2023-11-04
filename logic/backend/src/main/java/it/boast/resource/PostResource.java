package it.boast.resource;

import it.boast.model.Post;
import it.boast.repository.PostRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

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
    @Path("/getPostsAsList")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public List<Post> getPostsAsList() {
        return postRepository.getPostsAsList();
    }

    @POST
    @Path("/addPost")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public void addPost(Post post) {
        postRepository.addPost(post);
    }

}
