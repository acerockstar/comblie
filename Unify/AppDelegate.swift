//
//  AppDelegate.swift
//  Unify
//
//  Created by Annie Cheng on 6/1/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    class func appDelegate() -> AppDelegate {
       
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        Parse.enableLocalDatastore()
        Parse.setApplicationId("zsNeOQ3y6WHVaBMg1se7FIuv2c5uLtXrn59HOqcV", clientKey: "KsY7BPh17bfLEAHy4O89l314m54XYbOaqNJf8XcS")
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)

        let notificationTypes = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
        let notificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: nil)

       
        var tabBarController: UITabBarController = self.window?.rootViewController as! UITabBarController
        tabBarController.selectedIndex = 2

        let userDefaults=NSUserDefaults.standardUserDefaults()
        var getObject: AnyObject?=userDefaults.valueForKey("Session")
        let storyboard:UIStoryboard = UIStoryboard(name: "Main_iPhone", bundle: nil)

        if (getObject == nil) {
            let ObjSocialMediaViewController:UIViewController = (storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as? HomeViewController)!
            let navigationController = UINavigationController(rootViewController: ObjSocialMediaViewController);
            self.window?.rootViewController = navigationController
        }
        
        var ThemeChanges =   NSUserDefaults.standardUserDefaults().objectForKey("ThemeChange") as! String?
        if ThemeChanges == "Yes"{
            self.window?.tintColor = UIColor.ThemeColor()
            UITabBar.appearance().selectionIndicatorImage = UIImage(named: "Light-Theme-Grey-Highlight.png")
            UITabBar.appearance().tintColor = UIColor.whiteColor()
            
        }
        else if ThemeChanges == "No"
        {
            self.window?.tintColor = UIColor.purpleColor()
            UITabBar.appearance().selectionIndicatorImage = UIImage(named: "Light-Theme-Purple-Highlight")
            UITabBar.appearance().tintColor = UIColor.whiteColor()
            
        }
        
        return true
    }
    func windowThemeChange(Yes_No : String)
    {
        if Yes_No == "Yes"{
           self.window?.tintColor = UIColor.ThemeColor()
            UITabBar.appearance().selectionIndicatorImage = UIImage(named: "Light-Theme-Grey-Highlight.png")
            UITabBar.appearance().tintColor = UIColor.whiteColor()

        }
        else if Yes_No == "No"
        {
            self.window?.tintColor = UIColor.purpleColor()
            UITabBar.appearance().selectionIndicatorImage = UIImage(named: "Light-Theme-Purple-Highlight")
            UITabBar.appearance().tintColor = UIColor.whiteColor()

        }
    }
  
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

