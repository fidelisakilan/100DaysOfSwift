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
    }
    
    init(minimumDate: Date, sortBy: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User>{ user in
            user.joinDate >= minimumDate
        }, sort: sortBy)
    }
}

#Preview {
    UsersView(minimumDate: .now, sortBy: [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate)
    ])
    .modelContainer(for: User.self)
}
