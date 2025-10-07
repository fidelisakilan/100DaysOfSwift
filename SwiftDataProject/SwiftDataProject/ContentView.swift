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
    @State private var sortBy: [SortDescriptor<User>] = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ]
    @State private var showUpcomingOnly = false
    var body: some View {
        NavigationStack {
            UsersView(minimumDate: showUpcomingOnly ? .now : .distantPast, sortBy: sortBy)
                .navigationTitle("SwiftData")
                .toolbar {
                    Button(showUpcomingOnly ? "Show All": "Show Upcoming") {
                        showUpcomingOnly.toggle()
                    }
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortBy) {
                            Text("Sort by name").tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.joinDate)
                            ])
                            Text("Sort by date").tag([
                                SortDescriptor(\User.joinDate),
                                SortDescriptor(\User.name)
                            ])
                        }
                    }
                    Button("Add Samples", systemImage: "plus") {
                        try? modelContext.delete(model: User.self)
                        let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                        let second = User(name: "Taylor Swift", city: "Nashville", joinDate: .now.addingTimeInterval(86400 * -5))
                        let third = User(name: "Linkin Park", city: "Brooklyn", joinDate: .now.addingTimeInterval(86400 * 10))
                        let fourth = User(name: "Ado", city: "Tokyo", joinDate:
                            .now.addingTimeInterval(86400 * 5))
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
