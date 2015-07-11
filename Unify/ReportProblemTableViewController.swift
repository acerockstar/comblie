//
//  ReportProblemTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ReportProblemTableViewController: UITableViewController {
    
    @IBOutlet weak var submitButton: UIBarButtonItem!

    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func submitButtonClicked(sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "ReportProblemTableViewCell", bundle: nil), forCellReuseIdentifier: "ReportProblemTableViewCell")
        
        tableView.scrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ReportProblemTableViewCell", forIndexPath: indexPath) as! ReportProblemTableViewCell
        
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.layoutMargins = UIEdgeInsetsZero
        tableView.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
    }

}
