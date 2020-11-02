//
//  ReferAFriendVC.swift
//  SocietyMangement
//
//  Created by Innovius on 23/08/1941 Saka.
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
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ReferAFriendVC: BaseVC {
    
    @IBOutlet weak var btnmenu: UIButton!
    @IBOutlet weak var lblprice: UILabel!
    
    @IBAction func NotificationAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        nextViewController.isfrom = 0
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func btnOpenQRCodePressed(_ sender: Any) {
        let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
        vc.isfrom = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            if(revealViewController() != nil)
            {
                btnmenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
        
        lblprice.text = "\u{20B9} 2500"
        // Do any additional setup after loading the view.
    }
    

}
