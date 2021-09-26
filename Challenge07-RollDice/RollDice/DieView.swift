//
//  DieView.swift
//  RollDice
//
//  Created by Konrad Cureau on 19/07/2021.
//

import SwiftUI

struct DieView: View {
    
    var die: Int
    var width: CGFloat
    var height: CGFloat
    var font: Font
    
    
    var body: some View {
        Text("\(die)")
            .frame(width: self.width, height: self.height)
            .background(Color.black.opacity(0.3))
            .foregroundColor(.black)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
            .font(font)
    }
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        DieView(die: 4, width: 100, height: 100, font: .title)
    }
}
