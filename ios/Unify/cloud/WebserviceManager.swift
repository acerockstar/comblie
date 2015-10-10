//
//  WebserviceManager.swift
//  Unify
//
//  Created by Luke McDonald on 6/1/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import Foundation

#if DEBUG

#elseif ADHOC

#else

#endif

class WebserviceManager {
    
    // MARK: Initilization
    static let sharedManager = WebserviceManager()
    
    init() {

    }
    
    // TODO: real data
    func loadFeed(networks: SocialNetwork, success: ([FeedItem])->(), error: (NSError)->()) {
        // Demo data only!!
        
        // TODO: networking, JSON decoding, ...
        // simulate network delay (between 1 and 6 secs)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(UInt64(arc4random_uniform(6) + 1) * NSEC_PER_SEC)), dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            
            if arc4random_uniform(25) == 14 { //unlikely... -> simulate error
                error(NSError(domain: "UnifyFakeErrorDomain", code: 1234, userInfo: [NSLocalizedDescriptionKey : "Demo error, just try again"]))
                return
            }
            else {
                let fakeTexts = ["Lorem Ipsum is simply dummy text of the printing and typesetting industry", "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", "Contrary to popular belief, Lorem Ipsum is not simply random text"]
                let fakeNames = ["Debra D. Wang", "Patricia N. Richmond", "Michael N. White"]
                let fakeDates = [NSDate(timeInterval: 13442, sinceDate: NSDate()), NSDate(timeInterval: 132352, sinceDate: NSDate()), NSDate(timeInterval: 12, sinceDate: NSDate())]
                
                
                // generate fake feed items
                var feedItems = [FeedItem]()
                for i in 0...10 {
                    let item = FeedItem()
                    item.text = fakeTexts.randomItem()
                    item.profileName = fakeNames.randomItem()
                    item.date = fakeDates.randomItem()
                    feedItems.append(item)
                }
                
                success(feedItems)
                return
                
                
            }
            
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}


// MARK: Utilies
extension Array {
    func randomItem() -> T {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
}





class FeedItem : DebugPrintable {
    var profileName: String?
    var text: String?
    var date: NSDate?
    // ...
    
    // subclass this for each network?
    
    
    var debugDescription: String {
        get {
            return "FeedItem<profileName: \(profileName), text: \(text), date: \(date)>"
        }
    }
    
    
}


// NS_OPTIONS in Swift, check out http://stackoverflow.com/questions/24066170/swift-ns-options-style-bitmask-enumerations/24066171#24066171
struct SocialNetwork : RawOptionSetType {
    typealias RawValue = UInt
    private var value: UInt = 0
    init(_ value: UInt) { self.value = value }
    init(rawValue value: UInt) { self.value = value }
    init(nilLiteral: ()) { self.value = 0 }
    static var allZeros: SocialNetwork { return self(0) }
    static func fromMask(raw: UInt) -> SocialNetwork { return self(raw) }
    var rawValue: UInt { return self.value }
    
    static var None: SocialNetwork { return self(0) }
    static var Twitter: SocialNetwork   { return self(1 << 0) }
    static var Instagram: SocialNetwork  { return self(1 << 1) }
    static var Vine: SocialNetwork   { return self(1 << 2) }
    static var Tumblr: SocialNetwork   { return self(1 << 2) }
}