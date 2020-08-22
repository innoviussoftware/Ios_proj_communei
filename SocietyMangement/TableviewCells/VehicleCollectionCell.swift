//
//  VehicleCollectionCell.swift
//  SocietyMangement
//
//  Created by Innovius on 18/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class VehicleCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imgVehicle: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblVehicleType: UILabel!
    @IBOutlet weak var lblVehicleNumber: UILabel!
    
    @IBOutlet weak var btndelete: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 10
        bgView.clipsToBounds = true
    }

}
