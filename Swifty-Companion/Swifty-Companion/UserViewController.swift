//
//  UserViewController.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/25/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import Alamofire

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user : User?
    
    @IBOutlet weak var skillTableView: UITableView!
    @IBOutlet weak var achievementTableView: UITableView!
    @IBOutlet weak var projectTableView: UITableView!

    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var backGround: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = (userImage.frame.size.width)/2
        userImage.clipsToBounds = true
        self.getImage()
    
        backGround.backgroundColor = UIColor(patternImage: UIImage(named: "background_login")!)

        skillTableView.delegate = self
        skillTableView.dataSource = self
        projectTableView.delegate = self
        projectTableView.dataSource = self
        achievementTableView.delegate = self
        achievementTableView.dataSource = self
        achievementTableView.estimatedRowHeight = 110
        achievementTableView.rowHeight = UITableViewAutomaticDimension
        
        printInfo()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == skillTableView{
            return self.user!.skills.count
        }
        if tableView == achievementTableView{
            return self.user!.achievements.count
        }
        if tableView == projectTableView{
            return self.user!.projects.count
        }
        return 1
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        skillTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == skillTableView{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as? skillTableViewCell{
                cell.skill = self.user!.skills[indexPath.row]
                return cell
            }
        }
        if tableView == achievementTableView{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "achievementCell") as? AchievementTableViewCell{
                cell.achievement = self.user!.achievements[indexPath.row]
                return cell
            }
            
        }
        if tableView == projectTableView{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as? ProjectTableViewCell{
                cell.project = self.user!.projects[indexPath.row]
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSubProject"{
            if let dest =  segue.destination as? ProjectViewController{
                dest.parentProject = sender as? Project
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == projectTableView{
            if self.user!.projects[indexPath.row].hasChildren ?? false{
                performSegue(withIdentifier: "goSubProject", sender: self.user!.projects[indexPath.row])
            }
        }
    }
    
    func printInfo(){
        levelLabel.text = "level : \(self.user!.level ?? 0.0) grade : \(self.user!.grade ?? "no One")"
        let levelBAr = UIView(frame: CGRect( x : 0 , y : 0, width :  CGFloat(self.user!.level! - floor(self.user!.level!)) * levelView.frame.width, height : 40))
        levelBAr.backgroundColor = UIColor(colorLiteralRed: 1.0/255, green: 185.0/255, blue: 188.0/255, alpha: 1)
        levelView.addSubview(levelBAr)
        levelView.bringSubview(toFront: levelLabel)
        nameLabel.text = "\(self.user!.firstName ?? "prenom") \(self.user!.lastName ?? "nom") "
        loginLabel.text = "\(self.user!.login ?? "login")"
        emailLabel.text = "\(self.user!.email ?? "email")"
        phoneLabel.text = "\(self.user!.phone ?? "phone")"
        walletLabel.text = "Wallet : \(self.user!.wallet ?? 0)"
        correctionLabel.text = "Correction Points : \(self.user!.correctionPoint ?? 0)"
    }
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var levelView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionLabel: UILabel!
    
    func getImage(){
        if let url = URL(string: self.user!.image!){
            if let donnee = try? Data(contentsOf: url){
                self.userImage.image = UIImage(data: donnee)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
