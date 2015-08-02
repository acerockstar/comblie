//
//  TumblrOwnProfileTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 8/2/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TumblrOwnProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var profilePicBorder: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var name = "Jaden Smith"
    var username = "@jadensmith"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .None
        
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2
        profilePicture.layer.masksToBounds = true
        profilePicBorder.layer.cornerRadius = profilePicBorder.frame.size.width/2
        profilePicBorder.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.tumblrBlue()
        
        setUpLabels(name, username: username)
    }
    
    func setUpLabels(name: String, username: String) {
        nameLabel.text = name
        usernameLabel.text = username
        
        nameLabel.frame = CGRectIntegral(nameLabel.frame)
        usernameLabel.frame = CGRectIntegral(usernameLabel.frame)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
