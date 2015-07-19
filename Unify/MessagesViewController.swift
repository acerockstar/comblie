//
//  MessagesViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/2/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var customRefresh: CustomRefreshControl!
    
    @IBAction func unwindToMessagesVC(sender: UIStoryboardSegue) {
        
    }
    
    var messages: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Refresh
        self.refreshControl = UIRefreshControl()
        customRefresh = CustomRefreshControl(refreshControl: refreshControl!, tableView: self.tableView)
        refreshControl?.addTarget(self, action: "refreshMessages", forControlEvents: .ValueChanged)
        refreshMessages()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(UINib(nibName: "MessagesTableViewCell", bundle: nil), forCellReuseIdentifier: "messageCell")
        self.tableView.addSubview(self.refreshControl)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom Refresh
    
    func refreshMessages() {
        messages.append(1)
        self.tableView.reloadData()
        var delayInSeconds = 3.0
        var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            self.refreshControl!.endRefreshing()
        }
    }
    
    // MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if messages.count == 0 {
            var label = UILabel(frame: CGRectMake(0,0,200, 50))
            label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "You have no messages"
            label.sizeToFit()
            self.tableView.backgroundView = label
            self.tableView.separatorColor = UIColor.clearColor()
        } else {
            self.tableView.backgroundView = nil
            self.tableView.separatorColor = nil
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! MessagesTableViewCell
        
        cell.userName.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleBody), size: 0)
        
        //cell.userName.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(65)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell = tableView.cellForRowAtIndexPath(indexPath)! as! MessagesTableViewCell
        selectedCell.contentView.backgroundColor = UIColor.lightGrayColor()
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        let newVC = storyboard.instantiateViewControllerWithIdentifier("messaging") as! OldMessageViewController
        newVC.name = selectedCell.userName.text!
        self.navigationController?.pushViewController(newVC, animated: true)
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        customRefresh.scrollViewDidScroll(scrollView)
    }
    
    // Swipe left to delete mechanism
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        messages.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }

}
