//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Konrad Cureau on 10/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var userScore = 0
    
    @State private var moves = ["Rock", "Paper", "Scissors"]
    
    
    func match(_ number: Int) {
        var didWin : Bool {
            if appChoice == 2 && number == 0 {
                return true
            } else if appChoice == 0 && number == 2 {
                return false
            } else if number == (appChoice + 1) {
                return true
            } else if number == (appChoice - 1){
                return false
            } else {
                return false
            }
        }
        if (didWin && shouldWin) || (!didWin && !shouldWin) {
            userScore += 1
        } else if (didWin && !shouldWin) || (!didWin && shouldWin) {
            userScore -= 1
        }
    }
    

    
    func reset() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    var body: some View {
        VStack {
            Text("Your score : \(userScore) ")
            Spacer()
            Text("The app move is : \(moves[appChoice])")
            if shouldWin {
                Text("Win !")
            } else {
                Text("Loose !")
            }
            HStack {
                /* ForEach(moves, id: \.self) {
                    Button(action: {
                        self.flagTapped($0)
                    }) {
                        Text($0)
                    }
                } */
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.match(number)
                        self.reset()
                    }) {
                        Text("\(moves[number])")
                    }
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
