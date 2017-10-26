//
//  User.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/25/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Skill {
    var name : String?
    var level : Float?
}

struct Project {
    var id : Int?
    var mark : Int?
    var validated : Bool?
    var children : [Project]?
}

struct Achievement {
    var name : String?
    var descricptio : String?
    var image : String?
}

class User: NSObject {
    var firstName : String?
    var lastName : String?
    var login : String?
    var correctionPoint : Int?
    var phone : String?
    var level : Float?
    var email : String?
    var grade : String?
    var image : String?
    var wallet : Int?
    var isStaff : Bool = false
    
    var skills : [Skill]?
    var projects : [Project]?
    var achievements : [Achievement]?
    
    init(info : JSON) {
        self.firstName = info["first_name"].string
        self.lastName = info["last_name"].string
        self.login = info["login"].string
        self.correctionPoint = info["correction_point"].int
        self.phone = info["phone"].string
        self.email = info["email"].string
        self.image = info["image_url"].string
        self.wallet = info["wallet"].int
        if (info["staff?"].boolValue){self.isStaff = true}
        if let cursus = info["cursus_users"].array{
            for cur in cursus{
                if cur["cursus_id"].int == 1{
                    self.grade = cur["grade"].string
                    self.level = cur["level"].float
                }
            }
        }
    }
    
    override var description: String{
        return  "name : \(String(describing: self.firstName ?? "no name")) \(String(describing: self.lastName ?? "no name")) \n" +
                "level : \(String(describing: self.level ?? 0.0)) grade : \(String(describing: self.grade ?? "no grade")) \n"
    }
    

}
