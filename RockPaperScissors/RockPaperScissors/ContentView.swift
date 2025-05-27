//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Fidelis Akilan on 5/26/25.
//

import SwiftUI

struct ContentView: View {
    let choices = ["Rock", "Paper", "Scissors"]
    @State private var systemChoice: String = "Rock"
    @State private var shouldWin = true
    @State private var score = 0
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Text("Player Score")
                        Spacer()
                        Text("\(score)")
                    }
                    HStack {
                        Text("Player Action to")
                        Spacer()
                        Text(shouldWin ? "Win": "Lose")
                    }
                    HStack {
                        Text("System Move")
                        Spacer()
                        Text(systemChoice)
                    }
                }
                Section("Choose") {
                    Button("🪨 Rock") {
                        tapButton(value: "Rock")
                    }
                    Button("📄 Paper") {
                        tapButton(value: "Paper")
                    }
                    Button("✂️ Scissors") {
                        tapButton(value: "Scissors")
                    }
                }
                Button("Reset") {
                    reset()
                }
            }
            
        }
        
    }
    
    func tapButton(value: String) {
        switch value {
        case "Rock":
            if systemChoice == "Paper" {
                score += shouldWin ? 1 : -1
            }
            else if systemChoice == "Scissors" {
                score += shouldWin ? -1 : 1
            }
        case "Scissors":
            if systemChoice == "Paper" {
                score += shouldWin ? 1 : -1
            }
            else if systemChoice == "Rock" {
                score += shouldWin ? -1 : 1
            }
        case "Paper":
            if  systemChoice == "Rock" {
                score += shouldWin ? 1 : -1
            }
            else if systemChoice == "Scissors" {
                score += shouldWin ? -1 : 1
            }
        default:
            break
        }
        if score < 0 {
            score = 0
        }
        toggle()
    }
    
    func toggle() {
        systemChoice = choices[Int.random(in: 0...2)]
        shouldWin = Bool.random()
    }
    func reset() {
        score = 0
        toggle()
    }
}

#Preview {
    ContentView()
}
