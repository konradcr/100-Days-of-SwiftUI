//
//  MapView.swift
//  WhoIMet
//
//  Created by Konrad Cureau on 09/07/2021.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var currentLocation: CLLocationCoordinate2D?
    var withAnnotation: MKPointAnnotation?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = false
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        if let currentLocation = self.currentLocation {
            uiView.showsUserLocation = true
            let region = MKCoordinateRegion(
                center: currentLocation,
                latitudinalMeters: 300,
                longitudinalMeters: 300
            )
            uiView.setRegion(region, animated: true)
        }
        if let annotation = self.withAnnotation {
            uiView.addAnnotation(annotation)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            if !mapView.showsUserLocation {
                parent.centerCoordinate = mapView.centerCoordinate
            }
        }
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
    }
}
