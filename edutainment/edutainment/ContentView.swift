//
//  ContentView.swift
//  edutainment
//
//  Created by Fidelis Akilan on 6/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var numOfQuestions = 5
    @State private var table = 2
    @State private var questionOptions = [5, 10, 20]
    
    @State private var questionIndex = 0
    @State private var questionList = [Int]()
    @State private var started = false
    @State private var completed = false
    @State private var score = 0.0
    @State private var userEntry: Double? = nil
    
    @FocusState private var keyboardFocused
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    Stepper(value: $table,in: 2...12,step: 1) {
                        Text("Table: \(table)")
                    }
                    Picker("Questions to choose", selection: $numOfQuestions) {
                        ForEach(questionOptions, id: \.self) { count in
                            Text("\(count) Questions")
                        }
                    }
                    .pickerStyle(.segmented)
                    HStack {
                        Spacer()
                        Button("Start",action: start)
                            .disabled(started)
                        Button("Reset",action: reset)
                            .disabled(!started)
                    }
                }
                .buttonStyle(.bordered)
                if completed {
                    Section("Last test score") {
                        Text("\(Int(score))%")
                    }
                }
                if started {
                    Section("Question \(questionIndex + 1) of \(numOfQuestions)"){
                        Text("What is \(table) x \(questionList[questionIndex]) ?")
                            .font(.largeTitle)
                        TextField("Your Answer",value: $userEntry, format: .number)
                            .keyboardType(.numberPad)
                            .focused($keyboardFocused)
                            .onSubmit(onSubmit)
                    }
                }
            }
            .navigationTitle("Edutainment")
            .toolbar() {
                if keyboardFocused {
                    Button("Done") {
                        keyboardFocused = false
                    }
                }
            }
        }
    }
    
    func generateNumbers(questionCount: Int) -> [Int] {
        var randomNumbers: [Int] = [Int]()
        for _ in 1...questionCount{
            randomNumbers.append(Int.random(in: 2...12))
        }
        return randomNumbers
    }
    
    func onSubmit() {
        guard userEntry != nil else {
            return
        }
        
        if table * questionList[questionIndex] == Int(userEntry!) {
            score += 1
        }
        if questionIndex + 1 < numOfQuestions {
            questionIndex += 1
        } else {
            score = Double(score / Double(numOfQuestions)) * 100
            completed = true
            reset()
        }
        userEntry = nil
    }
    
    func start() {
        questionList = generateNumbers(questionCount: numOfQuestions)
        started = true
        completed = false
        score = 0
        userEntry = nil
    }
    
    func reset() {
        questionList.removeAll()
        started = false
        questionIndex = 0
    }
}

#Preview {
    ContentView()
}
