//
//  FeedbackTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class FeedbackTableViewController: UITableViewController {

    @IBOutlet weak var submitButton: UIBarButtonItem!
    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitButtonClicked(sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TextViewTableViewCell", bundle: nil), forCellReuseIdentifier: "TextViewTableViewCell")
        
        tableView.scrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source
    
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

}
