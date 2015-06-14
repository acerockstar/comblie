//
//  CustomRefreshControl.swift
//  Unify
//
//  Created by Annie Cheng on 6/13/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import Foundation

class CustomRefreshControl: NSObject {
    
    var refreshControl:UIRefreshControl!
    var tableView:UITableView!
    var graphicView:UIImageView!
    var refreshColorView:UIView!
    var isRefreshAnimating = false
    var timesAnimationLooped = 0
    var pullDistance:CGFloat = 0
    
    init(refreshControl:UIRefreshControl, tableView:UITableView) {
        
        self.refreshControl = refreshControl
        self.tableView = tableView
        
        graphicView = UIImageView(image: UIImage(named: "FeedIcon"))
        graphicView.frame = CGRectMake(0, 0, 45, 45)
        
        refreshColorView = UIView(frame: refreshControl.bounds)
        refreshColorView.backgroundColor = UIColor.clearColor()
        refreshColorView.alpha = 0.30
        
        refreshControl.tintColor = UIColor.clearColor()
        refreshControl.addSubview(graphicView)
        refreshControl.addSubview(self.refreshColorView)
        
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let newPullDistance = max(0.0, -self.refreshControl.frame.origin.y);
        
        if(!isRefreshAnimating) {
            if(newPullDistance < pullDistance) {
                graphicView.transform = CGAffineTransformRotate(graphicView.transform, CGFloat(-10 * M_PI/180))
            } else {
                graphicView.transform = CGAffineTransformRotate(graphicView.transform, CGFloat(10 * M_PI/180))
            }
        }
        
        pullDistance = newPullDistance
        
        graphicView.center = CGPointMake(self.refreshControl.bounds.size.width/2.0, pullDistance / 2.0)
        
        self.refreshControl.bounds.size.height = pullDistance
        self.refreshColorView.frame = self.refreshControl.bounds

        if (self.refreshControl!.refreshing && !self.isRefreshAnimating) {
            self.animateRefreshView()
        }
        
    }
    
    func animateRefreshView() {
        
        struct ColorIndex {
            static var colorIndex = 0
        }
        
        var colorArray = [UIColor.redColor(), UIColor.blueColor(), UIColor.purpleColor(), UIColor.cyanColor(), UIColor.orangeColor(), UIColor.magentaColor()]
        
        self.isRefreshAnimating = true;
        
        UIView.animateWithDuration(
            Double(0.5),
            delay: Double(0.0),
            options: UIViewAnimationOptions.CurveLinear,
            animations: {
                self.graphicView.transform = CGAffineTransformRotate(self.graphicView.transform, CGFloat(-1 * M_PI_2))
                self.refreshColorView.backgroundColor = colorArray[ColorIndex.colorIndex]
                ColorIndex.colorIndex = (ColorIndex.colorIndex + 1) % colorArray.count
            },
            completion: { finished in
                if (self.refreshControl.refreshing) {
                    self.animateRefreshView()
                } else {
                    if (self.timesAnimationLooped % 2 != 0) {
                        self.graphicView.transform = CGAffineTransformScale(self.graphicView.transform, 1/1.3, 1/1.3)
                    }
                    self.timesAnimationLooped = 0
                    self.isRefreshAnimating = false
                    self.refreshColorView.backgroundColor = UIColor.clearColor()
                }
            }
        )
        timesAnimationLooped += 1
    }
    
}
