//
//  InvitePopUpVC.swift
//  SocietyMangement
//
//  Created by Innovius on 04/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class InvitePopUpVC: UIViewController {
    
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var btnInvitation: UIButton!
    
    @IBOutlet weak var lblInvitationaddres: UILabel!
    
    @IBOutlet weak var btnOTP: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
      setUpView()
        
      self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    func setUpView() {
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        
        btnInvitation.layer.cornerRadius = 8
        btnInvitation.clipsToBounds = true
        
        self.btnInvitation.layer.masksToBounds = false
        self.btnInvitation.layer.shadowColor = UIColor.lightGray.cgColor
        // *** *** Use following to add Shadow top, left ***
        //self.containerView.layer.shadowOffset = CGSizeMake(-5.0f, -5.0f);
        
        // *** Use following to add Shadow bottom, right ***
        //self.avatarImageView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
        
        // *** Use following to add Shadow top, left, bottom, right ***
        btnInvitation.layer.shadowOffset = .zero
        btnInvitation.layer.shadowRadius = 4.0
        // *** Set shadowOpacity to full (1) ***
        self.btnInvitation.layer.shadowOpacity = 1.0
                
    }
    
    @IBAction func actionShare(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
