//
//  PhotoVideoTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PhotoVideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repostImage: UIButton!
    @IBOutlet weak var heartImage: UIButton!
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var divider: UIView!
    
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
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        repostImage.setImage(UIImage(named: "ReplyIcon"), forState: .Normal)
        heartImage.setImage(UIImage(named: "FilledHeartIcon"), forState: .Normal)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
