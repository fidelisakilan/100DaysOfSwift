//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Fidelis Akilan on 5/23/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {
            print("Button was pressed")
        } label: {
            Label("Edit", systemImage: "pencil")
                .foregroundStyle(.white)
                .background(.red)
        }
    }
    func executeDelet() {
        print("Now deleting...")
        
    }
}

#Preview {
    ContentView()
}
