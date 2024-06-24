//
//  GasStationView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 21.06.24.
//

import SwiftUI
import MapKit
import CoreLocation

extension CLLocationCoordinate2D {
    static let parking = CLLocationCoordinate2D(latitude: 42.354528, longitude: -71.068369)
}

struct GasStationView: View {
    
    
    @StateObject private var viewModel = GasStationViewModel()
    
    @State private var searchResluts: [MKMapItem] = []

        var body: some View {
            Map {
                if viewModel.isLocationAuthorized {
                    Annotation("Parking", coordinate: .parking) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.background)
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.secondary, lineWidth: 5)
                            Image(systemName: "car")
                                .padding(5)
                        }
                    }
                    .annotationTitles(.hidden)
                    
                    ForEach(searchResluts, id: \.self) { result in
                        Marker(item: result)
                    }
                }
            }
                    .mapStyle(.standard(elevation: .realistic))
                    .safeAreaInset(edge: .bottom) {
                        HStack {
                            Spacer()
                            BeantownButtons(searchResults: $searchResluts)
                                .padding(.top)
                                .padding(.bottom, 20)
                            Spacer()
                        }
                        .background(.thinMaterial)
                    }
            
            .onAppear {
                viewModel.checkLocationAuthorization()
            }
        }
    
        
    }

#Preview {
    GasStationView()
}
