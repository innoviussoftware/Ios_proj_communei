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
    @IBOutlet weak var lblapproved: UILabel!
    @IBOutlet weak var btncall: RSImageViewCustomisation!
    
    @IBOutlet weak var lblapprovedby: UILabel!
    @IBOutlet weak var imgaprroved: UIImageView!
    @IBOutlet weak var hightlblout: NSLayoutConstraint!
    @IBOutlet weak var lblreport: UILabel!
    
    @IBOutlet weak var btnapproved: RSButtonCustomisation!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
