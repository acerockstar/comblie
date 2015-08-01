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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var name = "David Beckham"
    var message = "Hey, you down for a pickup game later today? Meet at 7 on the field. Joe and Peyton are coming too."
    var time = "9:26pm"
    
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
        
        setUpLabels(name, message: message, time: time, read: false)
    }
    
    func setUpLabels(name: String, message: String, time: String, read: Bool) {
        
        // Set up messsage label
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        let messageString = NSMutableAttributedString(string: message)
        messageString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, messageString.length))
        messageLabel.attributedText = messageString
        
        nameLabel.text = name
        timeLabel.text = time
        
        if read {
            nameLabel.font = UIFont(name: "HelveticaNeueLTStd-Md", size: 14.5)
            messageLabel.font = UIFont(name: "HelveticaNeueLTStd-Lt", size: 13)
            timeLabel.font = UIFont(name: "HelveticaNeueLTStd-Lt", size: 12.5)
        } else {
            nameLabel.font = UIFont(name: "HelveticaNeueLTStd-Bd", size: 14.5)
            messageLabel.font = UIFont(name: "HelveticaNeueLTStd-Md", size: 13)
            timeLabel.font = UIFont(name: "HelveticaNeueLTStd-Roman", size: 12.5)
        }

        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        messageLabel.frame = CGRectIntegral(messageLabel.frame)
        timeLabel.frame = CGRectIntegral(timeLabel.frame)
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

