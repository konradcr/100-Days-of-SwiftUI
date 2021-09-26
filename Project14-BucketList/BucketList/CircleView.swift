//
//  CircleView.swift
//  BucketList
//
//  Created by Konrad Cureau on 05/07/2021.
//

import SwiftUI

struct CircleView: View {
    var body: some View {
        Circle()
        .fill(Color.blue)
        .opacity(0.3)
        .frame(width: 32, height: 32)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
