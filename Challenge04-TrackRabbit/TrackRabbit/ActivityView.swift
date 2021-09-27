//
//  ActivityView.swift
//  TrackRabbit
//
//  Created by Konrad Cureau on 09/05/2021.
//

import SwiftUI

struct ActivityView: View {
    let activity: ActivityItem
    @State private var progress = UserDefaults.standard.double(forKey: "Tap")

    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(self.activity.title)
                    .font(.title)
                    .padding()

                Text(self.activity.description)
                    .padding()

                ProgressView(
                    value: self.progress,
                    total: self.activity.targetCount,
                    label: {
                             Text("Completion")
                                 .padding(.bottom, 4)
                    },
                    currentValueLabel: {
                            Text("\(Int(self.progress*100/self.activity.targetCount))%")
                                 .padding(.top, 4)
                    }
                )
                    .padding()

                Button("More") {
                    self.progress += 1.0
                    UserDefaults.standard.set(self.progress, forKey: "Tap")
                }
                .padding()

                Spacer(minLength: 25)
            }
        }
        .navigationBarTitle(Text(activity.title), displayMode: .inline)
    }
}

struct ActivityView_Previews: PreviewProvider {
    static let items: [ActivityItem] = []
    static var previews: some View {
        ActivityView(activity: items[0])
    }
}
