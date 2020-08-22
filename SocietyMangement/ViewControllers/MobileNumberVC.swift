//
//  MobileNumberVC.swift
//  SocietyMangement
//
//  Created by MacMini on 21/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire

@available(iOS 13.0, *)
class MobileNumberVC: BaseVC  , UITextFieldDelegate{
    
    @IBOutlet weak var btncreatenew: UIButton!
    
    @IBAction func BAckaction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func CreateNewAccountAction(_ sender: Any) {
        let nextVC = self.pushViewController(withName:SignUPOTPVC.id(), fromStoryboard:"Main")
        
    }
    @IBOutlet weak var txtmobile: RSTextFieldCustomisation!
    
    @IBOutlet weak var btnnext: UIButton!
    
    @IBAction func nextaction(_ sender: Any) {
        
        //20/8/20.
        
        txtmobile.text! = "9998099631"

        if(txtmobile.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter mobile number")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtmobile.text!.count < 10)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Mobile should contain atleast 10 digits")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
            
        {
            //        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            //        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
            //        self.navigationController?.pushViewController(nextViewController, animated: true)
            
            ApiCallLogin()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtmobile.isUserInteractionEnabled = true
        if #available(iOS 13.0, *) {
                        // Always adopt a light interface style.
             overrideUserInterfaceStyle = .light
           }
        
   let yourAttributes : [NSAttributedStringKey: Any] = [
    NSAttributedStringKey.font : UIFont(name: "Gotham-Book", size:17.0),
   NSAttributedStringKey.foregroundColor : UIColor(red: 0.51, green: 0.56, blue: 0.65, alpha: 1.00),
   NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Create New Account",
                                                           attributes: yourAttributes)
           btncreatenew.setAttributedTitle(attributeString, for: .normal)
        
      //.styleDouble.rawValue, .styleThick.rawValue, .styleNone.rawValue

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - textfield delegate and datsource method
    
    func ApiCallLogin()
    {
        var strFCmToken = ""
        if UserDefaults.standard.value(forKey: "FcmToken") != nil{
            strFCmToken = UserDefaults.standard.value(forKey: "FcmToken") as! String
        }else{
            strFCmToken = "abc"
        }
        
        print("FCM Token-------->\(strFCmToken)")
        if !NetworkState().isInternetAvailable {
                   ShowNoInternetAlert()
                   return
               }
       
            webservices().StartSpinner()

            let param : Parameters = [
                "phone" : txtmobile.text!,
                "device_id" :strFCmToken
            ]

            Apicallhandler.sharedInstance.LoginNew(URL: webservices().baseurl + APILogin, param: param) { response in
                webservices().StopSpinner()
                switch(response.result) {
                case .success(let resp):
                    if resp.status == 1{

                        print("OTP---------->\(resp.data?.otp)")
                        print("login token---------->\(resp.data?.token)")
                        
                        
                        if resp.isapporve == 0{
                            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Your account is not approved yet")
                            self.present(alert, animated: true, completion: nil)
                            
                        }else{
                            if resp.data?.isExist != "0"{
                                                       UserDefaults.standard.set(resp.data?.role, forKey: USER_ROLE)
                                                       UserDefaults.standard.set(resp.data?.token, forKey: USER_TOKEN)
                                                       UserDefaults.standard.synchronize()
                                                   }

                                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                                                   nextViewController.strmobileno = self.txtmobile.text!
                                                   nextViewController.strotp = "\(resp.data!.otp!)"
                                                   nextViewController.ismember = (resp.data?.isExist)!
                                                   self.navigationController?.pushViewController(nextViewController, animated: true)

                        }
                    }else{
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }

                    break
                case .failure(let err):
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)

                }


            }
       
    }
    
    
   
    
}
