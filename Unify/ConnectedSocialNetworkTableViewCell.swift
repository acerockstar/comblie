//
//  ConnectedSocialNetworkTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ConnectedSocialNetworkTableViewCell: UITableViewCell {

    @IBOutlet weak var socialNetworkLabel: UILabel!
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var toggleSocialNetworkSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .None
        toggleSocialNetworkSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
    }

}
