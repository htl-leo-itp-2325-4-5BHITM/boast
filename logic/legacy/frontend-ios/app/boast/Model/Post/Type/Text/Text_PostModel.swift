

import Foundation

struct WinnerRanking: Codable {
    var first: [Int]?
    var second: [Int]?
    var third: [Int]?
}

class Text_PostModel: PostModel {
    var postDetails: [Text_PostDetailModel]?
    var winnerRanking: WinnerRanking?
    
    private enum CodingKeys: CodingKey {
        case postDetails
        case winnerRanking
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        postDetails = try container.decode([Text_PostDetailModel].self, forKey: .postDetails)
        winnerRanking = try container.decode(WinnerRanking.self, forKey: .winnerRanking)
        try super.init(from: decoder)
    }
    
    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postDetails, forKey: .postDetails)
        try container.encode(winnerRanking, forKey: .winnerRanking)
        try super.encode(to: encoder)
    }
    
    override init() {
        super.init()
    }
}
