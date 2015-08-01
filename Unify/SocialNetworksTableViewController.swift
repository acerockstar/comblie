//
//  SocialNetworksTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SocialNetworksTableViewController: UITableViewController,UIAlertViewDelegate {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
     var Loader: ViewControllerUtils = ViewControllerUtils()
//    var connectedSocialNetworks = [:]
    // TODO: Get social networks from user info
    var connectedSocialNetworks = ["Twitter": "off", "Instagram": "off", "Tumblr": "off", "Vine": "off"]
    var unconnectedSocialNetworks = ["Facebook", "GooglePlus", "Linkedin", "Pinterest"]

    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonClicked(sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let CheckVineLoginStatus = NSUserDefaults.standardUserDefaults().stringForKey("VineLogin")
        let CheckInstagramLoginStatus = NSUserDefaults.standardUserDefaults().stringForKey("InstagramLogin")
        let CheckTwitterLoginStatus = NSUserDefaults.standardUserDefaults().stringForKey("TwitterLogin")
        let CheckTubmlroginStatus = NSUserDefaults.standardUserDefaults().stringForKey("TubmlrLogin")
        if CheckInstagramLoginStatus == "Yes"{
            connectedSocialNetworks["Instagram"]="on"
        }
        if CheckTubmlroginStatus == "Yes"{
             connectedSocialNetworks["Tumblr"]="on"
        }
        if CheckTwitterLoginStatus == "Yes"{
             connectedSocialNetworks["Twitter"]="on"
        }
        if CheckVineLoginStatus == "Yes"{
             connectedSocialNetworks["Vine"]="on"
        }
        
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
        
        if section == 0 {
            return CGFloat(18.0)
        } else {
            return CGFloat(46.0)
        }
    }

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
                connectedCell.socialNetworkLabel.textColor = UIColor.blackColor()
                connectedCell.connectedLabel.textColor = UIColor.blackColor()
            } else {
                connectedCell.toggleSocialNetworkSwitch.setOn(false, animated: false)
                connectedCell.connectedLabel.text = "Unconnected"
                connectedCell.socialNetworkLabel.textColor = UIColor.lightGrayColor()
                connectedCell.connectedLabel.textColor = UIColor.lightGrayColor()
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
        let CheckVineLoginStatus = NSUserDefaults.standardUserDefaults().stringForKey("VineLogin")
        let CheckInstagramLoginStatus = NSUserDefaults.standardUserDefaults().stringForKey("InstagramLogin")
        let CheckTwitterLoginStatus = NSUserDefaults.standardUserDefaults().stringForKey("TwitterLogin")
        let CheckTubmlroginStatus = NSUserDefaults.standardUserDefaults().stringForKey("TubmlrLogin")
        
        if CheckVineLoginStatus == nil {
            alertTitle("Login info!", message: "You are not currently login from vine\nAre you want login from  vine?", CancelbtnTitle: "No",OtherBtnTitle:"Yes")
            sender.on = false
            tableView.reloadData()
        }
        else if CheckInstagramLoginStatus == nil {
            alertTitle("Login info!", message: "You are not currently login from Instagram\nAre you want login from Instagram?", CancelbtnTitle: "No",OtherBtnTitle:"Yes")
            sender.on = false
            tableView.reloadData()
        }
        else if CheckTwitterLoginStatus == nil {
            alertTitle("Login info!", message: "You are not currently login from Twitter\nAre you want login from  Twitter?", CancelbtnTitle: "No",OtherBtnTitle:"Yes")
            sender.on = false
            tableView.reloadData()
        }
        else if CheckTubmlroginStatus == nil {
            alertTitle("Login info!", message: "You are not currently login from Tubmlr\nAre you want login from  Tubmlr?", CancelbtnTitle: "No",OtherBtnTitle:"Yes")
            sender.on = false
            tableView.reloadData()
        }
        else{
        let socialNetworkNames = connectedSocialNetworks.keys.array
        
        if cell.toggleSocialNetworkSwitch.on {
            cell.connectedLabel.text = "Connected"
            cell.socialNetworkLabel.textColor = UIColor.blackColor()
            cell.connectedLabel.textColor = UIColor.blackColor()
            connectedSocialNetworks[socialNetworkNames[indexPath!.row]] = "on"
        } else {
            cell.connectedLabel.text = "Unconnected"
            cell.socialNetworkLabel.textColor = UIColor.lightGrayColor()
            cell.connectedLabel.textColor = UIColor.lightGrayColor()
            connectedSocialNetworks[socialNetworkNames[indexPath!.row]] = "off"
        }
        }
    }
    func alertTitle(title :String, message:String,CancelbtnTitle:String,OtherBtnTitle:String) {
        var alert = UIAlertView(title: title, message: message, delegate: UIAlertViewDelegate?(), cancelButtonTitle: CancelbtnTitle, otherButtonTitles: OtherBtnTitle)
        alert.tag=11
        alert.show()
    }
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch (buttonIndex) {
  case 0:
    break;
        case 1:
            Loader.hideActivityIndicator(self.view)
             UIApplication.sharedApplication().delegate?.application!(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil)
            break;

  default:
    break;
}
    }
    

}
