//
//  EmergencyNumberCell.swift
//  SocietyMangement
//
//  Created by Macmini on 25/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class EmergencyNumberCell: UITableViewCell {

    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var lblCallNumbber: UILabel!

    @IBOutlet weak var btnCall: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
