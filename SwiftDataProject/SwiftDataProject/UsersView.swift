//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Fidelis Akilan on 10/7/25.
//

import SwiftData
import SwiftUI

struct UsersView: View {
    @Query var users: [User]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                Spacer()
                Text(String(user.unwrappedJobs.count))
                    .fontWeight(.black)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .onAppear(perform: addSample)
    }
    
    init(minimumDate: Date, sortBy: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User>{ user in
            user.joinDate >= minimumDate
        }, sort: sortBy)
    }
    
    func addSample() {
        let user = User(name: "Akilan", city: "Dallas", joinDate: .now.addingTimeInterval(86500*5))
        let job1 = Job(name: "Make plans with Jake", priority: 1)
        let job2 = Job(name: "Study for exam", priority: 2)
        modelContext.insert(user)
        user.jobs?.append(job1)
        user.jobs?.append(job2)
    }
}

#Preview {
    UsersView(minimumDate: .now, sortBy: [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ])
    .modelContainer(for: User.self)
}
