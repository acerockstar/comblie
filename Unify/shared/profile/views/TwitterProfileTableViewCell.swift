//
//  TwitterProfileTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 8/1/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TwitterProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profilePicBorder: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    
    var name = "Jaden Smith"
    var username = "@officialjaden"
    var userDescription = "Hello, this is my description."
    var numFollowers = "9.8m"
    var numFollowing = "4"
    var numTweets = "1068"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.masksToBounds = true
        profilePicBorder.layer.cornerRadius = profilePicBorder.frame.size.width/2
        profilePicBorder.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.twitterBlue()
        
        setUpLabels(name, username: username, description: userDescription, numFollowers: numFollowers, numFollowing: numFollowing, numTweets: numTweets)
    }
    
    func setUpLabels(name: String, username: String, description: String, numFollowers: String, numFollowing: String, numTweets: String) {
        nameLabel.text = name
        usernameLabel.text = username
        numFollowersLabel.text = numFollowers
        numFollowingLabel.text = numFollowing
        numTweetsLabel.text = numTweets
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        messageStyle.alignment = .Center
        let descriptionString = NSMutableAttributedString(string: description)
        descriptionString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, descriptionString.length))
        descriptionLabel.attributedText = descriptionString
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        usernameLabel.frame = CGRectIntegral(usernameLabel.frame)
        descriptionLabel.frame = CGRectIntegral(descriptionLabel.frame)
        numFollowersLabel.frame = CGRectIntegral(numFollowersLabel.frame)
        numFollowingLabel.frame = CGRectIntegral(numFollowingLabel.frame)
        numTweetsLabel.frame = CGRectIntegral(numTweetsLabel.frame)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
