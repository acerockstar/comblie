//
//  ActivityTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "Persona")
        activityImage.image = UIImage(named: "Photo")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.contentView.backgroundColor = UIColor.selectedFeedCell()
            descriptionLabel.textColor = UIColor.whiteColor()
            timeLabel.textColor = UIColor.whiteColor()
        } else {
            self.contentView.backgroundColor = UIColor.clearColor()
            descriptionLabel.textColor = UIColor.blackColor()
            timeLabel.textColor = UIColor.customLightGrayColor()
        }
    }
    
}
