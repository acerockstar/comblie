//
//  OldMessageViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/2/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class OldMessageViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK - Constants
    let messageFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 13.0)
    let messageBubbleWidth: CGFloat = 189.0
    
    
    let imagePicker = UIImagePickerController()
    var name = "Name"
    
    @IBOutlet weak var typeMessageField: UITextField!
    @IBOutlet weak var uploadButton: UIBarButtonItem!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messagesTableView: UITableView!
    
    
    @IBAction func goBackToMessages(sender: UIBarButtonItem) {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    @IBAction func uploadItem(sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //            Determines selected image
            //            imageView.contentMode = .ScaleAspectFit
            //            imageView.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeMessageField.delegate = self
        imagePicker.delegate = self
        //addContactField.becomeFirstResponder()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardShown:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardHidden:"), name:UIKeyboardWillHideNotification, object: nil)
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        messagesTableView.estimatedRowHeight = 48.0
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        
        // TODO: - Remove Dummy data
        addTimeStamp("4:20 PM")
        addMessage(false, sender: "Persona", text: "Hello!", type: NetworkType.Twitter)
        addMessage(true, sender: "Photo", text: "Hi! How are you doing?", type: NetworkType.Twitter)
        addMessage(true, sender: "Photo", text: "It's a beautiful day!", type: NetworkType.Twitter)
        addMessage(false, sender: "Persona", text: "I'm doing great! Thanks for asking :-)", type: NetworkType.Twitter)
        addMessage(true, sender: "Photo", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", type: NetworkType.Twitter)
        addSeenStamp()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16.5)!]
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = name
        typeMessageField.frame = CGRectMake(0, 0, self.view.frame.size.width - self.uploadButton.width - 55, self.typeMessageField.frame.size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK - Keyboard Functionality
    
    func keyboardShown(sender: NSNotification) {
        var keyboardFrame: CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.bottomConstraint.constant = keyboardFrame.size.height
        self.view.layoutIfNeeded()
    }
    
    func keyboardHidden(sender: NSNotification) {
        var keyboardFrame: CGRect = (sender.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        self.bottomConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    // MARK - Messages Table View
    
    var dummyData:[Cell] = []
    var previousMessageWasUserSender = false
    var previousWasStamp = false
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellType = dummyData[indexPath.row]
        switch cellType.cellType as CellType {
            // MESSAGE
        case CellType.message:
            let message = cellType as! Message
            if message.userIsSender == false {
                let cell = tableView.dequeueReusableCellWithIdentifier("recipientCell", forIndexPath: indexPath) as? RecipientTableViewCell
                cell?.textView.text = message.text
                if previousMessageWasUserSender == false && previousWasStamp == false {
                    cell!.imageView!.hidden = true
                } else {
                    cell?.profileImage.image = UIImage(named: message.senderName!)
                }
                if widthOfString(message.text, withFont: messageFont!) < messageBubbleWidth {
                    if widthOfString(message.text, withFont: messageFont!) + 20 > messageBubbleWidth {
                        cell?.widthConstraint.constant = messageBubbleWidth
                    } else {
                        cell?.widthConstraint.constant = widthOfString(message.text, withFont: messageFont!) + 20
                        cell?.textView.textAlignment = .Center
                    }
                }
                cell?.textView?.contentInset = UIEdgeInsetsMake(2.0,0.0,0,0.0)
                previousMessageWasUserSender = false
                previousWasStamp = false
                
                return cell!
                
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("senderCell", forIndexPath: indexPath) as? SenderTableViewCell
                cell?.textView.text = message.text
                if previousMessageWasUserSender == true && previousWasStamp == false {
                    cell!.imageView!.hidden = true
                } else {
                    cell?.profileImage.image = UIImage(named: message.senderName!)
                }
                if widthOfString(message.text, withFont: messageFont!) < messageBubbleWidth {
                    if widthOfString(message.text, withFont: messageFont!) + 20 > messageBubbleWidth {
                        cell?.widthConstraint.constant = messageBubbleWidth
                    } else {
                        cell?.widthConstraint.constant = widthOfString(message.text, withFont: messageFont!) + 20
                        cell?.textView.textAlignment = .Center
                    }
                }
                cell?.textView?.contentInset = UIEdgeInsetsMake(2.0,0.0,0,0.0)
                previousMessageWasUserSender = true
                previousWasStamp = false
                
                return cell!
            }
            
            
            // SEEN STAMP
        case CellType.seenStamp:
            previousWasStamp = true
            let cell = tableView.dequeueReusableCellWithIdentifier("seenCell", forIndexPath: indexPath) as? SeenTableViewCell
            
            return cell!
            
            // TIME STAMP
        case CellType.timeStamp:
            previousWasStamp = true
            let timeStamp = cellType as! TimeStamp
            let cell = tableView.dequeueReusableCellWithIdentifier("timeCell", forIndexPath: indexPath) as? TimeTableViewCell
            cell?.timeLabel.text = timeStamp.date
            
            return cell!
        }
        
//        if indexPath.row % 2 == 0 {
//            // Sender
//            let cell = tableView.dequeueReusableCellWithIdentifier("senderCell", forIndexPath: indexPath) as? SenderTableViewCell
//            cell?.textView.text = dummyData[indexPath.row]
//            cell?.profileImage.image = UIImage(named: "Persona")
//            if widthOfString(dummyData[indexPath.row], withFont: messageFont!) < messageBubbleWidth {
//                if widthOfString(dummyData[indexPath.row], withFont: messageFont!) + 20 > messageBubbleWidth {
//                    cell?.widthConstraint.constant = messageBubbleWidth
//                } else {
//                    cell?.widthConstraint.constant = widthOfString(dummyData[indexPath.row], withFont: messageFont!) + 20
//                    cell?.textView.textAlignment = .Center
//                }
//            }
//
//            return cell!
//        } else {
//            // Recipient
//            let cell = tableView.dequeueReusableCellWithIdentifier("recipientCell", forIndexPath: indexPath) as? RecipientTableViewCell
//            cell?.textView.text = dummyData[indexPath.row]
//            cell?.profileImage.image = UIImage(named: "Photo")
//            if widthOfString(dummyData[indexPath.row], withFont: messageFont!) < messageBubbleWidth {
//                if widthOfString(dummyData[indexPath.row], withFont: messageFont!) + 20 > messageBubbleWidth {
//                    cell?.widthConstraint.constant = messageBubbleWidth
//                } else {
//                    cell?.widthConstraint.constant = widthOfString(dummyData[indexPath.row], withFont: messageFont!) + 20
//                    cell?.textView.textAlignment = .Center
//                }
//            }
//
//            return cell!
//        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func addMessage(userIsSender: Bool, sender: String?, text: String, type: NetworkType) {
        let message = Message(userIsSender: userIsSender, text: text, type: type, senderName: sender)
        
        // TODO: Change!
        dummyData += [message]
    }
    
    func addTimeStamp(forDate: String) {
        let timeStamp = TimeStamp(date: forDate)
        
        // TODO: Change!
        dummyData += [timeStamp]
    }
    
    func addSeenStamp() {
        let seenStamp = SeenStamp()
        
        // TODO: Change!
        dummyData += [seenStamp]
    }
    
    // MARK - Helper Functions
    
    func widthOfString(string: String, withFont font: UIFont) -> CGFloat {
        var attributes: [NSObject : AnyObject] = [font: NSFontAttributeName]
        return NSAttributedString(string: string, attributes: attributes).size().width
    }
}

// MARK - Message and Stamp Classes

class Cell: NSObject {
    let cellType: CellType!
    init(cellType: CellType) {
        self.cellType = cellType
    }
}

class Message: Cell {
    var userIsSender: Bool!
    var text: String!
    var type: NetworkType!
    var senderName: String?
    
    init(userIsSender: Bool, text: String, type: NetworkType, senderName: String?) {
        super.init(cellType: .message)
        self.userIsSender = userIsSender
        self.text = text
        self.type = type
        self.senderName = senderName
    }
}

class TimeStamp: Cell {
    var date: String!
    
    init(date: String) {
        super.init(cellType: .timeStamp)
        self.date = date
    }
}

class SeenStamp: Cell {
    init() {
        super.init(cellType: .seenStamp)
    }
}

enum CellType {
    case timeStamp
    case seenStamp
    case message
}

enum NetworkType {
    case Twitter
    case Facebook
}


