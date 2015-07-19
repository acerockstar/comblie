//
//  ActivityContentViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/13/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ActivityContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    var customRefresh: CustomRefreshControl!
    var pageIndex: Int = 0
    var labelText: String!
    var activities: [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15] // TODO: Replace dummy data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Refresh
        self.refreshControl = UIRefreshControl()
        customRefresh = CustomRefreshControl(refreshControl: refreshControl!, tableView: self.tableView)
        refreshControl?.addTarget(self, action: "refreshActivities", forControlEvents: .ValueChanged)
        refreshActivities()
        
        self.tableView.estimatedRowHeight = 64.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "activityCell")
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
    
    func refreshActivities() {
        activities.append(1)
        self.tableView.reloadData()
        var delayInSeconds = 3.0
        var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)));
        dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
            self.refreshControl!.endRefreshing()
        }
    }
    
    // MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if activities.count == 0 {
            var label = UILabel(frame: CGRectMake(0,0,200, 50))
            label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "You have no activities"
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
        return activities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("activityCell") as! ActivityTableViewCell
        
        cell.descriptionLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleBody), size: 0)
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
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        selectedCell.backgroundColor = UIColor.clearColor()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        customRefresh.scrollViewDidScroll(scrollView)
    }

}
