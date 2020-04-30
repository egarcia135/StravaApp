//
//  FeedTableViewCell.swift
//  FirebaseApp
//
//  Created by William Ordaz on 4/29/20.
//  Copyright © 2020 Eduardo Garcia. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    weak var post:Post?
    
    func set(post:Post){
        self.post = post
        
        self.profileImageView.image = nil
        ImageService.getImage(withURL: post.author.photoURL) { image, url in
            guard let _post = self.post else {return}
            if _post.author.photoURL.absoluteString == url.absoluteString {
                self.profileImageView.image = image
            } else {
                print("Not the right image")
            }
            
        }
        
        
        usernameLabel.text = post.author.username
        whenLabel.text = post.when
        titleLabel.text = post.title
        timeLabel.text = post.time
        distanceLabel.text = post.distance
        paceLabel.text = post.pace
        subtitleLabel.text = post.createdAt.calenderTimeSinceNow()
    }
    
}
