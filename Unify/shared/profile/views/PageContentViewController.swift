//
//  PageContentViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var pageIndex: Int!
    var labelText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.label.sizeToFit()
        self.label.text = self.labelText
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
