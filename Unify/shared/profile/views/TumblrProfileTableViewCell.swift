//
//  TumblrProfileTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 8/1/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TumblrProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profilePicBorder: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numPostsLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    
    var name = "Jaden Smith"
    var username = "@jadensmith"
    var numFollowers = "9.8m"
    var numPosts = "4"
    var numLikes = "1068"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.masksToBounds = true
        profilePicBorder.layer.cornerRadius = profilePicBorder.frame.size.width/2
        profilePicBorder.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.tumblrBlue()

        setUpLabels(name, username: username, numFollowers: numFollowers, numPosts: numPosts, numLikes: numLikes)
    }
    
    func setUpLabels(name: String, username: String, numFollowers: String, numPosts: String, numLikes: String) {
        nameLabel.text = name
        usernameLabel.text = username
        numFollowersLabel.text = numFollowers
        numPostsLabel.text = numPosts
        numLikesLabel.text = numLikes
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        usernameLabel.frame = CGRectIntegral(usernameLabel.frame)
        numFollowersLabel.frame = CGRectIntegral(numFollowersLabel.frame)
        numPostsLabel.frame = CGRectIntegral(numPostsLabel.frame)
        numLikesLabel.frame = CGRectIntegral(numLikesLabel.frame)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
