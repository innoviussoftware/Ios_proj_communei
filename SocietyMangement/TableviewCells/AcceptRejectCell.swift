//
//  AcceptRejectCell.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 20/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class AcceptRejectCell: UITableViewCell {

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblguest: UILabel!
    
    @IBOutlet weak var lbldate: UILabel!
    @IBOutlet weak var btnaccept: UIButton!
    @IBOutlet weak var btnreject: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
