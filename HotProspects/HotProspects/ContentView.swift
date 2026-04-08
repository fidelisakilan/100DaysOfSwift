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
    @State private var output = ""
    @State private var backgroundColor = Color.white
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack {
                    List(users, id: \.self, selection: $selection) { user in
                        Text(user)
                    }
                    Spacer()
                    Spacer()
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
            
            VStack {
                Button("Switch to tab 1") { selectedTab = "one" }
                if output != "" { Text(output) }
            }
            .tabItem {
                Label("Two", systemImage: "circle")
            }
            .tag("two")
            NavigationStack {
                VStack {
                    Image(.guy)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .background(backgroundColor)
                        .padding()
                        .contextMenu {
                            Button("Transparent", systemImage: "trash") {
                                backgroundColor = .white
                            }
                            Button("Red") {
                                backgroundColor = .red
                            }
                            Button("Blue") {
                                backgroundColor = .blue
                            }
                            Button("Green") {
                                backgroundColor = .green
                            }
                        }
                }
            }
            .tabItem {
                Label("Three", systemImage: "square")
            }
            .tag("three")
        }
        .task {
            await fetchApi()
        }
    }
    
    func fetchApi() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        let result = await fetchTask.result
        
        switch result {
        case .success(let data):
            output = data
        case .failure(let error):
            output = "error: \(error.localizedDescription)"
        }
        
//        do {
//            output = result.get()
//        } catch {
//            output = "error: \(error.localizedDescription)"
//        }

    }
}

#Preview {
    ContentView()
}
