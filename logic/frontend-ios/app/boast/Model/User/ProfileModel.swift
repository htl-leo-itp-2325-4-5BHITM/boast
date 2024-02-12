
import Foundation

class ProfileModel: Codable {
    var userId: Int?
    var createdOn: String?
    var name: String?
    var username: String?
    var friends: Int?
    var follows: Int?
    var posts: [Int]?
}

class PreviewModel: Codable {
    var userId: Int?
    var name: String?
    var username: String?
}
