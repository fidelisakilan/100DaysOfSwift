//
//  ContentView.swift
//  HotProspects
//
//  Created by Fidelis Akilan on 4/7/26.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView: View {
    let users = ["Tohro", "Yuki", "Kyo", "Momiji"]
    @State private var selection = Set<String>()
    @State private var selectedTab = "One"
    @State private var output = ""
    @State private var backgroundColor = Color.white
    
    let possibleNumbers = 1...60
    var sequence: String {
        let lottery = possibleNumbers.random(7).sorted()
        let strings = lottery.map(String.init)
        return strings.formatted()
    }
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack {
                    List(users, id: \.self, selection: $selection) { user in
                        Text(user)
                            .swipeActions {
                                Button("Delete",systemImage: "minus.circle", role: .destructive) {
                                    print("Delete")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button("Pin", systemImage: "pin") {
                                    print("Pinning")
                                }
                                .tint(.orange)
                            }
                    }
                    Spacer()
                    Spacer()
                    if selection.isEmpty == false {
                        Text("Selected value: \(selection.formatted())")
                            .padding()
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
            VStack {
                Text(sequence)
                    .padding()
                Button("Request Permission") {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All Set")
                        } else if let error {
                            print("error: \(error.localizedDescription)")
                        }
                    }
                }
                Button("Schedule Notification") {
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = .default
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request)
                    
                }
            }
            .tabItem {
                Label("Four", systemImage: "triangle")
            }
            .tag("four")
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
