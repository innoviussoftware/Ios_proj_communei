//
//  AddEventVC.swift
//  SocietyMangement
//
//  Created by MacMini on 30/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
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
class AddEventVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDataSource , UIPickerViewDelegate{
    
    @IBOutlet weak var btnMenu: UIButton!

    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var lbltite: UILabel!
    
    @IBOutlet weak var AttechemntView: UIView!
    
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var txttype: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txttitle: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtdes: IQTextView!
    
    @IBOutlet weak var txtstartdate: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtenddate: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnattechment: UIButton!
    
    var evenetary = ["Festival","AGM", "Committee","Entertainment"]
    
    var dic:Event?
    var isfrom = 0
    
    var imgData : Data?
    
    @IBAction func chnagephoto(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        if(txttype.text == "")
        {
            
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select event type")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txttitle.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter title")
            self.present(alert, animated: true, completion: nil)
            
        }   else if(txtdes.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter description")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtstartdate.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select start date time")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtenddate.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select end date time")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(btnattechment.backgroundImage(for: .normal) == nil)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select image")
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            if(isfrom == 1)
            {
                apicallEditEvents()
            }else{
                apicallAddEvents()
            }
        }
    }
    
    var pickerview = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
        if isfrom == 0{
                  btnMenu.setImage(UIImage(named: "menu"), for: .normal)
                //  btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
              }else{
                //  btnMenu.setImage(UIImage(named: "menu"), for: .normal)
                 btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
              }
        
        AttechemntView.layer.borderColor = AppColor.appcolor.cgColor
        AttechemntView.layer.borderWidth = 2.0
        showDatePicker()
        showDatePicker1()
        
        pickerview.delegate = self
        pickerview.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = AppColor.appcolor
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        txttype.inputAccessoryView = toolBar
        txttype.inputView = pickerview
        
        if(isfrom == 1)
        {
            lbltite.text = "Update Event"
            btnsave.setTitle("UPDATE", for:.normal)
            
            txttype.text = dic?.eventType
            txttitle.text = dic?.title
            txtdes.text = dic?.datumDescription
            txtdes.placeholder = ""
            txtstartdate.text = "\(dic!.eventStartDate!) \(dic!.eventStartTime!)"
            txtenddate.text =  "\(dic!.eventEndDate!) \(dic!.eventEndTime!)"
            btnattechment.sd_setBackgroundImage(with: URL(string:webservices().imgurl + dic!.eventAttachment!), for: .normal)
            btnattechment.setTitle("", for:.normal)
            
            let testImage = NSData(contentsOf: URL(string:webservices().imgurl + dic!.eventAttachment!)!)
            imgData = testImage as Data?
        }
        else
        {
            lbltite.text = "Add Event"
            btnsave.setTitle("SAVE", for:.normal)
            
        }
        setrightviewnew(textfield:txtenddate, image: #imageLiteral(resourceName: "ic-calender"))
        setrightviewnew(textfield:txtstartdate, image: #imageLiteral(resourceName: "ic-calender"))
        setrightviewnew(textfield:txttype, image: #imageLiteral(resourceName: "ic_nxt_click"))

        
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
            else  if object.value(forKey: "notification_type") as! String == "Notice"{
                                   
                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                        
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                                        nextViewController.isFrormDashboard = 0
                                        navigationController?.pushViewController(nextViewController, animated: true)
                                   
                                   
                               }else if object.value(forKey: "notification_type") as! String == "Circular"{
                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                                                        nextViewController.isfrom = 0
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
    
    func setrightviewnew(textfield: UITextField ,image:UIImage)
    {
        var imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
        
        view.addSubview(imageView)
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
    }
    
    @objc func donePressed() {
        if(txttype.text == "")
        {
            self.txttype.text = evenetary[0]
            self.txttype.resignFirstResponder()
            
        }
        // tblview.reloadData()
        view.endEditing(true)
    }
    
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
    
    // MARK: - pickerview delegate and data source methods
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return evenetary.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return evenetary[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        txttype.text = evenetary[row]
    }
    
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerControllerMediaType] as? String) != nil {
            
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            btnattechment.setBackgroundImage(image, for: .normal)
            btnattechment.setTitle("", for: .normal)
            
            imgData = (UIImagePNGRepresentation(image)! as NSData) as Data
            
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    //MARK:-User define functions
    
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myPickerController.mediaTypes = ["public.image"]
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    var datePicker = UIDatePicker()
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        txtstartdate.inputAccessoryView = toolbar
        // add datepicker to textField
        txtstartdate.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        txtstartdate.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    func showDatePicker1(){
        //Formate Date
        datePicker.datePickerMode = .dateAndTime
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donedatePicker1))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(cancelDatePicker1))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        txtenddate.inputAccessoryView = toolbar
        // add datepicker to textField
        txtenddate.inputView = datePicker
        
    }
    
    @objc func donedatePicker1(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        txtenddate.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker1(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    //MARK:- Add Event
    
    func apicallAddEvents() {
        
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
        let strSocietyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
        let strBuildingId = String(format: "%d", UserDefaults.standard.value(forKey:USER_BUILDING_ID) as! Int)
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
        
        webservices().StartSpinner()
        let param : Parameters = [
            "society_id" : strSocietyId,
            "title" : txttitle.text!,
            "description" : txtdes.text!,
            "event_start_time":txtstartdate.text!.components(separatedBy:" ")[1],
            "event_end_time":txtenddate.text!.components(separatedBy:" ")[1],
            "event_start_date":txtstartdate.text!.components(separatedBy:" ")[0],
            "event_end_date":txtenddate.text!.components(separatedBy:" ")[0],
            "event_type":txttype.text!,
            "building_id":strBuildingId
            //"event_attachment":btnattechment.backgroundImage(for:.normal)!
        ]
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let strFileName = formatter.string(from: date)
                
                for (key, value) in param {
                    MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
                }
                
                if self.imgData!.count != 0{
                    MultipartFormData.append(self.imgData!, withName: "event_attachment", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                }
                
                
        }, to:  webservices().baseurl + API_ADD_EVENT,headers:["Accept": "application/json","Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(resp)
                        
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(response.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                        self.txttype.text = ""
                        self.txttitle.text = ""
                        self.txtdes.text = ""
                        self.txtstartdate.text = ""
                        self.txtenddate.text = ""
                        self.btnattechment.setTitle("+", for: .normal)
                        self.btnattechment.setBackgroundImage(nil, for: .normal)
                        
                    }else{
                    }
                    
                    break
                case .failure(let err):
                    if statusCode == 401{
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
                    print(err.localizedDescription)
                    break
                    
                }
                
            })
        
    }
    
    
    
    func apicallEditEvents() {
        
        //event_id, society_id, building_id, event_start_time, event_start_date, event_end_time,
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        let strSocietyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
        let strBuildingId = String(format: "%d", UserDefaults.standard.value(forKey:USER_BUILDING_ID) as! Int)
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
        let strEventId = String(format: "%d", (dic?.id)!)
        
        webservices().StartSpinner()
        let param : Parameters = [
            "event_id":strEventId,
            "society_id" : strSocietyId,
            "title" : txttitle.text!,
            "description" : txtdes.text!,
            "event_start_time":txtstartdate.text!.components(separatedBy:" ")[1],
            "event_end_time":txtenddate.text!.components(separatedBy:" ")[1],
            "event_start_date":txtstartdate.text!.components(separatedBy:" ")[0],
            "event_end_date":txtenddate.text!.components(separatedBy:" ")[0],
            "event_type":txttype.text!,
            "building_id":strBuildingId
            //"event_attachment":btnattechment.backgroundImage(for:.normal)!
        ]
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let strFileName = formatter.string(from: date)
                
                for (key, value) in param {
                    MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
                }
                
                if self.imgData!.count != 0{
                    MultipartFormData.append(self.imgData!, withName: "event_attachment", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                }
                
                
        }, to:  webservices().baseurl + API_UPDATE_EVENT,headers:["Accept": "application/json","Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(resp)
                        
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(response.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                        self.txttype.text = ""
                        self.txttitle.text = ""
                        self.txtdes.text = ""
                        self.txtstartdate.text = ""
                        self.txtenddate.text = ""
                        self.btnattechment.setTitle("+", for: .normal)
                        self.btnattechment.setBackgroundImage(nil, for: .normal)
                        
                    }else{
                    }
                    
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    if statusCode == 401{
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
                    
                    break
                    
                }
                
            })
        
    }
    
    
    
}
