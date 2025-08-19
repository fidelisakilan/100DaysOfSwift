//
//  ContentView.swift
//  Navigation
//
//  Created by Fidelis Akilan on 8/18/25.
//

import SwiftUI

struct Student: Hashable {
    let id = UUID()
    let name: String
    let age: Int
}

struct DetailView: View {
    let number: Int
    
    init(number: Int) {
        print("Initialized with number \(number)")
        self.number = number
    }
    var body: some View {
        Text("\(number) it is")
    }
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<1000) { number in
                NavigationLink("TAP \(number)", value: number)
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .navigationDestination(for: Student.self) { selection in
                Text("You selected \(selection)")
            }
        }
    }
}

#Preview {
    ContentView()
}
