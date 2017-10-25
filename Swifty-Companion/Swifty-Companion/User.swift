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
        print("Yolo")
    }

}
