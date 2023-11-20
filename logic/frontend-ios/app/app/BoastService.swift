
import Foundation

func getPostsAsList() async -> [Post] {
    let url = URL(string: "http://localhost:8080/post/getPostsAsList")!
    var posts = [Post]()

    if let (data, _) = try? await URLSession.shared.data(from: url ) {
        if let loadedPosts = try? JSONDecoder().decode([Post].self, from: data) {
            posts = loadedPosts
        }else {
            print("failed to decode json object")
        }
    }else {
        print("failed to load")
    }
    return posts
}
