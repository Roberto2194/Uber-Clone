//
//  LocationHandler.swift
//  Uber-Clone
//
//  Created by Roberto on 17/08/22.
//

import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHandler()
 
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    private override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
          
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print("not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorized always")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("authorized when in use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            print("unknown")
        }
    }

}
