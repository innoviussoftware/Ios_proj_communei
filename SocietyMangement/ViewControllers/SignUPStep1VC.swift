//
//  SignUPStep1VC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 13/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire

var fullname:String?
var email:String?
var mobile:String?

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class SignUPStep1VC: BaseVC {
    @IBOutlet weak var btnterms: UIButton!
    @IBOutlet weak var txtemail: RSTextFieldCustomisation!
    @IBOutlet weak var txtname: RSTextFieldCustomisation!
    @IBOutlet weak var cbagree: Checkbox!
    var strmobile = ""
    @IBAction func actionTC(_ sender: Any) {
        
        let pdffile = "http://societybuddy.in/privacy-policy"
        guard let url = URL(string:pdffile) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func NextAction(_ sender: Any) {
        
        
        if(txtname.text == "") && (txtemail.text! == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
        }
        else if (txtemail.text != nil) {
            if(isValidEmail(emailStr:txtemail.text!) == false) {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter vaild email")
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            fullname = txtname.text!
            email = txtemail.text!
            mobile = strmobile
            let nextVC = self.pushViewController(withName:SignUPStep2.id(), fromStoryboard: "Main") as! SignUPStep2
        }
        
        
    }
    
    func checkbox(cb:Checkbox)
    {
        cb.borderStyle = .square
        cb.checkmarkStyle = .tick
        cb.uncheckedBorderColor = .black
        cb.borderWidth = 1
        cb.uncheckedBorderColor = .black
        cb.checkedBorderColor = UIColor(named:"Orange")
        cb.backgroundColor = .clear
        cb.checkboxBackgroundColor = UIColor.clear
        cb.checkmarkColor = UIColor(named:"Orange")
        
    }
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let yourAttributes : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont(name: "Gotham-Book", size:17.0),
            NSAttributedStringKey.foregroundColor : UIColor(named:"Orange"),
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue]
        
        let yourAttributes1 : [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font : UIFont(name: "Gotham-Book", size:17.0),
            NSAttributedStringKey.foregroundColor :UIColor(red: 0.51, green: 0.56, blue: 0.65, alpha: 1.00)]
        
        let combionation = NSMutableAttributedString()
        let attributeString = NSMutableAttributedString(string: "I agree to the",attributes: yourAttributes1)
        let attributeString1 = NSMutableAttributedString(string: "Terms & Conditions",attributes: yourAttributes)
        combionation.append(attributeString)
        combionation.append(attributeString1)
        
        btnterms.setAttributedTitle(combionation, for: .normal)
        
        checkbox(cb: cbagree)
        // Do any additional setup after loading the view.
    }
    
    func ApiCallCheckEmailExist()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        webservices().StartSpinner()
        Apicallhandler().ApiCallCheckMailExists(URL: webservices().baseurl + API_EMAIL_VERIFY, email:txtemail.text!) { JSON in
            
            let statusCode = JSON.response?.statusCode
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(statusCode == 200)
                {
                    
                    
                    
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.errors!)
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
            case .failure(let err):
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError)
                webservices().StopSpinner()
                
            }
            
        }
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
