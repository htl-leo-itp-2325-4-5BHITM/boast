package it.boast.resource;

import it.boast.model.Post;
import it.boast.model.PostDetail;
import it.boast.repository.PostRepository;
import jakarta.inject.Inject;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

import java.util.LinkedList;
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
    @Path("/clearPosts")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public void clearPosts() {
        System.out.println("CLEAR");
        postRepository.clearList();
    }

    @GET
    @Path("/getPostsAsList")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public List<Post> getPostsAsList() {
        List<Post> posts = postRepository.getPostsAsList();
        System.out.println(posts);
        return posts;
    }

    @POST
    @Path("/addPost")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public void addPost(JsonObject object) {
        Post post = new Post(object.getString("title"), object.getString("definition"), object.getString("creator"), object.getString("winner"));
        JsonArray postDetails = object.getJsonArray("postDetails");

        List<PostDetail> postDetailList = new LinkedList<>();

        postDetails.forEach((current) -> {
            JsonObject currentDetailObject = current.asJsonObject();
            postDetailList.add(new PostDetail(currentDetailObject.getString("bet"), currentDetailObject.getString("creator")));
        });

        postRepository.addPost(post, postDetailList);
    }

}
