package social.boast.resource.milestone;

import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.HeaderParam;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;
import social.boast.model.notification.Notification;
import social.boast.service.MilestoneService;

@Path("/milestone")
public class MilestoneResource {

    @Inject
    MilestoneService milestoneService;

    @GET
    @Path("/")
    @Transactional
    public Response getMilestones(@HeaderParam("reqUserId") Long reqUserId) {
        try {
            if (reqUserId == null) throw new IllegalArgumentException();
            return Response.ok().entity(milestoneService.getMilestones(reqUserId)).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(404).build();
        }
    }
}
