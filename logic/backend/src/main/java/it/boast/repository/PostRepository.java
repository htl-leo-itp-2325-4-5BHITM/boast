package it.boast.repository;

import it.boast.model.Post;
import it.boast.model.PostDetail;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;

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

    public List<Post> getPostsAsList() {
        return entityManager.createQuery("select p from Post p", Post.class).getResultList().stream().toList();
    }

    public void clearList() {
        entityManager.createQuery("delete from Post").executeUpdate();
        entityManager.createQuery("delete from PostDetail").executeUpdate();
    }
}
