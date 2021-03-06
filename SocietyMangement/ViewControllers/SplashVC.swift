//
//  SplashVC.swift
//  SocietyMangement
//
//  Created by MacMini on 29/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController


class SplashVC: UIViewController {
    
    
    var poseDuration: Double = 5.00
    var timer = Timer()
    var currentPoseIndex = 0.0
    
    @IBOutlet weak var progressbar: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        progressbar.progress = 0.0
        
        progressbar.transform = progressbar.transform.scaledBy(x: 1, y: 3)
        
        timer = Timer.scheduledTimer(timeInterval:1.4, target: self, selector:#selector(getnextdata), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
    }
 
    
    @objc func AcceptRequest(notification: NSNotification) {
        
        let object = notification.object as! NSDictionary
        
        if let key = object.object(forKey: "notification_type")
        {
            let value = object.value(forKey: "notification_type") as! String
            
            if(value == "security")
            {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GuestPopVC") as! GuestPopVC
                nextViewController.guestdic = object
                nextViewController.isfromnotification = 0
                navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            else  if object.value(forKey: "notification_type") as! String == "alert"{
                       
              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryWaitingPopupVC") as! DeliveryWaitingPopupVC
                
                nextViewController.deliverydic = object

                          //  nextViewController.isFrormDashboard = 0
                            navigationController?.pushViewController(nextViewController, animated: true)
                       
                       
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
                
                
                
                
            else
            {
              //  apicallNotificationCount()
                
            }
            
        }
        
    }
    
    @objc func getnextdata()
    {
        
        currentPoseIndex = currentPoseIndex + 0.2
        progressbar.setProgress(Float(currentPoseIndex), animated: true)
        
        if(currentPoseIndex == 1)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                
                if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
                {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                    
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                    
                }else
                {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                    nextViewController.isfrom = 1
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    
                }
            })
         
            
        }
    }
    
    
}
