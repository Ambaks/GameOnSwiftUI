//
//  LocationManager.swift
//  GameOnSwiftUI
//
//  Created by Anaia Hoard on 12/06/2024.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    private let locationManager = CLLocationManager()
    
    override init(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastKnownLocation = locations.first?.coordinate
        }

}



