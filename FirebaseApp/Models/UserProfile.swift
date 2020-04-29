//
//  UserProfile.swift
//  FirebaseApp
//
//  Created by William Ordaz on 4/29/20.
//  Copyright © 2020 Robert Canton. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    
    init(uid:String, username:String, photoURL:URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
    }
}
