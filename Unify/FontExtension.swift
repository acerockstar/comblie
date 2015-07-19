//
//  FontExtension.swift
//  Unify
//
//  Created by Annie Cheng on 7/18/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import Foundation

extension UIFontDescriptor {
    
    class func preferredDescriptor(textStyle: NSString) -> UIFontDescriptor {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var fontSizeTable : NSDictionary = NSDictionary()
        }
        
        var preferredFontName: NSString = "HelveticaNeue-Regular"
        
        if textStyle == UIFontTextStyleHeadline {
            preferredFontName = "HelveticaNeue-Medium"
        }
        
        dispatch_once(&Static.onceToken) {
            Static.fontSizeTable = [
                UIFontTextStyleHeadline: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 26,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 25,
                    UIContentSizeCategoryAccessibilityExtraLarge: 24,
                    UIContentSizeCategoryAccessibilityLarge: 24,
                    UIContentSizeCategoryAccessibilityMedium: 23,
                    UIContentSizeCategoryExtraExtraExtraLarge: 23,
                    UIContentSizeCategoryExtraExtraLarge: 22,
                    UIContentSizeCategoryExtraLarge: 21,
                    UIContentSizeCategoryLarge: 20,
                    UIContentSizeCategoryMedium: 19,
                    UIContentSizeCategorySmall: 18,
                    UIContentSizeCategoryExtraSmall: 17
                ],
                UIFontTextStyleSubheadline: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 24,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 23,
                    UIContentSizeCategoryAccessibilityExtraLarge: 22,
                    UIContentSizeCategoryAccessibilityLarge: 22,
                    UIContentSizeCategoryAccessibilityMedium: 21,
                    UIContentSizeCategoryExtraExtraExtraLarge: 21,
                    UIContentSizeCategoryExtraExtraLarge: 20,
                    UIContentSizeCategoryExtraLarge: 19,
                    UIContentSizeCategoryLarge: 18,
                    UIContentSizeCategoryMedium: 17,
                    UIContentSizeCategorySmall: 16,
                    UIContentSizeCategoryExtraSmall: 15
                ],
                UIFontTextStyleBody: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 21,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 20,
                    UIContentSizeCategoryAccessibilityExtraLarge: 19,
                    UIContentSizeCategoryAccessibilityLarge: 19,
                    UIContentSizeCategoryAccessibilityMedium: 18,
                    UIContentSizeCategoryExtraExtraExtraLarge: 18,
                    UIContentSizeCategoryExtraExtraLarge: 17,
                    UIContentSizeCategoryExtraLarge: 16,
                    UIContentSizeCategoryLarge: 15,
                    UIContentSizeCategoryMedium: 14,
                    UIContentSizeCategorySmall: 13,
                    UIContentSizeCategoryExtraSmall: 12
                ],
                UIFontTextStyleCaption1: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 29,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 29,
                    UIContentSizeCategoryAccessibilityExtraLarge: 27,
                    UIContentSizeCategoryAccessibilityLarge: 25,
                    UIContentSizeCategoryAccessibilityMedium: 23,
                    UIContentSizeCategoryExtraExtraExtraLarge: 23,
                    UIContentSizeCategoryExtraExtraLarge: 21,
                    UIContentSizeCategoryExtraLarge: 19,
                    UIContentSizeCategoryLarge: 17,
                    UIContentSizeCategoryMedium: 15,
                    UIContentSizeCategorySmall: 13,
                    UIContentSizeCategoryExtraSmall: 11
                ],
                UIFontTextStyleCaption2: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 18,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 17,
                    UIContentSizeCategoryAccessibilityExtraLarge: 16,
                    UIContentSizeCategoryAccessibilityLarge: 16,
                    UIContentSizeCategoryAccessibilityMedium: 15,
                    UIContentSizeCategoryExtraExtraExtraLarge: 15,
                    UIContentSizeCategoryExtraExtraLarge: 14,
                    UIContentSizeCategoryExtraLarge: 14,
                    UIContentSizeCategoryLarge: 13,
                    UIContentSizeCategoryMedium: 12,
                    UIContentSizeCategorySmall: 12,
                    UIContentSizeCategoryExtraSmall: 11
                ],
                UIFontTextStyleFootnote: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 16,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 15,
                    UIContentSizeCategoryAccessibilityExtraLarge: 14,
                    UIContentSizeCategoryAccessibilityLarge: 14,
                    UIContentSizeCategoryAccessibilityMedium: 13,
                    UIContentSizeCategoryExtraExtraExtraLarge: 13,
                    UIContentSizeCategoryExtraExtraLarge: 12,
                    UIContentSizeCategoryExtraLarge: 12,
                    UIContentSizeCategoryLarge: 11,
                    UIContentSizeCategoryMedium: 11,
                    UIContentSizeCategorySmall: 10,
                    UIContentSizeCategoryExtraSmall: 10
                ],
            ]
        }
        
        let contentSize = UIApplication.sharedApplication().preferredContentSizeCategory
        
        let style = Static.fontSizeTable[textStyle] as! NSDictionary
        
        return UIFontDescriptor(name: preferredFontName as String, size: CGFloat((style[contentSize] as! NSNumber).floatValue))
    }
    
}
