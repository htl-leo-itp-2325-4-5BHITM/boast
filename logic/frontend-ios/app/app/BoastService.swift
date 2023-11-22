
import Foundation

func getPostsAsList() async -> [Model.Post] {
    print("test")
    let url = URL(string: "http://localhost:8080/post/getPostsAsList")!
    var posts = [Model.Post]()
    if let (data, _) = try? await URLSession.shared.data(from: url ) {
        if let loadedPosts = try? JSONDecoder().decode([Model.Post].self, from: data) {
            posts = loadedPosts
        } else {
            print("error while parsing data")
        }
    } else {
        print("error while loading data")
    }
    return posts
}
