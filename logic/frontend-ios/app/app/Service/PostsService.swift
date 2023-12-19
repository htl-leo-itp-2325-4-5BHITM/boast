
import Foundation

func loadPost(postId: Int) async -> PostModel {
    var post = PostModel()
    let url = URL(string: "http://www.boast.social/api/posts/\(postId)")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
            do {
                let postType = try JSONDecoder().decode(TypeModel.self, from: data)
                let type = PostType(rawValue: postType.type!)
                switch type {
                    case .POLL:
                        post = try JSONDecoder().decode(Poll_PostModel.self, from: data)
                    default:
                        break
                }
            } catch {
                print(error)
                print("failed to decode")
            }
    } else {
        print("failed to load url")
    }
    return post
}

func posts() async -> [Int] {
    var postList: [Int] = []
    let url = URL(string: "http://www.boast.social/api/posts")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        postList = try! JSONDecoder().decode([Int].self, from: data)
    } else {
        print("failed to load url")
    }
    return postList
}

func updateStatus(postId: Int, postStatus: Status) async {
    if postId != -1 {
        let url = URL(string: "http://www.boast.social/api/posts/\(postId)/status/\(postStatus)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
            print("status:  \(statusCode)")
        }
        task.resume()
    }
}
