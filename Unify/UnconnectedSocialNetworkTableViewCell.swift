//
//  UnconnectedSocialNetworkTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class UnconnectedSocialNetworkTableViewCell: UITableViewCell {

    @IBOutlet weak var socialNetworkLabel: UILabel!
    @IBOutlet weak var connectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
    }

}
