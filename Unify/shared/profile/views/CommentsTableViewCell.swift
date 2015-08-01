//
//  CommentsTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/16/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var name = "Savannah Brinson"
    var comment = "Hahahahaha this is totally about me."
    var names = "Lebron James"
    var time = "4 minutes ago"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
        timeLabel.textColor = UIColor.timeLabelGrey()
        
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        
        setUpLabels(name, username: comment, tweet: names, time: time)
    }
    
    func setUpLabels(name: String, username: String, tweet: String, time: String) {
        
        nameLabel.text = name
        timeLabel.text = time
        
        let commentString = NSMutableAttributedString()
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 13) {
            let thinString = NSAttributedString(string: "\(comment) ", attributes: [NSFontAttributeName: romanFont])
            commentString.appendAttributedString(thinString)
        }
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 13) {
            let thickString = NSAttributedString(string: names, attributes: [NSFontAttributeName: mediumFont])
            commentString.appendAttributedString(thickString)
        }
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        commentString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, commentString.length))
        commentLabel.attributedText = commentString
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        commentLabel.frame = CGRectIntegral(commentLabel.frame)
        timeLabel.frame = CGRectIntegral(timeLabel.frame)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
