//
//  NewsFeedViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/4/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var postStatusViewController : PostStatusViewController!
    var items: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var postStatusButton: UIBarButtonItem!
    @IBAction func postStatusButtonClicked(sender: UIBarButtonItem) {
        self.postStatusViewController = PostStatusViewController(nibName: "PostStatusView", bundle: nil)
        self.postStatusViewController.showInView(self.view.window, withImage: nil, withMessage: nil, animated: true)
    }
    @IBAction func unwindToNewsFeedVC(sender: UIStoryboardSegue) {}

    // Initializers
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
        self.tableView.estimatedRowHeight = 55.0
        self.tableView.separatorColor = UIColor.clearColor()
        self.tableView.registerNib(UINib(nibName: "TwitterTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterTweetCell")
        self.tableView.registerNib(UINib(nibName: "TwitterActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "twitterActivityCell")
        self.tableView.registerNib(UINib(nibName: "PhotoVideoTableViewCell", bundle: nil), forCellReuseIdentifier: "photoVideoCell")
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Refresh Control
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refreshActivities:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
        }()
    
    func refreshActivities(refreshControl: UIRefreshControl) {
        items.append(1) // TODO: Fetch info from API
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Table View Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if items.count == 0 {
            var label = UILabel(frame: CGRectMake(0,0,200, 50))
            label.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
            label.textAlignment = NSTextAlignment.Center
            label.text = "You have no activities"
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
        if indexPath.row % 3 == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("twitterTweetCell") as! TwitterTweetTableViewCell
            return cell
        } else if indexPath.row % 3 == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("twitterActivityCell") as! TwitterActivityTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("photoVideoCell") as! PhotoVideoTableViewCell
            cell.backgroundView = UIImageView(image: UIImage(named: "Photo"))
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // TODO: make cells dynamic
        if indexPath.row % 3 == 2 {
            return CGFloat(300)
        } else {
            return CGFloat(55)
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedCell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        // TODO: enable on images/videos only (replace manual placeholder)
        if indexPath.row % 3 == 2 {
            let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
            let newVC = storyboard.instantiateViewControllerWithIdentifier("enlargedItemVC") as! EnlargedItemViewController
            self.presentViewController(newVC, animated: true, completion: nil)
        }
    }
    
    // Swipe left to delete mechanism
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    // Rounded corners for popup window
    func setRoundedBorder(radius : CGFloat, withBorderWidth borderWidth: CGFloat, withColor color : UIColor, forButton button : UIButton)
    {
        let layer : CALayer = button.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = borderWidth
        layer.borderColor = color.CGColor
    }

}
