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
    class var sharedManager: WebserviceManager {
        struct Singleton {
            static let instance = WebserviceManager()
        }
        
        return Singleton.instance
    }
    
    init() {

    }
    
}