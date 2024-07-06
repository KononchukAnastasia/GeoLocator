//
//  MapView.swift
//  GeoLocator
//
//  Created by Анастасия Конончук on 30.06.2024.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    // MARK: - Public Properties
    
    var coordinate: CLLocationCoordinate2D
    var mapType: MKMapType
    
    // MARK: - Public Methods
    
    func makeUIView(context: Context) -> MKMapView {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        let mapView = MKMapView(frame: .zero)
        mapView.setRegion(region, animated: true)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        view.mapType = mapType
        view.showsUserLocation = true
        view.setUserTrackingMode(.followWithHeading, animated: true)
    }
}
