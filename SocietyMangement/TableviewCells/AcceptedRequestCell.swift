//
//  AcceptedRequestCell.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 20/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class AcceptedRequestCell: UITableViewCell {
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblguest: UILabel!
    @IBOutlet weak var lblintime: UILabel!
    @IBOutlet weak var lblouttime: UILabel!
    @IBOutlet weak var imgout: UIImageView!
    @IBOutlet weak var lblapprovedby: UILabel!
  //  @IBOutlet weak var btncall: RSImageViewCustomisation!
    
    @IBOutlet weak var btncall: UIButton!
    @IBOutlet weak var imgviewCompanyLogo: UIImageView!

    @IBOutlet weak var lbladdedby: UILabel!
    @IBOutlet weak var imgaprroved: UIImageView!
    @IBOutlet weak var hightlblout: NSLayoutConstraint!
    @IBOutlet weak var lblreport: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var btnapproved: RSButtonCustomisation!
    
    @IBOutlet weak var imgview1: UIImageView!
    @IBOutlet weak var imgview2: UIImageView!
    @IBOutlet weak var imgview3: UIImageView!
    @IBOutlet weak var imgview4: UIImageView!
    @IBOutlet weak var imgview5: UIImageView!
    @IBOutlet weak var imgview6: UIImageView!
    @IBOutlet weak var imgview7: UIImageView!
    @IBOutlet weak var imgview8: UIImageView!
    @IBOutlet weak var imgview9: UIImageView!
    @IBOutlet weak var imgview10: UIImageView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnRenew: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var btnWrong_Entry: UIButton!
    @IBOutlet weak var btnNote_Guard: UIButton!
    @IBOutlet weak var btnOut: UIButton!

    @IBOutlet weak var btnDeliveryInfo: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
