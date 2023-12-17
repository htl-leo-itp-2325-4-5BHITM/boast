
import Foundation

class Poll_PostModel: PostModel {
    var typeInfo: Poll_TypeInfoModel?
    var postDetails: [Poll_PostDetailModel]?

    
    func dataChanged(
        postId: Int?,
        createdOn: String?,
        title: String?,
        definiton: String?,
        creator: Int?,
        status: Status?,
        typeInfo: Poll_TypeInfoModel?,
        postDetails: [Poll_PostDetailModel]?
    ){
        if let val = postId {
            self.postId = val
        }
        if let val = createdOn {
            self.createdOn = val
        }
        if let val = title {
            self.title = val
        }
        if let val = definiton {
            self.definition = val
        }
        if let val = creator {
            self.creator = val
        }
        if let val = status {
            self.status = val
        }
    }
    
    private enum CodingKeys: CodingKey {
        case typeInfo
        case postDetails
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        typeInfo = try container.decode(Poll_TypeInfoModel.self, forKey: .typeInfo)
        postDetails = try container.decode([Poll_PostDetailModel].self, forKey: .postDetails)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(typeInfo, forKey: .typeInfo)
        try container.encode(postDetails, forKey: .postDetails)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
}
