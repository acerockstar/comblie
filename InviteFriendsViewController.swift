//
//  InviteFriendsViewController.swift
//  Unify
//
//  Created by Monu on 8/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class InviteFriendsViewController: UIViewController {

    @IBOutlet weak var Cancel: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        Cancel.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Roman", size: 16)!], forState: .Normal)

    }
    @IBAction func CancelBtnClick(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
