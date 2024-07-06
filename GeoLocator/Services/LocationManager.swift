//
//  LocationManager.swift
//  GeoLocator
//
//  Created by Анастасия Конончук on 30.06.2024.
//

import CoreLocation
import UIKit

final class LocationManager: NSObject, ObservableObject {
    // MARK: - Property Wrappers
    
    @Published var isLocationEnabled = false
    @Published var location: CLLocation?
    
    // MARK: - Private Properties
    
    private let locationManager = CLLocationManager()
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: - Public Methods
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
    
    // MARK: - Private Methods
    
    private func checkLocationAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            isLocationEnabled = true
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            isLocationEnabled = false
        default:
            isLocationEnabled = false
        }
    }
}

// MARK: - Ext. CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        self.location = location
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorizationStatus()
    }
}
