//
//  OldMessageViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/2/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class OldMessageViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Constants
    let messageFont = UIFont(name: "HelveticaNeueLTStd-Lt", size: 16.0)
    let messageBubbleWidth: CGFloat = 220.0
    
    
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
        messagesTableView.estimatedRowHeight = 10.0
        messagesTableView.rowHeight = UITableViewAutomaticDimension
        
        // TODO: - Remove Dummy data
        addTimeStamp("4:20 PM")
        addMessage(true, sender: "Persona", text: "Lorem ipsum dolor sit amet, laoreet placeat, suscipit hymenaeos, ipsum nulla lorem quis massa, et etiam, nisl lacus litora ligula.", type: NetworkType.Tumblr)
        addMessage(false, sender: "Photo", text: "Aliquet nullam luctus, tortor integer necessitatibus, porttitor nunc, sollicitudin urna id ut orci metus, volutpat porttitor. Cursus ipsum felis egestas turpis diam lacus, suspendisse nec suspendisse, voluptatem tortor lobortis, viverra vestibulum, in sapien hendrerit nunc purus per.", type: NetworkType.Tumblr)
        addMessage(true, sender: "Persona", text: "Vitae nullam, morbi lectus vitae venenatis viverra, lectus sed wisi cras proin dui, erat rutrum id ad amet vel. Fugiat ultricies enim nec ipsum adipiscing sit, nunc inceptos magna adipiscing, eu erat ac eget phasellus pellentesque.", type: NetworkType.Tumblr)
        addMessage(false, sender: "Photo", text: "Eu et suscipit tellus tellus sagittis justo, pellentesque dictum amet turpis, tellus urna egestas dignissim, nullam sed voluptatem in blandit, lacus vivamus. Quisque egestas nullam adipiscing in ligula, ut luctus. Sapien metus wisi mus mollis aliquam ullamcorper. Felis platea erat sed ut egestas.", type: NetworkType.Tumblr)
        addMessage(true, sender: "Persona", text: "Ipsum est nibh hac vestibulum molestie viverra.", type: NetworkType.Tumblr)
        addMessage(true, sender: "Persona", text: "Sodales nec in cras, ut elit vitae, faucibus orci.", type: NetworkType.Tumblr)
        addTimeStamp("4:32 PM")
        addMessage(true, sender: "Persona", text: "Posuere volutpat urna ante. Eget congue tellus nonummy, dolor imperdiet ligula tristique.", type: NetworkType.Tumblr)
        addMessage(false, sender: "Photo", text: "Arcu sem semper arcu, nulla aliquet per vivamus egestas porttitor ut. Proin vitae vitae, ultricies urna proin dui, porttitor consequat, enim fringilla tincidunt id dapibus ornare sed. Venenatis ut eu, posuere fringilla, est massa sed donec, risus pretium, pulvinar non est interdum porttitor ultricies bibendum. Pellentesque ultricies velit, pulvinar sit consequat tempor in, elit vitae quis.", type: NetworkType.Tumblr)
        addMessage(false, sender: "Photo", text: "Arcu sem semper arcu, nulla aliquet per vivamus egestas porttitor ut. Proin vitae vitae, ultricies urna proin dui, porttitor consequat, enim fringilla tincidunt id dapibus ornare sed. Venenatis ut eu, posuere fringilla, est massa sed donec, risus pretium, pulvinar non est interdum porttitor ultricies bibendum. Pellentesque ultricies velit, pulvinar sit consequat tempor in, elit vitae quis.", type: NetworkType.Tumblr)
        addMessage(true, sender: "Persona", text: "Pretium posuere, vehicula orci at consequat bibendum nulla dui, quaerat bibendum aliquet lacus vel amet.", type: NetworkType.Tumblr)
        addSeenStamp("Seen 4:35 PM")
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16.5)!]
        messagesTableView.scrollToRowAtIndexPath(NSIndexPath(forRow: data.count - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = name
        typeMessageField.frame = CGRectMake(0, 0, self.view.frame.size.width - self.uploadButton.width - 55, self.typeMessageField.frame.size.height)
        navigationController!.navigationBar.barTintColor = UIColor(red: 227.0/255.0, green: 223.0/255.0, blue: 223.0/255.0, alpha: 1.0)
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
    
    var data:[Cell] = []
    var senderCells:[Int : SecondSenderTableViewCell] = [:]
    var recipientCells:[Int : SecondRecipientTableViewCell] = [:]
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellType = data[indexPath.row]
        switch cellType.cellType as CellType {
            // MESSAGE
        case CellType.message:
            let message = cellType as! Message
            
            if message.userIsSender == true {
                // Current user is the sender of this message
                let cell = tableView.dequeueReusableCellWithIdentifier("secondSenderCell", forIndexPath: indexPath) as? SecondSenderTableViewCell
                
                // Setup cell's properties
                cell?.textView.text = message.text
                
                // Check if message cell is also from this user
                if let nextMessage = data[indexPath.row + 1] as? Message {
                    if nextMessage.senderName == message.senderName {
                        cell?.profileImageView.hidden = true
                    } else {
                        // Set the profile Image
                        cell?.profileImageView.hidden = false
                        cell?.profileImageView.image = UIImage(named: message.senderName!)
                    }
                } else {
                    // Set the profile Image
                    cell?.profileImageView.hidden = false
                    cell?.profileImageView.image = UIImage(named: message.senderName!)
                }
                
                // Adapt width of cell
                if widthOfString(message.text, withFont: messageFont!) < messageBubbleWidth {
                    // The width is smaller than the messageBubbleWidth
                    cell?.widthConstraint.constant = widthOfString(message.text, withFont: messageFont!)
                } else {
                    cell?.widthConstraint.constant = messageBubbleWidth
                }
                
                // Change Content Inset
                cell?.textView?.contentInset = UIEdgeInsetsMake(2.0,0.0,0,0.0)
                
                // Add to allCells
                senderCells[indexPath.row] = cell!
                
                return cell!
                
            } else {
                // Current user is *not* the sender of this message
                let cell = tableView.dequeueReusableCellWithIdentifier("secondRecipientCell", forIndexPath: indexPath) as? SecondRecipientTableViewCell
                
                // Setup cell's properties
                cell?.textView.text = message.text
                
                // Check if message cell is also from this user
                if let nextMessage = data[indexPath.row + 1] as? Message {
                    if nextMessage.senderName == message.senderName {
                        cell?.profileImageView.hidden = true
                    } else {
                        // Set the profile Image
                        cell?.profileImageView.hidden = false
                        cell?.profileImageView.image = UIImage(named: message.senderName!)
                    }
                } else {
                    // Set the profile Image
                    cell?.profileImageView.hidden = false
                    cell?.profileImageView.image = UIImage(named: message.senderName!)
                }
                
                // Adapt width of cell
                if widthOfString(message.text, withFont: messageFont!) < messageBubbleWidth {
                    // The width is smaller than the messageBubbleWidth
                    cell?.widthConstraint.constant = widthOfString(message.text, withFont: messageFont!)
                } else {
                    cell?.widthConstraint.constant = messageBubbleWidth
                }
                
                // Change Content Inset
                cell?.textView?.contentInset = UIEdgeInsetsMake(2.0,0.0,0,0.0)
                
                // Change cell's color
                cell?.textView.backgroundColor = colorForCellOfNetworkType(message.type)
                
                // Add to allCells
                recipientCells[indexPath.row] = cell!
                
                return cell!
            }
            
            // SEEN STAMP
        case CellType.seenStamp:
            let seenStamp = cellType as! SeenStamp
            let cell = tableView.dequeueReusableCellWithIdentifier("seenCell", forIndexPath: indexPath) as? SeenTableViewCell
            cell?.seenLabel.text = seenStamp.text
            
            return cell!
            
            // TIME STAMP
        case CellType.timeStamp:
            let timeStamp = cellType as! TimeStamp
            let cell = tableView.dequeueReusableCellWithIdentifier("timeCell", forIndexPath: indexPath) as? TimeTableViewCell
            cell?.timeLabel.text = timeStamp.date
            
            return cell!
            
            // WHITE CELL
        case CellType.white:
            let cell = tableView.dequeueReusableCellWithIdentifier("whiteCell", forIndexPath: indexPath) as? UITableViewCell
            
            return cell!
        }
    }
    
//    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
//        if let thisMessage = data[indexPath.row] as? Message {
//            let userIsSender = thisMessage.userIsSender
//            
//            if userIsSender == true {
//                let senderCell = cell as! SecondSenderTableViewCell
//                if let nextMessage = data[indexPath.row + 1] as? Message {
//                    
//                    if nextMessage.senderName == thisMessage.senderName {
//                        senderCell.profileImageView.hidden = true
//                    } else {
//                        senderCell.profileImageView.hidden = false
//                    }
//                }
//            } else {
//                let recipientCell = cell as! SecondRecipientTableViewCell
//                if let nextMessage = data[indexPath.row + 1] as? Message {
//                    
//                    if nextMessage.senderName == thisMessage.senderName {
//                        recipientCell.profileImageView.hidden = true
//                    } else {
//                        recipientCell.profileImageView.hidden = false
//                    }
//                }
//            }
//
//        }
//    }
    
    func hideProfileImageOfCellAtIndexPath(indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func addMessage(userIsSender: Bool, sender: String?, text: String, type: NetworkType) {
        let message = Message(userIsSender: userIsSender, text: text, type: type, senderName: sender)
        
        // Check if previous message was not from this user
        if let previousMessage = data.last as? Message {
            if previousMessage.userIsSender == true {
                if message.userIsSender == false {
                    let whiteCell = Cell(cellType: CellType.white)
                    self.data.append(whiteCell)
                }
            } else {
                if message.userIsSender == true {
                    let whiteCell = Cell(cellType: CellType.white)
                    self.data.append(whiteCell)
                }
            }
        }
        
        // TODO: Change!
        data += [message]
    }
    
    func addTimeStamp(forDate: String) {
        let timeStamp = TimeStamp(date: forDate)
        
        // TODO: Change!
        data += [timeStamp]
    }
    
    func addSeenStamp(text: String) {
        let seenStamp = SeenStamp()
        seenStamp.text = text
        
        // TODO: Change!
        data += [seenStamp]
    }
    
    func addWhiteCell() {
        let whiteCell = Cell(cellType: CellType.white)
        
        // TODO: Change!
        data += [whiteCell]
    }
    
    // MARK: - Helper Functions
    
    func widthOfString(string: String, withFont font: UIFont) -> CGFloat {
        let s = string as NSString
        return s.sizeWithAttributes([NSFontAttributeName:font]).width + 12.0
    }
    
    func colorForCellOfNetworkType(networkType: NetworkType) -> UIColor {
        switch networkType {
        case NetworkType.Facebook:
            return UIColor(rgba: "#4A70B6")
        case NetworkType.Twitter:
            return UIColor(rgba: "#40b0ff")
        case NetworkType.Vine:
            return UIColor(rgba: "#00cd96")
        case NetworkType.Tumblr:
            return UIColor(rgba: "#1a3f6c")
        }
    }
}

// MARK: - Message and Stamp Classes

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
    var text = "Seen 4:31 PM"
    init() {
        super.init(cellType: .seenStamp)
    }
}

enum CellType {
    case timeStamp
    case seenStamp
    case message
    case white
}

enum NetworkType {
    case Twitter
    case Facebook
    case Vine
    case Tumblr
}


