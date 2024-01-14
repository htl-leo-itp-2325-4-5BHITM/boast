
import Foundation

func loadPost(postId: Int) async -> PostModel {
    var post = PostModel()
    let url = URL(string: "https://www.boast.social/api/posts/\(postId)")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        do {
            let postType = try JSONDecoder().decode(TypeModel.self, from: data)
            let type = PostType(rawValue: postType.type!)
            switch type {
            case .POLL:
                post = try JSONDecoder().decode(Poll_PostModel.self, from: data)
            case .TEXT:
                post = try JSONDecoder().decode(Text_PostModel.self, from: data)
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
    let url = URL(string: "https://www.boast.social/api/posts")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        postList = try! JSONDecoder().decode([Int].self, from: data)
    } else {
        print("failed to load url")
    }
    return postList
}

func updateStatus(postId: Int, postStatus: Status) async {
    if postId != -1 {
        let url = URL(string: "https://www.boast.social/api/posts/\(postId)/status/\(postStatus)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
        }
        task.resume()
    }
}

//TODO

func createPostDetail(creatorId: Int, postId: Int, pollAnswerId: Int) -> Int {
    var statusCode: Int?
    print(creatorId, postId, pollAnswerId)
    if (creatorId != -1 && pollAnswerId != -1) {
        let url = URL(string: "https://www.boast.social/api/post-details/poll")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = Data("{\"creator\": \(creatorId),\"postId\": \(postId),\"pollAnswerId\": \(pollAnswerId)}".utf8) // :(
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print((response as! HTTPURLResponse).statusCode)
            statusCode = (response as! HTTPURLResponse).statusCode 
            if let error = error {
                print(error)
                return
            }
        }
        task.resume()
    }
    return statusCode ?? -1
}

// DRINGENST DTO KLASSEN IMPLEMENTIEREN
func createPost(title: String, definition: String, creatorId: Int, status: Status, type: PostType, typeInfo: [String]) async {
    let post = Poll_PostModel()
    post.title = title
    post.definition = definition
    post.creatorId = creatorId
    post.status = status
    post.type = type
    var pollAnswers = [Poll_PostAnswerModel]()
    for answer in 0..<typeInfo.count {
        var temp = Poll_PostAnswerModel()
        temp.title = typeInfo[answer]
        pollAnswers.append(temp)
    }
    let typeInfo = Poll_TypeInfoModel()
    typeInfo.pollAnswers = pollAnswers
    post.typeInfo = typeInfo
    
    
    let json = try? JSONEncoder().encode(post)
    let url = URL(string: "https://www.boast.social/api/posts/poll")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.httpBody = json
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        var statusCode = (response as! HTTPURLResponse).statusCode
    }
    task.resume()
}
