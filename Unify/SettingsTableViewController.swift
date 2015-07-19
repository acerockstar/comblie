//
//  SettingsTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate,UIAlertViewDelegate,WebServiceDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    
    // Profile Images
    @IBOutlet weak var nameCellImageView: UIView!
    @IBOutlet weak var nameCellImage: UIImageView!
    @IBOutlet weak var bioCellImageView: UIView!
    @IBOutlet weak var bioCellImage: UIImageView!
    
    // Cells
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var bioCell: UITableViewCell!
    @IBOutlet weak var lightThemeCell: UITableViewCell!
    @IBOutlet weak var refreshAutomaticallyCell: UITableViewCell!
    @IBOutlet weak var chatHeadsCell: UITableViewCell!
    @IBOutlet weak var LogoutCell: UITableViewCell!
    
    // Cell Labels
    @IBOutlet weak var socialNetworkLabel: UILabel!
    @IBOutlet weak var lightThemeLabel: UILabel!
    @IBOutlet weak var refreshAutomaticallyLabel: UILabel!
    @IBOutlet weak var chatHeadsLabel: UILabel!
    @IBOutlet weak var pushNotificationsLabel: UILabel!
    @IBOutlet weak var reportProblemLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var inviteFriendsLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!

    // Cell Arrows
    @IBOutlet weak var socialNetworkCellArrow: UIImageView!
    @IBOutlet weak var pushNotificationCellArrow: UIImageView!
    @IBOutlet weak var reportProblemCellArrow: UIImageView!
    @IBOutlet weak var feedbackCellArrow: UIImageView!
    @IBOutlet weak var blogCellArrow: UIImageView!
    @IBOutlet weak var privacyPolicyCellArrow: UIImageView!
    @IBOutlet weak var inviteFriendsArrow: UIImageView!
    @IBOutlet weak var LogoutCellArrow: UIImageView!

    var Loader: ViewControllerUtils = ViewControllerUtils()
    var api: WebService = WebService()
    var postStatusViewController: PostStatusViewController!
    
    @IBAction func postStatusButtonClicked(sender: UIBarButtonItem) {
        self.postStatusViewController = PostStatusViewController(nibName: "PostStatusView", bundle: nil)
        self.postStatusViewController.showInView(self.view.window, withImage: nil, withMessage: nil, animated: true)
    }
    @IBAction func toggleLightThemeSwitch(sender: UISwitch) {
        println("toggle light theme")
    }
    @IBAction func toggleRefreshAutomaticallySwitch(sender: UISwitch) {
        println("toggle refresh automatically")
    }
    
    @IBAction func toggleChatHeadsSwitch(sender: UISwitch) {
        println("toggle chat heads")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        bioTextField.delegate = self
        
        nameCellImage.tintColor = UIColor.combliePurple()
        nameCellImageView.backgroundColor = UIColor.whiteColor()
        nameCellImageView.layer.borderColor = UIColor.combliePurple().CGColor
        nameCellImageView.layer.borderWidth = 1.25
        nameCellImageView.layer.cornerRadius = nameCellImageView.frame.size.width * (0.4)
        
        bioCellImage.tintColor = UIColor.combliePurple()
        bioCellImageView.backgroundColor = UIColor.whiteColor()
        bioCellImageView.layer.borderColor = UIColor.combliePurple().CGColor
        bioCellImageView.layer.borderWidth = 1.25
        bioCellImageView.layer.cornerRadius = bioCellImageView.frame.size.width * (0.4)

        let cells = [nameCell, bioCell, lightThemeCell, refreshAutomaticallyCell, chatHeadsCell]
        
        for cell in cells {
            cell.selectionStyle = .None
        }
        
        let cellArrows = [socialNetworkCellArrow, pushNotificationCellArrow, reportProblemCellArrow,
            feedbackCellArrow, blogCellArrow, privacyPolicyCellArrow, inviteFriendsArrow, LogoutCellArrow]
        
        for arrow in cellArrows {
            arrow.tintColor = UIColor.combliePurple()
        }
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.tableView.backgroundView = UIView(frame: self.tableView.bounds)
        self.tableView.backgroundView!.addGestureRecognizer(tap)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "preferredContentSizeChanged:",
            name: UIContentSizeCategoryDidChangeNotification,
            object: nil)
    }
    
    func preferredContentSizeChanged(notification: NSNotification) {
        let cellLabels = [socialNetworkLabel, lightThemeLabel, refreshAutomaticallyLabel, chatHeadsLabel, pushNotificationsLabel, reportProblemLabel, feedbackLabel, blogLabel, privacyPolicyLabel, inviteFriendsLabel, logoutLabel]
        
        for label in cellLabels {
            label.font = UIFont(descriptor: UIFontDescriptor.preferredDescriptor(UIFontTextStyleCaption1), size: 0)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    // MARK: - Keyboard Functionality

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    func dismissKeyboard() {
        if nameTextField.isFirstResponder() {
            nameTextField.resignFirstResponder()
        } else if bioTextField.isFirstResponder() {
            bioTextField.resignFirstResponder()
        }
    }

    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat(40.0)
        }

        return CGFloat(25.0)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

    @IBAction func LogoutClick(sender: AnyObject) {
        var alert = UIAlertController(title: "Confirmation!", message: "Are you sure you want log out?", preferredStyle: UIAlertControllerStyle.Alert)

        alert.addAction(UIAlertAction(title: "Yes", style:UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!) -> Void in
            if Reachability.isConnectedToNetwork() == true{
                self.Loader.showActivityIndicator(self.view)
                self.vineLogout()
            }
            else{
                 self.alertTitle("No Internet Connection", message: "Make sure your device is connected to the Internet.", btnTitle: "OK")
            }

        }))
        alert.addAction(UIAlertAction(title: "No", style:UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!) -> Void in

        }))

        self.presentViewController(alert, animated: true, completion: nil)
    }

    func vineLogout(){
        api.delegate=self
        api.logoutVine("")
    }
    
    func TwitterLogOut(){
        api.delegate=self
        api.logoutTwitter("")
    }
    
    func TumblrLogOut(){
        api.delegate=self
        api.logoutTumblr("")
    }
    
    func InstagramLogOut(){
        api.delegate=self
        api.logoutInstagram("")
    }
    
    func returnFail() {

    }
    
    func returnSuccess(paraDict: NSDictionary) {
        Loader.hideActivityIndicator(self.view)
        println("paraDict===\(paraDict)")
        var Status : AnyObject = paraDict.valueForKey("success") as! Bool
        if Status as! NSObject == true{
            alertTitle("Report", message: "Logout successfully.", btnTitle: "OK")
        }
        else if Status as! NSObject == false{
            alertTitle("Report", message: "Logout successfully.", btnTitle: "OK")
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func alertTitle(title :String, message:String,btnTitle:String){
        var alert = UIAlertView(title: title, message:message, delegate: nil, cancelButtonTitle: btnTitle)
        alert.show()
        
    }

}
