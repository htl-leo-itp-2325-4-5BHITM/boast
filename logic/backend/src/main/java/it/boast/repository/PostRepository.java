package it.boast.repository;

import it.boast.dto.PostDTO;
import it.boast.dto.PostDetailDTO;
import it.boast.model.Post;
import it.boast.model.PostDetail;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

import java.util.LinkedList;
import java.util.List;

@ApplicationScoped
public class PostRepository {

    @Inject
    EntityManager entityManager;

    public PostRepository(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void addPost(Post post, List<PostDetail> postDetailList) {
        for (PostDetail current : postDetailList) {
            entityManager.persist(current);
            post.addPostDetail(current);
        }
        entityManager.persist(post);
    }

    public void removePost(Post post) {
        entityManager.remove(post);
    }

    public List<PostDTO> getPostsAsList() {
        List<Post> posts = entityManager.createQuery("select p from Post p", Post.class).getResultList().stream().toList();
        List<PostDTO> postDTOS = new LinkedList<>();
        for (Post post: posts) {
            List<PostDetailDTO> postDetails = new LinkedList<>();
            for (PostDetail postDetail : post.getPostDetails()) {
                postDetails.add(new PostDetailDTO(postDetail.getBet(), postDetail.getCreator()));
            }
            postDTOS.add(new PostDTO(post.getTitle(), post.getDefinition(), post.getCreator(), post.getWinner(), postDetails));
        }
        return postDTOS;
    }

    public void clearList() {
        entityManager.createQuery("delete from Post").executeUpdate();
        entityManager.createQuery("delete from PostDetail").executeUpdate();
    }
}
