//
//  NumLikesTableViewCell.swift
//  Unify
//
//  Created by Annie Cheng on 6/16/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class NumLikesTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolImage: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
