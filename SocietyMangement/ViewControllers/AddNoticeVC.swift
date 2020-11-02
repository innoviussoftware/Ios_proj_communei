//
//  AddNoticeVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SkyFloatingLabelTextField
import Alamofire



@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AddNoticeVC: UIViewController , Buildings , UITextFieldDelegate{

    
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var lbltitlename: UILabel!
    
    @IBOutlet weak var lblsendto: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lbltitle: SkyFloatingLabelTextField!
    
    @IBOutlet weak var lbldes: IQTextView!
    
    @IBOutlet weak var innerview: UIView!
    @IBOutlet weak var lbldate: SkyFloatingLabelTextField!
    
    var selectedary = NSMutableArray()
    
    var selectedaryId = NSMutableArray()
    
    var selectedId = ""


    var datePicker = UIDatePicker()
    
    var isfrom = 0
    var dic:Notice?
    
    
    @IBAction func savection(_ sender: Any) {
        
        if(lblsendto.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select send blocks")
            self.present(alert, animated: true, completion: nil)
            
        }   else if(lbltitle.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter title")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(lbldes.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter description")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(lbldate.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select valid till")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            if(isfrom == 1)
            {
                
                apicallEditNotice()
            }
            else
            {
                apicallAddNotice()
                
            }
            
        }
    }
    
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        
        showDatePicker()
        lblsendto.delegate = self
        
        if(isfrom == 1)
        {
            lbltitlename.text = "Update Notice"
            btnsave.setTitle("Update", for: .normal)
            apicallGetBuildings()
            self.lbltitle.text = dic?.title
            self.lbldes.text = dic?.datumDescription
            self.lbldate.text = dic?.visibleTill
            self.lbldes.placeholder = ""
            
        }
        else
        {
            lbltitlename.text = "Add Notice"
            btnsave.setTitle("Save", for: .normal)
        }
        
        // 19/8/20.
      //  setrightviewnew(textfield:lblsendto, image: #imageLiteral(resourceName: "ic_next"))
        
     //   setrightviewnew(textfield:lbldate, image: #imageLiteral(resourceName: "ic-calender"))

        
       // webservices().setShadow(view: innerview)
        // Do any additional setup after loading the view.
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
        
    }
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField == lblsendto)
        {
            
            //self.view.endEditing(true)
            lblsendto.resignFirstResponder()
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SendtoPopUP") as! SendtoPopUP
            popOverConfirmVC.delegate = self
            popOverConfirmVC.strlbl = "Send Notice to"
            popOverConfirmVC.selectedary = self.selectedary
            self.addChildViewController(popOverConfirmVC)
            popOverConfirmVC.view.frame = self.view.frame
            self.view.center = popOverConfirmVC.view.center
            self.view.addSubview(popOverConfirmVC.view)
            popOverConfirmVC.didMove(toParentViewController: self)
            
            return false
        }else{
            return true
        }
        
    }   
    
    func selectedbuildings(selectedary: NSMutableArray,nameary:NSMutableArray,selectedaryId:NSMutableArray) {
        
        self.selectedary =  selectedary
        self.lblsendto.text =  nameary.componentsJoined(by:",")
        
        self.selectedId = selectedaryId.componentsJoined(by: ",")
        
        print("self.selectedId : ",self.selectedId)
        // selectedary.componentsJoined(by:",")
        
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        lbldate.inputAccessoryView = toolbar
        // add datepicker to textField
        lbldate.inputView = datePicker
        
    }
    
    @objc  func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        lbldate.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
   @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    func setrightviewnew(textfield: UITextField ,image:UIImage)
    {
        var imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        
        view.addSubview(imageView)
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
    }
    
    
    // MARK: - Add notice
    
    func apicallAddNotice()
    {
        if(webservices().isConnectedToNetwork())
        {
           // let strSocietyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
            let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
            
            webservices().StartSpinner()
            
            let param : Parameters = [
               // "society_id" : strSocietyId,
                "Properties" : self.selectedId,
                //selectedaryId.componentsJoined(by: ","),
                "Title" : lbltitle.text!,
                "Description" : lbldes.text!,
                "VisibleTill" : lbldate.text!
            ]
            
            print("AddNotice Parameters : ",param)

            
            Apicallhandler.sharedInstance.AddNotice(URL:  webservices().baseurl + API_ADD_NOTICE, param: param,token:strtoken) { JSON  in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.lbltitle.text = ""
                        self.lbldes.text = ""
                        self.lbldate.text = ""
                        self.lblsendto.text = ""
                    
                        
                        // create the alert
                        let alert = UIAlertController(title: Alert_Titel, message:resp.message , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
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
        else
        {
            //webservices.sharedInstance.nointernetconnection()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                                                                                                                                                                     let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoInternetVC") as! NoInternetVC
                                                                                                                                                                                                        nextViewController.TryAgian = {
                                                                                                                                                                                                            //self.apicallAddNotice()

                                                                                                                                                                         }
                                                                                                                                                                                                        self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }
        
    }
    
    
    
    // MARK: - Edit notice
    
    func apicallEditNotice()
    {
        if(webservices().isConnectedToNetwork())
        {
          //  let strSocietyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
            let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
            let strNoticeId = dic?.noticeID // String(format: "%d", (dic?.noticeID)!)
            
            webservices().StartSpinner()
            let param : Parameters = [
               // "NoticeID" : strSocietyId,
                "Properties" : self.selectedId,
                    //selectedaryId.componentsJoined(by: ","),
                "Title" : lbltitle.text!,
                "Description" : lbldes.text!,
                "VisibleTill" : lbldate.text!,
                "NoticeID":strNoticeId!
            ]
            
            print("Parameters edit : ",param)

            
            Apicallhandler.sharedInstance.EditNotice(URL:  webservices().baseurl + API_UPDATE_NOTICE, param: param,token:strtoken) { JSON  in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.lbltitle.text = ""
                        self.lbldes.text = ""
                        self.lbldate.text = ""
                        
                        
                        // create the alert
                        let alert = UIAlertController(title: Alert_Titel, message:"Notice updated successfully" , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"")
                        self.present(alert, animated: true, completion: nil)
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
        else
        {
            //webservices.sharedInstance.nointernetconnection()
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                                                                                                                                                                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoInternetVC") as! NoInternetVC
                                                                                                                                                                                                                   nextViewController.TryAgian = {
                                                                                                                                                                                                                       //self.apicallEditNotice()

                                                                                                                                                                                    }
                                                                                                                                                                                                                   self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }
        
    }
    
   
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
          //  let strSocetyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
        
          let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int

            
            webservices().StartSpinner()
         
        // Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, societyid:strSocetyId) { JSON in
                
                                
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                         let param : Parameters = [
                             "Society" : SociId,
                            "Parent" : UsermeResponse!.data!.society!.societyID!
                         ]
                        
                       print("Parameters : ",param)
                                
                     //   Apicallhandler.sharedInstance.GetAllBuidldingSociety(URL: webservices().baseurl + API_GET_BUILDING_SOCIETY,token: token as! String, param: param) { JSON in
                            
                    Apicallhandler.sharedInstance.GetAllBuidldingSociety(token: token as! String, param: param) { JSON in
                       
                
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    let nameary = NSMutableArray()
                    if(resp.status == 1)
                    {
                        if(self.isfrom == 1)
                        {
                            for dic in resp.data
                            {
                               /* if(((self.dic?.buildingID!.contains((dic.PropertyID as NSNumber).stringValue))!))
                                {
                                    self.selectedary.add(dic.PropertyID)
                                    nameary.add(dic.PropertyName)
                                } */
                                
                                // 27/10/20. temp comment
                                
                               // if(((self.dic?.buildingID.contains((dic.propertyID as NSNumber).stringValue))!))
                              //  {
                                    self.selectedary.add(dic.propertyFullName)
                                    nameary.add(dic.propertyFullName)
                                self.selectedaryId.add(dic.propertyName)// propertyID)
                              //  }
                            }
                            self.lblsendto.text = self.selectedary.componentsJoined(by:",")
                            
                            self.selectedId = self.selectedaryId.componentsJoined(by: ",")
                        }
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
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
    
    
    
 
}
