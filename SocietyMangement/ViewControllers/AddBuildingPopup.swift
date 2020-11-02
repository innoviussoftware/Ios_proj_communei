//
//  AddBuildingPopup.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import  IQKeyboardManagerSwift
protocol  updateview {
    func getupdate()
}


class AddBuildingPopup: UIViewController {

    var isfrom = 0
    var dic : Building?
    var delegate: updateview?
    @IBOutlet weak var txtname: GBTextField!
    
    @IBOutlet weak var txtdes: IQTextView!
    
    @IBOutlet weak var cbyes: Checkbox!
    @IBOutlet weak var cbno: Checkbox!
    
    @IBOutlet weak var viewinner: UIView!

    @IBAction func cancelaction(_ sender: Any) {
        
        self.removeAnimate()
    
    }
    
    @IBAction func yesaction(_ sender: Any) {
        
        cbyes.isChecked = true
        cbno.isChecked = false
    }
    
    
    @IBAction func noaction(_ sender: Any) {
        
        cbyes.isChecked = false
        cbno.isChecked = true
    }
    
    
    @IBAction func addbuidingaction(_ sender: Any) {
        if(txtname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter title")
            self.present(alert, animated: true, completion: nil)
            
        }   else if(txtdes.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter description")
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
              if(isfrom == 1)
            {
                
                ApiCallUpdate()
            }
            else
            {
                ApiCallAddBuilding()
                
            }

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
//
//        cbyes.borderStyle = .circle
//        cbyes.checkmarkStyle = .circle
//        cbyes.uncheckedBorderColor = AppColor.appcolor
//        cbyes.borderWidth = 1
//        cbyes.uncheckedBorderColor = AppColor.appcolor
//        cbyes.checkedBorderColor = AppColor.appcolor
//        cbyes.backgroundColor = .clear
//        cbyes.checkboxBackgroundColor = UIColor.clear
//        cbyes.checkmarkColor = AppColor.appcolor
//        cbyes.isChecked = true
//
//        cbno.borderStyle = .circle
//        cbno.checkmarkStyle = .circle
//        cbno.uncheckedBorderColor = AppColor.appcolor
//        cbno.borderWidth = 1
//        cbno.uncheckedBorderColor = AppColor.appcolor
//        cbno.checkedBorderColor = AppColor.appcolor
//        cbno.backgroundColor = .clear
//        cbno.checkboxBackgroundColor = UIColor.clear
//        cbyes.checkmarkColor = AppColor.appcolor
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        self.showAnimate()
        if(isfrom == 1)
        {
            txtdes.text = dic?.PropertyName
            txtname.text = dic?.PropertyName
            txtdes.placeholder = ""
            
        }
        
        // Do any additional setup after loading the view.
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
                self.view.removeFromSuperview()
                
            }
        });
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
    }
    
    
    // MARK: - Api call add Building

    func ApiCallAddBuilding()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().AddBuidldings(URL: webservices().baseurl + "addBuilding", society_id: UserDefaults.standard.value(forKey:"societyid")! as! String, user_id: UserDefaults.standard.value(forKey:"id")! as! String, building_name: txtname.text!, building_description: txtdes.text) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.errorCode == 0)
                    {
                    self.removeAnimate()
                        self.delegate?.getupdate()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
        
    }
    
    
    // MARK: - Api call add Building
    
    func ApiCallUpdate()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        Apicallhandler().EditBuidldings(URL: webservices().baseurl + "editBuilding", buildingid: (dic!.PropertyID as NSNumber).stringValue, user_id: UserDefaults.standard.value(forKey:"id")! as! String, building_name: txtname.text!, building_description: txtdes.text) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.errorCode == 0)
                    {
                        self.removeAnimate()
                        self.delegate?.getupdate()

                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
        
    }
    
  

}
