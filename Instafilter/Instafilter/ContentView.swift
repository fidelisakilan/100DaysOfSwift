//
//  ContentView.swift
//  Instafilter
//
//  Created by Fidelis Akilan on 3/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    var body: some View {
        VStack {
            Button("Hello, World!") {
                showingConfirmation.toggle()
            }
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .confirmationDialog("Change Background",isPresented: $showingConfirmation) {
                Button("Red") { backgroundColor = .red }
                Button("Green") { backgroundColor = .green}
                Button("Black") { backgroundColor = .black }
                Button("White") { backgroundColor = .white }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("Select a new color.")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
