//
//  PhotoVideoTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PhotoVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dividerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var repostImage: UIButton!
    @IBOutlet weak var heartImage: UIButton!
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var gradientView: UIView!
    
    var liked = false
    var userName = "Heidi Klum"
    var userAction = "posted a photo on"
    var socialMediaName = "Twitter"
    var descriptionText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco"
    var time = "1m"
    
    @IBAction func repostImageClicked(sender: UIButton) {
        println("repostImage clicked")
    }
    @IBAction func heartImageClicked(sender: UIButton) {
        println("heartImage clicked")
    }
    @IBAction func userImageClicked(sender: UIButton) {
        println("userImage clicked")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
        dividerHeightConstraint.constant = 0.5
        descriptionTextView.contentInset = UIEdgeInsetsMake(0, -5, 0, 0)
        descriptionTextView.textAlignment = .Left
        
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        
        repostImage.hidden = true
        heartImage.hidden = true
        
        setUpLabels(userName, userAction: userAction, socialMediaName: socialMediaName, description: descriptionText, time: time)
    }
    
    func setUpLabels(userName: String, userAction: String, socialMediaName: String, description: String, time: String) {
        
        timeLabel.text = time
        descriptionTextView.text = description
        
        // Set up activity label
        let activityString = NSMutableAttributedString()
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 11.5) {
            let thickString = NSAttributedString(string: "\(userName)", attributes: [NSFontAttributeName: romanFont])
            activityString.appendAttributedString(thickString)
        }
        
        if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 11.5) {
            let thinString = NSAttributedString(string: " \(userAction) ", attributes: [NSFontAttributeName: lightFont])
            activityString.appendAttributedString(thinString)
        }
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 11.5) {
            let thickString = NSAttributedString(string: "\(socialMediaName)", attributes: [NSFontAttributeName: romanFont])
            activityString.appendAttributedString(thickString)
        }
        
        activityLabel.attributedText = activityString
        
        activityLabel.frame = CGRectIntegral(activityLabel.frame)
        descriptionTextView.frame = CGRectIntegral(descriptionTextView.frame)
        timeLabel.frame = CGRectIntegral(timeLabel.frame)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
