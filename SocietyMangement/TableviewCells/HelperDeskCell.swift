//
//  HelperDeskCell.swift
//  SocietyMangement
//
//  Created by MacMini on 14/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import FloatRatingView

class HelperDeskCell: UICollectionViewCell {
    @IBOutlet weak var imgMaid: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMaidType: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btndelete: UIButton!
    
    @IBOutlet weak var btnNotification: UIButton!
    
    @IBOutlet weak var btnService: UIButton!
    
    @IBOutlet weak var lblService: UILabel!

    @IBOutlet weak var imgService: UIImageView!

    @IBOutlet weak var btnCalenderAttend: UIButton!

    @IBOutlet weak var ratingView: FloatRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
// hhhhhhhhhhh
}
