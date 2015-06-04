//
//  TwitterActivityTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TwitterActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "Persona")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.contentView.backgroundColor = UIColor.selectedFeedCell()
            nameLabel.textColor = UIColor.whiteColor()
            tweetLabel.textColor = UIColor.whiteColor()
            timeLabel.textColor = UIColor.whiteColor()
        } else {
            self.contentView.backgroundColor = UIColor.clearColor()
            nameLabel.textColor = UIColor.blackColor()
            tweetLabel.textColor = UIColor.blackColor()
            timeLabel.textColor = UIColor.customLightGrayColor()
        }
    }
    
}
