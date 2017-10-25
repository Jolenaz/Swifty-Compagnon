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
    
    var token : String = "2b549bdcdeab4691e45bee58ed177c0dc60d83523a4e9f93f287ce57590eea9e"
    var jsonResponse : JSON?{
        didSet{
            print ("get Token")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getToken()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
                self.jsonResponse = JSON(value)
            case .failure(let error):
                print (error)
            }
            
        }
        
    }
    @IBOutlet weak var inputField: UITextField!

    @IBAction func submitButton(_ sender: UIButton) {
        let pa = "Bearer \(self.token)"
        print (pa)
        let headers : HTTPHeaders = [
            "Authorization" : pa
        ]
        
        Alamofire.request("https://api.intra.42.fr/v2/users/\(self.inputField.text!)" , method: .get, headers : headers).responseJSON{
            response in
            switch response.result{
            case .success(let value):
                let info = JSON(value)
                print ("Success : ")
                print (info)
            case .failure(let error):
                print ("Error : ")
                print (error)
            }
            
        }
    
    }

}


























