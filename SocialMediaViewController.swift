//
//  SocialMediaViewController.swift
//  Unify
//
//  Created by Shailendra Gupta on 09/07/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class SocialMediaViewController: UIViewController,WebServiceDelegate {
    var api: WebService = WebService()
    var CheckValue : String!
    var userId : NSDecimalNumber!
    var userDefault : NSUserDefaults!

     var window: UIWindow?
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden=true
        super.viewDidLoad()
    }
    @IBAction func LoginWithInstagram(sender: AnyObject) {
        if Reachability.isConnectedToNetwork() == true {
            LoginWithVine()
        } else {
            alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
        }
    }
    @IBAction func LoginWithTumblr(sender: AnyObject) {
        if Reachability.isConnectedToNetwork() == true {
            LoginWithVine()
        } else {
            alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
        }
    }

    @IBAction func LoginWithTwitter(sender: AnyObject) {
        if Reachability.isConnectedToNetwork() == true {
            LoginWithVine()
        } else {
            alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
        }
    }

    @IBAction func LoginWithVine(sender: AnyObject) {
        
        if Reachability.isConnectedToNetwork() == true {
            LoginWithVine()
        } else {
             alertTitle("No Internet Connection", message: "Make sure your device is connected to the internet.", btnTitle: "OK")
        }

    }
    @IBAction func NewUserLogin(sender: AnyObject) {

        let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("StartConnectingViewController") as! StartConnectingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func LoginWithVine(){
        CheckValue = "1"
        api.delegate=self
        api.Login_With_Vine("Shailendragupta35@yahoo.com", Password: "Monu1987")
    }
    func LoginWithInstagram(){
        CheckValue = "1"
        api.delegate=self
        api.Login_With_Vine("Shailendragupta35@yahoo.com", Password: "Monu1987")
    }
    func LoginWithTwitter(){
        CheckValue = "1"
        api.delegate=self
        api.Login_With_Vine("Shailendragupta35@yahoo.com", Password: "Monu1987")
    }
    func LoginWithTubmler(){
        CheckValue = "1"
        api.delegate=self
        api.Login_With_Vine("Shailendragupta35@yahoo.com", Password: "Monu1987")
    }
    func VineUserInfo(userid : NSString){
        print(userid)
        CheckValue = "2"
        api.delegate=self
        api.VineUserInfo(userid)
    }
    func returnFail() {

    }
    func returnSuccess(paraDict: NSDictionary) {
        println("paraDict===\(paraDict)")

        var Status : AnyObject = paraDict.valueForKey("success") as! Bool
        if Status as! NSObject == true{

            if CheckValue == "1"{
                userId = paraDict.objectForKey("data")?.valueForKey("userId") as! NSDecimalNumber
                let userIdConvertToString = NSString(format: "%@", userId)
                VineUserInfo(userIdConvertToString)
                var data = NSKeyedArchiver.archivedDataWithRootObject(paraDict)
                userDefault = NSUserDefaults.standardUserDefaults()
                userDefault.setObject(data, forKey:"UserInfo")
                userDefault.setObject("1", forKey: "Session")
                userDefault.synchronize()


            }
            else if CheckValue == "2"{

            }
        }
        else if Status as! NSObject == false{

        }
        //let userid : String = paraDict.objectForKey("data")?.valueForKey("userId") as! NSDictionary
    }
    func alertTitle(title :String, message:String,btnTitle:String){
        var alert = UIAlertView(title: title, message:message, delegate: nil, cancelButtonTitle: btnTitle)
        alert.show()

    }




}
