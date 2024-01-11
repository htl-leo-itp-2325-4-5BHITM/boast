
import Foundation

class PollPostViewModel: ObservableObject {
    @Published private(set) var model: Poll_PostModel
    
    init(model: Poll_PostModel) {
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
    var typeInfo: Poll_TypeInfoModel {
        get {
            model.typeInfo!
        }
    }
    var postDetails: [Poll_PostDetailModel] {
        get {
            model.postDetails!
        }
    }
    
    func dataChanged(
        postId: Int? = nil,
        createdOn: String? = nil,
        title: String? = nil,
        definiton: String? = nil,
        creatorId: Int? = nil,
        creatorName: String? = nil,
        status: Status? = nil,
        typeInfo: Poll_TypeInfoModel? = nil,
        postDetails: [Poll_PostDetailModel]? = nil
    ){
        model.dataChanged(
            postId: postId,
            createdOn: createdOn,
            title: title,
            definiton: definiton,
            creatorId: creatorId,
            creatorName: creatorName,
            status: status,
            typeInfo: typeInfo,
            postDetails: postDetails
        )
    }
    
}
