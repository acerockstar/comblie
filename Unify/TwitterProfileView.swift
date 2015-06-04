//
//  TwitterProfileView.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TwitterProfileView: UIView {

    @IBOutlet var customView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var numFollowersLabel: UILabel!
    @IBOutlet weak var numFollowingLabel: UILabel!
    @IBOutlet weak var numTweetsLabel: UILabel!
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        profilePicture.layer.cornerRadius = profilePicture.bounds.size.width/2
//        profilePicture.clipsToBounds = true
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        NSBundle.mainBundle().loadNibNamed("TwitterProfileView", owner: self, options: nil)
//        self.addSubview(self.customView)
//    }

}
