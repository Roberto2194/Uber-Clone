//
//  Service.swift
//  Uber-Clone
//
//  Created by Roberto on 14/08/22.
//

import Firebase

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
    
}
