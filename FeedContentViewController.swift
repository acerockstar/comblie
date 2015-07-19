//
//  FeedContentViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/13/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class FeedContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var refreshControl: UIRefreshControl!
    var customRefresh: CustomRefreshControl!
    var postStatusViewController : PostStatusViewController!
    var pageIndex: Int = 0
    var labelText: String!
    var items: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data
    var cellTapped:Bool = true
    var currentRow = -1
    
    @IBOutlet var tableView: UITableView!
    
    // Initializers
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Refresh
        self.refreshControl = UIRefreshControl()
        customRefresh = CustomRefreshControl(refreshControl: refreshControl!, tableView: self.tableView)
        refreshControl?.addTarget(self, action: "refreshFeed", forControlEvents: .ValueChanged)
        refreshFeed()
        
        self.tableView.estimatedRowHeight = 64
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.tableFooterView = UIView()
        
        self.tableView.registerNib(UINib(nibName: "TwitterTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterTweetCell")
        self.tableView.registerNib(UINib(nibName: "TwitterActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterActivityCell")
        self.tableView.registerNib(UINib(nibName: "PhotoVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "photoVideoCell")
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.tableView.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredContentSizeChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        self.shyNavBarManager.scrollView = self.tableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom Refresh
    
    func refreshFeed() {
        self.tableView.reloadData()
        var delayInSeconds = 3.0
        var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            self.refreshControl!.endRefreshing()
        }
    }
    
    // MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if items.count == 0 {
            var label = UILabel(frame: CGRectMake(0,0,200, 50))
            label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "You have no feed"
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
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 3 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("twitterTweetCell") as! TwitterTweetTableViewCell
            
            cell.nameLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleSubheadline), size: 0)
            cell.usernameLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleFootnote), size: 0)
            cell.tweetLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleBody), size: 0)
            cell.timeLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleFootnote), size: 0)
            
            cell.tweetLabel.text = " complex situation which can't fit here to explain, but in a brief, after the cell is created, some frames of the cell's subviews are changed after the views have been created, so I need to fix these frames after the cell has appeared."
            
            if pageIndex == 0 {
                cell.socialMediaIcon.hidden = false
                cell.socialMediaIconBorder.hidden = false
            } else {
                cell.socialMediaIcon.hidden = true
                cell.socialMediaIconBorder.hidden = true
            }
            
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            
            return cell
        } else if indexPath.row % 3 == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("twitterActivityCell") as! TwitterActivityTableViewCell
            
            cell.activityLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleBody), size: 0)
            cell.tweetLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleBody), size: 0)
            cell.timeLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleFootnote), size: 0)
            
            if pageIndex == 0 {
                cell.socialMediaIcon.hidden = false
                cell.socialMediaIconBorder.hidden = false
            } else {
                cell.socialMediaIcon.hidden = true
                cell.socialMediaIconBorder.hidden = true
            }
            
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("photoVideoCell") as! PhotoVideoTableViewCell
            cell.backgroundView = UIImageView(image: UIImage(named: "Photo"))
            
            cell.descriptionLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleBody), size: 0)
            cell.activityLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleFootnote), size: 0)
            cell.timeLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleFootnote), size: 0)
            
            if pageIndex == 0 {
                cell.socialMediaIcon.hidden = false
                cell.socialMediaIconBorder.hidden = false
            } else {
                cell.socialMediaIcon.hidden = true
                cell.socialMediaIconBorder.hidden = true
            }
            
            cell.setNeedsUpdateConstraints()
            cell.updateConstraintsIfNeeded()
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 3 == 0 {
            if indexPath.row == currentRow {
                return CGFloat(84)
            } else {
                return CGFloat(64)
            }
        } else if indexPath.row % 3 == 1 {
            return CGFloat(64)
        } else {
            return CGFloat(300)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        currentRow = indexPath.row
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        // TODO: enable on images/videos only (replace manual placeholder)
        if indexPath.row % 3 == 2 {
            let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
            let newVC = storyboard.instantiateViewControllerWithIdentifier("enlargedItemVC") as! EnlargedItemViewController
            self.presentViewController(newVC, animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        customRefresh.scrollViewDidScroll(scrollView)
    }
    
    // TODO: Make swipe right to delete only on combined newsfeed
//    // Swipe left to delete mechanism
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//
//        items.removeAtIndex(indexPath.row)
//        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
//    }
    
    func swipeRightToDelete() {
        
    }
}
