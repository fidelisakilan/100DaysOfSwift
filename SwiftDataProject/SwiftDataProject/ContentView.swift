//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Fidelis Akilan on 3/12/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(filter: #Predicate<User> { user in
        user.name.localizedStandardContains("R")
    }, sort: \User.name) var users: [User]
    var body: some View {
        NavigationStack {
            List(users) { user in
                    Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar{
                Button("Add Sample", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    
                    let user1 = User(name: "Ed Sheeran", city: "London", joinDate: .now)
                    let user2 = User(name: "Taylor Swift", city: "Nashville", joinDate: .now)
                    let user3 = User(name: "Maroon", city: "San Francisco", joinDate: .now)
                    let user4 = User(name: "Linkin Park", city: "New York", joinDate: .now)
                    modelContext.insert(user1)
                    modelContext.insert(user2)
                    modelContext.insert(user3)
                    modelContext.insert(user4)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
