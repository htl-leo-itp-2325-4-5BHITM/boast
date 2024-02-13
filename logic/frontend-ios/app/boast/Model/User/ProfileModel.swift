
import Foundation

class ProfileModel: Codable {
    var userId: Int?
    var createdOn: String?
    var name: String?
    var username: String?
    var follower: Int?
    var following: Int?
    var relationStatus: RelationStatus?
    var posts: [Int]?
}

class PreviewModel: Codable {
    var userId: Int?
    var name: String?
    var username: String?
}
