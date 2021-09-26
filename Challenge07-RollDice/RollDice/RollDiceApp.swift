//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Konrad Cureau on 18/07/2021.
//

import SwiftUI

@main
struct RollDiceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
