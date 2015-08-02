//
//  SocialMediaViewController.swift
//  Unify
//
//  Created by Shailendra Gupta on 09/07/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import CloudKit
import SwiftyJSON
import Parse

class SocialMediaViewController: UIViewController,WebServiceDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginPopupView: UIView!
    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var vineButton: UIButton!
    @IBOutlet weak var tumblrButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var LoginIcon: UIImageView!
    
    var api: WebService = WebService()
    var Loader: ViewControllerUtils = ViewControllerUtils()
    var CheckValue : String!
    var userId : NSDecimalNumber!
    var userDefault : NSUserDefaults!
    let container = CKContainer.defaultContainer()
    var publicDatabase: CKDatabase?
    var currentRecord: CKRecord?
    var DefaulstUser : NSUserDefaults?
    var CheckClickBtn : String!

     var window: UIWindow?
    override func viewDidLoad() {
        DefaulstUser = NSUserDefaults.standardUserDefaults()
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden=true
        publicDatabase = container.publicCloudDatabase
        // Styling
        let loginButtons = [twitterButton, vineButton, tumblrButton, instagramButton]
        for button in loginButtons {
            button.layer.cornerRadius = twitterButton.frame.size.height/2
            button.layer.borderWidth = 1.5
            button.layer.borderColor = UIColor.comblieDarkPurple().CGColor
            button.tintColor = UIColor.comblieDarkPurple()
            button.titleLabel!.font = UIFont(name: "HelveticaNeueLTStd-Md", size: 18)
        }
        
        welcomeBackLabel.textColor = UIColor.comblieDarkPurple()
        messageLabel.textColor = UIColor.comblieDarkPurple()
        signUpButton.tintColor = UIColor.comblieDarkPurple()
        
        welcomeBackLabel.font = UIFont(name: "HelveticaNeueLTStd-Md", size: 18)
        messageLabel.font = UIFont(name: "HelveticaNeueLTStd-Roman", size: 16)
        
        let messageStyle = NSMutableParagraphStyle()
        messageStyle.lineSpacing = 3
        let messageString = NSMutableAttributedString(string: "Log in to one of your social media accounts to resume.")
        messageString.addAttribute(NSParagraphStyleAttributeName, value: messageStyle, range: NSMakeRange(0, messageString.length))
        messageLabel.attributedText = messageString
        messageLabel.textAlignment = .Center
        
        let signUpString = NSMutableAttributedString()
        
        if let romanFont = UIFont(name: "HelveticaNeueLTStd-Roman", size: 13) {
            let thinString = NSAttributedString(string: "New user? ", attributes: [NSFontAttributeName: romanFont])
            signUpString.appendAttributedString(thinString)
        }
        
        if let mediumFont = UIFont(name: "HelveticaNeueLTStd-Md", size: 13) {
            let thickString = NSAttributedString(string: "Sign Up", attributes: [NSFontAttributeName: mediumFont])
            signUpString.appendAttributedString(thickString)
        }

        signUpButton.setAttributedTitle(signUpString, forState: .Normal)
        
    }
    @IBAction func LoginWithTwitter(sender: AnyObject) {
        CheckClickBtn = "Twitter"
        twitterButton.backgroundColor = UIColor.comblieDarkPurple()
        twitterButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
        LoginIcon.image = UIImage(named: "Twitter-Large-Icon")
        if loginPopupView.hidden == true {
            loginPopupView.hidden = false
        }
    }
    
    @IBAction func LoginWithVine(sender: AnyObject) {
        CheckClickBtn = "Vine"
        LoginIcon.image = UIImage(named: "Vine-Large-Icon")
        vineButton.backgroundColor = UIColor.comblieDarkPurple()
        vineButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
        if loginPopupView.hidden == true {
            loginPopupView.hidden = false
        }
    }
    @IBAction func LoginWithTumblr(sender: AnyObject) {
        CheckClickBtn = "Tumblr"
        tumblrButton.backgroundColor = UIColor.comblieDarkPurple()
        tumblrButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
        LoginIcon.image = UIImage(named: "Tumblr-Large-Icon")
        if loginPopupView.hidden == true {
            loginPopupView.hidden = false
        }
    }
   
    @IBAction func LoginWithInstagram(sender: AnyObject) {
        CheckClickBtn = "Instagram"
        instagramButton.backgroundColor = UIColor.comblieDarkPurple()
        instagramButton.setTitleColor(UIColor.backgroundLightGrey(), forState: .Normal)
        LoginIcon.image = UIImage(named: "Instagram-Large-Icon")
        if loginPopupView.hidden == true {
            loginPopupView.hidden = false
        }
    }


    //********************************************** Twitter user area ***************************************
    
    func LoginWithTwitter(){
        CheckValue = "3"
        api.delegate=self
        api.Login_With_Vine("Shailendragupta35@yahoo.com", Password: "Monu1987")
    }
    
    //**********************************************Vine user area ***************************************
    
    func LoginWithVine(){
        CheckValue = "1"
        Loader.showActivityIndicator(self.view)
        api.delegate=self
        //Shailendragupta35@yahoo.com
        //Monu1987
        api.Login_With_Vine(emailIdTextField.text, Password:passwordTextField.text)
    }

    func VineUserInfo(userid : NSString){
        print(userid)
        CheckValue = "4"
        api.delegate=self
        api.VineUserInfo(userid)
    }
    
    //********************************************** Tubmlr user area ***************************************
    
    func LoginWithTubmlr(){
        CheckValue = "3"
        api.delegate=self
        api.Login_With_Vine("Shailendragupta35@yahoo.com", Password: "Monu1987")
    }
    //**********************************************Instagram user area ***************************************
    
    func LoginWithInstagram(){
        CheckValue = "2"
        api.delegate=self
        api.InstagramUserLogin("comblie12")
    }
    func InstagramUser_Info(userid : NSString){
        CheckValue = "5"
        api.delegate=self
        api.Instagram_user_info(userid as String)
    }
    //**********************************************Facevook user area ***************************************
    
    func LoginWithFacebook(){
        CheckValue = "2"
        api.delegate=self
        api.InstagramUserLogin("comblie12")
    }
    func FacebookUser_Info(userid : NSString){
        CheckValue = "5"
        api.delegate=self
        api.Instagram_user_info(userid as String)
    }

    
    @IBAction func LoginClick(sender: AnyObject) {
        
        if emailIdTextField.text == "" || passwordTextField.text == "" {
            alertTitle("alert!", message: "All field is requird", btnTitle: "OK")
        }
        else {
            
            if Reachability.isConnectedToNetwork() == true {
                if CheckClickBtn == "Vine" {
                    LoginWithVine()
                }
                else if CheckClickBtn == "Instagram" {
                    LoginWithInstagram()
                }
                else if CheckClickBtn == "Tumblr" {
                    LoginWithTubmlr()
                }
                else if CheckClickBtn == "Twitter" {
                    LoginWithTubmlr()
                }
                else if CheckClickBtn == "Facebook" {
                    LoginWithFacebook()
                }
            }
            else {
                alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
            }
            emailIdTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
    
    
    
//**********************************************Reasult user area ***************************************
    
    func returnSuccess(paraDict: NSDictionary) {
        println("paraDict===\(paraDict)")
        Loader.hideActivityIndicator(self.view)
            if CheckValue == "1"{
                var Status : AnyObject = paraDict.valueForKey("success") as! Bool
                if Status as! NSObject == true {
                    userId = paraDict.objectForKey("data")?.valueForKey("userId") as! NSDecimalNumber
                    let userIdConvertToString = NSString(format: "%@", userId)
                    VineUserInfo(userIdConvertToString)
                    
                    // Go to feed
                    var data = NSKeyedArchiver.archivedDataWithRootObject(paraDict)
                    userDefault = NSUserDefaults.standardUserDefaults()
                    userDefault.setObject(data, forKey:"UserInfo")
                    userDefault.setObject("1", forKey: "Session")
                    userDefault.synchronize()
                } else {
                    alertTitle("Alert!", message: "Please check your email id and password", btnTitle: "OK")
                }
            }
            else if CheckValue == "4"{
                Loader.hideActivityIndicator(self.view)
                var Status : AnyObject = paraDict.valueForKey("success") as! Bool
                if Status as! NSObject == true{
                    var avatarUrlString : String = paraDict.objectForKey("data")?.valueForKey("avatarUrl") as! String
                    var  userIds = paraDict.objectForKey("data")?.valueForKey("userId") as! NSDecimalNumber
                    let userIdConvertToString = NSString(format: "%@", userIds)
                    var userNameString : String = paraDict.objectForKey("data")?.valueForKey("username") as! String
                    var followerDouble  = paraDict.objectForKey("data")?.valueForKey("followerCount") as! Double
                    var followingDouble  = paraDict.objectForKey("data")?.valueForKey("followingCount") as! Double
                    var likeDouble  = paraDict.objectForKey("data")?.valueForKey("likeCount") as! Double
                    var loopDouble  = paraDict.objectForKey("data")?.valueForKey("loopCount") as! Double
                    var postDouble  = paraDict.objectForKey("data")?.valueForKey("postCount") as! Double
                    
                    let VineObject = PFObject(className: "Vine")
                    let query = PFQuery(className: "Vine")
                    query.selectKeys(["userId"])
                    query.findObjectsInBackgroundWithBlock({ (result : [AnyObject]?, error : NSError?) -> Void in
                        
                        if error == nil {
                            
                           if result?.count>0{
                            query.whereKey("userId", equalTo: userIds)
                             VineObject.setValue(avatarUrlString, forKey: "avatarUrl")
                             VineObject.setValue(userIds, forKey: "userId")
                             VineObject.setValue(userNameString, forKey: "username")
                             VineObject.setValue(followerDouble, forKey: "followerCount")
                             VineObject.setValue(followingDouble, forKey: "followingCount")
                             VineObject.setValue(likeDouble, forKey: "likeCount")
                             VineObject.setValue(loopDouble, forKey: "loopCount")
                             VineObject.setValue(postDouble, forKey: "postCount")
                             VineObject.save()
                            println("Object has been Update.")
                            }
                           else{
                            
                            VineObject["avatarUrl"] = avatarUrlString
                            VineObject["userId"] = userIds
                            VineObject["username"] = userNameString
                            VineObject["followerCount"] = followerDouble
                            VineObject["followingCount"] = followingDouble
                            VineObject["likeCount"] = likeDouble
                            VineObject["loopCount"] = loopDouble
                            VineObject["postCount"] = postDouble
                            VineObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                                println("Object has been saved.")
                            }
                            }
                            
                            self.DefaulstUser?.setValue("Yes", forKey: "VineLogin")
                            self.DefaulstUser?.synchronize()
                        }
                   })
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.gotofeedpage()
                    })
                   
                }
                else{
                   alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
                }
            }

//            else if CheckValue == "2"{
//
//                var DataArray : AnyObject = paraDict.valueForKey("data")!
//                if DataArray.count > 0{
//                    var idSting : String = DataArray.objectAtIndex(0).valueForKey("id") as! String
//                    InstagramUser_Info(idSting)
//                }
//            }
    }
    func gotofeedpage(){
        
      let storyboard1 : UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
      let DefaultController:UITabBarController = (storyboard1.instantiateViewControllerWithIdentifier("Main") as? UITabBarController)!
        DefaultController.selectedIndex=2
        self.presentViewController(DefaultController, animated: true, completion: nil)
        
    }
  
    func alertTitle(title :String, message:String,btnTitle:String){
        var alert = UIAlertView(title: title, message:message, delegate: nil, cancelButtonTitle: btnTitle)
        alert.show()

    }
    func returnFail() {
        
    }
    @IBAction func NewUserLogin(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("StartConnectingViewController") as! StartConnectingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func textFieldShouldClear(textField: UITextField) -> Bool {
        emailIdTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        emailIdTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        loginPopupView.hidden = true
    }
}
