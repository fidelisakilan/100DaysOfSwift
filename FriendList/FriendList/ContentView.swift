//
//  ContentView.swift
//  FriendList
//
//  Created by Fidelis Akilan on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User]? = nil
    var body: some View {
        NavigationStack {
            VStack {
                if users != nil {
                    List(users!) { user in
                        NavigationLink(value: user){
                            Text(user.name)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .navigationDestination(for: User.self) { user in
                UserView(user: user)
            }
            .task {
                await callUsersApi()
            }
        }
    }
    func callUsersApi() async {
        if users == nil {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
            do {
                let (data, _) = try await URLSession.shared.data(from: url!)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                users = try decoder.decode([User].self, from: data)
            } catch {
                print("Error with network \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
