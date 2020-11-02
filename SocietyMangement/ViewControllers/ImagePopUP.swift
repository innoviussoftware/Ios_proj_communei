//
//  ImagePopUP.swift
//  SocietyMangement
//
//  Created by Innovius on 23/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
class ImagePopUP: UIViewController {

    @IBOutlet weak var imgview: UIImageView!
    @IBAction func closerecord(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3, animations: {
                           self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
                       }) { (true) in
                           self.view.removeFromSuperview()
                           self.removeFromParentViewController()
                       }
        
    }
    
    
    var imgurl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(self.panGesture))
              view.addGestureRecognizer(gesture)
        
        imgview.sd_setImage(with: URL(string:imgurl), placeholderImage: UIImage(named: "vendor-1"))

        // Do any additional setup after loading the view.
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
