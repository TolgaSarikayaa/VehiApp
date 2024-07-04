//
//  GasStationView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 21.06.24.
//

import SwiftUI
import MapKit
import CoreLocation

/*
struct GasStationView: View {
    
    @StateObject private var viewModel = GasStationViewModel()
    @State private var selectedResult: MKMapItem?

    var body: some View {
        Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: viewModel.searchResults) { result in
            MapMarker(coordinate: result.placemark.coordinate, tint: .red)
        }
        .overlay(
            ZStack {
                if viewModel.isLocationAuthorized, let userLocation = viewModel.userLocation {
                     
                }
            }
        )
        .onAppear {
            viewModel.checkLocationAuthorization()
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                BeantownButtons(searchResults: $viewModel.searchResults, userLocation: viewModel.userLocation)
                    .padding(.top)
                    .padding(.bottom, 20)
                Spacer()
            }
            .background(.thinMaterial)
        }
    }
}

#Preview {
    GasStationView()
}
*/
