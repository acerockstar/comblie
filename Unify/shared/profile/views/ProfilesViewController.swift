//
//  ProfilesViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController, UIPageViewControllerDataSource, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var pageViewController: UIPageViewController!
    var pageLabels: NSArray!
    var messages: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageLabels = ["Profile", "Instagram", "Tumblr", "Twitter", "Vine"]
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        var startVC = self.viewControllerAtIndex(0) as PageContentViewController
        var viewControllers = [startVC]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 100)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.tableView.registerNib(UINib(nibName: "TwitterTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterTweetCell")
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController {
        
        if (self.pageLabels.count == 0 || index >= self.pageLabels.count) {
            return PageContentViewController()
        }
        
        var vc: PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        vc.labelText = self.pageLabels[index] as! String
        vc.pageIndex = index
        
        return vc
    }
    
    // MARK: - Refresh Control
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshMessages:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
        }()
    
    func refreshMessages(refreshControl: UIRefreshControl) {
        messages.append(1) // TODO: Fetch info from API
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - PageViewController Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
        if (index == self.pageLabels.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageLabels.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if messages.count == 0 {
            var label = UILabel(frame: CGRectMake(0,0,200, 50))
            label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "You have no feed"
            label.sizeToFit()
            self.tableView.backgroundView = label
            self.tableView.separatorStyle = .None
        } else {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
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
        selectedCell.contentView.backgroundColor = UIColor.lightGrayColor()
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // Swipe left to delete mechanism
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        messages.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }

}
 