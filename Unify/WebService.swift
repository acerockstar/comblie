//
//  WebService.swift
//  Meddiapers
//
//  Created by Shailendra Gupta on 24/06/15.
//  Copyright (c) 2015 RPSB. All rights reserved.
//

import UIKit

protocol WebServiceDelegate {
func returnSuccess(paraDict:NSDictionary)
func returnFail()
}
public class WebService: NSObject,NSURLConnectionDataDelegate{

    var responseData: NSMutableData = NSMutableData()
    var delegate: WebServiceDelegate?
    var request :NSMutableURLRequest?

    func Login_With_Vine(Username : String , Password: String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/authenticate")!)
        request!.HTTPMethod = "POST"
        let postString = "username=\(Username)&password=\(Password)"
        request!.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        urlSession()
    }
    func VineUserInfo(userId : NSString){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(userId)")!)
        request!.HTTPMethod = "GET"
        urlSession()

    }

    func urlSession(){
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request!) {
            data, response, error in
            if error != nil {
                println("error=\(error)")
                return
            }
            var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data,
                options:NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            self.delegate?.returnSuccess(jsonResult)
        }
        task.resume()
    }
}
