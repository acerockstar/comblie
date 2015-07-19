//
//  ProfileContentViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ProfileContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var customRefresh: CustomRefreshControl!
    var pageIndex: Int = 0
    var labelText: String!
    var items: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data
    var titleView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Refresh
        self.refreshControl = UIRefreshControl()
        customRefresh = CustomRefreshControl(refreshControl: refreshControl!, tableView: self.tableView)
        refreshControl?.addTarget(self, action: "refreshProfiles", forControlEvents: .ValueChanged)
        refreshProfiles()
        
        self.tableView.estimatedRowHeight = 64
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.registerNib(UINib(nibName: "TwitterTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterTweetCell")
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
        let sectionHeader = NSBundle.mainBundle().loadNibNamed("\(self.labelText)ProfileView", owner: nil, options: nil)[0] as? UIView
        self.tableView.tableHeaderView = sectionHeader
        self.shyNavBarManager.scrollView = self.tableView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom Refresh
    
    func refreshProfiles() {
        items.append(1)
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
        let cell = tableView.dequeueReusableCellWithIdentifier("twitterTweetCell") as! TwitterTweetTableViewCell
        
        cell.nameLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleSubheadline), size: 0)
        cell.usernameLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleFootnote), size: 0)
        cell.tweetLabel.text = "This is going to be a very long text to test the dynamic table view cell.This is going to be a very long text to test the dynamic table view cell."
        cell.tweetLabel.sizeToFit()
        cell.tweetLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleBody), size: 0)
        cell.timeLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleFootnote), size: 0)
        
        cell.setNeedsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        customRefresh.scrollViewDidScroll(scrollView)
    }

}
