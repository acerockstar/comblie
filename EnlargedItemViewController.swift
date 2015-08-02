//
//  EnlargedItemViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class EnlargedItemViewController: UIViewController {

    @IBOutlet weak var dividerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var enlargedImage: UIImageView!
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeSymbol: UIButton!
    @IBOutlet weak var commentSymbol: UIButton!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var numCommentsLabel: UILabel!
    
    var userName = "Heidi Klum"
    var userAction = "posted a photo on"
    var socialMediaName = "Instagram"
    var caption = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    var numLikes = "19.1k"
    var numComments = "179"
    
    @IBAction func likeButtonClicked(sender: UIButton) {
        // Increment/decrement likes count
        println("liked button clicked")
    }
    
    @IBAction func commentButtonClicked(sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        let newVC = storyboard.instantiateViewControllerWithIdentifier("commentsVC") as! CommentsViewController
        self.presentViewController(newVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dividerHeightConstraint.constant = 0.5
        
        userImage.layer.cornerRadius = userImage.bounds.size.width/2
        userImage.clipsToBounds = true
        userImage.setImage(UIImage(named: "Persona"), forState: .Normal)
        likeSymbol.tintColor = UIColor.whiteColor()
        commentSymbol.tintColor = UIColor.whiteColor()
        
        setUpLabels(userName, userAction: userAction, socialMediaName: socialMediaName, caption: caption, numLikes: numLikes, numComments: numComments)
    }
    
    func setUpLabels(userName: String, userAction: String, socialMediaName: String, caption: String, numLikes: String, numComments: String) {
        
        captionTextView.text = caption
        numLikesLabel.text = numLikes
        numCommentsLabel.text = numComments
        
        // Set up activity label
        let activityString = NSMutableAttributedString()
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 11.5) {
            let thickString = NSAttributedString(string: "\(userName)", attributes: [NSFontAttributeName: romanFont])
            activityString.appendAttributedString(thickString)
        }
        
        if let lightFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 11.5) {
            let thinString = NSAttributedString(string: " \(userAction) ", attributes: [NSFontAttributeName: lightFont])
            activityString.appendAttributedString(thinString)
        }
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 11.5) {
            let thickString = NSAttributedString(string: "\(socialMediaName)", attributes: [NSFontAttributeName: romanFont])
            activityString.appendAttributedString(thickString)
        }
        
        activityLabel.attributedText = activityString
        
        activityLabel.frame = CGRectIntegral(activityLabel.frame)
        captionTextView.frame = CGRectIntegral(captionTextView.frame)
        numLikesLabel.frame = CGRectIntegral(numLikesLabel.frame)
        numCommentsLabel.frame = CGRectIntegral(numCommentsLabel.frame)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().statusBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
