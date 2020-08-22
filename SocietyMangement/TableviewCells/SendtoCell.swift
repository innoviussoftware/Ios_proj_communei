//
//  SendtoCell.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class SendtoCell: UITableViewCell {

    @IBOutlet weak var cb: Checkbox!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
