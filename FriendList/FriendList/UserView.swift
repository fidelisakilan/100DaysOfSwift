//
//  UserView.swift
//  FriendList
//
//  Created by Fidelis Akilan on 3/16/26.
//

import SwiftUI

struct UserView: View {
    let user: User
    var body: some View {
        Form {
            LabeledContent("Age") {
                Text(String(user.age))
            }
            LabeledContent("Email") {
                Text(user.email)
            }
            LabeledContent("Address") {
                Text(user.address)
            }
            LabeledContent("Company") {
                Text(user.company)
            }
            LabeledContent("Registered Date") {
                Text(user.registered.formatted())
            }
            LabeledContent("About") {
                Text(user.about)
            }
            Section("Tags") {
                ForEach(user.tags,id: \.self) { tag in
                    Text(tag)
                }
            }
            Section("Friend List") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    UserView()
//}
