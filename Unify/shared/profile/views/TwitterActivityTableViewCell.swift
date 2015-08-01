//
//  TwitterActivityTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TwitterActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func userImageClicked(sender: UIButton) {
        println("userImage clicked")
    }
    
    var userName = "Jaden Smith"
    var userAction = "shared"
    var otherUserName = "Justin Bieber"
    var otherUserItem = "'s post"
    var tweet = "People will try to take advantage of u...they will try to tear you down. Keep your head up and know your truth. Be kind in the face of anger."
    var time = "1m"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
        timeLabel.textColor = UIColor.timeLabelGrey()
        
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        
        setUpLabels(userName, userAction: userAction, otherName: otherUserName, otherItem: otherUserItem, tweet: tweet, time: time)
    }
    
    func setUpLabels(name: String, userAction: String, otherName: String, otherItem: String, tweet: String, time: String) {
        
        timeLabel.text = time
        
        // Set up activity label
        let activityString = NSMutableAttributedString()
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 14) {
            let thickString = NSAttributedString(string: "\(userName)", attributes: [NSFontAttributeName: mediumFont])
            activityString.appendAttributedString(thickString)
        }
        
        if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 13.5) {
            let thinString = NSAttributedString(string: " \(userAction) ", attributes: [NSFontAttributeName: lightFont])
            activityString.appendAttributedString(thinString)
        }
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 13.5) {
            let mediumString = NSAttributedString(string: "\(otherUserName)", attributes: [NSFontAttributeName: romanFont])
            activityString.appendAttributedString(mediumString)
        }
        
        if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 13.5) {
            let thinString = NSAttributedString(string: "\(otherUserItem)", attributes: [NSFontAttributeName: lightFont])
            activityString.appendAttributedString(thinString)
        }
        
        activityLabel.attributedText = activityString
        
        // Set up tweet label
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        let messageString = NSMutableAttributedString(string: tweet)
        messageString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, messageString.length))
        tweetLabel.attributedText = messageString
        
        activityLabel.frame = CGRectIntegral(activityLabel.frame)
        tweetLabel.frame = CGRectIntegral(tweetLabel.frame)
        timeLabel.frame = CGRectIntegral(timeLabel.frame)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.contentView.backgroundColor = UIColor.twitterBlue()
            activityLabel.textColor = UIColor.whiteColor()
            tweetLabel.textColor = UIColor.whiteColor()
            timeLabel.textColor = UIColor.whiteColor()
        } else {
            self.contentView.backgroundColor = UIColor.clearColor()
            activityLabel.textColor = UIColor.twitterBlue()
            tweetLabel.textColor = UIColor.blackColor()
            timeLabel.textColor = UIColor.customLightGrayColor()
        }
    }
    
}
