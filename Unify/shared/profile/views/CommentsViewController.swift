//
//  CommentsViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/16/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var comments: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data
    var commentLiked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentField.delegate = self
        
        self.tableView.estimatedRowHeight = 64.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.estimatedSectionHeaderHeight = 44.0
        self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        self.tableView.registerNib(UINib(nibName: "NumLikesTableViewCell", bundle: nil), forCellReuseIdentifier: "numLikesCell")
        self.tableView.registerNib(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "commentCell")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardShown:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardHidden:"), name:UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    func dismissCommentsVC() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func toggleLike(sender: UIButton) {
        if commentLiked {
            sender.setImage(UIImage(named: "Not-Liked-Icon"), forState: .Normal)
            commentLiked = false
        } else {
            sender.setImage(UIImage(named: "Liked-Icon"), forState: .Normal)
            commentLiked = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarHidden = true
        self.commentField.frame = CGRectMake(0, 0, self.view.frame.size.width - 55, self.commentField.frame.size.height)
    }

    // MARK: - Table View Methods
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("numLikesCell") as! NumLikesTableViewCell
        cell.backButton.addTarget(self, action: "dismissCommentsVC", forControlEvents: .TouchUpInside)
        cell.likeButton.addTarget(self, action: "toggleLike:", forControlEvents: .TouchUpInside)
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell") as! CommentsTableViewCell

        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    // MARK: - Keyboard Functionality
    
    func keyboardShown(sender: NSNotification) {
        var keyboardFrame: CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.bottomConstraint.constant = keyboardFrame.size.height
        self.view.layoutIfNeeded()
    }
    
    func keyboardHidden(sender: NSNotification) {
        var keyboardFrame: CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}
