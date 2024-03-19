//
//  Feed.swift
//  dummy
//
//  Created by Jannis Sideras on 19.03.24.
//

import SwiftUI

struct Feed: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // USER
                HStack {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 50)
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.title)
                            Text("@Username")
                                .font(.subheadline)
                        }
                        Spacer()
                    }
                }
                
                // BET
                Text("I bet we will get an A+")
                    .font(.title)
                
                HStack {
                    Button(action: {}, label: {
                        Text("4")
                            .font(.title)
                            .foregroundStyle(.white)
                            .frame(height: 40)
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 30)
                            .foregroundStyle(.white)
                    })
                    .buttonStyle(.borderedProminent)
                    .disabled(true)
                    
                    Button(action: {}, label: {
                        Text("10€")
                            .font(.title)
                            .foregroundStyle(.white)
                            .frame(width: 100)
                            .frame(height: 40)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    .disabled(true)
                    //.tint(.yellow)
                    
                    Button(action: {}, label: {
                        Text("Enter Bet")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .frame(height: 40)
                    })
                    .buttonStyle(BorderedProminentButtonStyle())
                    
                }
            }
        }
    }
}

#Preview {
    Feed()
}
