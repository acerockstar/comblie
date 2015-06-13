//
//  PostStatusViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/8/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import QuartzCore

class PostStatusViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tabBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    // Initializers
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.masksToBounds = true
        self.userImage.layer.cornerRadius = 5
        self.userImage.layer.masksToBounds = true
        self.textView.text = "What are you thinking?"
        self.textView.textColor = UIColor.lightGrayColor()
        self.textView.delegate = self
        self.navBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 14)!]
        self.cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 12)!], forState: UIControlState.Normal)
        self.postButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 12)!], forState: UIControlState.Normal)
        self.postButton.enabled = false
    }
    
    func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool) {
        aView.addSubview(self.view)
        if animated {
            self.showAnimate()
        }
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished) {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func closePopup(sender: AnyObject) {
        self.removeAnimate()
    }
    
    @IBAction func postStatus(sender: UIBarButtonItem) {
        // Post status
        self.removeAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITextView Delegate Methods
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let currentText : NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        if count(updatedText) == 0 {
            self.postButton.enabled = false
            textView.text = "What are you thinking?"
            textView.textColor = UIColor.lightGrayColor()
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            return false
        } else if textView.textColor == UIColor.lightGrayColor() && count(text) > 0 {
            self.postButton.enabled = true
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }
    }

}
