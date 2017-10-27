//
//  AchievementTableViewCell.swift
//  Swifty-Companion
//
//  Created by Jonas BELLESSA on 10/27/17.
//  Copyright © 2017 Jonas BELLESSA. All rights reserved.
//

import UIKit

class AchievementTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var achievement : Achievement?{
        didSet{
            titleLabel.text = achievement!.name
            descriptionLabel.text = achievement!.descricption
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
