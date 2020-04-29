//
//  User.swift
//  FirebaseApp
//
//  Created by Eduardo Garcia on 4/18/20.
//  Copyright © 2020 Eduardo Garcia. All rights reserved.
//

import UIKit

class User: NSObject {
    @objc var id: String!
    @objc var email: String!
    @objc var photoURL: String!
    @objc var username: String!
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.username = dictionary["username"] as? String
        self.email = dictionary["email"] as? String
        self.photoURL = dictionary["photoURL"] as? String
    }
}
