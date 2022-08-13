//
//  HomeController.swift
//  Uber-Clone
//
//  Created by Roberto on 12/08/22.
//

import UIKit
import Firebase
import MapKit

class HomeController: UIViewController {
    
    //MARK: - Properties
    
    private let mapView = MKMapView()
    private var locationManager: CLLocationManager!
    
    private let locationInputActivationView = LocationInputActivationView()
    private let locationInputView = LocationInputView()
        
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUserLoggedIn()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationInputActivationView.delegate = self
        locationInputView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // mapView
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // locationInputActivationView
        view.addSubview(locationInputActivationView)
        locationInputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, centerX: view.centerXAnchor, width: view.frame.width - 64, height: 50)
        
        locationInputActivationView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.locationInputActivationView.alpha = 1
        }
                
    }
    
    //MARK: - Methods
    
    func checkUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginController = UINavigationController(rootViewController: LogInController())
                loginController.modalPresentationStyle = .fullScreen
                self.present(loginController, animated: true, completion: nil)
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }

}

//MARK: - Extensions

extension HomeController: CLLocationManagerDelegate {
    
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

extension HomeController: LocationInputActivationViewDelegate {
    
    func presentLocationInputView() {
        locationInputActivationView.alpha = 0
        
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 200)
        
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            // TODO: - Present table view
            print("present table view")
        }
    }
    
}

extension HomeController: LocationInputViewDelegate {
    
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
        } completion: { _ in
            self.locationInputActivationView.alpha = 1
        }
    }
    
}
