//
//  UnlockButtonView.swift
//  BucketList
//
//  Created by Konrad Cureau on 05/07/2021.
//

import SwiftUI
import LocalAuthentication

struct UnlockButtonView: View {

    @Binding var isUnlocked: Bool

    @State private var showErrorAlert = false

    var body: some View {
        // button here
        Button("Unlock Places") {
            self.authenticate()
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Capsule())
        .alert(isPresented: $showErrorAlert) { () -> Alert in
            Alert(
                title: Text("Error with Authentication"),
                message: Text("Try again"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, _) in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        self.showErrorAlert = true
                    }
                }
            }
        } else {
            // no biometric
        }
    }
}
