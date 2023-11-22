
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
    struct DeleteThis: Codable {
        let id = UUID()
        let bet: String
        let creator2: String
        let bet2: String
        let creator3: String
        let bet3: String
        let creator4: String
        let bet4: String
        let creator5: String
        let bet5: String
        let creator6: String
        let bet6: String
        let creator7: String
        let bet7: String
        let creator8: String
        let bet8: String
        let creator9: String
        let bet9: String
        let creator10: String
        let bet81: String
        let creator11: String
        let bet22: String
        let creator33: String
    }
}

typealias Post = Model.Post
typealias PostDetail = Model.PostDetail
