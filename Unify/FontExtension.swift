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
        } else if textStyle == UIFontTextStyleSubheadline {
            preferredFontName = "HelveticaNeue-Medium"
        }
        
        dispatch_once(&Static.onceToken) {
            Static.fontSizeTable = [
                UIFontTextStyleHeadline: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 24,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 23,
                    UIContentSizeCategoryAccessibilityExtraLarge: 22,
                    UIContentSizeCategoryAccessibilityLarge: 21,
                    UIContentSizeCategoryAccessibilityMedium: 20,
                    UIContentSizeCategoryExtraExtraExtraLarge: 19,
                    UIContentSizeCategoryExtraExtraLarge: 18,
                    UIContentSizeCategoryExtraLarge: 17,
                    UIContentSizeCategoryLarge: 16,
                    UIContentSizeCategoryMedium: 15,
                    UIContentSizeCategorySmall: 14,
                    UIContentSizeCategoryExtraSmall: 13
                ],
                UIFontTextStyleSubheadline: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 23,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 22,
                    UIContentSizeCategoryAccessibilityExtraLarge: 21,
                    UIContentSizeCategoryAccessibilityLarge: 20,
                    UIContentSizeCategoryAccessibilityMedium: 19,
                    UIContentSizeCategoryExtraExtraExtraLarge: 18,
                    UIContentSizeCategoryExtraExtraLarge: 17,
                    UIContentSizeCategoryExtraLarge: 16,
                    UIContentSizeCategoryLarge: 15,
                    UIContentSizeCategoryMedium: 14,
                    UIContentSizeCategorySmall: 13,
                    UIContentSizeCategoryExtraSmall: 12
                ],
                UIFontTextStyleBody: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 23,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 22,
                    UIContentSizeCategoryAccessibilityExtraLarge: 21,
                    UIContentSizeCategoryAccessibilityLarge: 20,
                    UIContentSizeCategoryAccessibilityMedium: 19,
                    UIContentSizeCategoryExtraExtraExtraLarge: 18,
                    UIContentSizeCategoryExtraExtraLarge: 17,
                    UIContentSizeCategoryExtraLarge: 16,
                    UIContentSizeCategoryLarge: 15,
                    UIContentSizeCategoryMedium: 14,
                    UIContentSizeCategorySmall: 13,
                    UIContentSizeCategoryExtraSmall: 12
                ],
                UIFontTextStyleCaption1: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 24,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 23,
                    UIContentSizeCategoryAccessibilityExtraLarge: 22,
                    UIContentSizeCategoryAccessibilityLarge: 21,
                    UIContentSizeCategoryAccessibilityMedium: 20,
                    UIContentSizeCategoryExtraExtraExtraLarge: 20,
                    UIContentSizeCategoryExtraExtraLarge: 19,
                    UIContentSizeCategoryExtraLarge: 18,
                    UIContentSizeCategoryLarge: 17,
                    UIContentSizeCategoryMedium: 16,
                    UIContentSizeCategorySmall: 15,
                    UIContentSizeCategoryExtraSmall: 14
                ],
                UIFontTextStyleCaption2: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 22,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 21,
                    UIContentSizeCategoryAccessibilityExtraLarge: 20,
                    UIContentSizeCategoryAccessibilityLarge: 19,
                    UIContentSizeCategoryAccessibilityMedium: 18,
                    UIContentSizeCategoryExtraExtraExtraLarge: 17,
                    UIContentSizeCategoryExtraExtraLarge: 16,
                    UIContentSizeCategoryExtraLarge: 15,
                    UIContentSizeCategoryLarge: 14,
                    UIContentSizeCategoryMedium: 13,
                    UIContentSizeCategorySmall: 12,
                    UIContentSizeCategoryExtraSmall: 11
                ],
                UIFontTextStyleFootnote: [
                    UIContentSizeCategoryAccessibilityExtraExtraExtraLarge: 17,
                    UIContentSizeCategoryAccessibilityExtraExtraLarge: 16,
                    UIContentSizeCategoryAccessibilityExtraLarge: 15,
                    UIContentSizeCategoryAccessibilityLarge: 15,
                    UIContentSizeCategoryAccessibilityMedium: 14,
                    UIContentSizeCategoryExtraExtraExtraLarge: 14,
                    UIContentSizeCategoryExtraExtraLarge: 13,
                    UIContentSizeCategoryExtraLarge: 13,
                    UIContentSizeCategoryLarge: 12,
                    UIContentSizeCategoryMedium: 12,
                    UIContentSizeCategorySmall: 11,
                    UIContentSizeCategoryExtraSmall: 11
                ],
            ]
        }
        
        let contentSize = UIApplication.sharedApplication().preferredContentSizeCategory
        
        let style = Static.fontSizeTable[textStyle] as! NSDictionary
        
        return UIFontDescriptor(name: preferredFontName as String, size: CGFloat((style[contentSize] as! NSNumber).floatValue))
    }
    
}
