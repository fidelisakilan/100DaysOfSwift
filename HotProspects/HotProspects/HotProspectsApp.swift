//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Fidelis Akilan on 4/7/26.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
