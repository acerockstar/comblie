//
//  TwitterClickedTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/5/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TwitterClickedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var replyIcon: UIButton!
    @IBOutlet weak var repostIcon: UIButton!
    @IBOutlet weak var starIcon: UIButton!
    @IBOutlet weak var replyLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        replyIcon.tintColor = UIColor.whiteColor()
        repostIcon.tintColor = UIColor.whiteColor()
        starIcon.tintColor = UIColor.whiteColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.contentView.backgroundColor = UIColor.selectedFeedCell()
            nameLabel.textColor = UIColor.whiteColor()
            usernameLabel.textColor = UIColor.whiteColor()
            tweetLabel.textColor = UIColor.whiteColor()
            timeLabel.textColor = UIColor.whiteColor()
            replyLabel.textColor = UIColor.whiteColor()
            retweetLabel.textColor = UIColor.whiteColor()
            starLabel.textColor = UIColor.whiteColor()
            replyIcon.enabled = true
            repostIcon.enabled = true
            starIcon.enabled = true
        } else {
            self.contentView.backgroundColor = UIColor.clearColor()
            nameLabel.textColor = UIColor.blackColor()
            usernameLabel.textColor = UIColor.darkGrayColor()
            tweetLabel.textColor = UIColor.blackColor()
            timeLabel.textColor = UIColor.customLightGrayColor()
            replyLabel.textColor = UIColor.clearColor()
            retweetLabel.textColor = UIColor.clearColor()
            starLabel.textColor = UIColor.clearColor()
            replyIcon.enabled = false
            repostIcon.enabled = false
            starIcon.enabled = false
        }
    }
    
}
