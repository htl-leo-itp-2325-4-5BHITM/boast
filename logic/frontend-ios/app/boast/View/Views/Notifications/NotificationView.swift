
import SwiftUI

struct NotificationView: View {
    var notifications: Array<Int>
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(0..<notifications.count) { notification in
                        NotificationDetailView(id: notifications[notification])
                    }
                }
            }
        }
        
    }
}

