//
//  CombinedProfileView.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class CombinedProfileView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var coverPhoto: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func didMoveToSuperview() {
        profilePicture.layer.cornerRadius = profilePicture.bounds.size.width/2
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderWidth = 3
        profilePicture.layer.borderColor = UIColor.pictureBorderColor().CGColor
        coverPhoto.alpha = 0.5
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CombinedProfileView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
}
