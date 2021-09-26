//
//  AddView.swift
//  TrackRabbit
//
//  Created by Konrad Cureau on 09/05/2021.
//

import SwiftUI

struct AddView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var targetCount = 0.0
    @ObservedObject var activities: Activities
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
                Stepper(value: $targetCount, in: 0...1000, step: 1.0) {
                    Text("Target: \(targetCount, specifier: "%g") times")
                }
            }
            .navigationBarTitle("Add new activity")
            .navigationBarItems(trailing: Button("Save") {
                let item = ActivityItem(title: self.title, description: self.description, targetCount: self.targetCount)
                self.activities.items.append(item)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(activities: Activities())
    }
}
