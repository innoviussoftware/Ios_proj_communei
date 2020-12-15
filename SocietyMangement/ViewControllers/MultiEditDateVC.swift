//
//  MultiEditDateVC.swift
//  SocietyMangement
//
//  Created by Macmini on 15/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

protocol addMultiDate {
    func addedMultiDate()
}

class MultiEditDateVC: UIViewController , UITextFieldDelegate {

    var delegate : addMultiDate?

    
    @IBOutlet weak var viewinner: UIView!

    @IBOutlet weak var txtdate: UITextField!
    
    @IBOutlet weak var txttime: UITextField!
    
    @IBOutlet weak var txtvaildtill: UITextField!

    var VisitFlatPreApprovalID:Int?
    var UserActivityID:Int?
    var VisitorEntryTypeID:Int?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                
            }
        });
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
    }
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {

        removeAnimate()
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {

        removeAnimate()
    }

    func setborders(textfield:UITextField)
      {
          
         // textfield.layer.borderColor =  AppColor.appcolor.cgColor
           textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
          
          textfield.layer.borderWidth = 1.0
          
      }

}
