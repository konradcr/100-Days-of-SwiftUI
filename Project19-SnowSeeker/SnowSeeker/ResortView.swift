//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Konrad Cureau on 19/07/2021.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites

    @State private var selectedFacility: Facility?

    let resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Text(resort.imageCredit)
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.5))
                        .clipShape(Capsule())
                        .padding(4)
                }

                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)

                    Text(resort.description)
                        .padding(.vertical)

                    Text("Facilities")
                        .font(.headline)

                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)

                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if self.favorites.contains(self.resort) {
                        self.favorites.remove(self.resort)
                    } else {
                        self.favorites.add(self.resort)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle(Text("\(resort.name), \(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFacility) { facility in
            facility.alert
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
