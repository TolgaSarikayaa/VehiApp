//
//  LocationDetailsView.swift
//  MyCar
//
//  Created by Tolga Sarikaya on 02.07.24.
//

import SwiftUI
import MapKit

struct LocationDetailsView: View {
    @Binding var mapSelection: MKMapItem?
    @Binding var show: Bool
    @State private var lookAroundScene: MKLookAroundScene?
    //@Binding var getDirections: Bool
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                        .padding(.leading, 8)
                    Text(mapSelection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(12)
                        .padding(.trailing)
                        .padding(.leading, 8)
                }
                Spacer()
                Button {
                    show.toggle()
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(.gray, Color(.systemGray6))
                }
            }
            if let scene = lookAroundScene {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
            }
            HStack(spacing: 24) {
                Button {
                    if let mapSelection {
                        mapSelection.openInMaps()
                    }
                } label: {
                    Text("Open in Maps")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 220 , height: 48)
                        .background(.green)
                        .cornerRadius(12)
                }
                
                /*
                Button {
                    getDirections = true
                    show = false
                } label: {
                    Text("Get Directions")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 170 , height: 48)
                        .background(.blue)
                        .cornerRadius(12)
                }
                 */
            }
                .padding(.horizontal)
        }
        .onAppear {
            print("DEBUG: Did call on Appear")
            fetchLookAroundPreview()
        }
        
        .onChange(of: mapSelection) { oldValue, newValue in
            print("DEBUG: Did call on Change")
            fetchLookAroundPreview()
        }
    }
    
}

extension LocationDetailsView {
    func fetchLookAroundPreview() {
        if let mapSelection {
            lookAroundScene = nil
            Task {
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
                
            }
        }
    }
}

#Preview {
    LocationDetailsView(mapSelection: .constant(nil), show: .constant(false))
}
