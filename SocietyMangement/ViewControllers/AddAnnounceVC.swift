//
//  AddAnnounceVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire

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
class AddAnnounceVC: UIViewController , UITextFieldDelegate,Buildings {

    @IBOutlet weak var lblsendto: GBTextField!
    
    @IBOutlet weak var lbltitle: GBTextField!
    
    @IBOutlet weak var lbldes: GBFloatingTextView!
    
    @IBOutlet weak var lbldate: GBTextField!
    
    var selectedary = NSMutableArray()
    var datePicker = UIDatePicker()
    
    
    var isfrom = 0
    var dic: Announcement?
    
    @IBAction func savection(_ sender: Any) {
        
        
        if(lblsendto.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select send blocks")
            self.present(alert, animated: true, completion: nil)
            
        }   else if(lbltitle.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter title")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(lbldes.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter description")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(lbldate.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select valid till")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            if(isfrom == 0)
            {
            apicallAddAnnouncement()
            }
            else
            {
                apicallEditAnouncement()
                
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
           apicallGetBuildings()
            self.lbltitle.text = dic?.title
            self.lbldes.text = dic?.datumDescription
            self.lbldate.text = dic?.viewTill
            self.lbldes.placeholder = ""

        }
        // Do any additional setup after loading the view.
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
    
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField == lblsendto)
        {
            lblsendto.resignFirstResponder()
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SendtoPopUP") as! SendtoPopUP
            popOverConfirmVC.delegate = self
            popOverConfirmVC.strlbl = "Send Announce to"
            popOverConfirmVC.selectedary = self.selectedary
            self.addChildViewController(popOverConfirmVC)
            popOverConfirmVC.view.frame = self.view.frame
            self.view.center = popOverConfirmVC.view.center
            self.view.addSubview(popOverConfirmVC.view)
            popOverConfirmVC.didMove(toParentViewController: self)
        }
        return true
    }
    
   // func selectedbuildings(selectedary: NSMutableArray,nameary:NSMutableArray) {
        
    func selectedbuildings(selectedary: NSMutableArray, nameary: NSMutableArray, selectedaryId: NSMutableArray) {
        
        self.selectedary =  selectedary
        self.lblsendto.text = nameary.componentsJoined(by:",")
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
    
  @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        lbldate.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
  @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    // MARK: - Delete circulars
    
    func apicallAddAnnouncement()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().AddAnnouncement(URL: webservices().baseurl + "addAnnouncement", society_id: UserDefaults.standard.value(forKey:"societyid")! as! String, member_id: UserDefaults.standard.value(forKey:"id")! as! String, building_id: selectedary.componentsJoined(by: ","), title:lbltitle.text!, description: lbldes.text!, view_till: lbldate.text!) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        
                        self.lbltitle.text = ""
                        self.lbldes.text = ""
                        self.lbldate.text = ""

                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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
    
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
           // Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + "Auth/getBuildingList", societyid:UserDefaults.standard.value(forKey:"societyid")! as! String) { JSON in
        
        let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
    
        // 20/10/20. temp not sure
        
        let societyid = UserDefaults.standard.value(forKey:"societyid")!
        
         let param : Parameters = [
             "Phone" : mobile!,
             "Secret" : secret,
             "Society" : societyid
         ]
        
                
        Apicallhandler.sharedInstance.GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, param: param) { JSON in
           
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(resp.status == 1)
                    {
                     
                        if(self.isfrom == 1)
                        {
                            
                        for dic in resp.data
                        {
                            
                            if(((self.dic?.buildingID.contains((dic.PropertyID as NSNumber).stringValue))!)) {
                                self.selectedary.add(dic.PropertyID)
                                nameary.add(dic.PropertyName)
                           }
                        }
                           
                        self.lblsendto.text = nameary.componentsJoined(by:",")
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
    
    // MARK: - Edit Annoucement
    
    func apicallEditAnouncement()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().EditAnnoucement(URL: webservices().baseurl + "updateAnnouncement",announcement_id:(dic?.id)!, society_id: UserDefaults.standard.value(forKey:"societyid")! as! String, member_id: UserDefaults.standard.value(forKey:"id")! as! String, building_id: selectedary.componentsJoined(by: ","), title:lbltitle.text!, description: lbldes.text!, view_till: lbldate.text!) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        self.lbltitle.text = ""
                        self.lbldes.text = ""
                        self.lbldate.text = ""
                        
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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
