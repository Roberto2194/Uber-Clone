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
    private let tableView = UITableView()
    
    private var user: User? {
        didSet {
            locationInputView.user = user
        }
    }
            
    private let locationInputViewHeight: CGFloat = 200.0
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUserLoggedIn()

        locationManager = LocationHandler.shared.locationManager
        
        locationInputActivationView.delegate = self
        locationInputView.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUserData()
        fetchDrivers()

        // mapView
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        // locationInputActivationView
        view.addSubview(locationInputActivationView)
        locationInputActivationView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40, centerX: view.centerXAnchor, width: view.frame.width - 64, height: 50)
        
        locationInputActivationView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputActivationView.alpha = 1
        }
        
        // tableView
        tableView.register(LocationCell.self, forCellReuseIdentifier: "LocationCell")
        tableView.tableFooterView = UIView()
        
        let tableViewHeight = view.frame.height - locationInputViewHeight
        tableView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: tableViewHeight)

        view.addSubview(tableView)
    }
    
    //MARK: - Methods
    
    private func checkUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            self.presentLoginController()
        }
    }
    
    private func signOut() {
        do {
            try Auth.auth().signOut()
            self.presentLoginController()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    private func fetchUserData() {
        Service.shared.fetchUserData { user in
            self.user = user
        }
    }
    
    private func fetchDrivers() {
        guard let location = locationManager.location else { return }
        Service.shared.fetchDrivers(location: location)
    }
    
    private func presentLoginController() {
        DispatchQueue.main.async {
            let loginController = UINavigationController(rootViewController: LogInController())
            loginController.modalPresentationStyle = .fullScreen
            self.present(loginController, animated: true, completion: nil)
        }
    }

}

//MARK: - Extensions

extension HomeController: LocationInputActivationViewDelegate {
    
    func presentLocationInputView() {
        locationInputActivationView.alpha = 0
        
        view.addSubview(locationInputView)
        locationInputView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: locationInputViewHeight)
        
        locationInputView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.locationInputView.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.tableView.frame.origin.y = self.locationInputViewHeight
            }
        }
    }
    
}

extension HomeController: LocationInputViewDelegate {
    
    func dismissLocationInputView() {
        UIView.animate(withDuration: 0.3) {
            self.locationInputView.alpha = 0
            self.tableView.frame.origin.y = self.view.frame.height
        } completion: { _ in
            self.locationInputView.removeFromSuperview()
            UIView.animate(withDuration: 0.3) {
                self.locationInputActivationView.alpha = 1
            }
        }
    }
    
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Title"
    }
    
}
