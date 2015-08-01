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
        
        self.contentView.backgroundColor = selected ? UIColor.twitterBlue() : UIColor.clearColor()
        nameLabel.textColor = selected ? UIColor.whiteColor() : UIColor.blackColor()
        usernameLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.darkGrayColor()
        tweetLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.blackColor()
        timeLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.customLightGrayColor()
        replyLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        retweetLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        starLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        replyIcon.tintColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        repostIcon.tintColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        starIcon.tintColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        replyIcon.enabled = selected
        repostIcon.enabled = selected
        starIcon.enabled = selected
        
    }
    
}
