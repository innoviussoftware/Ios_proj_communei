//
//  InvitationPopUpVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 18/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController



class InvitationPopUpVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!

    @IBOutlet weak var lblfullpath: UILabel!

    @IBOutlet weak var lblCodeNumber: UILabel!
    
    @IBOutlet weak var viewinner: UIView!
    
    @IBOutlet weak var imgViewCard: UIImageView!

    var getImage = UIImage()

    var strNamecard = ""
    
    var isfrom = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        imgViewCard.sd_setImage(with: URL(string: strNamecard), placeholderImage: UIImage(named: ""))

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnclosePressed(_ sender: Any) {
        
       /* let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
        
        self.revealViewController()?.pushFrontViewController(nextViewController, animated: true)
        
        self.navigationController?.pushViewController(nextViewController, animated: true) */
        
        if isfrom == 1 {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                       
            let navigationController:UINavigationController = storyBoard.instantiateInitialViewController() as! UINavigationController
                                                          
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                                          
            navigationController.pushViewController(nextViewController, animated: true)
                                                          
            self.appDelegate.window?.rootViewController = navigationController
            
            self.appDelegate.window?.makeKeyAndVisible()
                           
        }else{
            removeAnimate()
        }

        
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
                               
        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                               
        let initialViewController = storyboard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
        
        self.revealViewController()?.pushFrontViewController(initialViewController, animated: true)
        
        navigationController.pushViewController(initialViewController, animated: true)
                               
        self.appDelegate.window?.rootViewController = navigationController
                               
        self.appDelegate.window?.makeKeyAndVisible() */
    }
    
  /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
    } */
    
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

    //Mark:- action method
    
    @IBAction func actionShare(_ sender: UIButton) {

       // let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: [strNamecard], applicationActivities: nil)
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: [imgViewCard.image!], applicationActivities: nil)

       // activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.copyToPasteboard, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
        
        print("actionShare")

    }
  

}
