//
//  User.swift
//  Uber-Clone
//
//  Created by kalpa on 15/08/22.
//

import Foundation

struct User {
    let fullname: String
    let email: String
    let accountType: Int
    
    init?(dictionary: [String : Any]) {
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
    }
}
