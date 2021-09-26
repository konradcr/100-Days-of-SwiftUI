//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Konrad Cureau on 28/06/2021.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
