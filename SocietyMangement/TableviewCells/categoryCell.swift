//
//  categoryCell.swift
//  SocietyMangement
//
//  Created by Innovius on 03/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell {
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblCategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProduct.layer.cornerRadius = imgProduct.frame.size.height/2
        imgProduct.clipsToBounds = true
       
    }

}
