//
//  DeliveryWaitingPopupVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 01/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
import SWRevealViewController

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class DeliveryWaitingPopupVC: UIViewController {
    
    var deliverydic = NSDictionary()
    
    var dicdeviveryatgate: DeliveryatGate?
    
    var UserActivityID:Int?
    var VisitingFlatID:Int?

    
    var isfromnotification = 0


    @IBOutlet weak var lblname: UILabel!

    @IBOutlet weak var lblVisitor: UILabel!
    
    @IBOutlet weak var lblTemp: UILabel!
    
    @IBOutlet weak var lblMask: UILabel!


    @IBOutlet weak var lbldescription: UILabel!
    
   // @IBOutlet weak var imgviewLogo: UIImageView!
    
    @IBOutlet weak var imgview: UIImageView!


    @IBOutlet weak var imgDeliveryProfile: UIImageView!

    @IBOutlet weak var btnCall: UIButton!

    @IBOutlet weak var btnDeliveryatGate: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("deliverydic :- ",deliverydic)

        if deliverydic.value(forKey: "Name") != nil {
            lblname.text = (deliverydic.value(forKey:"Name") as! String)
        }else{
            lblname.text = ""
        }
        
        if deliverydic.value(forKey: "Temperature") != nil {
            lblTemp.text = (deliverydic.value(forKey: "Temperature") as! String)
        }else{
            lblTemp.text = ""
        }
        
        if deliverydic.value(forKey: "description") != nil {
            lbldescription.text = (deliverydic.value(forKey:"description") as! String)
        }else{
            lbldescription.text = ""
        }
        
        
        if deliverydic.value(forKey: "PropertyFullName") != nil {
            lblVisitor.text = (deliverydic.value(forKey:"PropertyFullName") as! String)
        }else{
            lblVisitor.text = ""
        }
        
        if deliverydic.value(forKey: "Mask") != nil {
            lblMask.text = (deliverydic.value(forKey:"Mask") as! String)
        }else{
            lblMask.text = ""
        }
        
        if deliverydic.value(forKey: "UserActivityID") != nil {
            UserActivityID = deliverydic.value(forKey: "UserActivityID") as? Int
        }
        
        if deliverydic.value(forKey: "VisitingFlatID") != nil {
            VisitingFlatID = deliverydic.value(forKey: "VisitingFlatID") as? Int
        }
        
        if deliverydic.value(forKey: "ActivityType") as! String == "Visitor Entry"
        {
            btnDeliveryatGate.isHidden = true
        }else{
            btnDeliveryatGate.isHidden = false
        }
        
        if deliverydic.value(forKey: "ProfilePic") != nil {
            imgDeliveryProfile.sd_setImage(with: URL(string: deliverydic.value(forKey: "ProfilePic") as! String), placeholderImage: UIImage(named: ""))
        }else{
            imgDeliveryProfile.isHidden = true
        }
        
        if deliverydic.value(forKey: "CompanyLogoURL") != nil {
         imgview.sd_setImage(with: URL(string: deliverydic.value(forKey: "CompanyLogoURL") as! String), placeholderImage: UIImage(named: ""))
        }else{
            imgview.isHidden = true
        }

    }
    

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector:  #selector(DeliveryWaiting), name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
     }
    
     override func viewWillDisappear(_ animated: Bool) {
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
     }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3, animations: {
                           self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
                       }) { (true) in
                           self.view.removeFromSuperview()
                           self.removeFromParentViewController()
                       }
        
    }
    
    @IBAction func acceptaction(_ sender: UIButton) {
        if deliverydic.value(forKey: "ActivityType") as! String == "Visitor Entry"
        {
          //  user/pre-approved/1/approve
        }else{
          //  user/pre-approved/2/approve
        }
    }
    
    @IBAction func denyaction(_ sender: UIButton) {
        // user/pre-approved/1/deny
    }
    
    @IBAction func btnDeliveryatGatePressed(_ sender: UIButton){
        ApiCallDeliveryGate()
    }
    
    // MARK: - Delivery at Gate
    
    func ApiCallDeliveryGate() //(type:Int)
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            webservices().StartSpinner()
        
        Apicallhandler().ApicallDeliveryLeaveatGate(URL:  webservices().baseurl + API_DELIVERY_LEAVE_GATE, token: token as! String, VisitingFlatID: VisitingFlatID!, UserActivityID: UserActivityID!) { JSON in
            
        
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        
                    if(self.isfromnotification == 0)
                    {
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        }
                        
                    }else if (resp.status == 0){
                        
                        let alert = UIAlertController(title: Alert_Titel, message:resp.message , preferredStyle: UIAlertController.Style.alert)
                                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
                                       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                       self.navigationController?.pushViewController(nextViewController, animated: true)
                                        
                                      }))
                                      self.present(alert, animated: true, completion: nil)
                        
//                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
//                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Delivery leave at gate done." )
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
    }
    
    @IBAction func btnCallPressed(_ sender: UIButton){

        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Call"
        avc?.subtitleStr = "Are you sure you want to call: \(deliverydic.value(forKey: "Phone") as! String)"
        avc?.isfrom = 3

        avc?.yesAct = { [self] in
                                     self.dialNumber(number:  deliverydic.value(forKey: "Phone") as! String)
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
    
    @objc func DeliveryWaiting(notification: NSNotification)
    {
        let object = notification.object as! NSDictionary
        
      //  if let key = object.object(forKey: "notification_type")
       // {
            let value = object.value(forKey: "notification_type") as! String
            
            if(value == "alert")
            {
                if deliverydic.value(forKey: "Name") != nil {
                    lblname.text = (deliverydic.value(forKey:"Name") as! String)
                }else{
                    lblname.text = ""
                }

                if deliverydic.value(forKey: "Temperature") != nil {
                    lblTemp.text = (deliverydic.value(forKey: "Temperature") as! String)
                }else{
                    lblTemp.text = ""
                }
                
                if deliverydic.value(forKey: "description") != nil {
                    lbldescription.text = (deliverydic.value(forKey:"description") as! String)
                }else{
                    lbldescription.text = ""
                }
                
                if deliverydic.value(forKey: "PropertyFullName") != nil {
                    lblVisitor.text = (deliverydic.value(forKey:"PropertyFullName") as! String)
                }else{
                    lblVisitor.text = ""
                }
                
                if deliverydic.value(forKey: "Mask") != nil {
                    lblMask.text = (deliverydic.value(forKey:"Mask") as! String)
                }else{
                    lblMask.text = ""
                }
                
                if deliverydic.value(forKey: "UserActivityID") != nil {
                    UserActivityID = deliverydic.value(forKey: "UserActivityID") as? Int
                }
                
                if deliverydic.value(forKey: "VisitingFlatID") != nil {
                    VisitingFlatID = deliverydic.value(forKey: "VisitingFlatID") as? Int
                }
                
                if deliverydic.value(forKey: "ActivityType") as! String == "Visitor Entry"
                {
                    btnDeliveryatGate.isHidden = true
                }else{
                    btnDeliveryatGate.isHidden = false
                }

                if deliverydic.value(forKey: "ProfilePic") != nil {
                    imgDeliveryProfile.sd_setImage(with: URL(string: deliverydic.value(forKey: "ProfilePic") as! String), placeholderImage: UIImage(named: ""))
                }
                
                if deliverydic.value(forKey: "CompanyLogoURL") != nil {
                 imgview.sd_setImage(with: URL(string: deliverydic.value(forKey: "CompanyLogoURL") as! String), placeholderImage: UIImage(named: ""))

                }

            }
      //  }
        
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
    
    


}
