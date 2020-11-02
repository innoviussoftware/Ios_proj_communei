//
//  PollListCell.swift
//  SocietyMangement
//
//  Created by MacMini on 22/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class PollListCell: UITableViewCell {
    
    @IBOutlet weak var lblExpireDate: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBg.layer.cornerRadius = 12
        viewBg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
