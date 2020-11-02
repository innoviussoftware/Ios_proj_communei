//
//  NotificationsCell.swift
//  SocietyMangement
//
//  Created by prakash soni on 01/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class NotificationsCell: UITableViewCell {
      
    @IBOutlet weak var imgViewNotification: UIImageView!

    @IBOutlet weak var lblTitle: UILabel!

    @IBOutlet weak var lblDate: UILabel!
      
    @IBOutlet weak var lblDiscription: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
