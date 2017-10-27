//
//  skillTableViewCell.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/27/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class skillTableViewCell: UITableViewCell {

    @IBOutlet weak var skillLevel: UIView!
    
    @IBOutlet weak var skillLabel: UILabel!
    
    var levelBar : UIView?
        
    
    var width : CGFloat?
    
    var skill : Skill?{
        didSet{
            skillLabel.text = skill!.name
            if levelBar != nil{
                levelBar?.removeFromSuperview()
            }
            let wid = floor(CGFloat((skill?.level)! / 20.0) * skillLevel.frame.width)
            
            levelBar = UIView(frame: CGRect(x : 8,
                                            y : 8,
                                            width : wid,
                                            height : skillLevel.frame.height * 0.8))
            levelBar?.backgroundColor = UIColor(colorLiteralRed: 1.0/255,
                                                green: 185.0/255,
                                                blue: 187.0/255,
                                                alpha: 1)
            skillLevel.addSubview(levelBar!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
