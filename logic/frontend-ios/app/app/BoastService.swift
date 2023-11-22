
import Foundation

func getPostsAsList() async -> [PostModel] {
    print("test")
    let url = URL(string: "http://localhost:8080/post/getPostsAsList")!
    var posts = [PostModel]()
    if let (data, _) = try? await URLSession.shared.data(from: url ) {
        if let loadedPosts = try? JSONDecoder().decode([PostModel].self, from: data) {
            posts = loadedPosts
        } else {
            print("error while parsing data")
        }
    } else {
        print("error while loading data")
    }
    return posts
}

func addPost(postModel: PostModel) async {
    let url = URL(string: "http://localhost:8080/post/addPost")!
    
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    request.httpBody = try? JSONEncoder().encode(postModel)
    
    URLSession.shared.dataTask(with: request){
                    (data, response, error) in
                    
                    guard let data = data else{
                        return
                    }
                    print(data)
                    
                }.resume()
    


}
