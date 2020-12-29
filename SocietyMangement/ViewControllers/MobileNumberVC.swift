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
    
    var isfrom = 0
    
    @IBOutlet weak var btncreatenew: UIButton!
    
    @IBAction func BAckaction(_ sender: UIButton) {
        if isfrom == 0 {
            self.navigationController?.popViewController(animated:true)
        }else{
            exit(0)
        }
    }
    
    @IBAction func CreateNewAccountAction(_ sender: Any) {
        let nextVC = self.pushViewController(withName:SignUPOTPVC.id(), fromStoryboard:"Main")
        
    }
    @IBOutlet weak var txtmobile: RSTextFieldCustomisation!
    
    @IBOutlet weak var btnnext: UIButton!
    
    @IBAction func nextaction(_ sender: UIButton) {
        
        //20/8/20.
        
       // txtmobile.text! = "9998099631"

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
    NSAttributedStringKey.font : UIFont(name: "Gotham-Light", size:16.0) as Any,
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
                "Phone" : txtmobile.text!,
                "FCMToken" :strFCmToken
            ]

            Apicallhandler.sharedInstance.LoginNew(URL: webservices().baseurl + APILogin, param: param) { response in
                webservices().StopSpinner()
                switch(response.result) {
                case .success(let resp):
                    if resp.status == 1{

                        print("OTP---------->\(resp.data?.otp ?? "")")
                        print("login token---------->\(resp.data?.token ?? "")")
                        
                        /*
                         if (response.body().getIsapporve() == 0 && !response.body().getData().isIs_exist()) {
                                                            //new user
                        ""User is not registered""


                                                        }else if (response.body().getIsapporve() == 0 && response.body().getData().isIs_exist()) {
                                                            // new user but not approved by admin
                                                            String message = "Member is not approved from admin";
                                                            openNotApprovedDialog(message);


                                                        } else {
                                                            //approved user
                        goto otp then dashboard
                         */
                        
                        
                        if resp.isapporve == 0 && resp.data?.is_exist == false {
                            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"User is not registered")
                            self.present(alert, animated: true, completion: nil)
                            
                        }else if resp.isapporve == 0 &&  resp.data?.is_exist == true{
                            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Member is not approved from admin")
                            self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        
                        UserDefaults.standard.set(resp.data?.role, forKey: USER_ROLE)
                        UserDefaults.standard.set(resp.data?.token, forKey: USER_TOKEN)
                        UserDefaults.standard.synchronize()
                
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                    nextViewController.strmobileno = self.txtmobile.text!
                    nextViewController.strotp = "\(resp.data!.otp!)"
                    nextViewController.ismember = (resp.data?.is_exist)!
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                       // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                      //  self.present(alert, animated: true, completion: nil)
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
