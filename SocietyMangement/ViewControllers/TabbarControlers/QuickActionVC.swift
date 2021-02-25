//
//  QuickActionVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 17/08/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

import SWRevealViewController




class QuickActionVC: BaseVC ,Invite {
    
    
    @IBOutlet weak var menuaction: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
           if(revealViewController() != nil) {
                   menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                   
                   self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                   self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
               

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnZendeskPressed(_ sender: UIButton) {
        // let vc =
        _ = self.pushViewController(withName:SupportZendeskVC.id(), fromStoryboard: "Main") as! SupportZendeskVC
    }
    
    @IBAction func btnMenuActionPressed(_ sender: UIButton) {
       // revealViewController()?.revealToggle(self)
        print("revealViewController")
    }
     
    @IBAction func actionNotification(_ sender: UIButton) {
       let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
        vc.isfrom = 0
     }
    
    @IBAction func btnOpenQRCodePressed(_ sender: UIButton) {
        let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
        vc.isfrom = 0
    }
    
    @IBAction func btnVisitorPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddguestPopup") as! AddguestPopup
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        print("Visitor")
    }
    
    @IBAction func btnDeliveryPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryEntryVC") as! DeliveryEntryVC
       // vc.isfrom = 1
        self.navigationController?.pushViewController(vc, animated: true)
        print("Delivery")
    }
    
    @IBAction func btnCabPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CabEntryVC") as! CabEntryVC
        // vc.isfrom = 1
        self.navigationController?.pushViewController(vc, animated: true)
        print("Cab")
    }
    
    @IBAction func btnServiceProviderPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ServiceProviderEntryVC") as! ServiceProviderEntryVC
        // vc.isfrom = 1
        self.navigationController?.pushViewController(vc, animated: true)
        print("Service Provider")
    }
    
    @IBAction func btnDailyHelperPressed(_ sender: UIButton) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
        vc.isfrom = 1
        vc.isfromStr  = "Daily"
        self.navigationController?.pushViewController(vc, animated: true)
        print("Domestic Helper")
    }
    
    @IBAction func btnOnDemandHelperPressed(_ sender: UIButton) {

       let vc = self.storyboard?.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
        vc.isfrom = 1
       // vc.isfromStr  = "On Demand"
        vc.isfromStr  = "Daily"
        self.navigationController?.pushViewController(vc, animated: true)
        print("On Demand Helper")
    }
        
    
    @IBAction func btnEmergencyAlertsPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmergencyAlertVC") as! EmergencyAlertVC
        self.navigationController?.pushViewController(vc, animated: true)
        print("Emergency Alerts")
    }
    
    @IBAction func btnMessageGuardPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageGuardVC") as! MessageGuardVC
        self.navigationController?.pushViewController(vc, animated: true)
        print("Message Guard")
    }
    
    @IBAction func btnComplaintManagementPressed(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ComplaintManagementVC") as! ComplaintManagementVC
        self.navigationController?.pushViewController(vc, animated: true)
        print("Complaint Management")
    }
    
    func inviteaction(from: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "InviteVC") as! InviteVC
        nextViewController.isfrom = from
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
}
