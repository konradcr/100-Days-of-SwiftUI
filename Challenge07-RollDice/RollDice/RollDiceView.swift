//
//  RollDiceView.swift
//  RollDice
//
//  Created by Konrad Cureau on 18/07/2021.
//

import SwiftUI

struct RollDiceView: View {
    @Environment(\.managedObjectContext) var moc
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    @State private var isShowingEditView = false
    
    @State private var numberOfDice = 3
    @State private var numberOfSides = 5
    
    @State private var firstDie = 3
    @State private var secondDie = 5
    @State private var thirdDie = 1
    
    @State private var timeToRun = 0.0
    @State private var numberOfCallTimer = 0
    @State private var numberOfCallInDispatchQueue = 0
    
    var body: some View {
        NavigationView {
            GeometryReader { fullView in
                VStack {
                    Spacer()
                    HStack {
                        ForEach((1...self.numberOfDice), id: \.self) { number in
                            DieView(die: self.selectDie(at: number), width: 100, height: 100, font: .title)
                                .padding()
                        }
                    }
                    Spacer()
                    Text("Result: \(self.countTotalResult(at: self.numberOfDice))")
                        .font(.title)
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            self.runTimer()
                            
                        }) {
                            Image(systemName: "die.face.4")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                    }.padding(.bottom)
                }
                .frame(width: fullView.size.width, height: fullView.size.height)
                .navigationBarItems(trailing: Button(action: {
                    self.isShowingEditView.toggle()
                }) {
                    Image(systemName: "gearshape")
                })
                .sheet(isPresented: self.$isShowingEditView) {
                    Text("Hello, World!")
                }
                .navigationBarTitle(Text("Roll Dice"))
            }
        }
        .onReceive(timer) { (time) in
            self.runTimer()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func rollDice() {
        self.firstDie = Int.random(in: 0...self.numberOfSides)
        self.secondDie = Int.random(in: 0...self.numberOfSides)
        self.thirdDie = Int.random(in: 0...self.numberOfSides)
    }
    
    func runTimer() {
        self.numberOfCallTimer += 1
        if self.numberOfCallTimer == 6 {
            self.timer.upstream.connect().cancel()
            self.numberOfCallTimer = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + self.timeToRun) {
            self.rollDice()
            self.numberOfCallInDispatchQueue += 1
            if self.numberOfCallInDispatchQueue == 6 {
                self.numberOfCallInDispatchQueue = 0
                self.timeToRun = 0
                // MARK: Save to Code Data
                self.saveToCoreData()
            } else {
                self.timeToRun += 1
            }
        }
    }
    
    func saveToCoreData() {
        let newResult = Result(context: self.moc)
        newResult.id = UUID()
        newResult.nbrOfDice = Int16(numberOfDice)
        newResult.totalResult = self.countTotalResult(at: self.numberOfDice)
        for i in 1...self.numberOfDice {
            let newDie = Die(context: self.moc)
            newDie.id = UUID()
            newDie.dieResult = Int16(selectDie(at: i))
            newDie.nbrOfSide = Int16(numberOfSides)
            newResult.addToDice(newDie)
        }
        
        do {
            try self.moc.save()
        } catch {
            print("Error with save to Core Data")
        }
    }
    
    func selectDie(at number: Int) -> Int {
        switch number {
        case 1:
            return self.firstDie
        case 2:
            return self.secondDie
        case 3:
            return self.thirdDie
        default:
            return self.firstDie
        }
    }
    
    func countTotalResult(at number: Int) -> Int16 {
        switch number {
        case 1:
            return Int16(self.firstDie)
        case 2:
            return Int16(self.firstDie + self.secondDie)
        case 3:
            return Int16(self.firstDie + self.secondDie + self.thirdDie)
        default:
            return Int16(0)
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView()
    }
}
