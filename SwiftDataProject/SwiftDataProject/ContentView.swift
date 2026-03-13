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
    @State private var showUpcomingDateOnly: Bool = false
    @State private var sortOrder: [SortDescriptor] = [SortDescriptor(\User.name), SortDescriptor(\User.joinDate),]
    var body: some View {
        NavigationStack {
            UsersView(
                minimumJoinDate: showUpcomingDateOnly ? .now : .distantPast,
                sortOrder: sortOrder
            )
            .navigationTitle("Users")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name").tag([
                            SortDescriptor(\User.name),
                            SortDescriptor(\User.joinDate),
                        ])
                        Text("Sort by Date").tag([
                            SortDescriptor(\User.joinDate),
                            SortDescriptor(\User.name),
                        ])
                    }
                }
                Button(showUpcomingDateOnly ? "Show Everyone" : "Show Upcoming") {
                    showUpcomingDateOnly.toggle()
                }
                Button("Add Sample", systemImage: "plus") {
                    let user1 = User(name: "Piper Chapman", city: "New York", joinDate: .now)
                    let job1 = Job(name: "Organize sock drawer", priority: 3)
                    let job2 = Job(name: "Make plans with Alex", priority: 4)

                    modelContext.insert(user1)

                    user1.jobs.append(job1)
                    user1.jobs.append(job2)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
