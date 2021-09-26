//
//  WhoIMetApp.swift
//  WhoIMet
//
//  Created by Konrad Cureau on 08/07/2021.
//

import SwiftUI

@main
struct WhoIMetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
