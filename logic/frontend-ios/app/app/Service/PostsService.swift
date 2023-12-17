
import Foundation



func posts() -> Poll_PostModel {
    
    var post = Poll_PostModel()
    
    guard let url = URL(string: "http://www.boast.social/api/posts/100") else{ return post }
    let task = URLSession.shared.dataTask(with: url){
        data, response, error in
        if let data = data, let string = String(data: data, encoding: .utf8){     
            do {
                
                // ERSTELLE MODEL KLASSE NUR MIT TYP -> DECODEN DAMIT -> CASE JE NACH POSTTYPE -> JEWEILIGEN JSONDECODER AUFRUFEN
                
                let loadedPosts = try JSONDecoder().decode(PostModel.self, from: data)
                //post = loadedPosts
                print(loadedPosts)
            } catch {
                print(error)
            }
        }
    }
    task.resume()
    
    return post
}

