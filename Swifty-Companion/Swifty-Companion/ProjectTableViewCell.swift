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
    @IBOutlet weak var moreLabel: UILabel!
    
    var defaultColor : UIColor? = nil
    
    var project : Project?{
        didSet{
            moreLabel.isHidden = true
            statusLabel.text = "Label"
            if self.defaultColor == nil{
                self.defaultColor = self.statusLabel.textColor
            }else{
                self.statusLabel.textColor = self.defaultColor!
            }
            
            if (self.project?.hasChildren)!{
                moreLabel.isHidden = false
            }
            
            if (self.project?.validated ?? false){
                statusLabel.text = self.project?.mark?.description
            }else if (self.project?.status == "finished"){
                statusLabel.text = "Failed"
                statusLabel.textColor = UIColor(colorLiteralRed: 0.9, green: 0.1, blue: 0.2, alpha: 1.0)
            }else{
                statusLabel.text = "in progress"
                statusLabel.textColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
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
