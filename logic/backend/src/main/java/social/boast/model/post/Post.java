package social.boast.model.post;

import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import social.boast.dto.post.PostDTO;
import social.boast.model.post.type.poll.Poll_Post;
import social.boast.model.post.type.text.Text_Post;
import social.boast.model.user.BoastUser;
import jakarta.persistence.*;
import social.boast.model.user.RelationStatus;

import java.util.Date;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
public class Post extends PanacheEntityBase {
    @Id
    @GeneratedValue
    public Long postId;

    public Date createdOn;

    @Column(length = 80, nullable = false)
    public String title;

    @Column(length = 150, nullable = true)
    public String definition;

    @ManyToOne
    @JoinColumn(name = "creator_userId")
    public BoastUser creator;

    @Enumerated(EnumType.STRING)
    public PostStatus status;

    @Enumerated(EnumType.STRING)
    public PostType postType;

    @ManyToOne
    public BoastUser winner;

    public Post(Date createdOn, String title, String definition, BoastUser creator, PostStatus status, PostType postType) {
        this.createdOn = (createdOn != null) ? createdOn : new Date();
        this.title = title;
        this.definition = definition;
        this.creator = creator;
        this.status = status;
        this.postType = postType;
    }

    public Post() {

    }

    public static List<Long> getPostIds() {
        List<Post> posts = listAll();
        return posts.stream().map(p -> p.postId).toList();
    }

    public static List<Long> getFriendPostIds(Long userId) {
        return getEntityManager()
                        .createQuery("select p.id from Post p \n" +
                                        "join Relation r on p.creator.id = r.id.targetUser.id \n" +
                                        "where r.id.reqUser.id = :userId \n" +
                                        "and r.relationStatus = :status \n" +
                                        "order by p.createdOn desc",
                                Long.class)
                        .setParameter("userId", userId)
                        .setParameter("status", RelationStatus.FRIEND)
                        .getResultList();
    }

    public static void updateStatus(Long id, PostStatus status) {
        Post post = findById(id);
        if (post == null) throw new IllegalArgumentException();
        post.status = status;
    }

    public static Long addWinner(Long id, String name) {
        Post post = findById(id);
        BoastUser user = BoastUser.getBoastUserByName(name);
        if (user == null || post == null) throw new IllegalArgumentException();
        post.winner = user;
        return user.userId;
    }

    public static void removePost(Long postId) {
        try {
            deleteById(postId);
        } catch (Exception e) {
            e.printStackTrace();
            throw new IllegalArgumentException();
        }
    }

    public static Post getPost(Long id) {
        return findById(id);
    }

    public static PostDTO getPostDTO(Long postId) {
        Post post = findById(postId);
        if (post != null) {
            switch (post.postType) {
                case POLL -> {
                    return Poll_Post.getPostDTO((Poll_Post) post);
                }
                case TEXT -> {
                    return Text_Post.getPostDTO((Text_Post) post);
                }
            }
        }
        throw new IllegalArgumentException();
    }
}