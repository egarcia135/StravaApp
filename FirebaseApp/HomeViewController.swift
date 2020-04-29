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

class HomeViewController:UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView:UITableView!
    
    var posts = [Post]()
    var fetchingMore = false
    var endReached = false
    let leadingScreensForBatching:CGFloat = 3.0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "feedCell")
        tableView.backgroundColor = UIColor(white: 0.90,alpha:1.0)
        view.addSubview(tableView)
        
        var layoutGuide:UILayoutGuide!
        
        if #available(iOS 11.0, *){
            layoutGuide = view.safeAreaLayoutGuide
        }else {
            layoutGuide = view.layoutMarginsGuide
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        beginBatchFetch()
        
    }
    
    func fetchUploads(completion: @escaping(_ posts:[Post])->()) {
        let postsRef = Database.database().reference().child("uploads")
        let lastPost = posts.last
        
        var queryRef:DatabaseQuery
        
        
        if lastPost != nil {
            let lastTimestamp = lastPost!.createdAt.timeIntervalSince1970 * 1000
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryEnding(atValue: lastTimestamp).queryLimited(toLast: 20)
        } else {
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryLimited(toLast: 20)
        }
        
       /* if lastPost == nil {
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryLimited(toLast: 20)
        } else {
            let lastTimestamp = lastPost!.createdAt.timeIntervalSince1970 * 1000
            queryRef = postsRef.queryOrdered(byChild: "timestamp").queryEnding(atValue: lastTimestamp).queryLimited(toLast: 20)
        }
        */
        
        queryRef.observeSingleEvent(of: .value, with: { snapshot in
            
            var tempPosts = [Post]()
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dict = childSnapshot.value as? [String:Any],
                    let author = dict["author"] as? [String:Any],
                    let uid = author["uid"] as? String,
                    let username = author["username"] as? String,
                    let photoURL = author["photoURL"] as? String,
                    let url = URL(string:photoURL),
                    let title = dict["title"] as? String,
                    let when = dict["when"] as? String,
                    let time = dict["time"] as? String,
                    let distance = dict["distance"] as? String,
                    let pace = dict["pace"] as? String,
                    let timestamp = dict["timestamp"] as? Double {
                    
                    
                    if childSnapshot.key != lastPost?.id {
                        let userProfile = UserProfile(uid: uid, username: username, photoURL: url)
                        let post = Post(id: childSnapshot.key, author: userProfile, title: title, when: when, time: time, distance: distance, pace: pace, timestamp: timestamp)
                                           tempPosts.insert(post, at: 0)
                    }
                }
            }
            
            return completion(tempPosts)
        })
            
        
    }
    
    
    @IBAction func handleLogout(_ sender:Any) {
       try! Auth.auth().signOut()
        print("Logged out")
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height * leadingScreensForBatching {
            
            if !fetchingMore && !endReached {
                beginBatchFetch()
            }
        }
    }
    
    func beginBatchFetch(){
        fetchingMore = true

        fetchUploads { newPosts in
            self.posts.append(contentsOf: newPosts)
            self.endReached = newPosts.count == 0
            self.fetchingMore = false
            self.tableView.reloadData()
        }
        self.tableView.reloadData()

    }
    
}
