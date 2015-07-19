//
//  TwitterActivityTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TwitterActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var socialMediaIconBorder: UIView!
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var socialMediaIcon: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func userImageClicked(sender: UIButton) {
        println("userImage clicked")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        socialMediaIconBorder.layer.cornerRadius = socialMediaIconBorder.bounds.size.width/2
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        socialMediaIcon.image = UIImage(named: "Twitter-Small-Icon")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.contentView.backgroundColor = UIColor.selectedFeedCell()
            activityLabel.textColor = UIColor.whiteColor()
            tweetLabel.textColor = UIColor.whiteColor()
            timeLabel.textColor = UIColor.whiteColor()
        } else {
            self.contentView.backgroundColor = UIColor.clearColor()
            activityLabel.textColor = UIColor.blackColor()
            tweetLabel.textColor = UIColor.blackColor()
            timeLabel.textColor = UIColor.customLightGrayColor()
        }
    }
    
}
