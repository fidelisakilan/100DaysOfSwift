//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Fidelis Akilan on 9/20/25.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
