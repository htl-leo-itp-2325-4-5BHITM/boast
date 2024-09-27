

import Foundation

class Text_PostDetailModel: PostDetailModel {
    var text: String?
    
    private enum CodingKeys: CodingKey {
        case text
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        text = try container.decode(String.self, forKey: .text)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(text, forKey: .text)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
}
