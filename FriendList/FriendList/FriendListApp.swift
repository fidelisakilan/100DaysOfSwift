//
//  FriendListApp.swift
//  FriendList
//
//  Created by Fidelis Akilan on 3/16/26.
//

import SwiftUI
import SwiftData

@main
struct FriendListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
