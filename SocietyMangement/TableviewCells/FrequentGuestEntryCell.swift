//
//  FrequentGuestEntryCell.swift
//  SocietyMangement
//
//  Created by Innovius on 24/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class FrequentGuestEntryCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
