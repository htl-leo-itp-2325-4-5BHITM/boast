package it.boast.repository;

import it.boast.model.Post;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.criteria.CriteriaBuilder;
import jakarta.persistence.criteria.CriteriaQuery;
import jakarta.persistence.criteria.Root;

import java.util.List;

public class PostRepository {

    @Inject
    EntityManager entityManager;

    public PostRepository(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    public void addPost(Post post) {
        entityManager.persist(post);
    }

    public void removePost(Post post) {
        entityManager.remove(post);
    }

    public List<Post> getPostsAsList() {
        CriteriaBuilder cb = entityManager.getCriteriaBuilder();
        CriteriaQuery<Post> cq = ((CriteriaBuilder) cb).createQuery(Post.class);
        Root<Post> rootEntry = cq.from(Post.class);
        CriteriaQuery<Post> all = cq.select(rootEntry);
        TypedQuery<Post> allQuery = entityManager.createQuery(all);
        return allQuery.getResultList();
    }
}
