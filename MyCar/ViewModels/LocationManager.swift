//
//  LocationManager.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.07.24.
//

import Foundation
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    @Published var location: CLLocation? {
        didSet {
            if let location = location {
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
        }
    }
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.783333, longitude: 9.183333), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
}
