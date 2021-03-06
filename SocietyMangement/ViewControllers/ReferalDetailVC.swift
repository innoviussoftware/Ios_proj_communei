//
//  ReferalDetailVC.swift
//  SocietyMangement
//
//  Created by Innovius on 23/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import Alamofire
import SWRevealViewController


class ReferalDetailVC: BaseVC {
    
    @IBOutlet weak var vwrefer: UIView!
    @IBOutlet weak var vwrefer1: UIView!

    
    @IBOutlet weak var imguser: UIImageView!
    @IBOutlet weak var lblflatno: UILabel!
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var txtcontact: SkyFloatingLabelTextField!
    @IBOutlet weak var txtname: SkyFloatingLabelTextField!
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    @IBAction func SendAction(_ sender: Any) {
        if(txtname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please enter Community name")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (txtcontact.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please enter contact number")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (txtcontact.text!.count < 10)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please enter valid contact number")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            apicallReferFriend()
            
        }
        
    }
    
    @IBAction func btnOkAction(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //txtcontact.text = UsermeResponse?.data!.phone
        
        vwrefer.isHidden = false
        vwrefer1.isHidden = true
        
        lblname.text = UsermeResponse?.data!.name
        
        if UsermeResponse?.data!.profilePhotoPath != nil{
            imguser.sd_setImage(with: URL(string: (UsermeResponse?.data!.profilePhotoPath)!), placeholderImage: UIImage(named: "img_default"))
        }
        
        lblcontact.text = String(format: "Contact No: %@", (UsermeResponse?.data!.phone)!)   // "\(UsermeResponse?.data!.phone!)"
        
        //txtcontact.text = UsermeResponse?.data!.phone
        
      //  let strbuilding =  UsermeResponse?.data!.society?.parentProperty
        
      //  lblflatno.text =   String(format: "Flat No: %@-%@", strbuilding!,(UsermeResponse?.data!.society?.parentProperty)!)//strbuilding + "-" + (UsermeResponse?.data!.flats)!
        
        self.lblflatno.text = "Flat No: \(UsermeResponse?.data!.society?.parentProperty ?? "")-\(UsermeResponse?.data!.society?.property ?? "")"
        
        
    }
    
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
    
    
    // MARK: -
    
    func apicallReferFriend()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        webservices().StartSpinner()
        
       
        let token = UserDefaults.standard.value(forKey:USER_TOKEN) as! String

        let param : Parameters = [
            "CommunityName":txtname.text!,
            "ContactNumber":txtcontact.text!
        ]
        
        
        Apicallhandler().APIReferFriend(URL: webservices().baseurl + API_REFER_FRIEND, param:param, token: token) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(resp.status == 1)
                {
                    
                    // Referral added successfully
                    
                  //  let alert = UIAlertController(title: Alert_Titel, message:"Thank you for referring \(self.txtname.text!), we will get back to you soon", preferredStyle: UIAlertController.Style.alert)
                    
                    self.vwrefer.isHidden = true
                    self.vwrefer1.isHidden = false
                    
                    
                  /*  let alert = UIAlertController(title: Alert_Titel, message:resp.message, preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
                        
                    }))
                    // show the alert
                    self.present(alert, animated: true, completion: nil) */
                    
                    self.txtname.text = ""
                    self.txtcontact.text = ""
                    
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
                
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
                
            }
            
        }
        
        
    }
    
    
}
