//
//  ContentView.swift
//  Navigation
//
//  Created by Fidelis Akilan on 8/18/25.
//

import SwiftUI

@Observable class PathStore {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(representation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation path")
        }
    }
}

struct DetailsView : View {
    var number: Int
    @Binding var path: NavigationPath
    var body: some View {
        NavigationLink("Tap for a random number", value: Int.random(in: 1...1000))
            .navigationTitle("\(number)")
            .toolbar {
                Button("HOME") {
                    path = NavigationPath()
                }
            }
        
    }
}

struct ContentView : View {
    @State private var pathStore = PathStore()
    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailsView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { selection in
                    DetailsView(number: selection, path: $pathStore.path)
                }
        }
    }
}



//struct ContentView : View {
//    @State private var navigationPath = NavigationPath()
//    var body: some View {
//        NavigationStack(path: $navigationPath) {
//            List {
//                ForEach(0..<5) { i in
//                    NavigationLink("Number: \(i)", value: i)
//                }
//                ForEach(0..<5) { i in
//                    NavigationLink("String: \(i)", value: String(i))
//                }
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("It's a number \(selection)")
//            }
//            .navigationDestination(for: String.self) { selection in
//                Text("It's a string \(selection)")
//            }
//        }
//    }
//}

//struct Student: Hashable {
//    let id = UUID()
//    let name: String
//    let age: Int
//}
//
//struct DetailView: View {
//    let number: Int
//
//    init(number: Int) {
//        print("Initialized with number \(number)")
//        self.number = number
//    }
//    var body: some View {
//        Text("\(number) it is")
//    }
//}
//
//struct ContentView: View {
//    var body: some View {
//        NavigationStack {
//            List(0..<1000) { number in
//                NavigationLink("TAP \(number)", value: number)
//            }
//            .navigationDestination(for: Int.self) { selection in
//                Text("You selected \(selection)")
//            }
//            .navigationDestination(for: Student.self) { selection in
//                Text("You selected \(selection)")
//            }
//        }
//    }
//}

#Preview {
    ContentView()
}
