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
    @State private var showingError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    private var score: Int {
        return usedWords.count
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word",text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Score") {
                    Text(String(score))
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
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                Button("RESET",action: startGame)
            }
        }
    }
    
    func startGame() {
        usedWords = [String]()
        if let startWordsUrl = Bundle.main.url(forResource: "start",withExtension:"txt") {
            if let startWords = try? String(contentsOf: startWordsUrl, encoding:.utf8).components(separatedBy: "\n") {
                rootWord = startWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not start.txt from the bundle")
    }
    
    func onSubmitted() {
        let cleanedWord = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard cleanedWord.count > 0 else { return }
        
        guard isLarge(word: cleanedWord) else {
            wordError(title: "Less than 3", message: "This is too short")
            return
        }
        
        guard isDifferentFromRoot(word: cleanedWord) else {
            wordError(title: "Invalid", message: "Same as root")
            return
        }

        guard isOriginal(word: cleanedWord) else {
            wordError(title: "Be original", message: "This word is already entered")
            return
        }

        guard isValidCharacters(word: cleanedWord) else {
            wordError(title: "Invalid letters", message: "Where did you get those letters from ! !")
            return
        }

        guard isActualWord(word: cleanedWord) else {
            wordError(title: "Word not real", message: "not in the dictionary")
            return
        }
        
        
        
        newWord = ""
        withAnimation {
            usedWords.insert(cleanedWord,at: 0)
        }
    }
    
    func isLarge(word: String) -> Bool {
        return word.count >= 3
    }
    
    func isDifferentFromRoot(word: String) -> Bool {
        return word != rootWord
    }

    func isActualWord(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misplacedRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misplacedRange.location == NSNotFound
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isValidCharacters(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func wordError(title: String, message: String) {
        showingError = true
        errorTitle = title
        errorMessage = message
    }
}

#Preview {
    ContentView()
}
