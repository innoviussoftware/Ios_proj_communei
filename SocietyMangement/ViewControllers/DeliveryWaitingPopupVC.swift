//
//  DeliveryWaitingPopupVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 01/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class DeliveryWaitingPopupVC: UIViewController {
    
    var deliverydic = NSDictionary()

    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lbldescription: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()

        lblname.text = deliverydic.value(forKey:"Name") as? String

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector:  #selector(DeliveryWaiting), name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
         
     }
    
     override func viewWillDisappear(_ animated: Bool) {
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
         
     }
    
    @objc func DeliveryWaiting(notification: NSNotification)
    {
        let object = notification.object as! NSDictionary
        
        if let key = object.object(forKey: "notification_type")
        {
            let value = object.value(forKey: "notification_type") as! String
            
            if(value == "alert")
            {
                lblname.text = deliverydic.value(forKey:"Name") as? String

            }
        }
        
        else  if object.value(forKey: "notification_type") as! String == "Notice"{
                               
                      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                    
                                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                                    nextViewController.isFrormDashboard = 0
                                    navigationController?.pushViewController(nextViewController, animated: true)
                               
                               
                           }else if object.value(forKey: "notification_type") as! String == "Circular"{
                               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                                                    nextViewController.isfrom = 0
                                                                    navigationController?.pushViewController(nextViewController, animated: true)
                      
                               
                               
                           }else if object.value(forKey: "notification_type") as! String == "Event"{
                               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                      let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                                                                                 nextViewController.isfrom = 1
                                                                                 navigationController?.pushViewController(nextViewController, animated: true)
                      
                          
                               
                           }
        
        
    }
    
    
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
                           self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
                       }) { (true) in
                           self.view.removeFromSuperview()
                           self.removeFromParentViewController()
                       }
        
        
    }
}
