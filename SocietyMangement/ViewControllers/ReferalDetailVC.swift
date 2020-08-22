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

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ReferalDetailVC: UIViewController {
    
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
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please enter society name")
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //txtcontact.text = UsermeResponse?.data!.phone
        
        lblname.text = UsermeResponse?.data!.name
        
        if UsermeResponse?.data!.image != nil{
            imguser.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse?.data!.image)!), placeholderImage: UIImage(named: "img_default"))
        }
        
        lblcontact.text = String(format: "Contact No: %@", (UsermeResponse?.data!.phone)!)   // "\(UsermeResponse?.data!.phone!)"
        
        //txtcontact.text = UsermeResponse?.data!.phone
        let strbuilding =  UsermeResponse?.data!.building!
        lblflatno.text =   String(format: "Flat No: %@-%@", strbuilding!,(UsermeResponse?.data!.flats)!)//strbuilding + "-" + (UsermeResponse?.data!.flats)!
        
        
    }
    
    
    
    
    // MARK: -
    
    func apicallReferFriend()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        webservices().StartSpinner()
        
        let strSocietyName = UserDefaults.standard.value(forKey:USER_ID) as! Int
        let strUserId = (strSocietyName as NSNumber).stringValue
        
        
        let param : Parameters = [
            "user_id":strUserId,
            "society_name":txtname.text!,
            "phone":txtcontact.text!
        ]
        
        
        Apicallhandler().APIReferFriend(URL: webservices().baseurl + API_REFER_FRIEND, param:param) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(resp.status == 1)
                {
                   
//                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Thank you for referring \(self.txtname.text!), we will get back to you soon")
//                    self.present(alert, animated: true, completion: nil)
                    
                                                let alert = UIAlertController(title: Alert_Titel, message:"Thank you for referring \(self.txtname.text!), we will get back to you soon", preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                                    
                                                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                                                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                                                             self.navigationController?.pushViewController(nextViewController, animated: true)
                                                    
                                                    
                                                    
                                                }))
                                                // show the alert
                                                self.present(alert, animated: true, completion: nil)
                    
                    self.txtname.text = ""
                    self.txtcontact.text = ""
                    
                }
                else
                {
                    
                }
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()
                if JSON.response?.statusCode == 401{
                    APPDELEGATE.ApiLogout(onCompletion: { int in
                        if int == 1{
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                            let navController = UINavigationController(rootViewController: aVC)
                            navController.isNavigationBarHidden = true
                            self.appDelegate.window!.rootViewController  = navController
                            
                        }
                    })
                    
                    return
                }
                
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError)
                
                
            }
            
        }
        
        
    }
    
    
}
