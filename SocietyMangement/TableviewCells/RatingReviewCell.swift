//
//  RatingReviewCell.swift
//  SocietyMangement
//
//  Created by Innovius on 30/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import FloatRatingView

class RatingReviewCell: UITableViewCell {
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var ratingViews: FloatRatingView!
    @IBOutlet weak var imgStart1: UIImageView!
    @IBOutlet weak var imgStart2: UIImageView!
    @IBOutlet weak var imgStart3: UIImageView!
    @IBOutlet weak var imgStart4: UIImageView!
    @IBOutlet weak var imgStart5: UIImageView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFirstLetter: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblFirstLetter.layer.cornerRadius =  lblFirstLetter.frame.size.height/2
        lblFirstLetter.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
