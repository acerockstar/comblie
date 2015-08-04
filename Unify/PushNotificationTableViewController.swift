//
//  PushNotificationTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/11/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PushNotificationTableViewController: UITableViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonClicked(sender: UIBarButtonItem) {
        
    }
    
    // TODO: Get social networks from user info
    var socialNetworks = ["Twitter": "on", "Instagram": "off", "Tumblr": "on", "Vine": "off"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 32
        tableView.backgroundColor = UIColor.sectionHeaderGrey()
        
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Roman", size: 16)!], forState: .Normal)
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16)!], forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16.5)!]
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(18.0)
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return socialNetworks.count
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PushNotificationTableViewCell", forIndexPath: indexPath) as! PushNotificationTableViewCell

        let socialNetworkNames = socialNetworks.keys.array
        let socialNetwork = socialNetworkNames[indexPath.row]
        var ThemeChanges =   NSUserDefaults.standardUserDefaults().objectForKey("ThemeChange") as! String?
        if ThemeChanges == "Yes"{
            cell.toggleSocialNetworkSwitch.tintColor=UIColor.ThemeColor()
        }
        else if ThemeChanges == "No"{
            cell.toggleSocialNetworkSwitch.tintColor=UIColor.purpleColor()
        }
        if socialNetworks[socialNetwork] == "on" {
            cell.toggleSocialNetworkSwitch.setOn(true, animated: true)
        } else {
            cell.toggleSocialNetworkSwitch.setOn(false, animated: false)
        }
        
        cell.socialNetworkLabel.text = socialNetworkNames[indexPath.row]
        cell.toggleSocialNetworkSwitch.addTarget(self, action: "toggleSocialNetwork:", forControlEvents: .ValueChanged)
        cell.toggleSocialNetworkSwitch.tag = indexPath.row

        return cell
    }
    
    func toggleSocialNetwork(sender: UISwitch) {
        let cell = sender.superview!.superview as! PushNotificationTableViewCell
        let tableView = cell.superview!.superview as! UITableView
        let indexPath = tableView.indexPathForCell(cell)
        
        let socialNetworkNames = socialNetworks.keys.array
        
        if cell.toggleSocialNetworkSwitch.on {
            socialNetworks[socialNetworkNames[indexPath!.row]] = "on"
        } else {
            socialNetworks[socialNetworkNames[indexPath!.row]] = "off"
        }
        
        println(socialNetworks)
    }


}
