//
//  AddFamilyMemberVC.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AddFamilyMemberVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var viewCamera: UIView!

    var datePicker = UIDatePicker()
    
    
    var isfrom = 0
    var strGender = "M"
    var strRelation = ""
    
    
    
    
    var bloodgroupary = ["O+","O-","A-","A+","AB-","AB+","B-","B+"]
    var arrGender = ["Male","Female"]
    var arrRelation = ["Father","Mother","Son","Sister","Daughter","Brother","Spouse"]
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var imguser: UIImageView!
    
    @IBAction func ChangePhoto(_ sender: Any) {
        
        viewCamera.isHidden = false

      /*  let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        self.present(actionSheet, animated: true, completion: nil) */
        
        
    }
    
    @objc func tapviewCameraimage() {
        viewCamera.isHidden = true
    }
    
    @IBAction func btnOpenCameraClicked(_ sender: Any) {
           
        viewCamera.isHidden = true
        
        camera()
           
    }
    
    @IBAction func btnOpenGalleryClicked(_ sender: Any) {
           
        viewCamera.isHidden = true
        
        photoLibrary()
           
    }
    
    @IBAction func SaveAction(_ sender: Any) {
        
        if(txtname.text == "")
        {
            
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your family member name")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtname.text == "")
        {
            
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter contact number")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtbirthdate.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select birthdate")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtbloodgroup.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select blood group")
            self.present(alert, animated: true, completion: nil)
        }else if(txtGender.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select gender")
            self.present(alert, animated: true, completion: nil)
        }else if(txtRelation.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select relation")
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            if(isfrom == 0)
            {
                APIAddFamily()
            }
            else
            {
                self.APIUpdateFamilyMember()
            }
            
        }
    }
    
    
    @IBOutlet weak var txtRelation: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtGender: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtnum: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtbirthdate: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var txtbloodgroup: SkyFloatingLabelTextField!
    
    var pickerview = UIPickerView()
    var activeTextField : UITextField!
    var SelectedBlodGroup : Int! = 0
    var SelectedGender : Int! = 0
    var SelectedRelation : Int! = 0
    
    
    var member : FamilyMember?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        viewCamera.isHidden = true

        txtbloodgroup.addTarget(self, action: #selector(OpenPicker(txt:)), for: .editingDidBegin)
        txtbloodgroup.addDoneOnKeyboardWithTarget(self, action: #selector(DoneBlodGroup), shouldShowPlaceholder: true)
        
        txtGender.addTarget(self, action: #selector(OpenPicker(txt:)), for: .editingDidBegin)
        txtGender.addDoneOnKeyboardWithTarget(self, action: #selector(DoneGender), shouldShowPlaceholder: true)
        
        txtRelation.addTarget(self, action: #selector(OpenPicker(txt:)), for: .editingDidBegin)
        txtRelation.addDoneOnKeyboardWithTarget(self, action: #selector(DoneRelation), shouldShowPlaceholder: true)
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)
        
        
        if(isfrom == 1)
        {
            
            btnsave.setTitle("UPDATE", for: .normal)
            if member!.image != nil {
                imguser.sd_setImage(with: URL(string:webservices().imgurl + member!.image!), placeholderImage: UIImage(named: "vendor profile"))
            }
            txtname.text = member?.name
            txtnum.text = member?.phone
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let strDate = formatter.date(from: (member?.dob!)!)
            formatter.dateFormat = "dd-MM-yyyy"
            let str = formatter.string(from: strDate!)
            txtbirthdate.text = str //member?.dob
            txtbloodgroup.text = member?.bloodgroup
            txtGender.text = member?.gender
            txtRelation.text = member?.relation
            
        }
        else
        {
            btnsave.setTitle("SAVE", for: .normal)
            
        }
       // setrightviewnew(textfield:txtbirthdate, image: #imageLiteral(resourceName: "ic-calender")) // Dropdown
        
        // 11/8/20.
      /*  setrightviewnew(textfield: txtbirthdate, image: #imageLiteral(resourceName: "Dropdown"))
        setrightviewnew(textfield:txtbloodgroup, image: #imageLiteral(resourceName: "ic_downarrow"))
        setrightviewnew(textfield:txtGender, image: #imageLiteral(resourceName: "ic_downarrow"))
        setrightviewnew(textfield:txtRelation, image: #imageLiteral(resourceName: "ic_downorange")) */
        
        
        
        showDatePicker()
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    
    @available(iOS 13.0, *)
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
    
    
    @objc func donePressed()
        
    {
        if(txtbloodgroup.text == "")
        {
            
            txtbloodgroup.text = bloodgroupary[0]
            
            txtbloodgroup.resignFirstResponder()
        }
        else
        {
            txtbloodgroup.resignFirstResponder()
            
        }
    }
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
    
    //MARK:- openPicker
    
    @objc func OpenPicker(txt:UITextField) {
        activeTextField = txt
        
        if pickerview != nil{
            pickerview.removeFromSuperview()
        }
        
        pickerview = UIPickerView()
        pickerview.delegate = self
        pickerview.dataSource = self
        
        activeTextField.inputView = pickerview
        pickerview.backgroundColor = UIColor.white
        
    }
    
    @objc func DoneBlodGroup() {
        activeTextField.resignFirstResponder()
        txtbloodgroup.text = bloodgroupary[SelectedBlodGroup]
    }
    
    @objc func DoneGender()  {
        activeTextField.resignFirstResponder()
        txtGender.text = arrGender[SelectedGender]
        
        if arrGender[SelectedGender] == "Male"{
            strGender = "M"
        }else{
            strGender = "F"
        }
    }
    
    @objc func DoneRelation() {
        activeTextField.resignFirstResponder()
        txtRelation.text = arrRelation[SelectedRelation]
        
    }
    
    
    
    // MARK: - pickerview delegate and data source methods
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if activeTextField == txtbloodgroup{
            return bloodgroupary.count
        }else if activeTextField == txtGender{
            return arrGender.count
        }else{
            return arrRelation.count
        }
        
        
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if activeTextField == txtbloodgroup{
            return bloodgroupary[row]
        }else if activeTextField == txtGender{
            return arrGender[row]
        }else{
            return arrRelation[row]
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if activeTextField == txtbloodgroup{
            SelectedBlodGroup = row
        }else if activeTextField == txtGender{
            SelectedGender = row
        }else{
            SelectedRelation = row
        }
        
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        datePicker.maximumDate = Date()
        txtbirthdate.inputAccessoryView = toolbar
        txtbirthdate.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtbirthdate.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerControllerMediaType] as? String) != nil {
            
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            imguser.layer.cornerRadius = imguser.frame.size.height/2
            imguser.clipsToBounds = true
            imguser.image =  image
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
    
    
    
    func setrightviewnew(textfield: UITextField ,image:UIImage)
    {
        let imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        
        view.addSubview(imageView)
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
    }
    
    
    //    func apicalladdfmailyMember()
    //    {
    //        if(webservices().isConnectedToNetwork())
    //        {
    //            webservices().StartSpinner()
    //
    //            //family_member_name, family_member_phone, family_member_photo, family_member_gender,
    //            //family_member_dob, family_member_bloodgroup, family_member_relation
    //
    //            let para:Parameters = [
    //                "family_member_name" : txtname.text!,
    //                "family_member_phone" : txtnum.text!,
    //                "family_member_photo" : strMember,
    //                "family_member_gender" : "",
    //                "family_member_dob" : "",
    //                "family_member_bloodgroup" : "",
    //                "family_member_relation" : "",
    //            ]
    //
    //
    //            Apicallhandler().AddFamilyMember(URL:  webservices().baseurl + "Auth/addFamilyMember", member_id: UserDefaults.standard.value(forKey:"id")! as! String, family_member_name:txtname.text!, family_member_phone:txtnum.text!, family_member_gender: "Male", family_member_dob: txtbirthdate.text!,family_member_bloodgroup: txtbloodgroup.text!, family_member_photos:imguser.image!) { JSON in
    //                switch JSON.result{
    //                case .success(let resp):
    //
    //                    webservices().StopSpinner()
    //                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
    //                    {
    //
    //                        self.txtnum.text = ""
    //                        self.txtbirthdate.text = ""
    //                        self.txtbloodgroup.text = ""
    //                        self.txtname.text = ""
    //                        self.navigationController?.popViewController(animated: true)
    //
    //                    }
    //                    else
    //                    {
    //                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
    //                        self.present(alert, animated: true, completion: nil)
    //                    }
    //
    //
    //                    print(resp)
    //                case .failure(let err):
    //                    print(err.asAFError)
    //                    webservices().StopSpinner()
    //
    //                }
    //
    //            }
    //
    //        }
    //        else
    //        {
    //            webservices.sharedInstance.nointernetconnection()
    //        }
    //
    //    }
    //
    
    func APIAddFamily() {
        
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN) as! String
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let strDate = formatter.date(from: txtbirthdate.text!)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "yyyy-MM-dd"
            str = formatter.string(from: strDate!)
        }else{
            str = txtbirthdate.text!
        }
        
        
        let param : Parameters = [
            "family_member_name" : txtname.text!,
            "family_member_phone" : txtnum.text!,
            "family_member_gender" : strGender,
            "family_member_dob" : str,
            "family_member_bloodgroup" : txtbloodgroup.text!,
            "family_member_relation" : txtRelation.text!
        ]
        
        webservices().StartSpinner()
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in param {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(self.imguser.image != nil)
                {
                    let imgData = UIImageJPEGRepresentation(self.imguser.image!, 1.0)
                    MultipartFormData.append(imgData!, withName: "family_member_photo", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
                
                
        }, to: webservices().baseurl + API_ADD_FAMILY_MEMBER,headers:["Accept": "application/json","Authorization": "Bearer " + token]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(response.result.value)
                        
                        if (response.result.value as! NSDictionary).value(forKey: "status") as! Int == 1{
                            
                            self.txtnum.text = ""
                            self.txtbirthdate.text = ""
                            self.txtbloodgroup.text = ""
                            self.txtname.text = ""
                            
                            
//                            // create the alert
//                            let alert = UIAlertController(title: Alert_Titel, message:(response.result.value as! NSDictionary).value(forKey: "message") as! String , preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                self.navigationController?.popViewController(animated: true)
//                            }))
//                            // show the alert
//                            self.present(alert, animated: true, completion: nil)
                            
                        }else{
                            let alert = UIAlertController(title: Alert_Titel, message:(response.result.value as! NSDictionary).value(forKey: "message") as! String , preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                
                            }))
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                        
                    }else{
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message: (response.result.value as! NSDictionary).value(forKey: "message") as! String)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    break
                case .failure(let err):
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message: err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    break
                    
                }
                
            })
        
    }
    
    
    func APIUpdateFamilyMember() {
        
        
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN) as! String
        let strFamilyMemberID = String(format: "/%d", member!.id!)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let strDate = formatter.date(from: txtbirthdate.text!)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "yyyy-MM-dd"
            str = formatter.string(from: strDate!)
        }else{
            str = txtbirthdate.text!
        }
        
        
        let param : Parameters = [
            "family_member_name" : txtname.text!,
            "family_member_phone" : txtnum.text!,
            "family_member_gender" : strGender,
            "family_member_dob" : str,
            "family_member_bloodgroup" : txtbloodgroup.text!,
            "family_member_relation" : txtRelation.text!
        ]
        
        webservices().StartSpinner()
        AF.upload(
            multipartFormData: { MultipartFormData in
                for (key, value) in param {
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if(self.imguser.image != nil)
                {
                    let imgData = UIImageJPEGRepresentation(self.imguser.image!, 1.0)
                    MultipartFormData.append(imgData!, withName: "family_member_photo", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
                
                
        }, to: webservices().baseurl + API_UPDATE_FAMILY_MEMBER + strFamilyMemberID,headers:["Accept": "application/json","Authorization": "Bearer " + token]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(response.result.value)
                        
                        self.txtnum.text = ""
                        self.txtbirthdate.text = ""
                        self.txtbloodgroup.text = ""
                        self.txtname.text = ""
                        
                        // create the alert
                        let alert = UIAlertController(title: Alert_Titel, message:"Family member updated successfully" , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                    }else{
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message: (response.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    
                    break
                case .failure(let err):
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message: err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    break
                    
                }
                
            })
        
    }
    
    
}
