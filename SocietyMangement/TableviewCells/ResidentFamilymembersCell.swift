//
//  ResidentFamilymembersCell.swift
//  SocietyMangement
//
//  Created by prakash soni on 08/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class ResidentFamilymembersCell: UITableViewCell {
    
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var imgview: UIImageView!

    @IBOutlet weak var lblname: UILabel!

    @IBOutlet weak var lblmember: UILabel!
        
    @IBOutlet weak var btncll: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
