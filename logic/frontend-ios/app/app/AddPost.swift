//
//  AddPost.swift
//  app
//
//  Created by Jannis Sideras on 20.11.23.
//

import SwiftUI

struct AddPost: View {
    @State private var title: String = ""
    @State private var creator: String = ""
    @State private var description: String = ""
    @State private var amountOfPeople: Int = 0

    var body: some View {
        Text("Create a new Bet: ")
            .font(.largeTitle)
            .padding()
        Form(content:  {
            TextField("Title", text: $title)
            TextField("Creator", text: $creator)
            TextField("Description", text: $description, axis: .vertical)
                .lineLimit(3, reservesSpace: true)
            Stepper("Amount of people: \(amountOfPeople)", value: $amountOfPeople, in: 0...10)
            Button("Confirm") {
                
            }
        })
    }
}

#Preview {
    AddPost()
}
