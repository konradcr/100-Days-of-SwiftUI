//
//  AstronautView.swift
//  Moonshot
//
//  Created by Konrad Cureau on 28/04/2021.
//

import SwiftUI

struct AstronautView: View {

    let astronaut: Astronaut
//    let missions: [Mission]
    let missionsFlown: [String]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(decorative: self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        .accessibility(hidden: true)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)

                    ForEach(self.missionsFlown, id: \.self) { mission in
                        VStack {
                            Text(mission.description)
                                .font(.headline)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }

    init(astronaut: Astronaut) {
            self.astronaut = astronaut
            let missions: [Mission] = Bundle.main.decode("missions.json")

            var matches = [String]()

            for mission in missions {
                for _ in mission.crew {
                    if let match = mission.crew.first(where: {$0.name == astronaut.id}) {
                        matches.append("Apollo \(mission.id) - \(match.role)")
                        break
                    }
                }
            }
            self.missionsFlown = matches
        }
//    init(astronaut: Astronaut, missions: [Mission]) {
//        self.astronaut = astronaut
//
//        var matches = [Mission]()
//
//        for member in
//
//
//        self.missions = matches
//    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[4])
    }
}
