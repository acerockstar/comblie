//
//  SettingsTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {

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
    }
    @IBAction func toggleRefreshAutomaticallySwitch(sender: UISwitch) {
    }
    
    @IBAction func toggleChatHeadsSwitch(sender: UISwitch) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        bioTextField.delegate = self
        
        lightThemeSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        refreshAutomaticallySwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        chatHeadsSwitch.transform = CGAffineTransformMakeScale(0.75, 0.75)
        
//        let tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        self.view.addGestureRecognizer(tap)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let cell = sender as? UITableViewCell {
            let i = tableView.indexPathForCell(cell)!.row
            if segue.identifier == "goToReportProblem" {
                let vc = segue.destinationViewController as! ReportProblemTableViewController
            }
        }
    }
    
}
