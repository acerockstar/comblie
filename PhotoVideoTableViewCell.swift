//
//  PhotoVideoTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PhotoVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var socialMediaIconBorder: UIView!
    @IBOutlet weak var repostImage: UIButton!
    @IBOutlet weak var heartImage: UIButton!
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var socialMediaIcon: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var gradientView: UIView!
    
    var liked = false
    
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
        socialMediaIconBorder.layer.cornerRadius = socialMediaIconBorder.bounds.size.width/2
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        repostImage.setImage(UIImage(named: "ReplyIcon"), forState: .Normal)
        heartImage.setImage(UIImage(named: "FilledHeartIcon"), forState: .Normal)
        socialMediaIcon.image = UIImage(named: "Instagram-Small-Icon")
        
        var gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clearColor(), UIColor.blackColor()]
        gradientView.layer.insertSublayer(gradient, atIndex: 0)
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
