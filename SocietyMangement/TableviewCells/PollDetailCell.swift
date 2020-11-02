//
//  PollDetailCell.swift
//  SocietyMangement
//
//  Created by MacMini on 23/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class PollDetailCell: UITableViewCell {
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblTopic: UILabel!
    @IBOutlet weak var lblPercentage: UILabel!
    
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
