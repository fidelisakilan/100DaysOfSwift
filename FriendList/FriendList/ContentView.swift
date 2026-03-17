//
//  ContentView.swift
//  FriendList
//
//  Created by Fidelis Akilan on 3/16/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    var body: some View {
        NavigationStack {
            VStack {
                List(users) { user in
                    NavigationLink(value: user){
                        Text(user.name)
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
        if users.isEmpty {
            let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
            do {
                let (data, _) = try await URLSession.shared.data(from: url!)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode([User].self, from: data)
                for model in response {
                    modelContext.insert(model)
                }
            } catch {
                print("Error with network \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    ContentView()
}
