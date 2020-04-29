//
//  MessageController.swift
//  FirebaseApp
//
//  Created by Eduardo Garcia on 4/17/20.
//  Copyright © 2020 Eduardo Garcia. All rights reserved.
//

import Foundation
import UIKit
import Firebase


// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MessageController: UITableViewController {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users/profile").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in

            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User(dictionary: dictionary)
                //user.setValuesForKeys(dictionary)
                self.setUpNavBar(user: user)
                
            }
        }, withCancel: nil)
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
    }
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    func observeUserMessages() {
        
        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid else {
            return
        }
        let ref = Database.database().reference().child("user-messages").child(uid)
        ref.observe(.childAdded, with: { (snapshot) in
            
            let messageId = snapshot.key
            let messagesReference = Database.database().reference().child("messages").child(messageId)
            messagesReference.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = Message(dictionary: dictionary)

                        if let chatPartnerId = message.chatPartnerId() {
                            self.messagesDictionary[chatPartnerId] = message

                            self.messages = Array(self.messagesDictionary.values)
                            self.messages.sort(by: { (message1, message2) -> Bool in

                            return message1.timestamp?.int32Value > message2.timestamp?.int32Value
                        })
                    }
                    
                    self.timer?.invalidate()
                    self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
                }
                
            }, withCancel: nil)
            
        }, withCancel: nil)
        
    }
    var timer: Timer?
    
    
    @objc func handleReloadTable() {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
        
    }
    
      func observeMessages() {
             let ref = Database.database().reference().child("messages")
                    ref.observe(.childAdded, with: { (snapshot) in
                        
                       if let dictionary = snapshot.value as? [String: AnyObject] {
                            let message = Message(dictionary: dictionary)

                            if let toId = message.toId {
                                self.messagesDictionary[toId] = message

                                self.messages = Array(self.messagesDictionary.values)
                                self.messages.sort(by: { (message1, message2) -> Bool in

                                    return message1.timestamp?.int32Value > message2.timestamp?.int32Value
                                })
                            }

                            DispatchQueue.main.async(execute: {
                                self.tableView.reloadData()
                            })
                        }
                       }, withCancel: nil)
        }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
        
        let message = messages[indexPath.row]
        cell.message = message
        
        
        return cell
        
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]
        guard let chatPartnerId = message.chatPartnerId() else {
            return
        }
        let ref = Database.database().reference().child("users/profile").child(chatPartnerId)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
            guard let dictionary = snapshot.value as? [String: AnyObject]
                else {
                    return
            }
            let user = User(dictionary: dictionary)
            user.id = chatPartnerId
            user.setValuesForKeys(dictionary)
            self.showChatControllerForUser(user: user)

        }, withCancel: nil)
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func setUpNavBar(user: User) {
        
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()
        
       observeUserMessages()
        
        let titleView = UIButton()
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(containerView)
        
        let profileImageView = UIImageView()
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        if let profileImageUrl = user.photoURL {
            profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
        }
        containerView.addSubview(profileImageView)
        
        profileImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        let nameLabel = UILabel()
        
        containerView.addSubview(nameLabel)
        nameLabel.text = user.username
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        nameLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        
        self.navigationItem.titleView = titleView
        
    }
    

    @objc func showChatControllerForUser(user: User){
          let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
            navigationController?.pushViewController(chatLogController, animated: true)
        }
    
    
    
    @IBAction func handleNewMessage(_ sender: UIBarButtonItem) {
        let newMessageController = NewMessageController()
        newMessageController.messagesController = self
        let navController = UINavigationController(rootViewController: newMessageController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    

}
