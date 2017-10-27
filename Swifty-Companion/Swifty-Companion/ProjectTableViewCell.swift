//
//  ProjectTableViewCell.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/27/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var defaultColor : UIColor? = nil
    
    var project : Project?{
        didSet{
            if self.defaultColor == nil{
                self.defaultColor = self.statusLabel.textColor
            }else{
                self.statusLabel.textColor = self.defaultColor!
            }
            
            titleLabel.text = project!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
