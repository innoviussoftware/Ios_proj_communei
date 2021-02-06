//
//  AcceptedRequestCell.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 20/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class AcceptedRequestCell: UITableViewCell {
    
    @IBOutlet  var imgview: UIImageView!
    
    @IBOutlet  var imgviewCompanyLogo: UIImageView!

        
    @IBOutlet  var lblname: UILabel!
    @IBOutlet  var lblguest: UILabel!
    
    @IBOutlet  var lbldateintime: UILabel!
    @IBOutlet  var lbldateintimeMulti: UILabel!  // Extra
    @IBOutlet  var lblintime: UILabel!
    @IBOutlet  var lblouttime: UILabel!
    @IBOutlet  var lbladdedby: UILabel!
    @IBOutlet  var lblparceltime: UILabel!
    @IBOutlet  var lblLeaveatGate: UILabel!
    @IBOutlet  var lblcancelby: UILabel!
    @IBOutlet  var lblWrongEntry: UILabel!

    @IBOutlet  var lblStatus: UILabel!
    
    @IBOutlet  var btnInviteShare: UIButton!
    @IBOutlet  var btncall: UIButton!

    @IBOutlet  var btnExtraShow: UIButton!

    
    @IBOutlet  var imgview1: UIImageView!
    @IBOutlet  var imgview2: UIImageView!
    @IBOutlet  var imgview3: UIImageView!
    @IBOutlet  var imgview4: UIImageView!
    @IBOutlet  var imgview5: UIImageView!
    @IBOutlet  var imgview6: UIImageView!
    @IBOutlet  var imgview7: UIImageView!
    @IBOutlet  var imgview8: UIImageView!
    
    @IBOutlet  var imgviewExtra: UIImageView!

   
    @IBOutlet  var imgviewTop1: NSLayoutConstraint!
    @IBOutlet  var imgviewTop2: NSLayoutConstraint!
    @IBOutlet  var imgviewTop3: NSLayoutConstraint!
    @IBOutlet  var imgviewTop4: NSLayoutConstraint!
    @IBOutlet  var imgviewTop5: NSLayoutConstraint!
    @IBOutlet  var imgviewTop6: NSLayoutConstraint!
    @IBOutlet  var imgviewTop7: NSLayoutConstraint!
    @IBOutlet  var imgviewTop8: NSLayoutConstraint!

    @IBOutlet  var imgviewTopExtra: NSLayoutConstraint!

    @IBOutlet  var stackviewStatus: NSLayoutConstraint!

    
   /* @IBOutlet  var imgviewBottom6: NSLayoutConstraint!
    
    @IBOutlet  var imgviewTop3_1: NSLayoutConstraint!
    @IBOutlet  var imgviewTop6_3: NSLayoutConstraint!
    @IBOutlet  var imgviewTop6_1: NSLayoutConstraint!

    
    @IBOutlet  var imgviewStackTop1: NSLayoutConstraint!
    @IBOutlet  var imgviewStackTop2: NSLayoutConstraint!
    @IBOutlet  var imgviewStackTop3: NSLayoutConstraint!
    @IBOutlet  var imgviewStackTop4: NSLayoutConstraint!
    @IBOutlet  var imgviewStackTop5: NSLayoutConstraint!
    @IBOutlet  var imgviewStackTop6: NSLayoutConstraint!
    @IBOutlet  var imgviewStackTop7: NSLayoutConstraint! */

    
    @IBOutlet  var imgviewHight1: NSLayoutConstraint!
    @IBOutlet  var imgviewHight2: NSLayoutConstraint!
    @IBOutlet  var imgviewHight3: NSLayoutConstraint!
    @IBOutlet  var imgviewHight4: NSLayoutConstraint!
    @IBOutlet  var imgviewHight5: NSLayoutConstraint!
    @IBOutlet  var imgviewHight6: NSLayoutConstraint!
    @IBOutlet  var imgviewHight7: NSLayoutConstraint!
    @IBOutlet  var imgviewHight8: NSLayoutConstraint!

    @IBOutlet  var imgviewHightExtra: NSLayoutConstraint!


    @IBOutlet  var btnCancel: UIButton!
    @IBOutlet  var btnEdit: UIButton!
    @IBOutlet  var btnRenew: UIButton!
    @IBOutlet  var btnClose: UIButton!
    
    @IBOutlet  var btnWrong_Entry: UIButton!
    @IBOutlet  var btnWrong_Entry_Red: UIButton!

    @IBOutlet  var btnNote_Guard: UIButton!
    @IBOutlet  var btnOut: UIButton!
    
    @IBOutlet  var btnAlertInfo: UIButton!
    @IBOutlet  var btnDeliveryInfo: UIButton!

    
    @IBOutlet  var btnIn_OnDemand: UIButton! // Entry
    @IBOutlet  var btnEdit_OnDemand: UIButton!
    @IBOutlet  var btnCancel_OnDemand: UIButton!
    @IBOutlet  var btnOut_OnDemand: UIButton!  // Exit

   // @IBOutlet  var btnIn: UIButton!

    @IBOutlet  var constraintHightStackBtn: NSLayoutConstraint!

    @IBOutlet  var constraintHightStacklbl: NSLayoutConstraint!

    @IBOutlet  var lblHightStacklblMiddle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
