//
//  PrivacyViewController.swift
//  Unify
//
//  Created by Monu on 8/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {

    @IBOutlet weak var CancelButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
   CancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Roman", size: 16)!], forState: .Normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelBtnClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

   }
