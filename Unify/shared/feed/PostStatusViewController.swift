//
//  PostStatusViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/8/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import QuartzCore

class PostStatusViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,WebServiceDelegate {
    
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var postStatusNavBar: UINavigationBar!
    @IBOutlet weak var socialMediaButtonsView: UIView!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tabBar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    var api: WebService = WebService()
    var Loader: ViewControllerUtils = ViewControllerUtils()
    
    var imagePicker = UIImagePickerController()
    var socialMediaIcons = ["Instagram-Large-Icon", "Tumblr-Large-Icon", "Twitter-Large-Icon", "Vine-Large-Icon"]
    var socialMediaStatusLabel = ["Post to Instagram", "Post to Tumblr", "Update Status", "Post to Vine"]
    var socialMediaButtons: [UIButton!] = []
    var currentSocialMediaIndex = 0
    
    // Initializers
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        self.popUpView.layer.cornerRadius = 5
        self.popUpView.layer.masksToBounds = true
        self.userImage.layer.cornerRadius = 5
        self.userImage.layer.masksToBounds = true
        self.textView.delegate = self
        self.textView.text = "What are you thinking?"
        self.textView.textColor = UIColor.lightGrayColor()
        self.textView.becomeFirstResponder()
        self.textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
        self.postButton.enabled = false
        
        setUpSocialMediaButtons()
    }
    
    override func viewDidLayoutSubviews() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        
        self.view.frame.size.width = screenSize.width
        self.view.frame.size.height = screenSize.height
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .Default
    }

    func setUpSocialMediaButtons() {
        let buttonHeight = socialMediaButtonsView.frame.size.height
        let buttonXPos = socialMediaButtonsView.frame.origin.x
        let buttonYPos = socialMediaButtonsView.frame.origin.y
        
        for (index, icon) in enumerate(socialMediaIcons) {
            var socialMediaButton = UIButton(frame: CGRectMake((buttonHeight + 5) * CGFloat(index), 0, buttonHeight, buttonHeight))
            socialMediaButton.addTarget(self, action: "changeSocialMedia:", forControlEvents: .TouchUpInside)
            socialMediaButton.setImage(UIImage(named: icon), forState: .Normal)
            socialMediaButton.tag = index
            socialMediaButton.alpha = 0.5
            socialMediaButtons.append(socialMediaButton)
            socialMediaButtonsView.addSubview(socialMediaButton)
        }
    }
    
    func changeSocialMedia(sender: UIButton) {
        for button in socialMediaButtons {
            if button == sender {
                button.alpha = 1.0
                
            } else {
                button.alpha = 0.5
            }
        }
        
        postStatusNavBar.topItem!.title = socialMediaStatusLabel[sender.tag]
    }
    
    func showInView(aView: UIView!, withImage image : UIImage!, withMessage message: String!, animated: Bool) {
        aView.addSubview(self.view)
        if animated {
            self.showAnimate()
        }
    }
    
    func showAnimate() {
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0;
        UIView.animateWithDuration(0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate() {
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            }, completion:{(finished : Bool)  in
                if (finished) {
                    self.view.removeFromSuperview()
                }
        });
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    @IBAction func closePopup(sender: AnyObject) {
        self.removeAnimate()
    }
    
    @IBAction func postStatus(sender: UIBarButtonItem) {
        // TODO: Send POST request to server and create new tableview cell and prepend to tableview
        let PostToMediaName = postStatusNavBar.topItem!.title

        if Reachability.isConnectedToNetwork() == true {
            
            if (PostToMediaName == "Post to Instagram"){
                postToInstagram()
            }
            else if (PostToMediaName == "Post to Tumblr"){
                 postToTumblr()
            }
            else if (PostToMediaName == "Post to Twitter"){
                 postToTwitter()
            }
            else if (PostToMediaName == "Post to Vine"){
                postToVine()
            }
             self.removeAnimate()
        } else {
            alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
        }
        
       
    }
    func postToVine(){
        api.delegate=self;
        api.PostUpdateToVine(textView.text)
    }
    func postToTumblr(){
        api.delegate=self;
        api.PostUpdateToTumblr(textView.text)
    }
    func postToTwitter(){
        api.delegate=self;
        api.PostUpdateToTwitter(textView.text)
    }

    func postToInstagram(){
        api.delegate=self;
        api.PostUpdateToInstagram(textView.text)
    }

    func returnFail() {

    }
    func returnSuccess(paraDict: NSDictionary) {
        println("paraDict===\(paraDict)")
    }
    @IBAction func cameraButtonClicked(sender: UIBarButtonItem) {
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
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        
        // TODO: Post photo in box
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITextView Delegate Methods
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let currentText : NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        if count(updatedText) == 0 {
            self.postButton.enabled = false
            textView.text = "What are you thinking?"
            textView.textColor = UIColor.lightGrayColor()
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            return false
        } else if textView.textColor == UIColor.lightGrayColor() && count(text) > 0 {
            self.postButton.enabled = true
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }
    }
    func alertTitle(title :String, message:String,btnTitle:String){
        var alert = UIAlertView(title: title, message:message, delegate: nil, cancelButtonTitle: btnTitle)
        alert.show()
        
    }

}
