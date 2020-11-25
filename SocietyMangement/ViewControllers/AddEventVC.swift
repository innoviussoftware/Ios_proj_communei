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
import MobileCoreServices


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
class AddEventVC: BaseVC , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDataSource , UIPickerViewDelegate{
    
    @IBOutlet weak var btnMenu: UIButton!

    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var lbltite: UILabel!
    
    @IBOutlet weak var AttechemntView: UIView!
    
    @IBOutlet weak var AttechemntView_update: UIView!
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var txttype: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txttitle: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtdes: IQTextView!
    
    @IBOutlet weak var txtstartdate: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtenddate: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnattechment: UIButton!
    
    @IBOutlet weak var btnattechment_update: UIButton!

    
    @IBOutlet weak var viewCamera: UIView!

    
    var evenetary = [AddEventType]()
    
    //["Festival","AGM", "Committee","Entertainment"]
    
   // var dic : Event?
    
     var dic : SocietyEvent?

    
    var isfrom = 0
    
    var imgData : Data?
    
    var selectedaryId = NSMutableArray()

    var selectedId = ""

    
  /*  @IBAction func chnagephoto(_ sender: Any) {
        
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
        
    } */
    
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
            
            // 3/9/20.
            
//        else if(btnattechment.backgroundImage(for: .normal) == nil)
//        {
//            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select image")
//            self.present(alert, animated: true, completion: nil)
//
//        }
//
       // else if (btnattechment.imageView!.image == UIImage(named: "")) {
      
                
        else if (btnattechment.imageView!.image == nil) &&  (self.imgData == nil) {

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
    
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
          let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int

            webservices().StartSpinner()
                                         
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                         let param : Parameters = [
                             "Society" : SociId,
                           // "Parent" : UsermeResponse!.data!.society!.societyID!
                         ]
                        
                       print("Parameters : ",param)
                                
                            
        Apicallhandler.sharedInstance.GetAllBuidldingSociety(token: token as! String, param: param) { [self] JSON in
                
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    let nameary = NSMutableArray()
                    if(resp.status == 1)
                    {
                        for dic in resp.data
                        {
                            nameary.add(dic.propertyFullName)
                            self.selectedaryId.add(dic.propertyID)
                            self.selectedId = self.selectedaryId.componentsJoined(by: ",")
                        }
                            
                    }
                    
                    print("selectedaryId :- \(self.selectedaryId),selectedId :- \(self.selectedId)")
                    print(resp)
                case .failure(let err):
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
        
    }
    
    var pickerview = UIPickerView()
    
    var selectedType = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
                //  btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        
        btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
              
        apicallGetBuildings()
        
        viewCamera.isHidden = true

        
      //  AttechemntView.layer.borderColor = AppColor.appcolor.cgColor
      //  AttechemntView.layer.borderWidth = 2.0
        showDatePicker()
        showDatePicker1()
        
        apicallGetEventListType()
        
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
            btnsave.setTitle("Update", for:.normal)
            
            AttechemntView.isHidden = true
            AttechemntView_update.isHidden = false
            
           // txttype.text = dic?.eventType
            txttitle.text = dic?.title
            txtdes.text = dic?.datumDescription
            txtdes.placeholder = ""
            txtstartdate.text = dic?.eventStartDate
            // \(dic!.eventStartDate!)"
            txtenddate.text =  dic?.eventEndDate //\(dic!.eventEndDate!)"
           
            /* btnattechment_update.sd_setBackgroundImage(with: URL(string:webservices().imgurl + dic!.eventAttachment!), for: .normal)
           // btnattechment.setTitle("", for:.normal)
            
            let testImage = NSData(contentsOf: URL(string:webservices().imgurl + dic!.eventAttachment!)!)
            imgData = testImage as Data? */
            
            webservices().StartSpinner()
            
            //             btnattechment_update.imageView!.sd_setImage(with: URL(string:webservices().imgurl + dic!.attachments!), placeholderImage:nil, completed: { (image, error, cacheType, url) -> Void in
            
            
            btnattechment_update.imageView?.sd_setImage(with: URL(string:(dic!.attachments?[0])!), placeholderImage:nil, completed: { (image, error, cacheType, url) -> Void in
                if ((error) != nil) {
                    // set the placeholder image here
                    
                    self.btnattechment_update.setBackgroundImage(UIImage(named: "ic_pdf_file"), for: .normal)
                    
                    let testImage = NSData(contentsOf: URL(string:(self.dic!.attachments?[0])!)!)
                    self.imgData = testImage as Data?
                    
                    webservices().StopSpinner()


                } else {
                    // success ... use the image
                    self.btnattechment_update.sd_setBackgroundImage(with: URL(string:(self.dic!.attachments?[0])!), for: .normal)
                    
                    let testImage = NSData(contentsOf: URL(string:(self.dic!.attachments?[0])!)!)
                    self.imgData = testImage as Data?
                    
                    webservices().StopSpinner()

                }
            })
            
        }
        else
        {
            lbltite.text = "Add Event"
            btnsave.setTitle("Save", for:.normal)
            
            AttechemntView.isHidden = false
            AttechemntView_update.isHidden = true
        }
        
        setrightviewnew(textfield:txtenddate, image: #imageLiteral(resourceName: "ic-calender"))
        setrightviewnew(textfield:txtstartdate, image: #imageLiteral(resourceName: "ic-calender"))
        
       // setrightviewnew(textfield:txttype, image: #imageLiteral(resourceName: "ic_nxt_click"))
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)

        
        // Do any additional setup after loading the view.
    }
    
    @objc func tapviewCameraimage() {
          viewCamera.isHidden = true
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
    
    @IBAction func btnCameraClicked(_ sender: Any) {
           
           viewCamera.isHidden = false
           
    }

       @IBAction func btnOpenCameraClicked(_ sender: Any) {
              
           viewCamera.isHidden = true
           
           camera()
              
       }
       
    @IBAction func btnOpenGalleryClicked(_ sender: Any) {
            
         viewCamera.isHidden = true
         
         photoLibrary()
            
     }
    
        @IBAction func btnDocumentMenuClicked(_ sender: Any) {

            viewCamera.isHidden = true

            let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]

          //  let types = [kUTTypePDF]

            let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
    //           if #available(iOS 11.0, *) {
    //               importMenu.allowsMultipleSelection = true
    //           }

               importMenu.delegate = self
               importMenu.modalPresentationStyle = .formSheet
            
              self.present(importMenu, animated: true, completion: nil)
        }

    
    @IBAction func actionNotification(_ sender: Any) {
           let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
            vc.isfrom = 0
         }
        
        @IBAction func btnOpenQRCodePressed(_ sender: Any) {
            let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
            vc.isfrom = 0
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
            
            self.txttype.resignFirstResponder()
            let row = self.pickerview.selectedRow(inComponent: 0)
            self.txttype.text = evenetary[row].name
            selectedType = evenetary[row].eventTypeID
            
        // tblview.reloadData()
        view.endEditing(true)
    }
    
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
    //MARK:-  Event List Type
    
    func apicallGetEventListType()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
        Apicallhandler().GetEventList(URL: webservices().baseurl + API_GET_EVENTLISTTYPE, token:token as! String) { [self] JSON in
                switch JSON.result{
                    
                case .success(let resp):
                    
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.evenetary = resp.data!
                        if self.evenetary.count > 0{
                           // txtVehicleType.addTarget(self, action: #selector(openPicker(txt:)), for: .editingDidBegin)
                          //  txtVehicleType.addDoneOnKeyboardWithTarget(self, action: #selector(DoneVehicleType), shouldShowPlaceholder: true)
                        }else{
                           
                        }
                        
                    }
                    else
                    {
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                   
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError ?? "")
                    webservices().StopSpinner()
                    
                }
                
            }
     
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
        return evenetary[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
       // txttype.text = evenetary[row].name
        
        selectedType = evenetary[row].eventTypeID //row

    }
    
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerControllerMediaType] as? String) != nil {
            
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            
            if(isfrom == 1){
                btnattechment_update.setBackgroundImage(image, for: .normal)
               // btnattechment.setTitle("", for: .normal)
            }else{
                btnattechment.setBackgroundImage(image, for: .normal)
                btnattechment.setTitle("", for: .normal)
            }
            
            
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
        
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
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
      //  let strBuildingId = String(format: "%d", UserDefaults.standard.value(forKey:USER_BUILDING_ID) as! Int)
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
        
        print("strtoken : ",strtoken)
        
        webservices().StartSpinner()
        let param : Parameters = [
           // "society_id" : strSocietyId,
            "Title" : txttitle.text!,
            "Description" : txtdes.text!,
           // "event_start_time":txtstartdate.text!.components(separatedBy:" ")[1],
          //  "event_end_time":txtenddate.text!.components(separatedBy:" ")[1],
            "EventStartDate":txtstartdate.text!.components(separatedBy:" ")[0],
            "EventEndDate":txtenddate.text!.components(separatedBy:" ")[0],
            "EventTypeID": selectedType,//txttype.text!,
            "Properties": self.selectedId //"1" // strSocietyId // 6/11/20. temp comment
           // "building_id":strBuildingId
            //"event_attachment":btnattechment.backgroundImage(for:.normal)!
        ]
        
        print("param add",param)
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let strFileName = formatter.string(from: date)
                
                for (key, value) in param {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)

                    // MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)

                }
                
               /* if self.imgData!.count != 0{
                   // MultipartFormData.append(self.imgData!, withName: "event_attachment", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                    
                    MultipartFormData.append(self.imgData!, withName: "Attachments", fileName: strFileName, mimeType: "application/pdf")

                } */
                
                if self.imgData!.count != 0
                {
                    MultipartFormData.append(self.imgData!, withName: "Attachments", fileName: strFileName, mimeType: "image/jpeg/pdf")
                }
                
                
                
        }, to:  webservices().baseurl + API_ADD_EVENT,headers:["Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
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
                        
                       // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(response.result.value as! NSDictionary).value(forKey:"message") as! String)
                        
                        let alert = UIAlertController(title: Alert_Titel, message:((response.result.value as! NSDictionary).value(forKey:"message") as! String) , preferredStyle: UIAlertController.Style.alert)
                                                     
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                            self.navigationController?.popViewController(animated: true)
                                }))
                        
                        self.present(alert, animated: true, completion: nil)
                        self.txttype.text = ""
                        self.txttitle.text = ""
                        self.txtdes.text = ""
                        self.txtstartdate.text = ""
                        self.txtenddate.text = ""
                        // 3/9/20.
                      //  self.btnattechment.setTitle("+", for: .normal)
                        self.btnattechment.setBackgroundImage(nil, for: .normal)
                        
                        self.navigationController?.popViewController(animated: true)

                        
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
      //  let strSocietyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
      //  let strBuildingId = String(format: "%d", UserDefaults.standard.value(forKey:USER_BUILDING_ID) as! Int)
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
       // let strEventId = String(format: "%d", (dic?.eventTypeID)!)
        
        webservices().StartSpinner()
        let param : Parameters = [
            "NoticeID" :  dic?.noticeID! ?? "", //strSocietyId,
            "Title" : txttitle.text!,
            "Description" : txtdes.text!,
          //  "event_start_time":txtstartdate.text!.components(separatedBy:" ")[1],
          //  "event_end_time":txtenddate.text!.components(separatedBy:" ")[1],
            "EventStartDate":txtstartdate.text!.components(separatedBy:" ")[0],
            "EventEndDate":txtenddate.text!.components(separatedBy:" ")[0],
            "EventTypeID": selectedType, //txttype.text!,
          //  "building_id":strBuildingId
            
            "Properties": self.selectedId
            //"event_attachment":btnattechment.backgroundImage(for:.normal)!
        ]
        
        print("param :- ",param)
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let strFileName = formatter.string(from: date)
                
                for (key, value) in param {
                    
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)

                }
                
                if self.imgData!.count != 0{
                   // MultipartFormData.append(self.imgData!, withName: "event_attachment", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                  
                    MultipartFormData.append(self.imgData!, withName: "Attachments", fileName: strFileName, mimeType: "image/png/jpeg/application/pdf")

                }
                
                
        }, to:  webservices().baseurl + API_UPDATE_EVENT,headers:["Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
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
                        
                      //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(response.result.value as! NSDictionary).value(forKey:"message") as! String)

                        let alert = UIAlertController(title: Alert_Titel, message:((response.result.value as! NSDictionary).value(forKey:"message") as! String) , preferredStyle: UIAlertController.Style.alert)
                                
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                    self.navigationController?.popViewController(animated: true)
                                }))
                        self.present(alert, animated: true, completion: nil)
                        self.txttype.text = ""
                        self.txttitle.text = ""
                        self.txtdes.text = ""
                        self.txtstartdate.text = ""
                        self.txtenddate.text = ""
                      //  self.btnattechment.setTitle("+", for: .normal)
                        if(self.isfrom == 1){
                            self.btnattechment_update.setBackgroundImage(nil, for: .normal)
                        }else{
                            self.btnattechment.setBackgroundImage(nil, for: .normal)
                        }
                        
                      //  self.navigationController?.popViewController(animated: true)

                        
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


@available(iOS 13.0, *)
extension AddEventVC : UIDocumentPickerDelegate
{
     func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        
      //  strPdfUrl = myURL
                        
        if(isfrom == 1){
            btnattechment_update.setBackgroundImage(UIImage(named: "ic_pdf_file"), for: .normal)
        }else{
            btnattechment.setBackgroundImage(UIImage(named: "ic_pdf_file"), for: .normal)
        }

        do {
             imgData = try Data(contentsOf: myURL as URL)
        } catch {
            print("Unable to load data: \(error)")
        }
        
    }
    
    
//    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
//        documentPicker.delegate = self
//        present(documentPicker, animated: true, completion: nil)
//    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
