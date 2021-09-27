//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Konrad Cureau on 09/04/2021.
//
// swiftlint:disable line_length
// swiftlint:disable multiple_closures_with_trailing_closure

import SwiftUI

struct FlagImage: View {

    var image: String

    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]

    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""

    @State private var userScore = 0

    @State private var animationAmount = 0.0
    @State private var opacit = 1.0
    @State private var scaling = 1.0
    @State private var correctFlag = false
    @State private var backColor: Color = .clear

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            correctFlag = true
        } else {
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
            userScore = 0
        }
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        correctFlag = false
        animationAmount = 0
        backColor = .clear
    }

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(
                        action: { self.flagTapped(number)
                            withAnimation {
                                self.animationAmount += 360
                                self.backColor = .red
                            }
                        }
                    ) {
                        if self.correctFlag {
                            if number == self.correctAnswer {
                                withAnimation {
                                    FlagImage(image: countries[number])
                                        .rotation3DEffect(
                                            .degrees(animationAmount), axis: (x: 0, y: 1, z: 0)
                                        )
                                        .accessibility(
                                            label: Text(self.labels[self.countries[number], default: "Unknown flag"])
                                        )
                                }
                            } else {
                                FlagImage(image: countries[number])
                                    .opacity(0.25)
                                    .accessibility(
                                        label: Text(self.labels[self.countries[number], default: "Unknown flag"])
                                    )
                            }
                        } else {
                            if number != self.correctAnswer {
                                withAnimation {
                                    FlagImage(image: countries[number])
                                        .overlay(Capsule().fill(backColor))
                                        .accessibility(
                                            label: Text(self.labels[self.countries[number], default: "Unknown flag"])
                                        )
                                }
                            } else {
                                FlagImage(image: countries[number])
                                    .accessibility(
                                        label: Text(self.labels[self.countries[number], default: "Unknown flag"])
                                    )
                            }
                        }
                    }

                    .rotation3DEffect(
                        .degrees((number == correctAnswer) ? animationAmount:0), axis: (x: 0, y: 1, z: 0)
                    )
                    .opacity((number == correctAnswer) ? 1 : opacit)
                }
                Text("Your score : \(userScore)")
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text("Your score is \(userScore)"),
                dismissButton: .default(Text("Continue")) { self.askQuestion() }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
