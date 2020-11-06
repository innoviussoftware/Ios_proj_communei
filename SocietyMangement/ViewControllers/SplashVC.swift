//
//  SplashVC.swift
//  SocietyMangement
//
//  Created by MacMini on 29/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
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
