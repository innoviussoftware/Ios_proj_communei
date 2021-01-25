//
//  InvitationPopUpVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 18/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class InvitationPopUpVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var lblfullpath: UILabel!

    @IBOutlet weak var lblCodeNumber: UILabel!
    
    @IBOutlet weak var imgViewCard: UIImageView!

    var getImage = UIImage()

    var strNamecard = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        imgViewCard.sd_setImage(with: URL(string: strNamecard), placeholderImage: UIImage(named: ""))

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnclosePressed(_ sender: Any) {
        
       /* let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
        
        self.revealViewController()?.pushFrontViewController(nextViewController, animated: true)
        
        self.navigationController?.pushViewController(nextViewController, animated: true) */

        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                   
        let navigationController:UINavigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
                                                      
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                                      
        navigationController.pushViewController(nextViewController, animated: true)
                                                      
        self.appDelegate.window?.rootViewController = navigationController
        
        self.appDelegate.window?.makeKeyAndVisible()
                       
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
                               
        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                               
        let initialViewController = storyboard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
        
        self.revealViewController()?.pushFrontViewController(initialViewController, animated: true)
        
        navigationController.pushViewController(initialViewController, animated: true)
                               
        self.appDelegate.window?.rootViewController = navigationController
                               
        self.appDelegate.window?.makeKeyAndVisible() */
    }

    //Mark:- action method
    
    @IBAction func actionShare(_ sender: Any) {
        print("actionShare")

    }
  

}
