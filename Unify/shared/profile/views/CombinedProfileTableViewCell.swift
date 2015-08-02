//
//  CombinedProfileTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 8/1/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class CombinedProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicBorder: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    var name = "Cameron Dallas"
    var bio = "This is a bio about me."
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        profilePicture.layer.cornerRadius = profilePicture.bounds.size.width/2
        profilePicture.clipsToBounds = true
        profilePicBorder.layer.cornerRadius = profilePicBorder.bounds.size.width/2
        profilePicBorder.clipsToBounds = true
        contentView.backgroundColor = UIColor.combliePurple()
        
        setUpLabels(name, bio: bio)
    }
    
    func setUpLabels(name: String, bio: String) {
        nameLabel.text = name
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 2
        messageStyle.alignment = .Center
        let bioString = NSMutableAttributedString(string: bio)
        bioString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, bioString.length))
        bioLabel.attributedText = bioString
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        bioLabel.frame = CGRectIntegral(bioLabel.frame)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
