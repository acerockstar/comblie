//
//  SettingsTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate,UIAlertViewDelegate,WebServiceDelegate {
    
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var bioCell: UITableViewCell!
    @IBOutlet weak var lightThemeCell: UITableViewCell!
    @IBOutlet weak var refreshAutomaticallyCell: UITableViewCell!
    @IBOutlet weak var chatHeadsCell: UITableViewCell!
    @IBOutlet weak var LogoutCell: UITableViewCell!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var lightThemeSwitch: UISwitch!
    @IBOutlet weak var refreshAutomaticallySwitch: UISwitch!
    @IBOutlet weak var chatHeadsSwitch: UISwitch!



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
        
        lightThemeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        refreshAutomaticallySwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        chatHeadsSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        
        let cells = [nameCell, bioCell, lightThemeCell, refreshAutomaticallyCell, chatHeadsCell]
        
        for cell in cells {
            cell.selectionStyle = .None
        }
        
        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.tableView.backgroundView = UIView(frame: self.tableView.bounds)
        self.tableView.backgroundView!.addGestureRecognizer(tap)
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
        var alert = UIAlertController(title: "Conformation!", message: "Are you sure you want logout?", preferredStyle: UIAlertControllerStyle.Alert)

        alert.addAction(UIAlertAction(title: "Yes", style:UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!) -> Void in
            if Reachability.isConnectedToNetwork() == true{
                self.Loader.showActivityIndicator(self.view)
                self.vineLogout()
            }
            else{
                 self.alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
            }

        }))
        alert.addAction(UIAlertAction(title: "NO", style:UIAlertActionStyle.Default, handler: { (ACTION :UIAlertAction!) -> Void in

        }))

        self.presentViewController(alert, animated: true, completion: nil)
    }

    func vineLogout(){
        api.delegate=self
        api.logoutVine("")

    }
    func TwitterLogOut(){
        api.delegate=self
        api.logoutTumbler("")
    }
    func TumblrLogOut(){
        api.delegate=self
        api.logoutTumbler("")

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
            alertTitle("Report", message: "Your report submitted successfully.", btnTitle: "OK")
        }
        else if Status as! NSObject == false{
            alertTitle("Report", message: "Your report submitted successfully.", btnTitle: "OK")
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    func alertTitle(title :String, message:String,btnTitle:String){
        var alert = UIAlertView(title: title, message:message, delegate: nil, cancelButtonTitle: btnTitle)
        alert.show()
        
    }


}
