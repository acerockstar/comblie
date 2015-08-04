//
//  SettingsTableViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextViewDelegate,UIAlertViewDelegate,WebServiceDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var dividerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // Profile Images
    @IBOutlet weak var nameCellImageView: UIView!
    @IBOutlet weak var nameCellImage: UIImageView!
    @IBOutlet weak var bioCellImageView: UIView!
    @IBOutlet weak var bioCellImage: UIImageView!
    
    // Cells
    @IBOutlet weak var profileCell: UITableViewCell!
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

    // Cell Switches
    @IBOutlet weak var lightThemeSwitch: UISwitch!
    @IBOutlet weak var refreshAutomaticallySwitch: UISwitch!
    @IBOutlet weak var chatHeadsSwitch: UISwitch!
    
    // Cell Arrows
    @IBOutlet weak var socialNetworkCellArrow: UIImageView!
    @IBOutlet weak var pushNotificationCellArrow: UIImageView!
    @IBOutlet weak var reportProblemCellArrow: UIImageView!
    @IBOutlet weak var feedbackCellArrow: UIImageView!
    @IBOutlet weak var blogCellArrow: UIImageView!
    @IBOutlet weak var privacyPolicyCellArrow: UIImageView!
    @IBOutlet weak var inviteFriendsArrow: UIImageView!
    @IBOutlet weak var LogoutCellArrow: UIImageView!


    var imagePicker = UIImagePickerController()
    var Loader: ViewControllerUtils = ViewControllerUtils()
    var api: WebService = WebService()
    var sectionLabels = ["PROFILE", "ACCOUNTS", "PREFERENCES", "SUPPORT", "ABOUT", ""]
    var SwitchOnOff : String = ""
    
    @IBAction func saveButtonClicked(sender: UIBarButtonItem) {
        if userImage.image != UIImage(named: "Persona"){
            NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(userImage.image), forKey: "userimages")
        }
        NSUserDefaults.standardUserDefaults().setObject(nameTextView.text, forKey: "UserName")
        NSUserDefaults.standardUserDefaults().setObject(bioTextView.text, forKey: "UserBio")
        
        bioTextView.resignFirstResponder()
        nameTextView.resignFirstResponder()
        
         NSUserDefaults.standardUserDefaults().setObject(SwitchOnOff, forKey: "ThemeChange")
    }
    
    @IBAction func changeButtonClicked(sender: UIButton) {
         ActionSheet()
    }

    
    @IBAction func toggleRefreshAutomaticallySwitch(sender: UISwitch) {
        println("toggle refresh automatically")
    }
    
    @IBAction func toggleChatHeadsSwitch(sender: UISwitch) {
        println("toggle chat heads")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var Imagedata =   NSUserDefaults.standardUserDefaults().objectForKey("userimages") as! NSData?
        if Imagedata != nil {
        userImage.image = UIImage(data: Imagedata!)
        }
        userImage.layer.cornerRadius = userImage.frame.size.width/2
        userImage.layer.masksToBounds = true
        
        var UserNameValue =   NSUserDefaults.standardUserDefaults().objectForKey("UserName") as! String?
        var UserBioValue =   NSUserDefaults.standardUserDefaults().objectForKey("UserBio") as! String?
        
        nameTextView.text = UserNameValue
        bioTextView.text = UserBioValue
 
        dividerHeightConstraint.constant = 0.5
        
        closeButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Roman", size: 16)!], forState: .Normal)
        saveButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16)!], forState: .Normal)
        var ThemeChanges =   NSUserDefaults.standardUserDefaults().objectForKey("ThemeChange") as! String?
        if ThemeChanges == "Yes"{
            self.lightThemeSwitch.setOn(true, animated: false)
        }
        else if ThemeChanges == "No"
        {
            self.lightThemeSwitch.setOn(false, animated: false)
        }
        ThemeChangeSave()
    
    }
    @IBAction func toggleLightThemeSwitch(sender: UISwitch) {
        if sender.on{
            SwitchOnOff = "Yes"
        }
        else{
            SwitchOnOff = "No"
        }
        ThemeChange(SwitchOnOff)
        tableView.reloadData()
        let appdelegate = AppDelegate.appDelegate()
        appdelegate.windowThemeChange(SwitchOnOff)
        println("toggle light theme")
    }
    func CellLableColour(){
        nameCellImageView.backgroundColor = UIColor.whiteColor()
        nameCellImageView.layer.borderWidth = 1
        nameCellImageView.layer.cornerRadius = 10
        
        bioCellImageView.backgroundColor = UIColor.whiteColor()
        bioCellImageView.layer.borderWidth = 1
        bioCellImageView.layer.cornerRadius = 10
        
        nameTextView.delegate = self
        nameTextView.contentInset = UIEdgeInsetsMake(5, -5, 0, 0)
        nameTextView.textAlignment = .Left
        nameTextView.scrollEnabled = false
        nameTextView.textContainer.maximumNumberOfLines = 1
        
        bioTextView.delegate = self
        bioTextView.contentInset = UIEdgeInsetsMake(1, -5, 0, 0)
        bioTextView.textAlignment = .Left
        bioTextView.scrollEnabled = false
        bioTextView.textContainer.maximumNumberOfLines = 3
        bioTextView.textContainer.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        lightThemeSwitch.transform = CGAffineTransformMakeScale(0.65, 0.65)
        refreshAutomaticallySwitch.transform = CGAffineTransformMakeScale(0.65, 0.65)
        chatHeadsSwitch.transform = CGAffineTransformMakeScale(0.65, 0.65)
    }
    func setcombliePurple()
    {
        nameCellImage.tintColor = UIColor.combliePurple()
        nameCellImageView.layer.borderColor = UIColor.combliePurple().CGColor
        bioCellImage.tintColor = UIColor.combliePurple()
        bioCellImageView.layer.borderColor = UIColor.combliePurple().CGColor
        self.lightThemeSwitch.tintColor = UIColor.combliePurple()
        self.chatHeadsSwitch.tintColor = UIColor.combliePurple()
        self.refreshAutomaticallySwitch.tintColor = UIColor.combliePurple()
    }
    func setThemeColor()
    {
        nameCellImage.tintColor = UIColor.ThemeColor()
        nameCellImageView.layer.borderColor = UIColor.ThemeColor().CGColor
        bioCellImage.tintColor = UIColor.ThemeColor()
        bioCellImageView.layer.borderColor = UIColor.ThemeColor().CGColor
        self.lightThemeSwitch.tintColor = UIColor.ThemeColor()
        self.chatHeadsSwitch.tintColor = UIColor.ThemeColor()
        self.refreshAutomaticallySwitch.tintColor = UIColor.ThemeColor()
    }
    func ThemeChangeSave()
    {
        var ThemeChanges =   NSUserDefaults.standardUserDefaults().objectForKey("ThemeChange") as! String?
        if ThemeChanges == "Yes"{
           setThemeColor()
        }
        else if ThemeChanges == "No"
        {
           setcombliePurple()
        }
       
        CellLableColour()
        ChangeArrowColor((ThemeChanges as String?)!)
        GetstureOnTableView()
    }
    func ChangeArrowColor(Yes_NoCheck : String){
        let cells = [profileCell, lightThemeCell, refreshAutomaticallyCell, chatHeadsCell]
        
        for cell in cells {
            cell.selectionStyle = .None
        }
        
        let cellArrows = [socialNetworkCellArrow, pushNotificationCellArrow, reportProblemCellArrow,
            feedbackCellArrow, blogCellArrow, privacyPolicyCellArrow, inviteFriendsArrow, LogoutCellArrow]
        
        for arrow in cellArrows {
            if Yes_NoCheck == "Yes"{
                arrow.tintColor = UIColor.ThemeColor()
            }
            else if Yes_NoCheck == "No"
            {
                arrow.tintColor = UIColor.combliePurple()
            }
            
        }
    }
    func ThemeChange(Yes_No:String)
    {
        if Yes_No == "Yes"{
           setThemeColor()
        }
        else if Yes_No == "No"
        {
           setcombliePurple()
        }
        CellLableColour()
        ChangeArrowColor((Yes_No as String?)!)
        GetstureOnTableView()
        
    }
    func GetstureOnTableView(){
        tableView.rowHeight = 32.0
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.sectionHeaderGrey()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tapGesture.numberOfTapsRequired = 1
        tapGesture.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tapGesture)

    }
    func ActionSheet(){
        let cameraMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        let showPhotoLibraryAction = UIAlertAction(title: "Photo Library", style: .Default) { action -> Void in
            self.openPhotoLibrary()
        }
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .Default) { action -> Void in
            self.openImagePicker()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { action -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        cameraMenu.addAction(showPhotoLibraryAction)
        cameraMenu.addAction(takePhotoAction)
        cameraMenu.addAction(cancelAction)
        
        self.presentViewController(cameraMenu, animated: true, completion: nil)
    }
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
    }
    //
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        userImage.image = image.copy() as? UIImage
       
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        
        // TODO: Post photo in box
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Md", size: 16.5)!]
    }
    
    // MARK: - Keyboard Functionality

    func dismissKeyboard() {
        self.view.endEditing(true)
    }

    // MARK: - Table View Data Source
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch(section) {
        case 0:
            return CGFloat(40.0)
        case 5:
            return CGFloat(40.0)
        default:
            return CGFloat(30.0)
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(0.0)
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerHeight: CGFloat = 0.0
        
        switch(section) {
        case 0:
            headerHeight = 40.0
        case 5:
            headerHeight = 40.0
        default:
            headerHeight = 30.0
        }
        
        var headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, headerHeight))
        var titleLabel = UILabel()
        titleLabel.font = UIFont(name: "HelveticaNeueLTStd-Roman", size: 11)
        titleLabel.frame = CGRectMake(9, headerHeight - titleLabel.font.capHeight - 5, tableView.frame.size.width, titleLabel.font.capHeight + 2)
        titleLabel.text = sectionLabels[section]
        titleLabel.textColor = UIColor.sectionTitleGrey()
        
        headerView.addSubview(titleLabel)
        
        return headerView
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
        api.delegate = self
        api.logoutVine("")
    }
    
    func TwitterLogOut(){
        api.delegate = self
        api.logoutTwitter("")
    }
    
    func TumblrLogOut(){
        api.delegate = self
        api.logoutTumblr("")
    }
    
    func InstagramLogOut(){
        api.delegate = self
        api.logoutInstagram("")
    }
    
    func returnFail() {

    }
    func removeTheSession()
    {
        let defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("Session")
        defaults.synchronize()
    }
    func returnSuccess(paraDict: NSDictionary) {
        Loader.hideActivityIndicator(self.view)
        println("paraDict===\(paraDict)")
        var Status : AnyObject = paraDict.valueForKey("success") as! Bool
        if Status as! NSObject == true{
            alertTitle("Report", message: "Logout successfully.", btnTitle: "OK")
        }
        
        removeTheSession()
        UIApplication.sharedApplication().delegate?.application!(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil)
    }
  
    func alertTitle(title :String, message:String,btnTitle:String){
        var alert = UIAlertView(title: title, message:message, delegate: nil, cancelButtonTitle: btnTitle)
        alert.show()
    }

}
