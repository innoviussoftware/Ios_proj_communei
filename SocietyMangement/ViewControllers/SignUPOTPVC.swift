//
//  SignUPOTPVC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 13/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//


import UIKit
import Alamofire

@available(iOS 13.0, *)
class SignUPOTPVC: BaseVC  , UITextFieldDelegate{
    
    @IBOutlet weak var btncreatenew: UIButton!
    
    @IBAction func BAckaction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func CreateNewAccountAction(_ sender: Any) {
        
        _ = self.pushViewController(withName:MobileNumberVC.id(), fromStoryboard:"Main")

    }
    @IBOutlet weak var txtmobile: RSTextFieldCustomisation!
    
    @IBOutlet weak var btnnext: UIButton!
    
    @IBAction func nextaction(_ sender: UIButton) {
                
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
        
        if #available(iOS 13.0, *) {
                        // Always adopt a light interface style.
             overrideUserInterfaceStyle = .light
           }
    
        
        /*   //////// 31/8/20.
         
         
   let yourAttributes : [NSAttributedStringKey: Any] = [
    NSAttributedStringKey.font : UIFont(name: "Gotham-Book", size:17.0),
   NSAttributedStringKey.foregroundColor : UIColor(named:"Orange"),
   NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        
        let yourAttributes1 : [NSAttributedStringKey: Any] = [
         NSAttributedStringKey.font : UIFont(name: "Gotham-Book", size:17.0),
         NSAttributedStringKey.foregroundColor :UIColor(red: 26.0, green: 54.0, blue: 82.0, alpha: 1.00)]
        
        let combionation = NSMutableAttributedString()
        let attributeString = NSMutableAttributedString(string: "Already have an account?",attributes: yourAttributes1)
        let attributeString1 = NSMutableAttributedString(string: "Log In",attributes: yourAttributes)
        combionation.append(attributeString)
        combionation.append(attributeString1)
        
        btncreatenew.setAttributedTitle(combionation, for: .normal)
        
        */

        
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
        
        print("FCM Token --------> \(strFCmToken)")
        if !NetworkState().isInternetAvailable {
                   ShowNoInternetAlert()
                   return
               }
       
            webservices().StartSpinner()

            let param : Parameters = [
                "Phone" : txtmobile.text!,
                "FCMToken" : strFCmToken
            ]

            Apicallhandler.sharedInstance.LoginNew(URL: webservices().baseurl + APILogin, param: param) { response in
                
                webservices().StopSpinner()
                switch(response.result) {
                case .success(let resp):
                    if resp.status == 1{

                        print("OTP---------->\(resp.data?.otp ?? "")")
                        print("login token---------->\(resp.data?.token ?? "")")
                        
                        /*
                         
                         isapprove = 0 and is_exist = true means new but not approve by admin
                         isapprove = 1 and is_exist = true means user is approve by admin
                         isapprove = 0 and is_exist = false means new user
                         
                         */
                        
                        if resp.isapporve == 0 &&  resp.data?.is_exist == true {
                            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Your account is not approved by admin")
                            self.present(alert, animated: true, completion: nil)
                            
                        }else if resp.isapporve == 1 &&  resp.data?.is_exist == true {
                            
                            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"User is already exist")
                            self.present(alert, animated: true, completion: nil)
                           
                        }else if resp.isapporve == 0 && resp.data?.is_exist == false {
                            
                            UserDefaults.standard.set(resp.data?.Secret, forKey: USER_SECRET)
                            
                                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                                                   nextViewController.strmobileno = self.txtmobile.text!
                                                   nextViewController.strotp = "\(resp.data!.otp!)"
                                                   nextViewController.ismember = (resp.data?.is_exist)
                                                   self.navigationController?.pushViewController(nextViewController, animated: true)
                            }
                            else
                         {
                            self.showOkAlert(withMessage:"You have already register with communei. Please login.")
                            
                            }

                        }
                    else{
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
