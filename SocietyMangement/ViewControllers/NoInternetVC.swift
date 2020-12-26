//
//  NoInternetVC.swift
//  SocietyMangement
//
//  Created by Innovius on 09/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
var isNointernetVCShown = false

class NoInternetVC: UIViewController {

    var TryAgian:(()->())?

    @IBOutlet weak var btntragain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }

        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
           view.addGestureRecognizer(gesture)
        btntragain.layer.borderWidth = 1.0
      //  btntragain.layer.borderColor = AppColor.appcolor.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func TryAgainAction(_ sender: Any) {
        TryAgian?()
        
        UIView.animate(withDuration: 0.3, animations: {
                  self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
              }) { (true) in
                  ConnectionManager.sharedInstance.removeObserving()
                  ConnectionManager.sharedInstance.observeReachability()
                  isNointernetVCShown = false
                  self.view.removeFromSuperview()
                self.removeFromParentViewController()
              }
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
                      ConnectionManager.sharedInstance.removeObserving()
                      ConnectionManager.sharedInstance.observeReachability()
                      isNointernetVCShown = false
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
