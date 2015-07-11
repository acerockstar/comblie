//
//  SettingsTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameCell: UITableViewCell!
    @IBOutlet weak var bioCell: UITableViewCell!
    @IBOutlet weak var lightThemeCell: UITableViewCell!
    @IBOutlet weak var refreshAutomaticallyCell: UITableViewCell!
    @IBOutlet weak var chatHeadsCell: UITableViewCell!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var lightThemeSwitch: UISwitch!
    @IBOutlet weak var refreshAutomaticallySwitch: UISwitch!
    @IBOutlet weak var chatHeadsSwitch: UISwitch!

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
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }
        
}
