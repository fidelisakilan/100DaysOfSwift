//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Fidelis Akilan on 3/12/26.
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
