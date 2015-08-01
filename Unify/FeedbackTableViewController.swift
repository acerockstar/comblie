//
//  FeedbackTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class FeedbackTableViewController: UITableViewController,WebServiceDelegate {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBOutlet var FeedbackTableView: UITableView!
    
    var Loader: ViewControllerUtils = ViewControllerUtils()
    var api: WebService = WebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Roman", size: 16)!], forState: .Normal)
        submitButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16)!], forState: .Normal)
        
        tableView.registerNib(UINib(nibName: "TextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "TextViewTableViewCell")
        
        tableView.scrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.sectionHeaderGrey()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16.5)!]
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(18.0)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TextViewTableViewCell", forIndexPath: indexPath) as! TextViewTableViewCell
        
        cell.textView.text = "What would you like us to improve?"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func submitButtonClicked(sender: UIBarButtonItem) {

        if Reachability.isConnectedToNetwork() == true {
            let StingValue = getTextValueFromTableViewCell()
            Loader.showActivityIndicator(self.view)
            api.delegate=self
            api.Feedback(StingValue)

        } else {
            alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
        }

    }
    func getTextValueFromTableViewCell()->String{
        let indexPath = NSIndexPath(forRow: 0, inSection: 0);
        var tableViewCell = FeedbackTableView.cellForRowAtIndexPath(indexPath) as UITableViewCell?
        let TextViews :UITextView = (tableViewCell?.viewWithTag(1) as! UITextView?)!
        print(TextViews.text);
        return TextViews.text
    }
    func returnFail() {

    }
    func returnSuccess(paraDict: NSDictionary) {
        Loader.hideActivityIndicator(self.view)
        println("paraDict===\(paraDict)")
        var Status : AnyObject = paraDict.valueForKey("success") as! Bool
        if Status as! NSObject == true{
            alertTitle("Report", message: "Your feedback submitted successfully.", btnTitle: "OK")
        }
        else if Status as! NSObject == false{
            alertTitle("Report", message: "Your feedback submitted successfully.", btnTitle: "OK")
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    func alertTitle(title :String, message:String,btnTitle:String){
        var alert = UIAlertView(title: title, message:message, delegate: nil, cancelButtonTitle: btnTitle)
        alert.show()
        
    }

}
