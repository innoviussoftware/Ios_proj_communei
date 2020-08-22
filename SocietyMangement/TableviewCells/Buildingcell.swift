//
//  Buildingcell.swift
//  SocietyMangement
//
//  Created by MacMini on 23/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class Buildingcell: UICollectionViewCell {
    
    @IBOutlet weak var lblBadgeCount: UILabel?
    @IBOutlet weak var lblStaticBorder: UILabel!
    @IBOutlet weak var lblline: UILabel!
    @IBOutlet weak var btncll: UIButton!
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var innerview: UIView!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnedit: UIButton!
    
    @IBOutlet weak var btndelete: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblBadgeCount?.layer.cornerRadius = (lblBadgeCount?.frame.size.height)!/2
        lblBadgeCount?.clipsToBounds = true
       
    }
    
    
    
}
