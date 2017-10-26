//
//  UserViewController.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/25/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit
import Alamofire

class UserViewController: UIViewController {

    var user : User?
    
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage.layer.cornerRadius = (userImage.frame.size.height)/2
        userImage.clipsToBounds = true
        self.getImage()
            
        }
        // Do any additional setup after loading the view.

    func getImage(){
//        if let imURL = URL(self.user!.image!){
//            if let data = try? Data(
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
