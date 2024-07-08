//
//  LocationManager.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.07.24.
//

import Foundation
import CoreLocation
import MapKit

/*
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var searchResults: [MKMapItem] = []
    @Published var isLocationAuthorized = false
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
    )
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
            self.updateRegion(coordinate: location.coordinate)
        }
    }
    
    private func updateRegion(coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func search(for query: String) {
        guard let userLocation = userLocation else {
            print("Kullanıcı konumu henüz belirlenmedi.")
            return
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Arama sonuçları alınamadı: \(error?.localizedDescription ?? "Bilinmeyen hata")")
                return
            }
            
            DispatchQueue.main.async {
                self.searchResults = response.mapItems
            }
        }
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            DispatchQueue.main.async {
                self.isLocationAuthorized = false
            }
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.async {
                self.isLocationAuthorized = true
            }
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}
*/
