
import Foundation

func getPostsAsList() async -> [PostModel] {
    let url = URL(string: "http://localhost:8080/post/getPostsAsList")!
    var posts = [PostModel]()
    if let (data, _) = try? await URLSession.shared.data(from: url ) {
        if let loadedPosts = try? JSONDecoder().decode([PostModel].self, from: data) {
            posts = loadedPosts
        }
    }
    return posts
}
