//
//  RecommendationCell.swift
//  SocietyMangement
//
//  Created by Innovius on 03/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class RecommendationCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDiscription: UILabel!
    
    @IBOutlet weak var viewEdit: UIView!
    @IBOutlet weak var ViewDelete: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblSeprater: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 2
        containerView.clipsToBounds = true
        
        self.containerView.layer.masksToBounds = false
        self.containerView.layer.shadowColor = UIColor.lightGray.cgColor
        // *** *** Use following to add Shadow top, left ***
        //self.containerView.layer.shadowOffset = CGSizeMake(-5.0f, -5.0f);
        
        // *** Use following to add Shadow bottom, right ***
        //self.avatarImageView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
        
        // *** Use following to add Shadow top, left, bottom, right ***
         containerView.layer.shadowOffset = .zero
         containerView.layer.shadowRadius = 2.0
        // *** Set shadowOpacity to full (1) ***
        self.containerView.layer.shadowOpacity = 1.0
        
    }

}
