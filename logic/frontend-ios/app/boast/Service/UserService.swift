
import Foundation

func templateRequest(method: String, reqURL: String, postBody: String? = nil) async -> Data? {
    print("=== REQ ===: \(reqURL)")
    var request = URLRequest(url: URL(string: "https://boast.social/api/\(reqURL)")!)
    request.addValue("\(UserDefaults.standard.integer(forKey: "userId"))", forHTTPHeaderField: "reqUserId")
    request.httpMethod = method
    if let postBody {
        request.httpBody = postBody.data(using: .utf8)
    }    
    
    if let (data, response) = try? await URLSession.shared.data(for: request) {
        print(String(data: data, encoding: .utf8))
        return data
    }
    return nil
}

func userLogin(userName: String) async -> Int {
    if let data = await templateRequest(method: "GET", reqURL: "users/login/\(userName)") {
        let user = try? JSONDecoder().decode(UserModel.self, from: data)
        return user?.userId ?? -1
    }
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

func followUser(targetId: Int) async -> RelationStatus? {
    if let data =  await templateRequest(method: "POST", reqURL: "relations/follow/\(targetId)") {
        let changedRelation = try? JSONDecoder().decode(RelationStatus.self, from: data)
        return changedRelation
    }
    return nil
}

func unfollowUser(targetId: Int) async -> RelationStatus? {
    if let data =  await templateRequest(method: "POST", reqURL: "relations/unfollow/\(targetId)") {
        let changedRelation = try? JSONDecoder().decode(RelationStatus.self, from: data)
        return changedRelation
    }
    return nil
}

func searchForUsers(searchText: String) async -> [PreviewModel] {
    if let data =  await templateRequest(method: "GET", reqURL: "users/search/\(searchText)") {
        let userList = try? JSONDecoder().decode([PreviewModel].self, from: data)
        return userList ?? [PreviewModel]()
    }
    return [PreviewModel]()
}

func getNotification() async -> [Int] {
    if let data = await templateRequest(method: "GET", reqURL: "notifications") {
        let notifications = (try? JSONDecoder().decode([Int].self, from: data)) ?? []
        return notifications
    }
    return []
}

func getNotificationFromId(id: Int) async -> NotificationModel {
    if let data = await templateRequest(method: "GET", reqURL: "notifications/\(id)") {
        let notifications = (try? JSONDecoder().decode(NotificationModel.self, from: data)) ?? NotificationModel()
        return notifications
    }
    return NotificationModel()
}
