

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

typealias Post = Model.Post
typealias PostDetail = Model.PostDetail
