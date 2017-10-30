//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/24/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    let uid = "794b712f87193b4a8355cae6f0293b389f05c40cdfbf67405f9a1d1c78208793"
    let secret = "30fb79299c9cac555e28d63b98ca92b7350d9616ca911e910cc68001c2504376"
    
    @IBOutlet var background: UIView!
    
    var token : JSON?
    
    var loading = false
    
    var user : User?{
        didSet{
            performSegue(withIdentifier: "goUserView", sender: "")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goUserView"{
            if  let dest = segue.destination as? UserViewController{
                dest.user = self.user
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToken()
        background.backgroundColor = UIColor(patternImage: UIImage(named : "ecole_42")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loading = false
    }
    
    @IBOutlet weak var inputField: UITextField!

    func getToken(){
        
        let parameters : Parameters = [
            "grant_type" : "client_credentials",
            "client_id" : self.uid,
            "client_secret" : self.secret
        ]
        
        Alamofire.request("https://api.intra.42.fr/oauth/token", method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                self.token = JSON(value)
            case .failure(let error):
                print (error)
            }
            
        }
        
    }
    
    @IBAction func tokenmButton(_ sender: UIButton) {
        if self.token == nil {return}
        if self.isTokenValide() == false {
            token = nil
            getToken()
            return
        }
        let pa = "Bearer \(self.token?["access_token"].string ?? "")"
        let headers : HTTPHeaders = [
            "Authorization" : pa
        ]
        
        Alamofire.request("https://api.intra.42.fr/oauth/token/info" , method: .get, headers : headers).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                let ret = JSON(value)
                let alert = UIAlertController(title: "Token Information", message: ret.description, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .failure(let error):
                print ("Error : ")
                print (error)
            }
        }
    }
    
    func isTokenValide() -> Bool{
        return (7200 - Int(Date().timeIntervalSince1970) + (self.token?["created_at"].int ?? 0) ) > 0
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        if self.token == nil || self.loading{
            return
        }
        if self.isTokenValide() == false {
            token = nil
            getToken()
            return
        }
        self.loading = true
        let pa = "Bearer \(self.token?["access_token"].string ?? "")"
        let headers : HTTPHeaders = [
            "Authorization" : pa
        ]
        
        if self.inputField.text! == "" {self.loading = false;return}
        
        Alamofire.request("https://api.intra.42.fr/v2/users/\(self.inputField.text!)" , method: .get, headers : headers).responseJSON{
            response in
            self.loading = false
            switch response.result{
            case .success(let value):
                let ret = JSON(value)
                if ret.isEmpty {
                    let alert = UIAlertController(title: "Invalid User", message: "This user was not found", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {self.user = User(info: ret)}
            case .failure(_):
                let alert = UIAlertController(title: "Invalid User", message: "This user was not found", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    
    }

}


























