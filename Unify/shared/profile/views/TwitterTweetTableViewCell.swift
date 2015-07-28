//
//  TwitterTweetTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TwitterTweetTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func userImageClicked(sender: UIButton) {
        println("userImage clicked")
    }
    
    var name = "Jaden Smith"
    var userName = "@officialjaden"
    var tweet = "People will try to take advantage of u...they will try to tear you down. Keep your head up and know who your truth. Be kind in the face of anger."
    var time = "1m"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
        timeLabel.textColor = UIColor.timeLabelGrey()
        
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        
        setUpLabels(name, username: userName, tweet: tweet, time: time)
    }
    
    func setUpLabels(name: String, username: String, tweet: String, time: String) {
        
        timeLabel.text = time
        
        // Set up name and username label
        let nameString = NSMutableAttributedString()
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 14) {
            let thickString = NSAttributedString(string: "\(name) ", attributes: [NSFontAttributeName: mediumFont])
            nameString.appendAttributedString(thickString)
        }
        
        if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 13.5) {
            let thinString = NSAttributedString(string: userName, attributes: [NSFontAttributeName: lightFont])
            nameString.appendAttributedString(thinString)
        }
        
        nameLabel.attributedText = nameString
        
        // Set up tweet label
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        let messageString = NSMutableAttributedString(string: tweet)
        messageString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, messageString.length))
        tweetLabel.attributedText = messageString
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        tweetLabel.frame = CGRectIntegral(tweetLabel.frame)
        timeLabel.frame = CGRectIntegral(timeLabel.frame)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if (selected) {
            self.contentView.backgroundColor = UIColor.twitterBlue()
            nameLabel.textColor = UIColor.whiteColor()
            tweetLabel.textColor = UIColor.whiteColor()
            timeLabel.textColor = UIColor.whiteColor()
        } else {
            self.contentView.backgroundColor = UIColor.clearColor()
            nameLabel.textColor = UIColor.twitterBlue()
            tweetLabel.textColor = UIColor.blackColor()
            timeLabel.textColor = UIColor.customLightGrayColor()
        }
    }
    
}
