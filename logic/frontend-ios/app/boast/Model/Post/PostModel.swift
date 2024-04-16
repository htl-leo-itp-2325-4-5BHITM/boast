


import Foundation

class PostModel: Codable {
    var postId: Int?
    var createdOn: String?
    var title: String?
    var definition: String?
    var creatorId: Int?
    var creatorName: String?
    var status: Status?
    var type: PostType?
    var winnerId: Int?
    var winnerName: String?
}
