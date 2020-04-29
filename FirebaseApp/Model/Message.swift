//
//  Message.swift
//  FirebaseApp
//
//  Created by Eduardo Garcia on 4/20/20.
//  Copyright © 2020 Eduardo Garcia. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {

    @objc var fromId: String?
    @objc var text: String?
    @objc var timestamp: NSNumber?
    @objc var toId: String?
    
    init(dictionary: [String: Any]) {
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
    }
    
    func chatPartnerId() -> String? {
        
        return fromId == FirebaseAuth.Auth.auth().currentUser?.uid ? toId : fromId
    }
    
}
