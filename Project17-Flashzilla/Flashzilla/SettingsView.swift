//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Konrad Cureau on 17/07/2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var reUseWrongCards: Bool

    var body: some View {
        NavigationView {
            VStack {

                Toggle("Re-use card answered wrong", isOn: $reUseWrongCards)
                    .padding()

            }
            .padding()
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            .listStyle(GroupedListStyle())
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationViewStyle(StackNavigationViewStyle())
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
