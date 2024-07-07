//
//  MapViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.07.24.
//

import Foundation
import MapKit
import CoreLocation
import SwiftUI

/*
struct MapViewModel: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var pointsOfInterest: [MKPointOfInterestCategory]
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.setRegion(region, animated: true)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.removeAnnotations(uiView.annotations)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Gas Station"
        request.pointOfInterestFilter = MKPointOfInterestFilter(including: pointsOfInterest)
        request.region = uiView.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else { return }
            let mapItems = response.mapItems
            let annotations = mapItems.map { mapItem -> MKPointAnnotation in
                let annotation = MKPointAnnotation()
                annotation.title = mapItem.name
                annotation.coordinate = mapItem.placemark.coordinate
                return annotation
            }
            uiView.addAnnotations(annotations)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewModel
        
        init(_ parent: MapViewModel) {
            self.parent = parent
        }
    }
}
*/
