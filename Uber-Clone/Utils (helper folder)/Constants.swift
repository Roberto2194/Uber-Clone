//
//  Constants.swift
//  Uber-Clone
//
//  Created by Roberto on 17/08/22.
//

import Firebase

enum Constants {
    static let DB_REF = Database.database().reference()
    static let REF_USERS = DB_REF.child("users")
    static let REF_DRIVER_LOCATION = DB_REF.child("driver-location")
}
