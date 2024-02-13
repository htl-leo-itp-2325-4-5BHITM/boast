import Foundation

class UserModel: Codable {
    var userId: Int?
    var createdOn: String?
    var username: String?
    var email: String?
    var isPublic: Bool?
    
    func dataChanged(userId: Int?, createdOn: String?, username: String?, email: String?) {
        if let val = userId {
            self.userId = val
        }
        if let val = createdOn {
            self.createdOn = val
        }
        if let val = username {
            self.username = val
        }
        if let val = email {
            self.email = val
        }
    }
}
