//
//  DomesticHelperAttendanceVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 25/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class DomesticHelperAttendanceVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!

    var strlbl = String()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblName.text = strlbl + "'s Attendance"
    
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionMenu(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
