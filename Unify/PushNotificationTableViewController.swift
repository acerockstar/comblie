//
//  PushNotificationTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/11/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class PushNotificationTableViewController: UITableViewController {

    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonClicked(sender: UIBarButtonItem) {
        
    }
    
    // TODO: Get social networks from user info
    var socialNetworks = ["Twitter": "on", "Instagram": "off", "Tumblr": "on", "Vine": "off"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)

    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

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
        
        if socialNetworks[socialNetwork] == "on" {
            cell.toggleSocialNetworkSwitch.setOn(true, animated: true)
        } else {
            cell.toggleSocialNetworkSwitch.setOn(false, animated: false)
        }
        
        cell.socialNetworkLabel.text = socialNetworkNames[indexPath.row]
        cell.socialNetworkLabel.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleCaption1), size: 0)
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
