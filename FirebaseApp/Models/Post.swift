//
//  Post.swift
//  FirebaseApp
//
//  Created by William Ordaz on 4/29/20.
//  Copyright © 2020 Eduardo Garcia. All rights reserved.
//

import Foundation

class Post {
    var id:String
    var author:UserProfile
    var title:String
    var when:String
    var time:String
    var distance:String
    var pace:String
    var createdAt:Date
    
    init(id:String, author:UserProfile, title:String, when:String, time:String, distance:String, pace:String, timestamp: Double) {
        self.id = id
        self.author = author
        self.title = title
        self.when = when
        self.time = time
        self.distance = distance
        self.pace = pace
        self.createdAt = Date(timeIntervalSince1970: timestamp / 1000)
    }
}
