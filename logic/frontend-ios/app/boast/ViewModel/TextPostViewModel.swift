

import Foundation

class TextPostViewModel: ObservableObject {
    @Published private(set) var model: Text_PostModel
    
    init(model: Text_PostModel) {
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
 
    var postDetails: [Poll_PostDetailModel] {
        get {
            model.postDetails!
        }
    }
}
