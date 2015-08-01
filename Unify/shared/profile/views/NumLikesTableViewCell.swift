//
//  NumLikesTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/16/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class NumLikesTableViewCell: UITableViewCell {

    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var dividerHeight: NSLayoutConstraint!
    
    var name = "Jennifer Aniston"
    var and = " and "
    var others = "345 others"
    var likeThis = "like this."
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        dividerHeight.constant = 0.5
        
        setUpLabels(name, and: and, others: others, likeThis: likeThis)
    }
    
    func setUpLabels(name: String, and: String, others: String, likeThis: String) {
        
        let numLikesString = NSMutableAttributedString()
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 14.5) {
            let thickString = NSAttributedString(string: name, attributes: [NSFontAttributeName: mediumFont])
            numLikesString.appendAttributedString(thickString)
        }
        
        if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 14.5) {
            let thinString = NSAttributedString(string: "\(and)", attributes: [NSFontAttributeName: lightFont])
            numLikesString.appendAttributedString(thinString)
        }
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 14.5) {
            let thickString = NSAttributedString(string: others, attributes: [NSFontAttributeName: mediumFont])
            numLikesString.appendAttributedString(thickString)
        }
        
        if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 14.5) {
            let thinString = NSAttributedString(string: " \(likeThis)", attributes: [NSFontAttributeName: lightFont])
            numLikesString.appendAttributedString(thinString)
        }
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        numLikesString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, numLikesString.length))
        likesLabel.attributedText = numLikesString
        
        likesLabel.frame = CGRectIntegral(likesLabel.frame)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
