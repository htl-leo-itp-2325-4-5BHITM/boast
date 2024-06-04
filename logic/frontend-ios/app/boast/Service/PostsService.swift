
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
            print("failed to decode2")
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
        do {
            postList = try JSONDecoder().decode([Int].self, from: data)
        }catch{}
    } else {
        print("failed to load url")
    }
    return postList
}

func postsFriends(userId: Int) async -> [Int] {
    var postList: [Int] = []
    let url = URL(string: "https://www.boast.social/api/posts/friends/\(userId)")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        do {
            postList = try JSONDecoder().decode([Int].self, from: data)
        }catch{}
    } else {
        print("failed to load url")
    }
    return postList
}

func setWinner(postId: Int, winnerName: String) async -> Int {
    let url = URL(string: "https://www.boast.social/api/posts/\(postId)/winner/\(winnerName)")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    var winnerId = -200
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let data = data {
            var temp = String(data: data ?? Data(), encoding: .utf8)
            winnerId =  Int(temp ?? "-1") ?? -100
            print("winnerid: \(winnerId)")
        }
    }
    task.resume()
    return winnerId
}

func updateStatus(postId: Int, postStatus: Status) async -> Status {
    var status: Status?
    if postId != -1 {
        let url = URL(string: "https://www.boast.social/api/posts/\(postId)/status/\(postStatus)")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let statusCode = (response as! HTTPURLResponse).statusCode
        }
        task.resume()
        status = postStatus
    }
    return status ?? .CANCELED
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

func createTextPostDetail(creatorId: Int, postId: Int, text: String) -> Int {
    var statusCode: Int?
    print(creatorId, postId, text)
    if (creatorId != -1 && text != "") {
        let url = URL(string: "https://www.boast.social/api/post-details/text")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = Data("{\"creatorId\": \(creatorId), \"postId\": \(postId),\"text\": \"\(text)\"}".utf8) // :(
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
func createPollPost(title: String, definition: String, creatorId: Int, status: Status, type: PostType, typeInfo: [String]) async -> Int {
    var statuscode: Int?
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
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = json
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        statuscode = (response as! HTTPURLResponse).statusCode
    }
    task.resume()
    return statuscode ?? -1
}

func createTextPost(title: String, definition: String, creatorId: Int) async {
    let str = "{\"title\": \"\(title)\", \"definition\": \"\(definition)\", \"creatorId\": \(creatorId), \"status\": \"OPEN\", \"type\": \"TEXT\"}"// :(
    let data = str.data(using: .utf8)
    
    let url = URL(string: "https://boast.social/api/posts/text")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
    request.httpBody = data
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        var statusCode = (response as! HTTPURLResponse).statusCode
    }
    task.resume()
}



func setTextPostWinner(postId: Int, winners: WinnerRanking) async -> Int {
    var statusCode: Int?
    let url = URL(string: "https://www.boast.social/api/posts/\(postId)/text/winners")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = try? JSONEncoder().encode(winners)
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        return (response as! HTTPURLResponse).statusCode
    } catch{
        return statusCode ?? -2
    }
}

func setPollPostWinner(postId: Int, pollId: Int) async -> Int {
    var statusCode: Int?
    let url = URL(string: "https://www.boast.social/api/posts/\(postId)/poll/winners/\(pollId)")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    do {
        let (data, response) = try await URLSession.shared.data(for: request)
        print(response)
        return (response as! HTTPURLResponse).statusCode
    } catch{
        return statusCode ?? -2
    }
}
