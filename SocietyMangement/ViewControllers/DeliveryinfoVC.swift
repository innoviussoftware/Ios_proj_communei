//
//  DeliveryinfoVC.swift
//  SocietyMangement
//
//  Created by Macmini on 29/01/21.
//  Copyright © 2021 MacMini. All rights reserved.
//

import UIKit

class DeliveryinfoVC: UIViewController {

    
    @IBOutlet weak var viewinner: UIView!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAllowed: UILabel!
    @IBOutlet weak var lbltime: UILabel!
   // @IBOutlet weak var lblMessage: UILabel!
    
    @IBOutlet weak var imgviewLogo: UIImageView!


    var strName = ""
    var strAllowed = ""
    var strTime = ""
    var strMessage = ""
    var strPhone = ""

    
    var getImage = "" //UIImage()


    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        
        lblName.text = strName
        lblAllowed.text = strAllowed
        lbltime.text = strTime
      //  lblMessage.text = strMessage
        
        if getImage == "" {
        }else{
            imgviewLogo.sd_setImage(with: URL(string: getImage), placeholderImage: UIImage(named: ""))
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func callmember(_ sender:UIButton)
    {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
        avc?.subtitleStr = "Are you sure you want to call: \("")"
        avc?.isfrom = 3

                                   avc?.yesAct = {
                                    self.dialNumber(number: self.strPhone)

                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
    }
    
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {

        removeAnimate()
    }

    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
    }

}
