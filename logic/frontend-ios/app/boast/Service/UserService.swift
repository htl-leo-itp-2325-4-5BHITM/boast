
import Foundation

func userLogin(userName: String) async -> Int{
    var userId: Int?
    let url = URL(string: "http://www.boast.social/api/users/login/\(userName)")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        let user = try? JSONDecoder().decode(UserModel.self, from: data)
        userId = user?.userId
    } else {
        print("failed to load url")
    }
    return userId ?? -1
}

func userInfo(userId: Int) async -> ProfileModel?{
    let url = URL(string: "https://www.boast.social/api/users/profile/\(userId)")!
    if let (data, _) = try? await URLSession.shared.data(from: url) {
        print(data)
        let userData = try? JSONDecoder().decode(ProfileModel.self, from: data)
            print(userData?.posts)
            return userData
    } else {
        print("failed to load url")
    }
    return nil
}

