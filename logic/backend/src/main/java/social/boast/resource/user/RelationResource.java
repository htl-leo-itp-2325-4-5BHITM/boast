package social.boast.resource.user;

import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import social.boast.dto.user.RelationDTO;
import social.boast.model.user.Relation;

@Path("/relations")
public class RelationResource {

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    @Transactional
    public Response relation (RelationDTO relationDTO) {
        try {
            Relation.createRelation(relationDTO);
            return Response.ok().build();
        } catch (Exception e) {
            return Response.status(422).build();
        }
    }
}
