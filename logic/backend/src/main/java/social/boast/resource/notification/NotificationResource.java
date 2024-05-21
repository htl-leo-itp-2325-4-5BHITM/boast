package social.boast.resource.notification;

import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.Response;
import social.boast.model.notification.Notification;

@Path("/notifications")
public class NotificationResource {
    @GET
    @Path("/")
    @Transactional
    public Response getNotifications(@HeaderParam("reqUserId") Long reqUserId) {
        try {
            if (reqUserId == null) throw new IllegalArgumentException();
            return Response.ok(Notification.getNotificationIds(reqUserId)).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(404).build();
        }
    }

    @GET
    @Path("/{id}")
    @Transactional
    public Response getNotifications(@HeaderParam("reqUserId") Long reqUserId, @PathParam("id") Long id) {
        try {
            if (reqUserId == null || id == null) throw new IllegalArgumentException();
            return Response.ok(Notification.getNotificationDTO(id, reqUserId)).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(404).build();
        }
    }
}
