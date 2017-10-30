//
//  ProjectViewController.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/30/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    
    var parentProject : Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.title = parentProject?.name
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parentProject?.children?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as? ProjectTableViewCell
        cell!.project = self.parentProject?.children?[indexPath.row]
        return cell!
        
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
