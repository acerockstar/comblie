//
//  Util.swift
//  Unify
//
//  Created by Annie Cheng on 6/21/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import Foundation

class Util {
    class func setUpPageControl(pageControl: UIPageControl, navBarView: UIView, numPages: Int) {
        pageControl.transform = CGAffineTransformMakeScale(0.7, 0.7)
        pageControl.backgroundColor = UIColor.whiteColor()
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPage = 0
        pageControl.numberOfPages = numPages
        navBarView.addSubview(pageControl)
    }

}