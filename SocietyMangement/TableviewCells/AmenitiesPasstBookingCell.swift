//
//  AmenitiesPasstBookingCell.swift
//  SocietyMangement
//
//  Created by MacMini on 02/10/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class AmenitiesPasstBookingCell: UITableViewCell {
    
    @IBOutlet weak var lblDateTimeBooked: UILabel!
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnEdit: UIButton!

    @IBOutlet weak var lblPaymentPending: UILabel!
    @IBOutlet weak var lblSeprater: UILabel!
    @IBOutlet weak var lblStaticPaymentPending: UILabel!
    @IBOutlet weak var lblDatetimeBlow: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblNameType: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
      
        bgView.layer.cornerRadius = 12
        bgView.clipsToBounds = true
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
