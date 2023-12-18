
import Foundation

class UserViewModel: ObservableObject {
    @Published private(set) var model : UserModel
    
    init(model: UserModel) {
        self.model = model
    }
    
    var userId: Int {
        get {
            model.userId ?? 0
        }
    }
    var createdOn: String {
        get {
            model.createdOn ?? ""
        }
    }
    var username: String {
        get {
            model.username ?? ""
        }
    }
    var email: String {
        get {
            model.email ?? ""
        }
    }
    
    func dataChanged(
        userId: Int? = nil,
        createdOn: String? = nil,
        username: String? = nil,
        email: String? = nil
    ) {
        model.dataChanged(userId: userId, createdOn: createdOn, username: username, email: email)
    }
    
    
    
}
