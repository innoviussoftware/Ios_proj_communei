//
//  FamilyCell.swift
//  SocietyMangement
//
//  Created by Innovius on 17/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class FrequentCell: UICollectionViewCell {

    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblMobilenumber: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var innerview: UIView!


    @IBOutlet weak var widthedit: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

class FamilyCell: UICollectionViewCell {
    
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblMobilenumber: UILabel!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    @IBOutlet weak var lblline: UILabel!

    @IBOutlet weak var lblline1: UILabel!
    @IBOutlet weak var lblline2: UILabel!
    
    @IBOutlet weak var vwCall: UIView!

    @IBOutlet weak var vwEdit: UIView!
    @IBOutlet weak var vwDelete: UIView!


    @IBOutlet weak var widthedit: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
