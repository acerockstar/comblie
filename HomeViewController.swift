//
//  HomeViewController.swift
//  Unify
//
//  Created by Shailendra Gupta on 20/07/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import Parse
class HomeViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        
       

        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        signUpButton.layer.cornerRadius = 20
        signUpButton.layer.borderWidth = 1.5
        signUpButton.layer.borderColor = UIColor.comblieDarkPurple().CGColor
        signUpButton.tintColor = UIColor.comblieDarkPurple()
        loginButton.tintColor = UIColor.comblieDarkPurple()
        
        let loginString = NSMutableAttributedString()
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 13) {
            let thinString = NSAttributedString(string: "Returning user? ", attributes: [NSFontAttributeName: romanFont])
            loginString.appendAttributedString(thinString)
        }
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 13) {
            let thickString = NSAttributedString(string: "Log In", attributes: [NSFontAttributeName: mediumFont])
            loginString.appendAttributedString(thickString)
        }
        
        loginButton.setAttributedTitle(loginString, forState: .Normal)
        
    }
    
    @IBAction func signUpButtonClicked(sender: UIButton) {
        signUpButton.backgroundColor = UIColor.comblieDarkPurple()
        signUpButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
    }

}
