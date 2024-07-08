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
    
    var body: some View {
        HStack {
            Button {
                search(for: "gas station")
            } label: {
                Label("Gas Stations", systemImage: "fuelpump")
            }
            .buttonStyle(.borderedProminent)
            Button {
                search(for: "restaurant")
            } label: {
                Label("Restaurants", systemImage: "fork.knife")
            }
            .buttonStyle(.borderedProminent)
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


