//
//  MissionView.swift
//  Moonshot
//
//  Created by Konrad Cureau on 28/04/2021.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let astronauts: [CrewMember]

    let frameHeight: CGFloat = 300

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
//                    Image(decorative: self.mission.image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: geometry.size.width * 0.7)
//                        .padding(.top)
//                        .accessibility(hidden: true)
                    GeometryReader { geometry in
                        HStack {
                            Spacer()
                            Image(self.mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: fullView.size.width * 0.7)
                                .padding(.top)
                                .offset(x: 0, y: getOffsetForMissionPatch(for: geometry))
                                .scaleEffect(getScaleOfMissionPatch(for: geometry))
                                .accessibility(label: Text("Mission patch for \(mission.displayName)"))
                            Spacer()
                        }
                    }
                    .frame(height: self.frameHeight, alignment: .center)

                    Text(mission.formattedLaunchDate)
                        .font(.headline)

                    Text(self.mission.description)
                        .padding()
                        .layoutPriority(1)

                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(decorative: crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(crewMember.astronaut.name) : \(crewMember.role)"))
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }

    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }

    func getOffsetForMissionPatch(for geometry: GeometryProxy) -> CGFloat {
        let scale = getScaleOfMissionPatch(for: geometry)
        return self.frameHeight * (1 - scale) * 0.95
    }

    func getScaleOfMissionPatch(for geometry: GeometryProxy) -> CGFloat {
        let offset = geometry.frame(in: .global).minY
        let halfHeight = self.frameHeight / 2

        // This value was found by just printing the minY of .global at the start
        let startingOffset: CGFloat = 91

        let minimumSizeAtOffset = startingOffset - halfHeight
        let scale = 0.8 + 0.2 * (offset - minimumSizeAtOffset) / halfHeight

        if scale < 0.8 {
            return 0.8
        } else if scale > 1.2 {
            return 1.2
        }

        return scale
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[2], astronauts: astronauts)
    }
}
