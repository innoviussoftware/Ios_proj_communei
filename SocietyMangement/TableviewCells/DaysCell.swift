//
//  DaysCell.swift
//  SocietyMangement
//
//  Created by Innovius on 05/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class DaysCell: UICollectionViewCell {
    @IBOutlet weak var lblDaysName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       lblDaysName.layer.cornerRadius = 12
       lblDaysName.clipsToBounds = true
        
        lblDaysName.layer.borderWidth = 2
        lblDaysName.layer.borderColor = UIColor.lightGray.cgColor
    }

}
