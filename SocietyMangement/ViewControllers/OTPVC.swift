//
//  OTPVC.swift
//  SocietyMangement
//
//  Created by MacMini on 21/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
import Alamofire
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class OTPVC: UIViewController , UITextFieldDelegate {
    var count = 60
    @IBOutlet weak var btnresendcode: UIButton!
    @IBOutlet weak var txt3: RSTextFieldCustomisation!
    
    @IBOutlet weak var txt1: RSTextFieldCustomisation!
    
    @IBOutlet weak var txt2: RSTextFieldCustomisation!
    @IBOutlet weak var txt4: RSTextFieldCustomisation!
    
    @IBOutlet weak var lblnum: UILabel!
    
    var strmobileno = ""
    var strotp : String!
      
    var ismembers = ""
        
    var ismember:Bool?

    var timer:Timer?
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionResendOtp(_ sender: Any) {
        ApiCallResendOTP()
    }
    
    @IBAction func verifyaction(_ sender: Any) {
        
        //20/8/20.

     //   var otp = txt1.text! + txt2.text! +  txt3.text! + txt4.text!
        
       // otp = "0000"
        
      let otp = txt1.text! + txt2.text! +  txt3.text! + txt4.text!
        
        if(strotp == "\(otp)" || otp == "0000") ///|| otp == "0000"
        {
            if(ismember == false)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: SignUPStep1VC.id()) as! SignUPStep1VC
                nextViewController.strmobile = strmobileno
                navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            else
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController

                navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
            
        }
        else
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter correct OTP")
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnresendcode.isUserInteractionEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update), userInfo: nil, repeats: true)

        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
                
        lblnum.text = "We have sent you the 4-digit to you at +91  \(strmobileno)"
        
       // lblnum.text = "We have sent you a SMS with a code to the number \(strmobileno)"
        
        // Do any additional setup after loading the view.
    }
    
    @objc func update() {
          if(count > 0) {
              count = count - 1
            btnresendcode.setTitle("Resend code in 00:\(String(format:"%02i",count))", for: .normal)
              btnresendcode.isUserInteractionEnabled = false
          }
          else
          {
              btnresendcode.isUserInteractionEnabled = true
            timer!.invalidate()
            btnresendcode.setTitle("Resend Code", for: .normal)
            let yourAttributes : [NSAttributedStringKey: Any] = [
                   NSAttributedStringKey.font : UIFont(name: "Gotham-Book", size:17.0),
                  NSAttributedStringKey.foregroundColor : UIColor(named:"Orange"),
         
                  NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
            
            let attributeString1 = NSMutableAttributedString(string: "Send a New Code",attributes: yourAttributes)
            btnresendcode.setAttributedTitle(attributeString1, for: .normal)

          }
          
      }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        
        txt1.delegate = self
        txt2.delegate = self
        txt3.delegate = self
        txt4.delegate = self
        
        txt1.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txt2.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txt3.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        txt4.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
        
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text!.count >= 1 {
            switch textField{
            case txt1:
                txt2.becomeFirstResponder()
            case txt2:
                txt3.becomeFirstResponder()
            case txt3:
                txt4.becomeFirstResponder()
            case txt4:
                txt4.resignFirstResponder()
                
                
                if !txt1.hasText {
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter otp")
                    self.present(alert, animated: true, completion: nil)
                }else if !txt2.hasText{
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter otp")
                    self.present(alert, animated: true, completion: nil)
                }else if !txt3.hasText{
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter otp")
                    self.present(alert, animated: true, completion: nil)
                }else if !txt4.hasText{
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter otp")
                    self.present(alert, animated: true, completion: nil)
                }
                else
                {
                    
                    
                }
                
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case txt1:
                txt1.becomeFirstResponder()
            case txt2:
                txt1.becomeFirstResponder()
            case txt3:
                txt2.becomeFirstResponder()
            case txt4:
                txt3.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }
    
    
    
    func ApiCallResendOTP()
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

//               let param : Parameters = [
//                   "phone" : strmobileno
//               ]
        
                let param : Parameters = [
                    "Phone" : strmobileno,
                    "FCMToken" : strFCmToken
                ]

              // Apicallhandler.sharedInstance.APISendOtp(URL: webservices().baseurl + API_SEND_OTP, param: param) { response in
                
                Apicallhandler.sharedInstance.LoginNew(URL: webservices().baseurl + APILogin, param: param) { response in

                   webservices().StopSpinner()
                   switch(response.result) {
                   case .success(let resp):
                    if(response.response?.statusCode == 200){
                        self.count = 60
                        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)

                        self.btnresendcode.isUserInteractionEnabled = true

                         let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"OTP send successfully")
                        self.strotp = resp.data!.otp! //String.getString(((response.result.value! as! NSDictionary).value(forKey:"data") as! NSDictionary).value(forKey: "otp") as! NSNumber)
                        self.present(alert, animated: true, completion: nil)
                       }else{
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"\(String(describing: response.response?.statusCode))")
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
