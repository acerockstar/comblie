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
    var Imagedata : NSData?
    var UserNameValue : String?
    var UserBioValue : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom Refresh.
        self.refreshControl = UIRefreshControl()
        customRefresh = CustomRefreshControl(refreshControl: refreshControl!, tableView: self.tableView)
        refreshControl?.addTarget(self, action: "refreshProfiles", forControlEvents: .ValueChanged)
        refreshProfiles()
        
        self.tableView.estimatedRowHeight = 64
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.registerNib(UINib(nibName: "TwitterTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterTweetCell")
        self.tableView.registerNib(UINib(nibName: "CombinedProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "CombinedProfileTableViewCell")
        self.tableView.registerNib(UINib(nibName: "InstagramProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "InstagramProfileTableViewCell")
        self.tableView.registerNib(UINib(nibName: "TumblrProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "TumblrProfileTableViewCell")
        self.tableView.registerNib(UINib(nibName: "TumblrOwnProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "TumblrOwnProfileTableViewCell")
        self.tableView.registerNib(UINib(nibName: "TwitterProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "TwitterProfileTableViewCell")
        self.tableView.registerNib(UINib(nibName: "VineProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "VineProfileTableViewCell")
        
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    override func viewDidLayoutSubviews() {
        self.shyNavBarManager.scrollView = self.tableView
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        Imagedata =   NSUserDefaults.standardUserDefaults().objectForKey("userimages") as! NSData?
        UserNameValue =   NSUserDefaults.standardUserDefaults().objectForKey("UserName") as! String?
        UserBioValue =   NSUserDefaults.standardUserDefaults().objectForKey("UserBio") as! String?
        self.tableView.reloadData()
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
            var label = UILabel(frame: CGRectMake(0, 0, 200, 50))
            label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "You have no profiles"
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
        
        if indexPath.row == 0 {
            if self.labelText == "Combined" {
                let sectionHeader = tableView.dequeueReusableCellWithIdentifier("CombinedProfileTableViewCell") as! CombinedProfileTableViewCell
               
                sectionHeader.profilePicture.image = UIImage(data: Imagedata!)
                sectionHeader.nameLabel.text = UserNameValue
                sectionHeader.bioLabel.text = UserBioValue
                
                return sectionHeader
            } else if self.labelText == "Instagram" {
                let sectionHeader = tableView.dequeueReusableCellWithIdentifier("InstagramProfileTableViewCell") as! InstagramProfileTableViewCell
                return sectionHeader
            } else if self.labelText == "Tumblr" {
                let sectionHeader = tableView.dequeueReusableCellWithIdentifier("TumblrProfileTableViewCell") as! TumblrProfileTableViewCell
                return sectionHeader
            } else if self.labelText == "Twitter" {
                let sectionHeader = tableView.dequeueReusableCellWithIdentifier("TwitterProfileTableViewCell") as! TwitterProfileTableViewCell
                return sectionHeader
            } else if self.labelText == "Vine" {
                let sectionHeader = tableView.dequeueReusableCellWithIdentifier("VineProfileTableViewCell") as! VineProfileTableViewCell
                return sectionHeader
            }
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("twitterTweetCell") as! TwitterTweetTableViewCell
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
