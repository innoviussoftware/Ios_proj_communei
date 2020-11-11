//
//  SidemenuCell.swift
//  SocietyMangement
//
//  Created by MacMini on 30/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class SidemenuCell: UITableViewCell {

    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imagview: UIImageView!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var lblTC: UILabel!

    @IBOutlet weak var lblPrivacyPolicy: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
