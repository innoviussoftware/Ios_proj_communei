//
//  AmenitiesFacilitiesCell.swift
//  SocietyMangement
//
//  Created by MacMini on 02/10/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class AmenitiesFacilitiesCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var btnViewAll: UIButton!
    @IBOutlet weak var lblNameType: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var imgService: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        bgView.layer.cornerRadius = 12
        bgView.clipsToBounds = true
        
        btnViewAll.layer.cornerRadius = 8
        btnViewAll.clipsToBounds = true
        
        imgService.layer.cornerRadius = 45
        imgService.clipsToBounds  = true
               
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
