//
//  User.swift
//  Unify
//
//  Created by Annie Cheng on 6/5/15.
//  Copyright (c) 2015 Unify. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject, NSCoding {
    
    static var currentUser: User = User()
    
    var createdAt: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var name: String {
        set(newName) {
            let newName = split(newName) { $0 == " " }
            firstName = newName.first ?? ""
            lastName = newName.count > 1 ? newName.last! : ""
        }
        get {
            return "\(firstName) \(lastName)"
        }
    }
    var email: String = "temp@example.com"
    var id: String = ""
    var socialMediaAccounts : [String] = []
    var locationID: String = ""
    var updatedAt: String!
    
    override init() {}
    
    init(json: JSON) {
        super.init()
        self.createdAt = json["created_at"].stringValue
        self.name = json["name"].stringValue
        self.email = json["email"].stringValue
        self.id = json["id"].stringValue
        self.socialMediaAccounts = json["social_media_accounts"].arrayObject as? [String] ?? []
        self.locationID = json["location_id"].stringValue
        self.updatedAt = json["updated_at"].stringValue
    }
    
    override var description: String {
        return "Name: \(name)| Email: \(email)| ID: \(id) | Social Media: \(socialMediaAccounts)"
    }
    
    // Extend NSCoding
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        createdAt = aDecoder.decodeObjectForKey("created_at") as! String
        name = aDecoder.decodeObjectForKey("name") as! String
        email = aDecoder.decodeObjectForKey("email") as! String
        id = aDecoder.decodeObjectForKey("id") as! String
        socialMediaAccounts = aDecoder.decodeObjectForKey("social_media_accounts") as! [String]
        locationID = aDecoder.decodeObjectForKey("location_id") as! String
        updatedAt = aDecoder.decodeObjectForKey("updated_at") as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(createdAt, forKey: "created_at")
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(socialMediaAccounts, forKey: "social_media_accounts")
        aCoder.encodeObject(locationID, forKey: "location_id")
        aCoder.encodeObject(updatedAt, forKey: "updated_at")
        
    }
    
}
