//
//  DomesticHelpCell.swift
//  SocietyMangement
//
//  Created by Innovius on 29/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class DomesticHelpCell: UITableViewCell {

    @IBOutlet weak var lblRatingNumber: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        
        
        imgUser.layer.cornerRadius = imgUser.frame.size.height/2
        imgUser.clipsToBounds  = true
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
