//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Fidelis Akilan on 5/23/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false
    
    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message",isPresented: $showingAlert) {
            Button("Delete", role: .destructive) { }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Please look at this")
        }
    }
}

#Preview {
    ContentView()
}
