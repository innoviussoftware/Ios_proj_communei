//
//  GuestListCell.swift
//  SocietyMangement
//
//  Created by Innovius on 09/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class GuestListCell: UITableViewCell {
    @IBOutlet weak var btnOut: UIButton!
    
    @IBOutlet weak var AcceptView: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var btnWaiting: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblGuestWaiting: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var viewDecline: UIView!
    
    @IBOutlet weak var lblStack: UILabel!
    @IBOutlet weak var btnGuestWaitingIcon: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    
    
    @IBOutlet weak var lblINTIme: UILabel!
    
    @IBOutlet weak var lblOutTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
