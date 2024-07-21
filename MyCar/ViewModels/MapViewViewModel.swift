//
//  GasStationViewModel.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 21.06.24.
//

import Foundation
import MapKit
import CoreLocation


class MapViewViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isLocationAuthorized = false
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
    )
    @Published var searchResults: [MKMapItem] = []

    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        checkLocationAuthorization()
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

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
            self.updateRegion(coordinate: location.coordinate)
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

    private func updateRegion(coordinate: CLLocationCoordinate2D) {
        DispatchQueue.main.async {
            self.region = MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
            )
        }
       
    }

    func search(for query: String) {
        guard let userLocation = userLocation else {
            print("User location not yet determined.")
            return
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Search results not received: \(error?.localizedDescription ?? "unknown error")")
                return
            }

            DispatchQueue.main.async {
                self.searchResults = response.mapItems
            }
        }
    }
    
}
extension MKMapItem: Identifiable {
    public var id: String {
        return placemark.coordinate.latitude.description + placemark.coordinate.longitude.description
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D {
    static let locationUser = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
}



