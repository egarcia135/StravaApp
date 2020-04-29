//
//  HomeViewController.swift
//  FirebaseApp
//
//  Created by Eduardo Garcia on 2020-04-01.
//  Copyright © 2020 Eduardo Garcia. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController:UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLogout(_ sender:Any) {
       try! Auth.auth().signOut()
        print("Logged out")
    }
    
}
