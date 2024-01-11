

import Foundation

class Text_PostModel: PostModel {
    var postDetails: [Poll_PostDetailModel]?
    
    private enum CodingKeys: CodingKey {
        case postDetails
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        postDetails = try container.decode([Poll_PostDetailModel].self, forKey: .postDetails)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postDetails, forKey: .postDetails)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
}
