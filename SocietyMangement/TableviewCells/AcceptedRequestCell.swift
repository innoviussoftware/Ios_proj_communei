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
    
    @IBOutlet weak var imgviewCompanyLogo: UIImageView!

        
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblguest: UILabel!
    
    @IBOutlet weak var lbldateintime: UILabel!
    @IBOutlet weak var lbldateintimeMulti: UILabel!  // Extra
    @IBOutlet weak var lblintime: UILabel!
    @IBOutlet weak var lblouttime: UILabel!
    @IBOutlet weak var lbladdedby: UILabel!
    @IBOutlet weak var lblparceltime: UILabel!
    @IBOutlet weak var lblLeaveatGate: UILabel!
    @IBOutlet weak var lblcancelby: UILabel!
    @IBOutlet weak var lblWrongEntry: UILabel!

    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var btnInviteShare: UIButton!
    @IBOutlet weak var btncall: UIButton!

    @IBOutlet weak var btnExtraShow: UIButton!

    
    @IBOutlet weak var imgview1: UIImageView!
    @IBOutlet weak var imgview2: UIImageView!
    @IBOutlet weak var imgview3: UIImageView!
    @IBOutlet weak var imgview4: UIImageView!
    @IBOutlet weak var imgview5: UIImageView!
    @IBOutlet weak var imgview6: UIImageView!
    @IBOutlet weak var imgview7: UIImageView!
    @IBOutlet weak var imgview8: UIImageView!
    
    @IBOutlet weak var imgviewExtra: UIImageView!

   
    
    @IBOutlet weak var imgviewTop1: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop2: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop3: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop4: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop5: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop7: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop8: NSLayoutConstraint!

    @IBOutlet weak var imgviewTopExtra: NSLayoutConstraint!

    @IBOutlet weak var stackviewStatus: NSLayoutConstraint!

    
   /* @IBOutlet weak var imgviewBottom6: NSLayoutConstraint!
    
    @IBOutlet weak var imgviewTop3_1: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6_3: NSLayoutConstraint!
    @IBOutlet weak var imgviewTop6_1: NSLayoutConstraint!

    
    @IBOutlet weak var imgviewStackTop1: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop2: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop3: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop4: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop5: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop6: NSLayoutConstraint!
    @IBOutlet weak var imgviewStackTop7: NSLayoutConstraint! */

    
    @IBOutlet weak var imgviewHight1: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight2: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight3: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight4: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight5: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight6: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight7: NSLayoutConstraint!
    @IBOutlet weak var imgviewHight8: NSLayoutConstraint!

    @IBOutlet weak var imgviewHightExtra: NSLayoutConstraint!


    

    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnRenew: UIButton!
    @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnWrong_Entry: UIButton!
    @IBOutlet weak var btnWrong_Entry_Red: UIButton!

    @IBOutlet weak var btnNote_Guard: UIButton!
    @IBOutlet weak var btnOut: UIButton!
    
    @IBOutlet weak var btnAlertInfo: UIButton!
    @IBOutlet weak var btnDeliveryInfo: UIButton!

    
   // @IBOutlet weak var btnIn: UIButton!

    @IBOutlet weak var btnIn_OnDemand: UIButton! // Entry
    @IBOutlet weak var btnEdit_OnDemand: UIButton!
    @IBOutlet weak var btnCancel_OnDemand: UIButton!
    @IBOutlet weak var btnOut_OnDemand: UIButton!  // Exit


    
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
