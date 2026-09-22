//
//  ContentView.swift
//  05_ WordScramble
//
//  Created by Vladislav on 15.04.2026.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var allWords = [String]()
    
    @State private var score = 0
    @AppStorage("BestScore") var bestScore = 0
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Score: \(score)") {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
            .toolbar {
                ToolbarItem {
                    Button("New Word", action: startNewGame)
                }
                ToolbarItem(placement: .title) {
                    Text("Best: \(bestScore)")
                }
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isNotShort(word: answer) else {
            wordError(title: "Word too short", message: "Please use at least 3-letter words")
            return
        }
        
        guard isNotRootWord(word: answer) else {
            wordError(title: "Not new word", message: "You can't just use source word")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        calculateScore(word: answer)
        newWord = ""
    }
    
    func startGame() {
        loadWords()
        pickUpRandomWord()
    }
    
    func startNewGame() {
        usedWords.removeAll()
        pickUpRandomWord()
        newWord = ""
        score = 0
    }
    
    func loadWords() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL, encoding: .utf8) {
                allWords = startWords.components(separatedBy: "\n")
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func pickUpRandomWord() {
        rootWord = allWords.randomElement() ?? "silkworm"
    }
    
    func isNotShort(word: String) -> Bool {
        word.count > 2
    }
    
    func isNotRootWord(word: String) -> Bool {
        word != rootWord
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
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
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func calculateScore(word: String) {
        let totalLetters = usedWords.reduce(0) { $0 + $1.count }
        score = totalLetters * usedWords.count
        
        updateBestScore()
    }
    
    func updateBestScore() {
        if score > bestScore {
            bestScore = score
        }
    }
}

#Preview {
    ContentView()
}
