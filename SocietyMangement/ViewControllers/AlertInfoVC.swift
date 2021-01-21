//
//  AlertInfoVC.swift
//  SocietyMangement
//
//  Created by Macmini on 18/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

class AlertInfoVC: UIViewController {
    
    @IBOutlet weak var viewinner: UIView!

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblMessage: UILabel!

    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var txtview: UITextView!

    var strName = ""
    var strTitle = ""
    var strTime = ""
    var strMessage = ""
    var strtxtview = ""
    
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
        lblTitle.text = strTitle
        lbltime.text = strTime
        lblMessage.text = strMessage
        txtview.text = strtxtview
        
        if getImage == "" {
        }else{
            imgview.sd_setImage(with: URL(string: getImage), placeholderImage: UIImage(named: ""))
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
