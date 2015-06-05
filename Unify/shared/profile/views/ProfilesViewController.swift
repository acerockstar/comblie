//
//  ProfilesViewController.swift
//  Unify
//
//  Created by Annie Cheng on 6/3/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class ProfilesViewController: UIViewController, UIPageViewControllerDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var pageViewController: UIPageViewController!
    var pageLabels: NSArray!
    var messages: [Int] = [1,2,3,4,5,6,7,8,9,10] // TODO: Replace dummy data

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageLabels = ["Combined", "Instagram", "Tumblr", "Twitter", "Vine"]
        self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        var startVC = self.viewControllerAtIndex(0) as PageContentViewController
        var viewControllers = [startVC]
        
        self.pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 50)
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController {
        
        if (self.pageLabels.count == 0 || index >= self.pageLabels.count) {
            return PageContentViewController()
        }
        
        var vc: PageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PageContentViewController
        
        vc.labelText = self.pageLabels[index] as! String
        vc.pageIndex = index
        
        return vc
    }
    
    // MARK: - PageViewController Data Source
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
        if (index == 0 || index == NSNotFound) {
            return nil
        }
        
        index--
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        var vc = viewController as! PageContentViewController
        var index = vc.pageIndex as Int
        
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

}
 