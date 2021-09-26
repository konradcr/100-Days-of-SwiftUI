//
//  ContentView.swift
//  Multiplay
//
//  Created by Konrad Cureau on 16/04/2021.
//

import SwiftUI

struct Questions : View {
    var text: String
    var answer: String
    
    
    init(text: String , answer: String) {
        self.text = text
        self.answer = answer
    }
    
    
    @State private var userAnswer = ""
    @State private var playerScore = 0
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    Text(text)
                    TextField("Answer", text: $userAnswer)
                        .keyboardType(.numberPad)
                    Button(action: checkAnswer) {
                        Text("Send")
                                    }
                    Text("Your Score : \(playerScore)")
                    }
            }
        }
        
    }
    
    func checkAnswer() {
        if userAnswer == answer {
            playerScore += 1
        }
    }
}


struct ContentView: View {
    
    @State private var isPlaying = false
    @State private var choosedTable = 1
    
    let numberQuestions = [5,10,20]
    @State private var choosedNumberQuestions = 0
    
    @State private var questions = [String]()
    @State private var answers = [String]()
    
    @State private var currentQuestion = 0
    
    var body: some View {
        Group {
            if !isPlaying {
            NavigationView {
                Form {

                    Section (header: Text("Choose your table to train")) {
                        Stepper(value: $choosedTable, in: 1...12, step: 1) {
                            Text("Until table \(choosedTable)")
                        }
                    }

                    Section (header: Text("How many questions ?")) {
                        Picker("Number of questions", selection: $choosedNumberQuestions) {
                            ForEach(0..<numberQuestions.count) {
                                    Text("\(numberQuestions[$0]) questions")
                                }
                        }
                    }





                }
                .navigationBarTitle("MultiPlay")
                .navigationBarItems(trailing:
                        Button(action: generateQuestions) {
                            Text("Play")
                                        }
                )

            }
            } else {
//                ForEach(questions, id: \.self) {
                
                Questions(text: questions[currentQuestion], answer: answers[currentQuestion])
//                }
            }
        }
    }

    func generateQuestions() {
        for _ in 0..<numberQuestions[choosedNumberQuestions] {
            let firstMultiply = Int.random(in: 1...choosedTable)
            let secondMultiply = Int.random(in: 1...12)
            let question = "\(firstMultiply) X \(secondMultiply)"
            questions.append(question)
            let answer = "\(firstMultiply * secondMultiply)"
            answers.append(answer)
        }
        isPlaying = true

    }


}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
