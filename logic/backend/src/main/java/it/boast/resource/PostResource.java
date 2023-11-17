package it.boast.resource;

import it.boast.dto.PostDTO;
import it.boast.dto.PostDetailDTO;
import it.boast.model.Post;
import it.boast.model.PostDetail;
import it.boast.repository.PostRepository;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
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
    public List<PostDTO> getPostsAsList() {
        List<PostDTO> posts = postRepository.getPostsAsList();
        System.out.println(posts);
        return posts;
    }

    @POST
    @Path("/addPost")
    @Produces(MediaType.APPLICATION_JSON)
    @Transactional
    public void addPost(PostDTO postDTO) {
        List<PostDetail> postDetails = new LinkedList<>();

        for (PostDetailDTO postDetailDTO : postDTO.postDetails()) {
            postDetails.add(new PostDetail(postDetailDTO.bet(), postDetailDTO.creator()));
        }

        postRepository.addPost(new Post(postDTO.title(), postDTO.definition(), postDTO.creator(), postDTO.winner()), postDetails);
    }

}
