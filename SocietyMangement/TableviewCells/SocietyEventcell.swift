//
//  SocietyEventcell.swift
//  SocietyMangement
//
//  Created by MacMini on 30/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class SocietyEventcell: UITableViewCell {
    
    @IBOutlet weak var btndownload: UIButton!
    @IBOutlet weak var btnNotification: UIButton!
    
    @IBOutlet weak var innerview: UIView!
    @IBOutlet weak var btnDownloadEvent: UIButton!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var btnreadmore: UIButton!
    
    @IBOutlet weak var lbldes: UILabel!
    
    @IBOutlet weak var lblstartdate: UILabel!
    
    @IBOutlet weak var lblenddate: UILabel!
    
    @IBOutlet weak var btnedit: UIButton!
    
    @IBOutlet weak var btndelete: UIButton!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var lblflatno: UILabel!
    
    @IBOutlet weak var lblflattype: UILabel!
    
    @IBOutlet weak var lblcolor: UILabel!

    @IBOutlet weak var imgview: UIImageView!
    
    
    @IBOutlet weak var btnEditNew: UIButton!
    
    @IBOutlet weak var btnDeleteNew: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

               btnDownloadEvent.layer.cornerRadius = btnDownloadEvent.frame.size.height/2
               btnDownloadEvent.clipsToBounds = true
    }

}
