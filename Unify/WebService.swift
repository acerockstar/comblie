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
    var urlPath:NSString?

    func UrlConnectionBody(urlPath :NSString){
        var url: NSURL = NSURL(string: urlPath as String)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self,
            startImmediately: false)!
        println("Search iTunes API at URL \(url)")
        connection.start()
    }

    public func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        println("Failed with error:\(error.localizedDescription)")
    }

    public func connection(didReceiveResponse: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.responseData = NSMutableData()
    }
    public  func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        self.responseData.appendData(data)
    }
    public  func connectionDidFinishLoading(connection: NSURLConnection) {
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(responseData,
            options:NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
        delegate?.returnSuccess(jsonResult)
    }
    func Vine_get_user_info(){
        urlPath = ""
        UrlConnectionBody(urlPath!)
    }
    func Vine_Avtar(){
        //urlPath = "http://api.tumblr.com/v2/blog/unify.tumblr.com/info?api_key=PyezS3Q4Smivb24d9SzZGYSuh--IaMfAkE"
        urlPath = "http://api.tumblr.com/v2/blog/unify.tumblr.com/followers"
        //urlPath = "http://api.tumblr.com/v2/blog/unify.tumblr.com/avatar"
        UrlConnectionBody(urlPath!)
    }
}
