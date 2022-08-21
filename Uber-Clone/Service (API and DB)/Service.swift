//
//  Service.swift
//  Uber-Clone
//
//  Created by Roberto on 14/08/22.
//

import Firebase
import CoreLocation
import GeoFire

struct Service {
    
    static let shared = Service()
    
    private init() { }
    
    func fetchUserData(completion: @escaping (User) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        Constants.REF_USERS.child(currentUid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            if let user = User(dictionary: dictionary) {
                completion(user)
            }
        }
    }
    
    func fetchDrivers(location: CLLocation) {
        let geofire = GeoFire(firebaseRef: Constants.REF_DRIVER_LOCATION)
        
        Constants.REF_DRIVER_LOCATION.observe(.value) { snapshot in
            let query = geofire.query(at: location, withRadius: 50)
            query.observe(.keyEntered, with: { uid, location in
                print("this is the uid: \(uid)")
                print("this is the location: \(location.coordinate)")
            })
        }
    }
    
}
