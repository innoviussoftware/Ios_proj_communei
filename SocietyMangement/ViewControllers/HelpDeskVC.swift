//
//  HelpDeskVC.swift
//  SocietyMangement
//
//  Created by MacMini on 14/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire
import SWRevealViewController

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class HelpDeskVC: UIViewController {
    
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var viewSociety1: UIView!
    @IBOutlet weak var lblSocietyName1: UILabel!
    @IBOutlet weak var lblnumberSociety1: UILabel!
    
    
    @IBOutlet weak var viewSociety2: UIView!
    @IBOutlet weak var lblSocietyName2: UILabel!
    @IBOutlet weak var lblnumberSociety2: UILabel!
    
    @IBOutlet weak var lblFire: UILabel!
    @IBOutlet weak var lblnumberFire: UILabel!
    
    @IBOutlet weak var lblnamePoliceStatic: UILabel!
     @IBOutlet weak var lblnamePolice: UILabel!
    @IBOutlet weak var lblnumberPolice: UILabel!
    
    @IBOutlet weak var lblNameHospital: UILabel!
    @IBOutlet weak var lblNAmeHospital: UILabel!
    
    @IBOutlet weak var lblNameAmbulance: UILabel!
       @IBOutlet weak var lblnumberAmbulance: UILabel!
    
    @IBOutlet weak var lblHospitalNum: UILabel!
    
    
    var arrDictDataHelpDesk = [GetHelpDeskData]()
    
    var isfrom = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        if isfrom == 1{
                // btnMenu.setImage(UIImage(named: "menu"), for: .normal)
                btnMenu.setImage(UIImage(named:"ic_back-1"), for: .normal)
        }else{
                btnMenu.setImage(UIImage(named:"menu"), for: .normal)
        }
        
        if isfrom == 0 {
            if(revealViewController() != nil)
            {
                btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
        }
        
       apicallGethelpDesk()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
           
       }
       
       @objc func AcceptRequest(notification: NSNotification) {
           
           let object = notification.object as! NSDictionary
           
           if let key = object.object(forKey: "notification_type")
           {
               let value = object.value(forKey: "notification_type") as! String
               
               if(value == "security")
               {
                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   
                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GuestPopVC") as! GuestPopVC
                   nextViewController.guestdic = object
                   nextViewController.isfromnotification = 0
                   navigationController?.pushViewController(nextViewController, animated: true)
               }
                else if object.value(forKey: "notification_type") as! String == "Notice"{
                                     
                                                
                                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                 
                                                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                                                 nextViewController.isFrormDashboard = 0

                                            navigationController?.pushViewController(nextViewController, animated: true)

                                     
                                     
                                 }else if object.value(forKey: "notification_type") as! String == "Circular"{
                                     
                                              
                                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                          
                                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                          nextViewController.isfrom = 2

                                     navigationController?.pushViewController(nextViewController, animated: true)

                                     
                                     
                                 }else if object.value(forKey: "notification_type") as! String == "Event"{

                             
                             
                             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                  
                                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                                  nextViewController.isfrom = 1

                             navigationController?.pushViewController(nextViewController, animated: true)
                                     
                                 }
           }
           
       }
    
    @IBAction func backaction(_ sender: Any) {

         if isfrom == 1{
             self.navigationController?.popViewController(animated: true)
         }else{
         }
         
     }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func actionQrCode(_ sender: Any) {
          if #available(iOS 13.0, *) {
                     let vc = self.storyboard?.instantiateViewController(identifier: "QRCodeVC") as! QRCodeVC
            self.navigationController?.pushViewController(vc, animated: true)

                 } else {
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeVC") as! QRCodeVC
                    self.navigationController?.pushViewController(vc, animated: true)

                 }
                 
      }
    
    @IBAction func actionCall(_ sender: UIButton) {
        
        
          //   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
           //  avc?.subtitleStr = "Are you sure you want to call?"
     
        avc?.isfrom = 3

        if sender.tag == 1{
               avc?.subtitleStr = "Are you sure you want to call:\(self.arrDictDataHelpDesk[0].societyPhone1!)"
        }else if sender.tag == 2{ //society 2
               avc?.subtitleStr = "Are you sure you want to call:\(self.arrDictDataHelpDesk[0].societyPhone2!)"
        }else if sender.tag == 3{//Hospital
                avc?.subtitleStr = "Are you sure you want to call:\(self.arrDictDataHelpDesk[0].hostipalPhone!)"
        }else if sender.tag == 4{//ambulance
           avc?.subtitleStr = "Are you sure you want to call:\(self.arrDictDataHelpDesk[0].ambulance!)"
        }else if sender.tag == 5{//police
              avc?.subtitleStr = "Are you sure you want to call:\(self.arrDictDataHelpDesk[0].policenumber!)"
        }else if sender.tag == 6{//fire
            avc?.subtitleStr = "Are you sure you want to call:\(self.arrDictDataHelpDesk[0].fire!)"
        }

                            avc?.yesAct = {
                                       
                                         if sender.tag == 1{ // society 1

                                             self.dialNumber(number:self.arrDictDataHelpDesk[0].societyPhone1!)

                                         }else if sender.tag == 2{ //society 2

                                             self.dialNumber(number:self.arrDictDataHelpDesk[0].societyPhone2!)

                                         }else if sender.tag == 3{//Hospital

                                             self.dialNumber(number:self.arrDictDataHelpDesk[0].hostipalPhone!)

                                         }else if sender.tag == 4{//ambulance

                                             self.dialNumber(number:self.arrDictDataHelpDesk[0].ambulance!)

                                         }else if sender.tag == 5{//police

                                             self.dialNumber(number:self.arrDictDataHelpDesk[0].policenumber!)
                                         }else if sender.tag == 6{//fire

                                             self.dialNumber(number:self.arrDictDataHelpDesk[0].fire!)
                                         }
                                }

                            avc?.noAct = {
                              
                            }
                            present(avc!, animated: true)
        
        
        
        
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to call?" , preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { alert in
//
//            if sender.tag == 1{ // society 1
//                self.dialNumber(number:self.arrDictDataHelpDesk[0].societyPhone1!)
//            }else if sender.tag == 2{ //society 2
//                self.dialNumber(number:self.arrDictDataHelpDesk[0].societyPhone2!)
//            }else if sender.tag == 3{//Hospital
//                self.dialNumber(number:self.arrDictDataHelpDesk[0].hostipalPhone!)
//            }else if sender.tag == 4{//ambulance
//                self.dialNumber(number:self.arrDictDataHelpDesk[0].ambulance!)
//            }else if sender.tag == 5{//police
//                self.dialNumber(number:self.arrDictDataHelpDesk[0].policenumber!)
//            }else if sender.tag == 6{//fire
//                self.dialNumber(number:self.arrDictDataHelpDesk[0].fire!)
//            }
//        }))
//        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//
        
        
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
    
    func apicallGethelpDesk()
       {
         if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
               
            let societyID = UserDefaults.standard.value(forKey: USER_SOCIETY_ID)
            let param : Parameters = [
                "society_id" : "\(societyID!)"
             ]
            
            webservices().StartSpinner()
            Apicallhandler.sharedInstance.ApiCallGetHelpDesk(param: param) { JSON in
                   
                   let statusCode = JSON.response?.statusCode
                   
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if statusCode == 200{
                        
                        self.arrDictDataHelpDesk = resp.data
                        if(self.arrDictDataHelpDesk.count > 0)
                        {
                        self.lblNoDataFound.isHidden = true
                            self.scrollview.isHidden = false
                            
                        self.lblSocietyName1.text = self.arrDictDataHelpDesk[0].societyName1
                        self.lblnumberSociety1.text = self.arrDictDataHelpDesk[0].societyPhone1
                        
                        self.lblSocietyName2.text = self.arrDictDataHelpDesk[0].societyName2
                        self.lblnumberSociety2.text = self.arrDictDataHelpDesk[0].societyPhone2
                        
                        self.lblnumberFire.text = self.arrDictDataHelpDesk[0].fire
                        
                        self.lblnamePolice.text = self.arrDictDataHelpDesk[0].police
                         self.lblnumberPolice.text = self.arrDictDataHelpDesk[0].policenumber
                        
                        
                        self.lblNAmeHospital.text = self.arrDictDataHelpDesk[0].hostipalName
                        self.lblHospitalNum.text = self.arrDictDataHelpDesk[0].hostipalPhone
                        self.lblnumberAmbulance.text = self.arrDictDataHelpDesk[0].ambulance
                        }else{
                            self.scrollview.isHidden = true
                            self.lblNoDataFound.isHidden = false
                            self.lblNoDataFound.text = "No Help Desk numbers are available"
                        }
                       }
                   case .failure(let err):
                       
                       webservices().StopSpinner()
                       let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       self.present(alert, animated: true, completion: nil)
                       print(err.asAFError)
                       
                       
                   }
               }
      
           
       }
       
    
    
    
    
    
    
    
    


}
