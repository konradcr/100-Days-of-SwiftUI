//
//  ContentView.swift
//  Moonshot
//
//  Created by Konrad Cureau on 27/04/2021.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingDates = false

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(decorative: mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
//                        Text(mission.formattedLaunchDate)
                        Text(showingDates ? mission.formattedLaunchDate : crewNames(actualMission: mission))
                    }
                }
            }
            .navigationBarItems(trailing: Button(action: {
                            showingDates.toggle()
                        }, label: {
                            Text(showingDates ? "Crew" : "Dates")
                        }))
            .navigationBarTitle("Moonshot")
        }
    }

    func crewNames(actualMission: Mission) -> String {
            var temp = [String]()
            for crewName in actualMission.crew {
                temp.append(crewName.name.capitalized)
            }

            return temp.joined(separator: ", ")
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
