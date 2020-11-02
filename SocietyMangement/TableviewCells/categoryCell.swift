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
    
    @IBOutlet weak var viewBG: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgProduct.layer.cornerRadius = imgProduct.frame.size.height/2
        imgProduct.clipsToBounds = true
        
        
        
      //  viewBG.layer.cornerRadius = 5
        viewBG.clipsToBounds = true
        
        self.viewBG.layer.masksToBounds = false
        self.viewBG.layer.shadowColor = UIColor.lightGray.cgColor
        // *** *** Use following to add Shadow top, left ***
        //self.containerView.layer.shadowOffset = CGSizeMake(-5.0f, -5.0f);
        
        // *** Use following to add Shadow bottom, right ***
        //self.avatarImageView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
        
        // *** Use following to add Shadow top, left, bottom, right ***
        viewBG.layer.shadowOffset = .zero
        viewBG.layer.shadowRadius = 2.0
        // *** Set shadowOpacity to full (1) ***
        self.viewBG.layer.shadowOpacity = 1.0
        
        
    }

}
