//
//  AlertBottomViewController.swift
//  Chequeit
//
//  Created by INEXTURE on 13/09/19.
//  Copyright © 2019 Govind Ravaliya. All rights reserved.
//

import UIKit

class AlertBottomViewController: UIViewController {

   @IBOutlet var lblTitle: UIButton!
    @IBOutlet var lblSubtitle: UILabel!
    
    @IBOutlet var lblSubtitle_sett: UILabel!

    
    @IBOutlet var stckVw: UIStackView!
    
    @IBOutlet var lblline1: UILabel!
    @IBOutlet var lblline2: UILabel!

    @IBOutlet var btnOk: UIButton!
    
    @IBOutlet var btnCancel: UIButton!

    @IBOutlet var btnYes: UIButton!


    var titleStr = ""
    var subtitleStr = ""
    var yesAct:(()->())?
    var noAct:(()->())?

    var isfrom = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isfrom == 1{
        }else if isfrom == 0
        {
            stckVw.isHidden = true
            lblline1.isHidden = true
            lblline2.isHidden = true
            btnOk.isHidden = false
        }else if isfrom == 2 {
            btnCancel.setTitle("Cancel", for: UIControl.State.normal)
          //  btnYes.setTitle("Call", for: UIControl.State.normal)

        }else if isfrom == 3 {
            btnCancel.setTitle("Cancel", for: UIControl.State.normal)
            btnYes.setTitle("Call", for: UIControl.State.normal)

        }else if isfrom == 4
        {
            lblTitle.setTitleColor(UIColor(red: 69.0/255.0, green: 191.0/255.0, blue: 85.0/255.0, alpha: 1.0), for: UIControl.State.normal)
            stckVw.isHidden = true
            lblline1.isHidden = true
            lblline2.isHidden = true
            btnOk.isHidden = false
        }else if isfrom == 5 {
            lblTitle.setTitleColor(UIColor(red: 246.0/255.0, green: 10.0/255.0, blue: 32.0/255.0, alpha: 1.0), for: UIControl.State.normal)
            lblSubtitle.isHidden = true
            lblSubtitle_sett.isHidden = false
            btnYes.setTitleColor(UIColor(red: 246.0/255.0, green: 10.0/255.0, blue: 32.0/255.0, alpha: 1.0), for: UIControl.State.normal)
            btnCancel.setTitle("Cancel", for: UIControl.State.normal)
        }
        
        
        lblTitle.setTitle(titleStr, for: .normal)

        
       // lblTitle.setTitle(titleStr, for:  UIControl.State.normal)
        
        lblSubtitle.text = subtitleStr
        
//        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
        
//        view.addGestureRecognizer(gesture)
        
    }

    @IBAction func btnNoClicked(_ sender: UIButton) {
        noAct?()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnYesClicked(_ sender: UIButton) {
        yesAct?()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnOkClicked(_ sender: UIButton) {
          yesAct?()
          self.dismiss(animated: true)
      }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer){
        let translation = recognizer.translation(in: self.view)
        let y = self.view.frame.minY
        
        if (y + translation.y) <= 0{
            return
        }
        
        self.view.frame =  CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
        recognizer.setTranslation(.zero, in: self.view)
        
        if recognizer.state == .began {
        } else if recognizer.state == .ended {
            if y > (view.frame.size.height/2){
                
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
                }) { (true) in
                    self.view.removeFromSuperview()
                    self.removeFromParentViewController()
                }
                
            }else{
                
                UIView.animate(withDuration: 0.2) {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                }
            }
        }
    }
    
    
}
