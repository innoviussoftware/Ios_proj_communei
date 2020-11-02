

/*import UIKit

class BuycategoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
} */




//
//  DomesticHelpCell.swift
//  SocietyMangement
//
//  Created by Innovius on 29/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class BuycategoryCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imgProduct: UIImageView!

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblQuality: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var stkviw: UIStackView!

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        
       // imgProduct.layer.cornerRadius = imgProduct.frame.size.height/2
       // imgProduct.clipsToBounds  = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
