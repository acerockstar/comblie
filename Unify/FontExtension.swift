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
