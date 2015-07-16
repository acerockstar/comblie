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
    var request : NSMutableURLRequest = NSMutableURLRequest()

    func Login_With_Vine(Username : String , Password: String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/authenticate")!)
        request.HTTPMethod = "POST"
        let postString = "username=\(Username)&password=\(Password)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        urlSession()
    }

    func VineUserInfo(userId : NSString){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(userId)")!)
        request.HTTPMethod = "GET"
        urlSession()

    }
    func Feedback(feedbackString : String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(Feedback)")!)
        request.HTTPMethod = "GET"
        urlSession()

    }
    func reportProblem(reportProblemString : String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(reportProblem)")!)
        request.HTTPMethod = "GET"
        urlSession()

    }
    func logoutVine(UserId : String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(UserId)")!)
        request.HTTPMethod = "GET"
        urlSession()

    }
    func logoutInstagram(UserId : String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(UserId)")!)
        request.HTTPMethod = "GET"
        urlSession()

    }
    func logoutTwitter(UserId : String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(UserId)")!)
        request.HTTPMethod = "GET"
        urlSession()

    }
    func logoutTumblr(UserId : String){
        request = NSMutableURLRequest(URL: NSURL(string: "https://api.vineapp.com/users/profiles/\(UserId)")!)
        request.HTTPMethod = "GET"
        urlSession()

    }

    func urlSession(){
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
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
    func PostUpdateToTumblr(textMessage : String){
        request = NSMutableURLRequest(URL: NSURL(string: "api.tumblr.com/v2/blog/loveshailendra.tumblr.com/post")!)
        var keys : NSMutableDictionary = NSMutableDictionary()
        keys.setValue("CXGIaODPGTLU0sjy8tcg8YkWMZYOFxvDTzMMT3mvilWv55mm99", forKey: "Consumer_Key")
        keys.setValue("v5NbhosgGBXX5D3w0VKnPOTZovCdHfAtLD4bEfZnFWLUxTD517", forKey: "ConsuAccess_Tokenmer_Key")
        keys.setValue("fy4i8stvK3Gmr9i2n2835QY3cezLPTIsjdG526EQK4SBEPNEBQ", forKey: "Consumer_Secret")
        keys.setValue("WjdAKsTM7sNDT2yJCnZUXaDLhkDQ2Kq7zopDzVXnhxm4excmXbQ", forKey: "Token_Secret")

      //  request.setValuesForKeysWithDictionary(<#keyedValues: [NSObject : AnyObject]#>)
        request.HTTPMethod = "POST"
        let postString = "body=\(textMessage)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        urlSession()
    }
}
