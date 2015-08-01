//
//  ActivityTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var socialMediaIconBorder: UIView!
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var socialMediaIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func userImage(sender: UIButton) {
        println("userImage clicked")
    }
    
    var names = "Jaden Smith"
    var and = " and "
    var others = "5 others"
    var action = "like your photo."
    var time = "Today at 9:36 PM"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
        timeLabel.textColor = UIColor.timeLabelGrey()
        socialMediaIconBorder.layer.cornerRadius = socialMediaIconBorder.bounds.size.width/2
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        socialMediaIcon.image = UIImage(named: "Tumblr-Small-Icon")
        
        setUpLabels(names, and: and, others: others, action: action, time: time)
    }
    
    func setUpLabels(name: String, and: String, others: String, action: String, time: String) {
        
        timeLabel.text = time
        
        // Set up description label
        let descriptionString = NSMutableAttributedString()
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 13) {
            let thickString = NSAttributedString(string: name, attributes: [NSFontAttributeName: mediumFont])
            descriptionString.appendAttributedString(thickString)
        }
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 13) {
            let thinString = NSAttributedString(string: and, attributes: [NSFontAttributeName: romanFont])
            descriptionString.appendAttributedString(thinString)
        }
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 13) {
            let thickString = NSAttributedString(string: others, attributes: [NSFontAttributeName: mediumFont])
            descriptionString.appendAttributedString(thickString)
        }
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 13) {
            let thinString = NSAttributedString(string: " \(action)", attributes: [NSFontAttributeName: romanFont])
            descriptionString.appendAttributedString(thinString)
        }
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        descriptionString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0,descriptionString.length))
        descriptionLabel.attributedText = descriptionString
        
        descriptionLabel.frame = CGRectIntegral(descriptionLabel.frame)
        timeLabel.frame = CGRectIntegral(timeLabel.frame)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
