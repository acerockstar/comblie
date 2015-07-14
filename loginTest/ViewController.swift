//
//  ViewController.swift
//  loginTest
//
//  Created by Sai Grandhi on 9/12/15.
//  Copyright (c) 2015 Sai Grandhi. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = PFUser()
        user.username = "my name"
        user.password = "my pass"
        user.email = "email@example.com"
        
        // other fields can be set if you want to save more information
        //user["phone"] = "650-555-0000"
        
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
            } else {
                // Examine the error object and inform the user.
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

