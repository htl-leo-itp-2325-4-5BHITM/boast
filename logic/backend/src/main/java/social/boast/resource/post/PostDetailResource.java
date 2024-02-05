package social.boast.resource.post;

import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import social.boast.dto.post.type.poll.Poll_PostDetailDTO;
import social.boast.dto.post.type.text.Text_PostDetailDTO;
import social.boast.model.post.type.poll.Poll_PostDetail;
import social.boast.model.post.type.text.Text_PostDetail;

@Path("/post-details")
public class PostDetailResource {

    //<editor-fold desc="POLL">
    @POST
    @Path("/poll")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response addPollPostDetail(Poll_PostDetailDTO postDetailDTO) {
        try {
            Poll_PostDetail.addPollPostDetails(postDetailDTO);
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
    public Response addTextPostDetail(Text_PostDetailDTO postDetailDTO) {
        try {
            Text_PostDetail.addTextPostDetails(postDetailDTO);
            return Response.status(200).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(422).build();
        }
    }
    //</editor-fold>

}
