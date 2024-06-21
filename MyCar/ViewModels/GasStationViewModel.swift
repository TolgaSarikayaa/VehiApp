//
//  GasStationViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 21.06.24.
//

import Foundation
import MapKit
import CoreLocation

class GasStationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        @Published var places: [Place] = []

        private var locationManager: CLLocationManager?
        
        override init() {
            super.init()
            checkIfLocationServicesIsEnabled()
        }
        
        func checkIfLocationServicesIsEnabled() {
            if CLLocationManager.locationServicesEnabled() {
                locationManager = CLLocationManager()
                locationManager?.delegate = self
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                checkLocationAuthorization()
            } else {
                print("Konum servisleri etkin değil.")
            }
        }
        
        private func checkLocationAuthorization() {
            guard let locationManager = locationManager else { return }
            
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                print("Konum izni kısıtlı veya reddedildi.")
            case .authorizedAlways, .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            @unknown default:
                break
            }
        }
        
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else { return }
            
            DispatchQueue.main.async {
                self.region = MKCoordinateRegion(center: location.coordinate,
                                                 span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.findGasStations(location: location)
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Konum hatası: \(error.localizedDescription)")
        }
        
        func findGasStations(location: CLLocation) {
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = "gas station"
            request.region = MKCoordinateRegion(center: location.coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            let search = MKLocalSearch(request: request)
            search.start { response, error in
                guard let response = response else { return }
                
                DispatchQueue.main.async {
                    self.places = response.mapItems.map { item in
                        Place(name: item.name ?? "Unknown", coordinate: item.placemark.coordinate)
                    }
                }
            }
        }
    }

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
