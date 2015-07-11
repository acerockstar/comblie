//
//  TextSizeViewController.swift
//  Unify
//
//  Created by Annie Cheng on 7/10/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit

class TextSizeViewController: UIViewController {
    
    @IBOutlet weak var textSizeBoxView: UIView!
    let stepValue: Float = 0.5
    let tickWidth: CGFloat = 2
    let tickHeight: CGFloat = 10
    var initialStepValue: Float = 0.0
    var minTickMark: UIView!
    var middleTickMark: UIView!
    var maxTickMark: UIView!

    @IBOutlet weak var textSizeSlider: UISlider!
    
    @IBAction func cancelButtonClicked(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func textSizeSliderMoved(sender: UISlider) {
        let newStep = roundf(textSizeSlider.value/stepValue)
        
        textSizeSlider.value = newStep * stepValue
        
        setTickColors()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        minTickMark = UIView(frame: CGRectMake(textSizeSlider.center.x - textSizeSlider.frame.size.width/2, textSizeSlider.center.y - tickHeight/2, tickWidth, tickHeight))
        middleTickMark = UIView(frame: CGRectMake(textSizeSlider.center.x, textSizeSlider.center.y - tickHeight/2, tickWidth, tickHeight))
        maxTickMark = UIView(frame: CGRectMake(textSizeSlider.center.x + textSizeSlider.frame.size.width/2 - 2, textSizeSlider.center.y - tickHeight/2, tickWidth, tickHeight))
        let tickMarks = [minTickMark, middleTickMark, maxTickMark]
        
        for tick in tickMarks {
            self.textSizeBoxView.addSubview(tick)
            self.textSizeBoxView.sendSubviewToBack(tick)
        }
        
        setTickColors()
    }
    
    func setTickColors() {
        switch(textSizeSlider.value){
        case 0:
            minTickMark.backgroundColor = UIColor.combliePurple()
            middleTickMark.backgroundColor = UIColor.lightGrayColor()
            maxTickMark.backgroundColor = UIColor.lightGrayColor()
        case 0.5:
            minTickMark.backgroundColor = UIColor.combliePurple()
            middleTickMark.backgroundColor = UIColor.combliePurple()
            maxTickMark.backgroundColor = UIColor.lightGrayColor()
        default:
            minTickMark.backgroundColor = UIColor.combliePurple()
            middleTickMark.backgroundColor = UIColor.combliePurple()
            maxTickMark.backgroundColor = UIColor.combliePurple()
        }
    }
    
}
