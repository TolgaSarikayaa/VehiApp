//
//  MapView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.07.24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject private var viewModel = MapViewViewModel()
    @State private var cameraPosition: MapCameraPosition = .region(.defaultRegion)
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State private var getDirections = false
    @State private var routeDisplaying = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    @State private var shouldFollowUser = true
    @State private var searchResults: MKMapItem?
    
    var body: some View {
        Map(position: $cameraPosition, selection: $mapSelection) {
            if let userLocation = viewModel.userLocation {
                Annotation("My Location", coordinate: userLocation) {
                    ZStack {
                        Circle()
                            .frame(width: 32, height: 32)
                            .foregroundStyle(.blue.opacity(0.25))
                        Circle()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.white)
                        Circle()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.blue)
                    }
                }
            }
            
            ForEach(results, id: \.self) { item in
                if routeDisplaying {
                    if item == routeDestination {
                        let placemark = item.placemark
                        Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                    }
                } else {
                    let placemark = item.placemark
                    Marker(placemark.name ?? "", coordinate: placemark.coordinate)
                }
            }
            
            ForEach(viewModel.searchResults, id: \.self) { result in
                Marker(item: result)
            }
            
            if let route {
                MapPolyline(route.polyline)
                    .stroke(.blue, lineWidth: 6)
            }
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
            
            HStack {
                VStack {
                    Button {
                        clearRoute()
                    } label: {
                        Image(systemName: "xmark.square")
                    }
                    .buttonStyle(.borderedProminent)
                          Text("Clear Route")
                              .font(.caption)
                              .foregroundColor(.blue)
                      }
                      .padding(.top)
                      .padding(.bottom, 3)
                      .padding(.leading, 260)
                  }
              }
        .onChange(of: getDirections, { oldValue, newValue in
            if newValue {
                fetchRoute()
            }
        })
        .onChange(of: mapSelection, { oldValue, newValue in
            showDetails = newValue != nil
        })
        .onChange(of: viewModel.userLocation) { newLocation, oldLocation in
            if let newLocation, shouldFollowUser {
                cameraPosition = .region(MKCoordinateRegion(center: newLocation, latitudinalMeters: 10000, longitudinalMeters: 10000))
            }
        }
        .sheet(isPresented: $showDetails, content: {
            LocationDetailsView(mapSelection: $mapSelection, show: $showDetails, getDirections: $getDirections)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
        })
        .mapControls {
            MapUserLocationButton()
            MapCompass()
        }
        .gesture(DragGesture().onChanged({ _ in
            shouldFollowUser = false
        }))
        .onAppear {
            if let userLocation = viewModel.userLocation {
                cameraPosition = .region(MKCoordinateRegion(center: userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000))
            }
        }
    }
    
    func fetchRoute() {
        guard let mapSelection, let userLocation = viewModel.userLocation else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: userLocation))
        request.destination = mapSelection
        
        Task {
            do {
                let result = try await MKDirections(request: request).calculate()
                route = result.routes.first
                routeDestination = mapSelection
                
                withAnimation(.snappy) {
                    routeDisplaying = true
                    showDetails = false
                    
                    if let rect = route?.polyline.boundingMapRect, routeDisplaying {
                        cameraPosition = .rect(rect)
                    }
                }
            } catch {
                print("Yol hesaplama hatası: \(error.localizedDescription)")
            }
        }
    }
    
    func clearRoute() {
        route = nil
        routeDestination = nil
        routeDisplaying = false
        mapSelection = nil
        viewModel.searchResults = []
        
        if let userLocation = viewModel.userLocation {
            cameraPosition = .region(MKCoordinateRegion(center: userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000))
        }
    }
}

extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion {
        return .init(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

#Preview {
    MapView()
}
