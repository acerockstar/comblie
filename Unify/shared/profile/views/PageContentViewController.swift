//
//  PageContentViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var pageIndex: Int!
    var labelText: String!
    var items: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGrayColor()
        self.title = labelText
        println(self.title)
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.registerNib(UINib(nibName: "TwitterTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterTweetCell")
        self.tableView.addSubview(self.refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Refresh Control
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshFeed:", forControlEvents: UIControlEvents.ValueChanged)
        return refreshControl
        }()
    
    func refreshFeed(refreshControl: UIRefreshControl) {
        items.append(1) // TODO: Fetch info from API
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Table View Methods
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return NSBundle.mainBundle().loadNibNamed("\(self.labelText)ProfileView", owner: nil, options: nil)[0] as? UIView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // TODO: Make dynamic
        if self.labelText == "Combined" {
            return CGFloat(100)
        } else if self.labelText == "Tumblr" {
            return CGFloat(130)
        } else {
            return CGFloat(190)
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if items.count == 0 {
            var label = UILabel(frame: CGRectMake(0,0,200, 50))
            label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "You have no feed"
            label.sizeToFit()
            self.tableView.backgroundView = label
        } else {
            self.tableView.backgroundView = nil
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("twitterTweetCell") as! TwitterTweetTableViewCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(55)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
    }

}
