
import SwiftUI

struct NotificationDetailView: View {
    var id: Int
    @State var notification: NotificationModel?
    @State var date: Date?
    var body: some View {
        NavigationStack {
            switch notification?.notificationType {
                case .USER:
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        VStack(alignment: .leading) {
                            HStack {
                                Text(notification?.sendingUserName ?? "")
                                    .bold()
                                Text(notification?.createdOn ?? "")
                                Spacer()
                            }
                            Text(notification?.description ?? "")
                        }
                        Spacer()
                    }
                case .CONGRATULATION:
                    HStack {
                        Image(systemName: "arrowshape.up.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .foregroundStyle(Color.green)
                        HStack {
                            VStack(alignment: .leading) {
                                Text(notification?.header ?? "")
                                    .bold()
                                Text(notification?.description ?? "")
                            }
                            Spacer()
                        }
                        Spacer()

                    }
                case .LOSER:
                    HStack {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                            .foregroundStyle(Color.red)
                        HStack {
                            VStack(alignment: .leading) {
                                Text(notification?.header ?? "")
                                    .bold()
                                Text(notification?.description ?? "")
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                default:
                    Text("loading...")
            }
        }
        .task {
            notification = await getNotificationFromId(id: id)
        }
    }
}
