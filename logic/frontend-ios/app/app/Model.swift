import Foundation

struct Model {
    struct Post: Codable {
        let id = UUID()
        let title, definition, creator, winner: String
        let postDetails: [PostDetail]
    }
    struct PostDetail: Codable {
        let id = UUID()
        let bet, creator: String
    }
}

class PostModel: ObservableObject, Codable {
    enum CodingKeys: String, CodingKey {
            case id
            case title
            case definition
            case creator
            case winner
            case postDetails
        }
    
    @Published var id = UUID();
    @Published var title = "";
    @Published var definition = "";
    @Published var creator = "";
    @Published var winner = "";
    @Published var postDetails = [PostDetailModel]();
    
    init () {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(UUID.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        definition = try values.decode(String.self, forKey: .definition)
        creator = try values.decode(String.self, forKey: .creator)
        winner = try values.decode(String.self, forKey: .winner)
        postDetails = try values.decode([PostDetailModel].self, forKey: .postDetails)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(definition, forKey: .definition)
        try container.encode(creator, forKey: .creator)
        try container.encode(winner, forKey: .winner)
        try container.encode(postDetails, forKey: .postDetails)
    }
}

class PostDetailModel: ObservableObject, Codable {
    enum CodingKeys: String, CodingKey {
            case id
            case bet
            case creator
        }
    
    @Published var id = UUID();
    @Published var bet = "";
    @Published var creator = "";
    
    init () {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(UUID.self, forKey: .id)
        bet = try values.decode(String.self, forKey: .bet)
        creator = try values.decode(String.self, forKey: .creator)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(bet, forKey: .bet)
        try container.encode(creator, forKey: .creator)
    }
}
