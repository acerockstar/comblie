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
        
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        let pageContentVC = self.viewControllerAtIndex(0)
        
        self.pageViewController.setViewControllers([pageContentVC!], direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
        self.pageControl = UIPageControl()
        self.pageControl.frame = CGRect(x: 0, y: 35, width: 0, height: 0)
        self.pageControl.backgroundColor = UIColor.whiteColor()
        self.pageControl.numberOfPages = self.pageLabels.count
        self.pageControl.currentPage = 0
        self.pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.navBarView.addSubview(pageControl)
    }
    
    @IBAction func postStatus(sender: UIBarButtonItem) {
        self.postStatusViewController = PostStatusViewController(nibName: "PostStatusView", bundle: nil)
        self.postStatusViewController.showInView(self.view.window, withImage: nil, withMessage: nil, animated: true)
    }
    
    // MARK: - Custom Paging Nav Bar
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.navBarView.frame = CGRect(x: self.view.bounds.width/4, y: 0, width: self.view.bounds.width/2, height: 44)
    }

    func viewControllerAtIndex(index: Int) -> UIViewController? {

        if (self.pageLabels.count == 0 || index >= self.pageLabels.count) {
            return PageContentViewController()
        }
        
        var pageContentVC: PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        pageContentVC.labelText = self.pageLabels[index] as! String
        pageContentVC.pageIndex = index
        
        return pageContentVC
    }
    
    // MARK: - PageViewController Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentViewController).pageIndex
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! PageContentViewController).pageIndex

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
            
            var currentVC = self.pageViewController.viewControllers.last as! PageContentViewController
            self.pageControl.currentPage = currentVC.pageIndex
            self.navigationItem.title = self.pageLabels[currentVC.pageIndex] as? String
            if currentVC.pageIndex == 0 {
                self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.blackColor()]
                self.pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
                self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
                self.navigationController?.navigationBar.barTintColor = nil
                UIApplication.sharedApplication().statusBarStyle = .Default
                postStatusButton.tintColor = nil
            } else {
                self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
                self.pageControl.currentPageIndicatorTintColor = UIColor.lightGrayColor()
                self.pageControl.pageIndicatorTintColor = UIColor.whiteColor()
                self.navigationController?.navigationBar.barTintColor = self.colors[currentVC.pageIndex] as? UIColor
                UIApplication.sharedApplication().statusBarStyle = .LightContent
                postStatusButton.tintColor = UIColor.whiteColor()
            }

        }
    }

}
 