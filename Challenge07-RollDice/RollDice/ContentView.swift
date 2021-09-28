//
//  ContentView.swift
//  RollDice
//
//  Created by Konrad Cureau on 18/07/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        TabView {
            RollDiceView()
                .tabItem {
                    Label("Dice", systemImage: "die.face.4")
                }
            ScoresView()
                .tabItem {
                    Label("Scores", systemImage: "list.bullet")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
