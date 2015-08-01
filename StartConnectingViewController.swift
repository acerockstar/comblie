//
//  StartConnectingViewController.swift
//  Unify
//
//  Created by Shailendra Gupta on 09/07/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class StartConnectingViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var vineButton: UIButton!
    @IBOutlet weak var tumblrButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden=true
        
        // Styling
        let loginButtons = [twitterButton, vineButton, tumblrButton, instagramButton]
        
        for button in loginButtons {
            button.layer.cornerRadius = twitterButton.frame.size.height/2
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.comblieDarkPurple().CGColor
            button.tintColor = UIColor.comblieDarkPurple()
            button.titleLabel!.font = UIFont(name: "HelveticaNeueLTStd-Md", size: 18)
        }
        
        welcomeLabel.textColor = UIColor.comblieDarkPurple()
        messageLabel.textColor = UIColor.comblieDarkPurple()
        signUpButton.tintColor = UIColor.comblieDarkPurple()
        
        welcomeLabel.font = UIFont(name: "HelveticaNeueLTStd-Md", size: 18)
        messageLabel.font = UIFont(name: "HelveticaNeueLTStd-Roman", size: 16)
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 3
        let messageString = NSMutableAttributedString(string: "Please connect to your social media accounts below.")
        messageString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, messageString.length))
        messageLabel.attributedText = messageString
        messageLabel.textAlignment = .Center
        
        let signUpString = NSMutableAttributedString()
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 13) {
            let thinString = NSAttributedString(string: "Returning User? ", attributes: [NSFontAttributeName: romanFont])
            signUpString.appendAttributedString(thinString)
        }
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 13) {
            let thickString = NSAttributedString(string: "Log In", attributes: [NSFontAttributeName: mediumFont])
            signUpString.appendAttributedString(thickString)
        }
        
        signUpButton.setAttributedTitle(signUpString, forState: .Normal)
    }
    
    @IBAction func connectToTwitter(sender: UIButton) {
        twitterButton.backgroundColor = UIColor.comblieDarkPurple()
        twitterButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
    }
    
    @IBAction func connectToVine(sender: UIButton) {
        vineButton.backgroundColor = UIColor.comblieDarkPurple()
        vineButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
    }
    
    @IBAction func connectToTumblr(sender: UIButton) {
        tumblrButton.backgroundColor = UIColor.comblieDarkPurple()
        tumblrButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
    }
    
    @IBAction func connectToInstagram(sender: UIButton) {
        instagramButton.backgroundColor = UIColor.comblieDarkPurple()
        instagramButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
    }

}
