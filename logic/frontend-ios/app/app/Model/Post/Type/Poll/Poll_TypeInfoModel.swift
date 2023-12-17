

import Foundation

class Poll_TypeInfoModel: TypeInfoModel {
    var pollAnswers: [Poll_PostAnswerModel]?
    
    private enum CodingKeys: CodingKey {
        case pollAnswers
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        pollAnswers = try container.decode([Poll_PostAnswerModel].self, forKey: .pollAnswers)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(pollAnswers, forKey: .pollAnswers)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
}
