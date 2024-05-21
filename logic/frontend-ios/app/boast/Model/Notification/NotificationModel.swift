
import Foundation

class NotificationModel: Codable {
    var notificationId: Int?
    var createdOn: String?
    var description: String?
    var notificationType: NotificationType?
    var sendingUserId: Int?
    var sendingUserName: String?
    var header: String?
    var postId: Int?
}
