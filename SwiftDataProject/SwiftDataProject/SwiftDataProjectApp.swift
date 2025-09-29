//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Fidelis Akilan on 9/29/25.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
