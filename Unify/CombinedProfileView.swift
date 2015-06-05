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
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        profilePicture.layer.cornerRadius = profilePicture.bounds.size.width/2
        profilePicture.clipsToBounds = true
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        NSBundle.mainBundle().loadNibNamed("CombinedProfileView", owner: self, options: nil)
        self.addSubview(view)
    }
}
