//
//  GasStationView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 21.06.24.
//

import SwiftUI
import MapKit
import CoreLocation

struct GasStationView: View {
    
    @StateObject private var viewModel = GasStationViewModel()
        
        var body: some View {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.places) { place in
                MapMarker(coordinate: place.coordinate, tint: .red)
            }
            .onAppear {
                viewModel.checkIfLocationServicesIsEnabled()
            }
        }
    }

#Preview {
    GasStationView()
}
