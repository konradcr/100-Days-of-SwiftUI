//
//  ContentView.swift
//  BucketList
//
//  Created by Konrad Cureau on 04/07/2021.
//
import LocalAuthentication
import SwiftUI
import MapKit

struct ContentView: View {
    @State private var isUnlocked = false
        
        var body: some View {
            
            ZStack {
                if isUnlocked {
                    UnlockView()
                } else {
                    UnlockButtonView(isUnlocked: $isUnlocked)
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
