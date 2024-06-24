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
    
    var body: some View {
        HStack {
            Button {
                search(for: "gas station")
            } label: {
                Label("Gas Stations", systemImage: "fuelpump")
            }
            .buttonStyle(.borderedProminent)
        }
        .labelStyle(.iconOnly)
    }
    
    func search(for query: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = .pointOfInterest
        request.region = MKCoordinateRegion(center: .parking, span: MKCoordinateSpan(latitudeDelta: 0.0125, longitudeDelta: 0.0125))
        
        Task {
            let search = MKLocalSearch(request: request)
            let response = try? await search.start()
            searchResults = response?.mapItems ?? []
        }
        
    }
}


