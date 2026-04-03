//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Fidelis Akilan on 4/1/26.
//

import SwiftUI

struct VoiceOverContentView: View {
    private var pictures = [
        "ingmar-bpJUsjxnxsQ",
        "leon-rohrwild-5APKpFvda8I",
        "pavel-boltov-YBfY46",
    ]
    private var labels = [
        "Flowers",
        "Waves",
        "Bridge",
    ]
    @State private var selectedIndex = Int.random(in: 0...2)
    @State private var value = 0
    var body: some View {
        //        Button {
        //            selectedIndex = Int.random(in: 0...2)
        //        } label: {
        //            Image(pictures[selectedIndex])
        //                .resizable()
        //                .scaledToFit()
        //        }
        //        .accessibilityLabel(labels[selectedIndex])
        
        //        Image(decorative: "character")
        //            .accessibilityHidden(true)
        
        //        VStack {
        //            Text("Your score is")
        //            Text("1000")
        //                .font(.title)
        //        }
        //        .accessibilityElement(children: .ignore)
        //        .accessibilityLabel("Your score is 1000")
        
        VStack {
            Text("Value: \(value)")
                .font(.title)
                .padding()
            HStack {
                Button("Decrement") { value -= 1}
                    .padding()
                Button("Increment") { value += 1}
                    .padding()
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment: value += 1
            case .decrement: value -= 1
            default: print("Not handled")
            }
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
