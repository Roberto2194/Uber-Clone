//
//  Service.swift
//  Uber-Clone
//
//  Created by Roberto on 14/08/22.
//

import Firebase

fileprivate let DB_REF = Database.database().reference()
fileprivate let REF_USERS = DB_REF.child("users")

struct Service {
    
    static let shared = Service()
    
    private init() { }

    private let currentUid = Auth.auth().currentUser!.uid

    func fetchUserData(completion: @escaping (User) -> Void) {
        REF_USERS.child(currentUid).observeSingleEvent(of: .value) { snapshot in
            guard let dictionary = snapshot.value as? [String : Any] else { return }
            if let user = User(dictionary: dictionary) {
                completion(user)
            }
        }
    }
    
}
