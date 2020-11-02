//
//  MembersCell.swift
//  SocietyMangement
//
//  Created by prakash soni on 02/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class MembersCell: UITableViewCell {
    
    @IBOutlet weak var innerview: UIView!

    @IBOutlet weak var imgMember: UIImageView!

       @IBOutlet weak var lblStatic: UILabel!
       @IBOutlet weak var btnCall: UIButton!
       @IBOutlet weak var lblprofession: UILabel!
       @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblBloodGroup: UILabel!
    
    @IBOutlet weak var lblBloodGroupName: UILabel!

    
    @IBOutlet weak var lblSelfs: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
