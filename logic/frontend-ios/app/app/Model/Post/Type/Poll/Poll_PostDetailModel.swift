
import Foundation

class Poll_PostDetailModel: PostDetailModel {
    var poll_answerId: Int?

    private enum CodingKeys: CodingKey {
        case poll_answerId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        poll_answerId = try container.decode(Int.self, forKey: .poll_answerId)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(poll_answerId, forKey: .poll_answerId)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
}
