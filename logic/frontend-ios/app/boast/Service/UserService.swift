
import Foundation

func templateRequest(method: String, reqURL: String, postBody: String? = nil) async -> Data? {
    print("=== REQ ===: \(reqURL)")
    var request = URLRequest(url: URL(string: "https://boast.social/api/\(reqURL)")!)
    request.addValue("\(UserDefaults.standard.integer(forKey: "userId"))", forHTTPHeaderField: "reqUserId")
    request.httpMethod = method
    if let postBody {
        request.httpBody = postBody.data(using: .utf8)
    }    
    
    let response = try? await URLSession.shared.data(for: request)
    print("DATA: \(String(data: response!.0, encoding: .utf8)!)")
    print("REQUEST - STATUS: \((response!.1 as! HTTPURLResponse).statusCode)")
    if (response!.1 as! HTTPURLResponse).statusCode != 200 {
        return nil
    }
    return response!.0
}

func userLogin(userName: String) async -> Int {
    if let data = await templateRequest(method: "GET", reqURL: "users/login/\(userName)") {
        print(data)
        let user = try? JSONDecoder().decode(UserModel.self, from: data)
        return user?.userId ?? -1
    }
    print("du hu")
    return -1
}

func userInfo(userId: Int) async -> ProfileModel? {
    if let data =  await templateRequest(method: "GET", reqURL: "users/profile/\(userId)") {
        let user = try? JSONDecoder().decode(ProfileModel.self, from: data)
        return user
    }
    return nil
}

func userList(userId: Int, userType: String) async -> [Int]? {
    if let data =  await templateRequest(method: "GET", reqURL: "relations/\(userType)/\(userId)") {
        let userList = try? JSONDecoder().decode([Int].self, from: data)
        return userList
    }
    return nil
}

func userPreview(userId: Int) async -> PreviewModel? {
    if let data =  await templateRequest(method: "GET", reqURL: "users/preview/\(userId)") {
        let userPreview = try? JSONDecoder().decode(PreviewModel.self, from: data)
        return userPreview
    }
    return nil
}
