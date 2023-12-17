
import Foundation



func posts() async -> PostModel {
    
    var post = PostModel()
    
    guard let url = URL(string: "http://www.boast.social/api/posts/100") else{ return post }
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        if let data = data, let string = String(data: data, encoding: .utf8){     
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
            }
        }
    }
    task.resume()
    
    return post
}

