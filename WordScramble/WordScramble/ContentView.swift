//
//  ContentView.swift
//  WordScramble
//
//  Created by Fidelis Akilan on 6/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var newWord = ""
    @State private var rootWord = ""
    @State private var usedWords = [String]()
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word",text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
            }
            .navigationTitle(rootWord)
            .onSubmit(onSubmitted)
        }
    }
    func onSubmitted() {
        let cleanedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard cleanedWord.count > 0 else { return }
        newWord = ""
        withAnimation {
            usedWords.insert(cleanedWord,at: 0)
        }

    }
}

#Preview {
    ContentView()
}
