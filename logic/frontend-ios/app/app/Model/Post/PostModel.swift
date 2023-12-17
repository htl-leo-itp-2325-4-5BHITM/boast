


import Foundation

class PostModel: Codable {
    var postId: Int?
    var createdOn: String?
    var title: String?
    var definition: String?
    var creator: Int?
    var status: Status?
    var type: PostType?
}
