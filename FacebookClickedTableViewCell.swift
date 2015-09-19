//
//  FacebookClickedTableViewCell.swift
//  Unify
//
//  Created by Maxime Defauw on 19/09/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class FacebookClickedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeIcon: UIButton!
    @IBOutlet weak var commentIcon: UIButton!
    @IBOutlet weak var shareIcon: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        likeIcon.tintColor = UIColor.whiteColor()
        commentIcon.tintColor = UIColor.whiteColor()
        shareIcon.tintColor = UIColor.whiteColor()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.contentView.backgroundColor = selected ? UIColor.facebookBlue() : UIColor.clearColor()
        nameLabel.textColor = selected ? UIColor.whiteColor() : UIColor.blackColor()
        postLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.blackColor()
        timeLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.customLightGrayColor()
        likeLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        commentLabel.textColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        likeIcon.tintColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        commentIcon.tintColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        shareIcon.tintColor = selected ?  UIColor.whiteColor() : UIColor.clearColor()
        likeIcon.enabled = selected
        commentIcon.enabled = selected
        shareIcon.enabled = selected
        
    }
    
}
