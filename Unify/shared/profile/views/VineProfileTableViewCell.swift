//
//  VineProfileTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 8/1/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class VineProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profilePicBorder: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numPostsLabel: UILabel!
    @IBOutlet weak var numLoopsLabel: UILabel!
    
    var name = "Jaden Smith"
    var userDescription = "Hello, this is my description."
    var numFollowers = "9.8m"
    var numPosts = "4"
    var numLoops = "1068"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.masksToBounds = true
        profilePicBorder.layer.cornerRadius = profilePicBorder.frame.size.width/2
        profilePicBorder.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.vineGreen()

        setUpLabels(name, description: userDescription, numFollowers: numFollowers, numPosts: numPosts, numLoops: numLoops)
    }
    
    func setUpLabels(name: String, description: String, numFollowers: String, numPosts: String, numLoops: String) {
        nameLabel.text = name
        numFollowersLabel.text = numFollowers
        numPostsLabel.text = numPosts
        numLoopsLabel.text = numLoops
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        messageStyle.alignment = .Center
        let descriptionString = NSMutableAttributedString(string: description)
        descriptionString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, descriptionString.length))
        descriptionLabel.attributedText = descriptionString
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        descriptionLabel.frame = CGRectIntegral(descriptionLabel.frame)
        numFollowersLabel.frame = CGRectIntegral(numFollowersLabel.frame)
        numPostsLabel.frame = CGRectIntegral(numPostsLabel.frame)
        numLoopsLabel.frame = CGRectIntegral(numLoopsLabel.frame)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
