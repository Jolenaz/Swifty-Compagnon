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
    var name : String?
    var slug : String?
    var mark : Int?
    var status : String?
    var validated : Bool?
    var hasChildren : Bool?
    var children : [Project]?
}

struct Achievement {
    var name : String?
    var descricption : String?
    
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
    
    var skills : [Skill] = []
    var projects : [Project] = []
    var achievements : [Achievement] = []
    var tmpProj : [Int:[Project]] = [:]
    
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
                    if let skills = cur["skills"].array{
                        for skill in skills{
                            let newSkill = Skill(name: skill["name"].string, level: skill["level"].float)
                            self.skills.append(newSkill)
                        }
                    }
                }else{
                    self.grade = "no grade"
                    self.level = 0
                }
            }
        }
        if let achievements = info["achievements"].array{
            for ach in achievements{
                let newAch = Achievement(name: ach["name"].string, descricption: ach["description"].string)
                self.achievements.append(newAch)
            }
            
        }
        if let projects = info["projects_users"].array{
            for proj in projects{
                if let cId = proj["cursus_ids"].array{
                    if cId[0] != 1{
                        continue
                    }
                }
                if let pInfo = proj["project"].dictionary{
                    let newProj = Project(id: pInfo["id"]?.int, name: pInfo["name"]?.string, slug: pInfo["slug"]?.string, mark: proj["final_mark"].int, status: proj["status"].string, validated: proj["validated?"].bool, hasChildren: false, children: nil)
                    if let parent = pInfo["parent_id"]?.int{
                        if (tmpProj[parent] == nil){
                            tmpProj[parent] = []
                        }
                        tmpProj[parent]!.append(newProj)
                    }
                    else{
                        self.projects.append(newProj)
                    }
                }
            }
        }
        for (tmpKey,tmpValue) in tmpProj{
            for index in 0...(projects.count - 1){
                if projects[index].id == tmpKey{
                    projects[index].children = tmpValue
                    projects[index].hasChildren = true
                }
            }
        }
    }
    
    override var description: String{
        return  "name : \(String(describing: self.firstName ?? "no name")) \(String(describing: self.lastName ?? "no name")) \n" +
                "level : \(String(describing: self.level ?? 0.0)) grade : \(String(describing: self.grade ?? "no grade")) \n"
    }
    

}
