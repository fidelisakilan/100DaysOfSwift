//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Fidelis Akilan on 9/29/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(
//        filter: #Predicate<User> { user in
//            user.name.localizedStandardContains("i")
//        },
        sort: \User.name,
    ) private var users : [User]
    var body: some View {
        NavigationStack {
            Form {
                List(users) { user in
                    Text(user.name)
                }
            }
            .navigationTitle("SwiftData")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Taylor Swift", city: "Nashville", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Linkin Park", city: "Brooklyn", joinDate: .now.addingTimeInterval(86400 * 10))
                    let fourth = User(name: "Ado", city: "Tokyo", joinDate: .now.addingTimeInterval(86400 * 5))
                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
