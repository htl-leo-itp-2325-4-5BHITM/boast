
import SwiftUI

struct Profile: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading) {
                        Text("Name")
                            .font(.title)
                        Text("@Username")
                            .font(.caption)
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 10)
            .frame(height: 75)
            
            Text("This is the Biography\nThis is the Biography")
                .font(.caption)
                .padding(.bottom, 10)
                .padding(.top,4)
            
            
            HStack {
                VStack {
                    Text("85")
                        .font(.title3)
                    Text("follower")
                        .font(.caption)
                }
                Spacer()
                VStack {
                    Text("121")
                        .font(.title3)
                    Text("following")
                        .font(.caption)
                }
                Spacer()
                VStack {
                    Text("1")
                        .font(.title3)
                    Text("posts")
                        .font(.caption)
                }
                Spacer()
                VStack {
                    Text("100")
                        .font(.title3)
                    Text("points")
                        .font(.caption)
                }
            }
            Divider()
                .overlay(.white)
            
            VStack(alignment: .leading) {
                
                // BET
                Text("I bet we will get an A+")
                    .font(.title3)
                
                HStack {
                    Button(action: {}, label: {
                        Text("4")
                            .font(.callout)
                            .foregroundStyle(.white)
                        
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Button(action: {}, label: {
                        Text("10€")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .frame(width: 100)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .disabled(true)
                    //.tint(.yellow)
                    
                    Button(action: {}, label: {
                        Text("Enter Bet")
                            .font(.callout)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
            .padding(10)
            Spacer()
        }
        .padding(10)
    }
}

#Preview {
    Profile()
}
