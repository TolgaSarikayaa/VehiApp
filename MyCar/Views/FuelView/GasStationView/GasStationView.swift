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
    @State private var searchResults: [MKMapItem] = []
   

        var body: some View {
            Map {
                if viewModel.isLocationAuthorized, let userLocation = viewModel.userLocation {
                    Annotation("User Location", coordinate: userLocation) {
                        ZStack {
                         RoundedRectangle(cornerRadius: 5)
                            .fill(Color.blue)
                            RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.white, lineWidth: 2)
                             Image(systemName: "location.fill")
                                .foregroundColor(.white)
                                .padding(5)
                               }
                           }
                           .annotationTitles(.hidden)

                           ForEach(searchResults, id: \.self) { result in
                               Marker(item: result)
                           }
                       }
                   }
                   .mapStyle(.standard(elevation: .realistic))
                   .safeAreaInset(edge: .bottom) {
                       HStack {
                           Spacer()
                           BeantownButtons(searchResults: $searchResults, userLocation: viewModel.userLocation)
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
