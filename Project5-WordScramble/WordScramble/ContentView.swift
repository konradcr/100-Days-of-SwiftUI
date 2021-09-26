//
//  ContentView.swift
//  WordScramble
//
//  Created by Konrad Cureau on 12/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    var body: some View {
        NavigationView {
            GeometryReader{ wordsView in
                VStack {
                    TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocapitalization(.none)
                        .padding()
                    ScrollView(.vertical) {
                        ForEach(0..<usedWords.count, id:\.self) { index in
                            GeometryReader { rowPos in
                                let rowFrame = rowPos.frame(in: .global)
                                let ratio = Double((rowFrame.midY/wordsView.size.height))
                                let red = ratio*ratio
                                let blue = ratio
                                let green = (1-ratio)
                                let offset = index > 6 ? CGFloat(7 * (index-5)) : 0
                                HStack{
                                    Spacer()
                                    Image(systemName: "\(usedWords[index].count).circle")
                                        .padding()
                                        .fixedSize(horizontal: true, vertical: true)
                                        .foregroundColor(Color(red: red , green: green, blue: blue))
                                        .position(x: rowPos.frame(in: .local).minX+offset)
                                    Text(usedWords[index])
                                        .font(.title)
                                        .position(x: rowPos.frame(in: .local).minX+offset)
                                }
                                
                                // If put here, it ailgn the last char in this position
                                // .position(x: rowPos.frame(in: .local).minX+offset)
                                
                                // If put here, it fix in leading align, can't see offset effect
                                //                                .alignmentGuide(.leading, computeValue: { dimension in
                                //                                    rowPos.frame(in: .global).midX + offset
                                //                                })
                                
                            } // end of geometry
                            .padding()
                        } // end of foreach
                    } // end of scrollview
                    Text("Score: \(userScore)")
                        .background(Color.blue)
                } // End of VStack
                .navigationBarTitle(rootWord)
                .onAppear(perform: startGame)
                .alert(isPresented: $showingError) {
                    Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                .navigationBarItems(trailing:
                                        Button(action: restart) {
                                            Text("Restart")
                                        }
                )
            }
            
        }
    }
    func addNewWord() {
        // lowercase and trim the word, to make sure we don't add duplicate words with case differences
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        // exit if the remaining string is empty
        guard answer.count > 0 else {
            return
        }
        
        guard isSame(word: answer) else {
            wordError(title: "Word is the word", message: "Please...")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not possible", message: "That isn't a real word.")
            return
        }
        
        usedWords.insert(answer, at: 0)
        calculateScore()
        newWord = ""
    }
    
    
    func startGame() {
        // 1. Find the URL for start.txt in our app bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL) {
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word, or use "silkworm" as a sensible default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                // If we are here everything has worked, so we can exit
                return
            }
        }
        
        // If were are *here* then there was a problem – trigger a crash and report the error
        fatalError("Could not load start.txt from bundle.")
    }
    
    func restart() {
        startGame()
        usedWords = []
        userScore = 0
    }
    
    func calculateScore() {
        let answer = newWord.trimmingCharacters(in: .whitespacesAndNewlines)
        let answerCount = answer.count
        switch answerCount {
        case 0...4:
            userScore += 2
        case 5...6:
            userScore += 5
        case 7:
            userScore += 7
        case 8:
            userScore += 10
        default:
            userScore += 0
        }
    }
    
    func isSame(word: String) -> Bool {
        if word == rootWord {
            return false
        }
        return true
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
        if word.count >= 3 {
            let checker = UITextChecker()
            let range = NSRange(location: 0, length: word.utf16.count)
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
            
            return misspelledRange.location == NSNotFound
        } else {
            return false
        }
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
