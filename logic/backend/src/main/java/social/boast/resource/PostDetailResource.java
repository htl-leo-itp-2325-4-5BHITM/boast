package social.boast.resource;

import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.repository.PostDetailRepository;

@Path("/post-details")
public class PostDetailResource {

    @Inject
    PostDetailRepository postDetailRepository;

    //<editor-fold desc="POLL">
    @POST
    @Path("/poll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response addPollPostDetail(Poll_PostDetailDTO postDetailDTO) {
        try {
            System.err.println("POLL ANSWER: " + postDetailDTO.getPoll_answerId());
            postDetailRepository.addPollPostDetails(postDetailDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }
    //</editor-fold>

}
