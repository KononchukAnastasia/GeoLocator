//
//  MapScreen.swift
//  GeoLocator
//
//  Created by Анастасия Конончук on 30.06.2024.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    // MARK: - Property Wrappers
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var mapType: MKMapType = .standard
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if !locationManager.isLocationEnabled {
                VStack {
                    Text("Location services are disabled. Please enable them in settings.")
                        .padding()
                    Button(action: {
                        locationManager.openSettings()
                    }) {
                        Text("Open Settings")
                            .padding()
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            } else {
                if let location = locationManager.location {
                    MapView(coordinate: location.coordinate, mapType: mapType)
                        .ignoresSafeArea()
                } else {
                    Text("Locating your position...")
                }
            }
            
            Picker("Map Type", selection: $mapType) {
                Text("Standard").tag(MKMapType.standard)
                Text("Satellite").tag(MKMapType.satellite)
                Text("Hybrid").tag(MKMapType.hybrid)
            }
            .pickerStyle(.segmented)
            .background(.white.opacity(0.8))
            .cornerRadius(10)
            .padding()
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

// MARK: - Preview

#Preview {
    MapScreen()
}
