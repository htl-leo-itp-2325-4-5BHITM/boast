
import Foundation

class PostViewModel: ObservableObject {
    @Published private(set) var model: PostModel
    
    init(model: PostModel) {
        self.model = model
    }
    
    var postId: Int {
        get {
            model.postId!
        }
    }
    
    var createdOn: String {
        get {
            model.createdOn!
        }
    }
    
    var title: String {
        get {
            model.title!
        }
    }
    
    var definiton: String {
        get {
            model.definition!
        }
    }
    var creatorId: Int {
        get {
            model.creatorId!
        }
    }
    var creatorName: String {
        get {
            model.creatorName!
        }
    }
    var status: Status {
        get {
            model.status!
        }
    }
    
    var type: PostType {
        get {
            model.type!
        }
    }
    
}
