//
//  MessagesTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/2/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    @IBOutlet weak var socialMediaIconBorder: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var socialMediaIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userMessage: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        socialMediaIcon.layer.cornerRadius = socialMediaIcon.bounds.size.width/2
        socialMediaIconBorder.layer.cornerRadius = socialMediaIconBorder.bounds.size.width/2
        socialMediaIcon.clipsToBounds = true
        socialMediaIcon.image = UIImage(named: "Twitter-Icon")
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "Persona")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if (selected) {
            self.contentView.backgroundColor = UIColor.lightGrayColor()
        } else {
            self.contentView.backgroundColor = UIColor.clearColor()
        }
    }
    
}

