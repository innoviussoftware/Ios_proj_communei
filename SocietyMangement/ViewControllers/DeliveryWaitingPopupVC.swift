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

import Alamofire



class DeliveryWaitingPopupVC: UIViewController {
    
    var deliverydic = NSDictionary()
    
    var dicdeviveryatgate: DeliveryatGate?
    
    var UserActivityID = NSString()
    var VisitingFlatID = NSString()
    var ActivityID = NSString()

    var isfromnotification = 0
    
    @IBOutlet weak var lblPropertyName: UILabel!

    @IBOutlet weak var viewinner: UIView!

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
    
   /* @IBOutlet weak var btnClose: UIButton!
    
    @IBOutlet weak var btnVisitor1: UIButton!
    
    @IBOutlet weak var btnVisitor2: UIButton!

    @IBOutlet weak var btnDelivery: UIButton! */

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        
      /*  if(revealViewController() != nil)
            {
                btnClose.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
                btnVisitor1.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

                btnVisitor2.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)

                btnDelivery.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
                
                print("revealViewController auto")

            } */
        
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
            lblPropertyName.text = (deliverydic.value(forKey:"PropertyFullName") as! String)
        }else{
            lblPropertyName.text = ""
        }
        
        if deliverydic.value(forKey: "Mask") != nil {
            if let num = deliverydic.value(forKey: "Mask") as? Int {
                if num == 1 {
                    lblMask.text = "Yes"
                }else{
                    lblMask.text = "No"
                }
            }
        }else{
            lblMask.text = "No"
        }
        
        if deliverydic.value(forKey: "UserActivityID") != nil {
            ActivityID = (deliverydic.value(forKey: "UserActivityID")) as! NSString
            print("ActivityID : ", ActivityID)
        }
        
        if deliverydic.value(forKey: "UserActivityID") != nil {
            UserActivityID = (deliverydic.value(forKey: "UserActivityID")) as! NSString
            print("UserActivityID : ", UserActivityID)
        }
        
        if deliverydic.value(forKey: "VisitingFlatID") != nil {
            VisitingFlatID = (deliverydic.value(forKey: "VisitingFlatID")) as! NSString
            print("VisitingFlatID : ", VisitingFlatID)
        }
        
        if deliverydic.value(forKey: "ActivityType") as! String == "Visitor Entry"
        {
            lblVisitor.text = "Visitor"
            lbldescription.text = "Guest is Waiting at the Gate"
            btnDeliveryatGate.isHidden = true
        }else if deliverydic.value(forKey: "ActivityType") as! String == "Delivery Entry" {
            lblVisitor.text = "Delivery"
            lbldescription.text = "Delivery person at Gate"
            btnDeliveryatGate.isHidden = false
        }else if deliverydic.value(forKey: "ActivityType") as! String == "Cab Entry" {
            lblVisitor.text = "Cab"
            lbldescription.text = "Cab driver at Gate"
            btnDeliveryatGate.isHidden = true
        }else if deliverydic.value(forKey: "ActivityType") as! String == "Service Provider Entry" {
            lblVisitor.text = "Service"
           // lbldescription.text = ""
            btnDeliveryatGate.isHidden = true
        }else {
            lblVisitor.text = "" // xyz name
           // lbldescription.text = ""
            btnDeliveryatGate.isHidden = true
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
        
       // print("ActivityID UserActivityID VisitingFlatID : ", ActivityID,UserActivityID,VisitingFlatID)

    }
    

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         NotificationCenter.default.addObserver(self, selector:  #selector(DeliveryWaiting), name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
     }
    
     override func viewWillDisappear(_ animated: Bool) {
         NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
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
               // self.viewinner.removeFromSuperview()

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                 nextViewController.selectedtabindex = 0

                self.revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                                
            }
        });
    }
    
    func removeAnimate1()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
               // self.viewinner.removeFromSuperview()

                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                 nextViewController.selectedtabindex = 1
                               // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

                    self.revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                
            }
        });
    }
    
    /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
    } */
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        
      /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
         nextViewController.selectedtabindex = 0

         revealViewController()?.pushFrontViewController(nextViewController, animated: true) */
        
       /* let navigationController:UINavigationController = self.storyboard?.instantiateInitialViewController() as! UINavigationController
          let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: NewHomeVC.id()) as! NewHomeVC
          navigationController.pushViewController(initialViewController, animated: true)
          appDelegate.window?.rootViewController = navigationController
          appDelegate.window?.makeKeyAndVisible() */
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
      
      //  removeAnimate()

        
       /* UIView.animate(withDuration: 0.3, animations: {
                           self.view.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.width, height: self.view.frame.height)
                       }) { (true) in
                           self.view.removeFromSuperview()
                           self.removeFromParentViewController()
                       } */
        
    }
    
    @IBAction func acceptaction(_ sender: UIButton) {
        if deliverydic.value(forKey: "ActivityType") as! String == "Visitor Entry"
        {
            visitorApprove_1()
          //  user/pre-approved/1/approve
        }else{
            visitorApprove_2()
          //  user/pre-approved/2/approve
        }
    }
    
    @IBAction func denyaction(_ sender: UIButton) {
        deny()
        // user/pre-approved/1/deny
    }
    
    @IBAction func btnDeliveryatGatePressed(_ sender: UIButton){
        
        ApiCallDeliveryGate()
        
    }
    
    func deny() {
       
       if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        
        if deliverydic.value(forKey: "VisitingFlatID") != nil {
           let VisitingID = (deliverydic.value(forKey: "VisitingFlatID")) as! NSString
           VisitingFlatID = VisitingID
        }
        
        if deliverydic.value(forKey: "ActivityID") != nil {
           let UserActivityID = (deliverydic.value(forKey: "ActivityID")) as! NSString
            ActivityID = UserActivityID
        }
       
      /* let param : Parameters = [
            "VisitingFlatID" : VisitingFlatID,
            "ActivityID" : ActivityID
        ]
       
        print("deny param", param) */
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)

       webservices().StartSpinner()
       
        Apicallhandler().LogoutAPIDeny(URL:  webservices().baseurl + "user/pre-approved/1/deny", token: token as! String, VisitingFlatID: VisitingFlatID, ActivityID: ActivityID) { JSON in

     //  Apicallhandler.sharedInstance.LogoutAPI(URL: webservices().baseurl + "user/pre-approved/1/deny", token: token  as! String) { [self] JSON in

           switch JSON.result{
           case .success(let resp):
               
               webservices().StopSpinner()
               if(JSON.response?.statusCode == 200)
               {
                
               /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                 nextViewController.selectedtabindex = 0
                               // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

                 revealViewController()?.pushFrontViewController(nextViewController, animated: true) */
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
                    
              //  removeAnimate()

                       
                 //  lblPresent.isHidden = true
                 //  lblAbsent.isHidden = true
                //   lbldateSelectDateCalendar.isHidden = true
                //   btnPresent.isHidden = true
                //   btnAbsent.isHidden = true
                   
                 //  apicallCalendarAttendance()
                   
                   print("user/pre-approved/1/deny")

               }
               
               else if(JSON.response?.statusCode == 401)
               {
                  
                   UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                   UserDefaults.standard.removeObject(forKey:USER_ID)
                   UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                   UserDefaults.standard.removeObject(forKey:USER_ROLE)
                   UserDefaults.standard.removeObject(forKey:USER_PHONE)
                   UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                   UserDefaults.standard.removeObject(forKey:USER_NAME)
                   UserDefaults.standard.removeObject(forKey:USER_SECRET)
                   UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                   
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                         let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                      let navController = UINavigationController(rootViewController: aVC)
                                                                      navController.isNavigationBarHidden = true
                                                         self.appDelegate.window!.rootViewController  = navController
                                                         
                   
               }
               else
               {
                  // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
                  // self.present(alert, animated: true, completion: nil)
               }
               
               print(resp)
           case .failure(let err):
               webservices().StopSpinner()
               if JSON.response?.statusCode == 401{
                   
                   UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                   UserDefaults.standard.removeObject(forKey:USER_ID)
                   UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                   UserDefaults.standard.removeObject(forKey:USER_ROLE)
                   UserDefaults.standard.removeObject(forKey:USER_PHONE)
                   UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                   UserDefaults.standard.removeObject(forKey:USER_NAME)
                   UserDefaults.standard.removeObject(forKey:USER_SECRET)
                   UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                   
                   
                       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                       
                       let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                      let navController = UINavigationController(rootViewController: aVC)
                                                                      navController.isNavigationBarHidden = true
                                                         self.appDelegate.window!.rootViewController  = navController
                       
                   
                   return
               }
              // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
             //  self.present(alert, animated: true, completion: nil)
               print(err.asAFError!)
               
           }
       }
   }
    
    // MARK: - VISITOR AT APPROVE
    
    func visitorApprove_1() { // 1
        
                if !NetworkState().isInternetAvailable {
                        ShowNoInternetAlert()
                        return
                }
            
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
                webservices().StartSpinner()
            
            Apicallhandler().ApicallDeliveryVisitorApprove(URL:  webservices().baseurl + "user/pre-approved/1/approve", token: token as! String, VisitingFlatID: VisitingFlatID, ActivityID: ActivityID) { JSON in
                
            
                    switch JSON.result{
                    case .success(let resp):
                        
                        webservices().StopSpinner()
                        
                        if(JSON.response?.statusCode == 200)
                        {
                           // let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityTabVC") as! ActivityTabVC
                           // vc.isFromDash = 1
                         //   self.navigationController?.pushViewController(vc, animated: true)
                            
                          /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                             nextViewController.selectedtabindex = 1
                                           // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

                                self.revealViewController()?.pushFrontViewController(nextViewController, animated: true)  */
                            
                              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                           // nextViewController.selectedtabindex = 1

                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                          /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                             nextViewController.selectedtabindex = 1
                            
                           // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

                            self.revealViewController()?.pushFrontViewController(nextViewController, animated: true) */
                            
                          //  self.removeAnimate1()

                           
                        }
                        
                        // 11/2/21
                        
                      /*  if(resp.status == 1)
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
                        } */
                        else
                        {
                            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"visitor Approve done." )
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        print(resp)
                    case .failure(let err):
                       // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       // self.present(alert, animated: true, completion: nil)
                        print(err.asAFError!)
                        webservices().StopSpinner()
                        
                    }
                    
                }
        
    }
    
    func visitorApprove_2() { // 2
        
              if !NetworkState().isInternetAvailable {
                             ShowNoInternetAlert()
                             return
                         }
            
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
                webservices().StartSpinner()
            
            Apicallhandler().ApicallDeliveryVisitorApprove(URL:  webservices().baseurl + "user/pre-approved/2/approve", token: token as! String, VisitingFlatID: VisitingFlatID, ActivityID: ActivityID) { JSON in
                
            
                    switch JSON.result{
                    case .success(let resp):
                        
                        webservices().StopSpinner()
                        
                        if(JSON.response?.statusCode == 200)
                        {
                            
                          /*  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                             nextViewController.selectedtabindex = 1
                                           // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

                                self.revealViewController()?.pushFrontViewController(nextViewController, animated: true) */
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                         //   self.removeAnimate1()
                            
                           // let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityTabVC") as! ActivityTabVC
                           // vc.isFromDash = 1
                         //   self.navigationController?.pushViewController(vc, animated: true)
                            
                           /* let navigationController:UINavigationController = self.storyboard?.instantiateInitialViewController() as! UINavigationController
                              let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: ActivityTabVC.id()) as! ActivityTabVC
                              navigationController.pushViewController(initialViewController, animated: true)
                                self.appDelegate.window?.rootViewController = navigationController
                            self.appDelegate.window?.makeKeyAndVisible() */
                        }
                        
                        // 11/2/21
                        
                       /* if(resp.status == 1)
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
                        } */
                        else
                        {
                            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"visitor Approve done." )
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        print(resp)
                    case .failure(let err):
                      //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                      //  self.present(alert, animated: true, completion: nil)
                        print(err.asAFError!)
                        webservices().StopSpinner()
                        
                    }
                    
                }
                
           
        
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
        
        // "user/pre-approved/2/leave-at-gate"
        
        Apicallhandler().ApicallDeliveryLeaveatGate(URL:  webservices().baseurl + API_DELIVERY_LEAVE_GATE, token: token as! String, VisitingFlatID: VisitingFlatID, UserActivityID: UserActivityID) { JSON in
            
        
                switch JSON.result{
                case .success(let resp):
                                        
                    webservices().StopSpinner()
                    
                    if(JSON.response?.statusCode == 200)
                    {
                        
                       /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                         let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                         nextViewController.selectedtabindex = 1
                                       // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

                            self.revealViewController()?.pushFrontViewController(nextViewController, animated: true) */
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                       // self.removeAnimate1()

                        
                       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "ActivityTabVC") as! ActivityTabVC
                       // vc.isFromDash = 1
                       // self.navigationController?.pushViewController(vc, animated: true)
                    }
                    
                    // 11/2/21
                    
                   /* if(resp.status == 1)
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
                    } */
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Delivery leave at gate done." )
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                   // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                  //  self.present(alert, animated: true, completion: nil)
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
                    UserActivityID = (deliverydic.value(forKey: "UserActivityID")) as! NSString
                }
                
                if deliverydic.value(forKey: "VisitingFlatID") != nil {
                    VisitingFlatID = (deliverydic.value(forKey: "VisitingFlatID")) as! NSString
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
