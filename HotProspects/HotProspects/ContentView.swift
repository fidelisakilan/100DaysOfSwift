//
//  ContentView.swift
//  HotProspects
//
//  Created by Fidelis Akilan on 4/7/26.
//

import SwiftUI

struct ContentView: View {
    let users = ["Tohro", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    @State private var selectedTab = "One"
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack {
                    List(users, id: \.self, selection: $selection) { user in
                        Text(user)
                    }
                    if selection.isEmpty == false {
                        Text("Selected value: \(selection.formatted())")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("one")
            
            Button("Switch to tab 1") { selectedTab = "one" }
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("two")
        }
    }
}

#Preview {
    ContentView()
}
