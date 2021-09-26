//
//  PlusButtonView.swift
//  BucketList
//
//  Created by Konrad Cureau on 05/07/2021.
//

import SwiftUI
import MapKit

struct PlusButtonView: View {
    
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingEditScreen: Bool
    
    var body: some View {
            Button(action: {
                                // create a new location
                                let newLocation = CodableMKPointAnnotation()
                                newLocation.coordinate = self.centerCoordinate
                                newLocation.title = "Example location"
                                self.locations.append(newLocation)
                                
                                self.selectedPlace = newLocation
                                self.showingEditScreen = true
                                
                            }) {
                                Image(systemName: "plus")
                            }
                            .padding()
                            .background(Color.black.opacity(0.75))
                            .foregroundColor(.white)
                            .font(.title)
                            .clipShape(Circle())
                            .padding(.trailing)
    }
}
