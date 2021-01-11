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
    
    @IBOutlet weak var lblLeaveatGate: UILabel!
    
    @IBOutlet weak var lblWrongEntry: UILabel!


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
    
    
    @IBOutlet weak var imgviewTop1: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop2: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop3_1: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop4: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop5: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6_3: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6_1: NSLayoutConstraint!

    @IBOutlet weak var imgviewBottom6: NSLayoutConstraint!

    
    @IBOutlet weak var imgviewStackTop1: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop2: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop3: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop4: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop5: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop6: NSLayoutConstraint!

    
    @IBOutlet weak var imgviewHight1: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight2: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight3: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight4: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight5: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight6: NSLayoutConstraint!

    /*
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
     */

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnRenew: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnWrong_Entry: UIButton!
    @IBOutlet weak var btnWrong_Entry_Red: UIButton!

    @IBOutlet weak var btnNote_Guard: UIButton!
    
    @IBOutlet weak var btnOut: UIButton!
    
   // @IBOutlet weak var btnIn: UIButton!

    @IBOutlet weak var btnIn_OnDemand: UIButton! // Entry

    @IBOutlet weak var btnEdit_OnDemand: UIButton!
    @IBOutlet weak var btnCancel_OnDemand: UIButton!
    @IBOutlet weak var btnOut_OnDemand: UIButton!  // Exit


    @IBOutlet weak var btnDeliveryInfo: UIButton!

    @IBOutlet weak var btnAlertInfo: UIButton!
    
    @IBOutlet weak var constraintHightStackBtn: NSLayoutConstraint!

    @IBOutlet weak var constraintHightStacklbl: NSLayoutConstraint!

    @IBOutlet weak var lblHightStacklblMiddle: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
