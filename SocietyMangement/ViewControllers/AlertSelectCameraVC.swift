//
//  AlertSelectCameraVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 14/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class AlertSelectCameraVC: UIViewController {

   // var yesActCamera:(()->())?
    
   // var yesActGallery:(()->())?

   // var noAct:(()->())?
    
    var yesActCamera  = {}
    var yesActGallery = {}
    var noAct  = {}


    var isfrom = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        print("AlertSelectCameraVC")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnOpenCameraClicked(_ sender: UIButton) {
        yesActCamera()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnOpenGalleryClicked(_ sender: UIButton) {
        yesActGallery()
        self.dismiss(animated: true)
    }
    
    @IBAction func btnCloseClicked(_ sender: UIButton) {
        noAct()
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
