//
//  CircularNewCell.swift
//  SocietyMangement
//
//  Created by Innovius on 26/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class CircularNewCell: UITableViewCell {
    @IBOutlet weak var btnNotification: UIButton!
    
    @IBOutlet weak var lblcolor: UILabel!
    
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnReadMore: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        btnDownload.layer.cornerRadius = btnDownload.frame.size.height/2
        btnDownload.clipsToBounds = true
        
    }
    
}
