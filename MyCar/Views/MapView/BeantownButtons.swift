//
//  BeantownButtons.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 24.06.24.
//

import SwiftUI
import MapKit

struct BeantownButtons: View {
    
    @Binding var searchResults: [MKMapItem]
    var userLocation: CLLocationCoordinate2D?
    @State private var isPressed = false
    @State private var isGasStationTapped = false
    @State private var isChargingStationTapped = false
    @State private var isRestaurantTapped = false
    @State private var selectedButton: String? = nil
    
    var body: some View {
        HStack {
            Button {
                search(for: "gas station")
                selectedButton = "gas station"
            } label: {
                Label("Gas Stations", systemImage: "fuelpump")
                    .padding()
                    .background(selectedButton == "gas station" ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button {
                search(for: "charging station")
                selectedButton = "charging station"
            } label: {
                Label("Charging station", systemImage: "ev.charger")
                    .padding()
                    .background(selectedButton == "charging station" ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button {
                search(for: "restaurant")
                selectedButton = "restaurant"
            } label: {
                Label("Restaurants", systemImage: "fork.knife")
                    .padding()
                    .background(selectedButton == "restaurant" ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .labelStyle(.iconOnly)
    }
    
    func search(for query: String) {
        guard let userLocation = userLocation else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
        
        Task {
            do {
                let search = MKLocalSearch(request: request)
                let response = try await search.start()
                DispatchQueue.main.async {
                    searchResults = response.mapItems
                }
            } catch {
                print("Arama hatası: \(error.localizedDescription)")
            }
        }
    }
}


