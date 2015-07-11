//
//  SocialNetworksTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SocialNetworksTableViewController: UITableViewController {
    
    // TODO: Get social networks from user info
    var connectedSocialNetworks = ["Twitter": "on", "Instagram": "off", "Tumblr": "on", "Vine": "off"]
    var unconnectedSocialNetworks = ["Facebook", "GooglePlus", "Linkedin", "Pinterest"]

    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    @IBAction func saveButtonClicked(sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return connectedSocialNetworks.count
        }
        
        return unconnectedSocialNetworks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let connectedCell = tableView.dequeueReusableCellWithIdentifier("ConnectedSocialNetworkTableViewCell", forIndexPath: indexPath) as! ConnectedSocialNetworkTableViewCell
            
            let socialNetworkNames = connectedSocialNetworks.keys.array
            let socialNetwork = socialNetworkNames[indexPath.row]
            
            if connectedSocialNetworks[socialNetwork] == "on" {
                connectedCell.toggleSocialNetworkSwitch.setOn(true, animated: true)
                connectedCell.connectedLabel.text = "Connected"
            } else {
                connectedCell.toggleSocialNetworkSwitch.setOn(false, animated: false)
                connectedCell.connectedLabel.text = "Unconnected"
            }
            
            connectedCell.socialNetworkLabel.text = socialNetworkNames[indexPath.row]
            connectedCell.toggleSocialNetworkSwitch.addTarget(self, action: "toggleSocialNetwork:", forControlEvents: .ValueChanged)
            connectedCell.toggleSocialNetworkSwitch.tag = indexPath.row
            
            return connectedCell
        } else {
            let unconnectedCell = tableView.dequeueReusableCellWithIdentifier("UnconnectedSocialNetworkTableViewCell", forIndexPath: indexPath) as! UnconnectedSocialNetworkTableViewCell
            
            unconnectedCell.socialNetworkLabel.text = unconnectedSocialNetworks[indexPath.row]
            unconnectedCell.connectButton.addTarget(self, action: "connectToSocialNetwork:", forControlEvents: .TouchUpInside)
            unconnectedCell.connectButton.tag = indexPath.row
            
            return unconnectedCell
        }
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

    func connectToSocialNetwork(sender: UIButton) {
        let cell = sender.superview!.superview as! UnconnectedSocialNetworkTableViewCell
        let tableView = cell.superview!.superview as! UITableView
        let indexPath = tableView.indexPathForCell(cell)
        
        // TODO: Let user login to social media account and store that account
        
        connectedSocialNetworks[unconnectedSocialNetworks[sender.tag]] = "on"
        unconnectedSocialNetworks.removeAtIndex(sender.tag)
        tableView.reloadData()
    }
    
    func toggleSocialNetwork(sender: UISwitch) {
        let cell = sender.superview!.superview as! ConnectedSocialNetworkTableViewCell
        let tableView = cell.superview!.superview as! UITableView
        let indexPath = tableView.indexPathForCell(cell)
        
        let socialNetworkNames = connectedSocialNetworks.keys.array
        
        if cell.toggleSocialNetworkSwitch.on {
            cell.connectedLabel.text = "Connected"
            connectedSocialNetworks[socialNetworkNames[indexPath!.row]] = "on"
        } else {
            cell.connectedLabel.text = "Unconnected"
            connectedSocialNetworks[socialNetworkNames[indexPath!.row]] = "off"
        }
    }
}
