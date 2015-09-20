//
//  PostTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func userImageClicked(sender: UIButton) {
        println("userImage clicked")
    }
    
    var type = NetworkType.Twitter
    var name = "Jaden Smith"
    var userName: String? = "@officialjaden"
    var postText = "People will try to take advantage of u..."
    var time = "1m"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
        timeLabel.textColor = UIColor.timeLabelGrey()
        
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        
        setUpLabels(name, username: userName, postText: postText, time: time, type: self.type)
    }
    
    func setUpLabels(name: String, username: String?, postText: String, time: String, type: NetworkType) {
        
        timeLabel.text = time
        
        // Set up name and username label
        let nameString = NSMutableAttributedString()
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 14) {
            let thickString = NSAttributedString(string: "\(name) ", attributes: [NSFontAttributeName: mediumFont])
            nameString.appendAttributedString(thickString)
        }
        
        self.userName = username
        if let text = userName {
            if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 13.5) {
                let thinString = NSAttributedString(string: text, attributes: [NSFontAttributeName: lightFont])
                nameString.appendAttributedString(thinString)
            }
        }
        
        nameLabel.attributedText = nameString
        
        switch type {
        case NetworkType.Facebook:
            nameLabel.textColor = UIColor.facebookBlue()
        case NetworkType.Twitter:
            nameLabel.textColor = UIColor.twitterBlue()
        case NetworkType.Vine:
            nameLabel.textColor = UIColor.vineGreen()
        case NetworkType.Tumblr:
            nameLabel.textColor = UIColor.tumblrBlue()
        }
        
        // Set up tweet label
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        let messageString = NSMutableAttributedString(string: postText)
        messageString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, messageString.length))
        postTextLabel.attributedText = messageString
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        postTextLabel.frame = CGRectIntegral(postTextLabel.frame)
        timeLabel.frame = CGRectIntegral(timeLabel.frame)
        
        // Set the network type
        self.type = type
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            switch type {
            case NetworkType.Facebook:
                self.contentView.backgroundColor = UIColor.facebookBlue()
            case NetworkType.Twitter:
                self.contentView.backgroundColor = UIColor.twitterBlue()
            case NetworkType.Vine:
                self.contentView.backgroundColor = UIColor.vineGreen()
            case NetworkType.Tumblr:
                self.contentView.backgroundColor = UIColor.tumblrBlue()
            }
            nameLabel.textColor = UIColor.whiteColor()
            postTextLabel.textColor = UIColor.whiteColor()
            timeLabel.textColor = UIColor.whiteColor()
        } else {
            switch type {
            case NetworkType.Facebook:
                nameLabel.textColor = UIColor.facebookBlue()
            case NetworkType.Twitter:
                nameLabel.textColor = UIColor.twitterBlue()
            case NetworkType.Vine:
                nameLabel.textColor = UIColor.vineGreen()
            case NetworkType.Tumblr:
                nameLabel.textColor = UIColor.tumblrBlue()
            }
            self.contentView.backgroundColor = UIColor.clearColor()
            postTextLabel.textColor = UIColor.blackColor()
            timeLabel.textColor = UIColor.customLightGrayColor()
        }
    }
    
}
