

import Foundation

class Text_PostModel: PostModel {
    var postDetails: [Text_PostDetailModel]?
    var winners: [Int]?
    
    private enum CodingKeys: CodingKey {
        case postDetails
        case winners
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        postDetails = try container.decode([Text_PostDetailModel].self, forKey: .postDetails)
        winners = try container.decode([Int].self, forKey: .winners)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postDetails, forKey: .postDetails)
        try container.encode(winners, forKey: .winners)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
}
