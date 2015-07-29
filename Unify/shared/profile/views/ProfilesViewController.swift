//
//  ProfilesViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageViewController: UIPageViewController!
    var postStatusViewController : PostStatusViewController!
    var navBarView =  UIView()
    var pageControl: UIPageControl!
    
    
    // TODO: Store as dictionary
    var pageLabels: NSArray = ["Combined", "Instagram", "Tumblr", "Twitter", "Vine"]
    var colors: NSArray = [UIColor.lightTextColor(), UIColor.instagramBlue(), UIColor.tumblrBlue(), UIColor.twitterBlue(), UIColor.vineGreen()]

    @IBOutlet weak var postStatusButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.addSubview(self.navBarView)
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfilePageViewController") as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let pageContentVC = self.viewControllerAtIndex(0)
        
        self.pageViewController.setViewControllers([pageContentVC!], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        let navBar = self.navigationController?.navigationBar
        navBar!.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HelveticaNeueLTStd-Bd", size: 16.5)!]
        navBar!.setTitleVerticalPositionAdjustment(-navBar!.frame.size.height * 0.1, forBarMetrics: .Default)
        self.pageControl = UIPageControl()
        self.pageControl.frame = CGRect(x: 0, y: navBar!.frame.size.height * 0.75, width: 0, height: 0)
        Util.setUpPageControl(self.pageControl, navBarView: self.navBarView, numPages: self.pageLabels.count)
        
    }

   
    override func viewWillAppear(animated: Bool) {
        changeNavBar()
    }
    
    @IBAction func postStatus(sender: UIBarButtonItem) {
        self.postStatusViewController = PostStatusViewController(nibName: "PostStatusView", bundle: nil)
        self.postStatusViewController.showInView(self.view.window, withImage: nil, withMessage: nil, animated: true)
    }
    
    // MARK: - Custom Paging Nav Bar
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let navBarHeight = self.navigationController?.navigationBar.frame.size.height
        self.navBarView.frame = CGRect(x: self.view.bounds.width/4, y: 0, width: self.view.bounds.width/2, height: navBarHeight!)
    }

    func viewControllerAtIndex(index: Int) -> UIViewController? {

        if (self.pageLabels.count == 0 || index >= self.pageLabels.count) {
            return ProfileContentViewController()
        }
        
        var pageContentVC: ProfileContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileContentViewController") as! ProfileContentViewController
        
        pageContentVC.labelText = self.pageLabels[index] as! String
        pageContentVC.pageIndex = index
        
        return pageContentVC
    }
    
    // MARK: - PageViewController Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ProfileContentViewController).pageIndex
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ProfileContentViewController).pageIndex

        if (index == NSNotFound) {
            return nil
        }
        
        index++
        
        if (index == self.pageLabels.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.pageLabels.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        
        if completed {
            changeNavBar()
        }
    }
    
    func changeNavBar() {
        var currentVC = self.pageViewController.viewControllers.last as! ProfileContentViewController
        self.pageControl.currentPage = currentVC.pageIndex
        self.navigationItem.title = self.pageLabels[currentVC.pageIndex] as? String
        UIApplication.sharedApplication().statusBarStyle = .Default
    }

}
 