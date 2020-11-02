//
//  EmergencyRespondPopUpVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 29/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class EmergencyRespondPopUpVC: UIViewController {
    
    @IBOutlet weak var textViewReasion: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewReasion.layer.borderWidth = 1
                       
        textViewReasion.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5
                 
        textViewReasion.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backaction(_ sender: Any) {
          self.navigationController?.popViewController(animated: false)
      }


}
