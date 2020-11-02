//
//  NotificationCell.swift
//  SocietyMangement
//
//  Created by MacMini on 15/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var btnCheckUnCheck: UIButton!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblStaticBtn: UILabel!
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        bgView.layer.cornerRadius = 12
        bgView.clipsToBounds = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
