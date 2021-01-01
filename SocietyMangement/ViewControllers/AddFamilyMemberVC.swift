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
import IQKeyboardManagerSwift


@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AddFamilyMemberVC: BaseVC , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource, addedOther{
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var viewCamera: UIView!

    var datePicker = UIDatePicker()
    
    
    var isfrom = 0
    var strGender = "Male"
    var strRelation = ""
    

    
    @IBOutlet weak var txtprofession: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtProfessionOther: SkyFloatingLabelTextField!

    @IBOutlet weak var txtViewProfessionDetail: IQTextView!

    @IBOutlet weak var constraintHeightProfessionOther: NSLayoutConstraint!

    @IBOutlet weak var constraintTopProfessionOther: NSLayoutConstraint!
    
    var professionary = [Profession]()

    // first solve blood group api

    var bloodgroupary = [BloodGroup]()
    //["O+","O-","A-","A+","AB-","AB+","B-","B+"]
    var arrGender = ["Male","Female","Prefer not to say"]
    var arrRelation = ["Father","Mother","Son","Sister","Daughter","Brother","Spouse","Mother In Law", "Father In Law","Co-tenant","Nephew","niece"]
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var imguser: UIImageView!
    
    @IBAction func ChangePhoto(_ sender: UIButton) {
        
        viewCamera.isHidden = false
        
        // 14/10/20.
        
    /*  viewCamera.isHidden = true
        
        let avc = storyboard?.instantiateViewController(withClass: AlertSelectCameraVC.self)

        avc?.yesActCamera = { [self] in
            print("camera open 1")
            camera()
            print("camera open 2")
        }
        
        
        avc?.yesActGallery = { [self] in
            print("photoLibrary open 1")
            photoLibrary()
            print("photoLibrary open 2")
        }
        
        avc?.noAct = {
            print("no open")
        }
        
        navigationController?.pushViewController(avc!, animated: true)
        
        
      //  present(avc!, animated: true) */
        
       /* let showAlert = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        showAlert.view.addSubview(viewCamera)
        showAlert.addAction(UIAlertAction(title: "", style: .default, handler: { action in
            
            print("open")

            // your actions here...
        }))
        self.present(showAlert, animated: true, completion: nil) */

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
    
    @IBAction func actionNotification(_ sender: Any) {
         let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
          vc.isfrom = 0
       }
      
      @IBAction func btnOpenQRCodePressed(_ sender: Any) {
          let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
          vc.isfrom = 0
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
    
    // MARK: - Userdefilne function
    
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    
    @IBAction func SaveAction(_ sender: UIButton) {
      
        /* if(self.imguser.image! == 0)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select family member Image")
            self.present(alert, animated: true, completion: nil)
        }
        else */
        if(txtname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your family member name")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtemail.text == "") {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your family member email")
            self.present(alert, animated: true, completion: nil)
        }
        else if txtemail.hasText{
            
            if(isValidEmail(emailStr: txtemail.text!) == false) {
              let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter vaild email")
             self.present(alert, animated: true, completion: nil)
            }
            else if(txtnum.text == "") || (txtnum.text!.count < 10)
            {
                
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter contact number 10 digit")
                self.present(alert, animated: true, completion: nil)
            }
//            else if(txtnum.text!.count > 9) {
//                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter contact number 10 digit")
//                self.present(alert, animated: true, completion: nil)
//            }
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
        }else if !txtprofession.hasText
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession")
            self.present(alert, animated: true, completion: nil)
        }else if !txtViewProfessionDetail.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession details")
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
    }
    
    
    @IBOutlet weak var txtRelation: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtGender: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtnum: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtbirthdate: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtbloodgroup: SkyFloatingLabelTextField!
    
    var pickerview = UIPickerView()
    
    var pickerview1 = UIPickerView()

    var activeTextField : UITextField!
    var SelectedBlodGroup : Int! = 0
    
    var bloodgroupId = Int()
    
    var professiongroupId = Int()

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
        
        txtProfessionOther.isHidden = true
        constraintHeightProfessionOther.constant = 0
        constraintTopProfessionOther.constant = 0
        

        txtbloodgroup.addTarget(self, action: #selector(OpenPicker(txt:)), for: .editingDidBegin)
        txtbloodgroup.addDoneOnKeyboardWithTarget(self, action: #selector(DoneBlodGroup), shouldShowPlaceholder: true)
        
        txtGender.addTarget(self, action: #selector(OpenPicker(txt:)), for: .editingDidBegin)
        txtGender.addDoneOnKeyboardWithTarget(self, action: #selector(DoneGender), shouldShowPlaceholder: true)
        
        txtRelation.addTarget(self, action: #selector(OpenPicker(txt:)), for: .editingDidBegin)
        txtRelation.addDoneOnKeyboardWithTarget(self, action: #selector(DoneRelation), shouldShowPlaceholder: true)
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)
        
        
        ApiCallGetProfession()
        
        ApiCallGetBlood()

        pickerview1.delegate = self
        pickerview1.dataSource = self
        
        if(isfrom == 1)
        {
            
            lblname.text = "Edit Family Member"
            btnsave.setTitle("Update", for: .normal)
            if member!.profilePhotoPath != nil {
                imguser.sd_setImage(with: URL(string: member!.profilePhotoPath!), placeholderImage: UIImage(named: "vendor profile"))
            }
            txtname.text = member?.name
            txtnum.text = member?.phone
            
            txtemail.text = member?.email
            
            txtViewProfessionDetail.text = member?.professionDetails
            
            txtprofession.text = member?.professionName
            
            txtProfessionOther.text = member?.professionDetails
            
            let date =   member?.dateOfBirth // "2016-02-10 00:00:00"
            let dateFormatter = DateFormatter()

              dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
              dateFormatter.dateFormat = "dd-MM-yyyy"
            let datenew = dateFormatter.string(from: dateFromString as Date)
            txtbirthdate.text = datenew

          //  txtbirthdate.text = dateee
            
          /*  let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let strDate = formatter.date(from: dateee!)
            formatter.dateFormat = "dd-MM-yyyy"
            if strDate != nil {
                let str = formatter.string(from: strDate!)
                txtbirthdate.text = str //member?.dob
            } */
//            let str = formatter.string(from: strDate!)
//            txtbirthdate.text = str //member?.dob
            txtbloodgroup.text = member?.bloodGroupName
            txtGender.text = member?.gender
            txtRelation.text = member?.relation
            
        }
        else
        {
            lblname.text = "Add Family Member"

            btnsave.setTitle("Save", for: .normal)
            
        }
       // setrightviewnew(textfield:txtbirthdate, image: #imageLiteral(resourceName: "ic-calender")) // Dropdown
        
        // 11/8/20.
      /*  setrightviewnew(textfield: txtbirthdate, image: #imageLiteral(resourceName: "Dropdown"))
        setrightviewnew(textfield:txtbloodgroup, image: #imageLiteral(resourceName: "ic_downarrow"))
        setrightviewnew(textfield:txtGender, image: #imageLiteral(resourceName: "ic_downarrow"))
        setrightviewnew(textfield:txtRelation, image: #imageLiteral(resourceName: "ic_downorange")) */
        
       
        let toolBar1 = UIToolbar()
        toolBar1.barStyle = .default
        toolBar1.isTranslucent = true
        toolBar1.tintColor = AppColor.appcolor
        let doneButton1 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed1))
        let cancelButton1 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar1.setItems([cancelButton1, spaceButton1, doneButton1], animated: false)
               
               
        toolBar1.isUserInteractionEnabled = true
        toolBar1.sizeToFit()
        txtprofession.inputAccessoryView = toolBar1
        txtprofession.inputView = pickerview1
        
               
        // 21/10/20. temp comment
        
      /*  if UsermeResponse?.data!.profession == "other"{
            txtprofession.text = setOptionalStr(value: UsermeResponse?.data!.profession_other)
        }else{
            txtprofession.text = setOptionalStr(value: UsermeResponse?.data!.profession)
        } */
        
      //  txtprofession.text = member?.professionName

      //  txtViewProfessionDetail.text = setOptionalStr(value: UsermeResponse?.data!.professionDetail)

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
            
            txtbloodgroup.text = bloodgroupary[0].name
            
            txtbloodgroup.resignFirstResponder()
        }
        else
        {
            txtbloodgroup.resignFirstResponder()
            
        }
    }
    
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something  // MembersDetailsVC
    }
    
     @objc func donePressed1()
    {
            //  if(txtprofession.text == "") {
        
        if(txtprofession.text == "other")
        {
            txtProfessionOther.isHidden = true
            constraintHeightProfessionOther.constant = 0
            constraintTopProfessionOther.constant = 0
        
           // let row = self.pickerview1.selectedRow(inComponent: 0)
            txtprofession.text! = "other"
            professiongroupId = 0
            
            txtprofession.resignFirstResponder()

        }else{
                      
                    txtProfessionOther.isHidden = true
                    constraintHeightProfessionOther.constant = 0
                    constraintTopProfessionOther.constant = 0
                
                let row = self.pickerview1.selectedRow(inComponent: 0)
                txtprofession.text! = professionary[row].name
                professiongroupId = professionary[row].id
                

                //    txtprofession.text = professionary[0].name
                
             //   professiongroupId = professionary[0].id

                
                      
                      txtprofession.resignFirstResponder()
            /*      }
                  else
                  {
                    let row = self.pickerview1.selectedRow(inComponent: 0)
                    txtprofession.text! = professionary[row].name
                    professiongroupId = professionary[row].id
                    
                      txtprofession.resignFirstResponder()
                      
                }
                  
            if(txtprofession.text == "other")
            {
                txtProfessionOther.isHidden = false
                constraintHeightProfessionOther.constant = 50
                constraintTopProfessionOther.constant = 10
                
                
    //            let avc = storyboard?.instantiateViewController(withClass: ProfessionPopUP.self)
    //            avc!.delegate = self
    //            avc?.yesAct = {
    //            }
    //            avc?.noAct = {
    //            }
    //            present(avc!, animated: true)
                
            }else{
                txtProfessionOther.isHidden = true
                constraintHeightProfessionOther.constant = 0
                constraintTopProfessionOther.constant = 0
            } */
            
            
          
        }
        
     }
    
    
        func addOtherProfession(str: String) {
           txtprofession.text = str
           txtprofession.resignFirstResponder()
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
        txtbloodgroup.text = bloodgroupary[SelectedBlodGroup].name
        bloodgroupId = bloodgroupary[SelectedBlodGroup].id
        
    }
    
    @objc func DoneGender()  {
        activeTextField.resignFirstResponder()
        txtGender.text = arrGender[SelectedGender]
        
        if arrGender[SelectedGender] == "Male"{
            strGender = "Male"
        }else if arrGender[SelectedGender] == "Female"{
            strGender = "Female"
        }else{
            strGender = "Prefer not to say"
        }
    }
    
    @objc func DoneRelation() {
        activeTextField.resignFirstResponder()
        txtRelation.text = arrRelation[SelectedRelation]
        
    }
    
    func setOptionalStr(value : Any?) -> String?{
           guard let string = value as! String?, !string.isEmpty else {
               return nil
           }
           return  value as? String
       }
    
    // MARK: - pickerview delegate and data source methods
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if activeTextField == txtbloodgroup{
            return bloodgroupary.count //+ 1
        }else if activeTextField == txtGender{
            return arrGender.count
        }else if(pickerView == pickerview1){
            return professionary.count + 1
        }else{
            return arrRelation.count
        }
        
        
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if(pickerView == pickerview1){
           if(row == professionary.count + 1){
                    return "other"
            }else{
                return professionary[row].name

                // Fatal error: Index out of range: file Swift/ContiguousArrayBuffer.swift, line 444

            }
      //  }else{ */
           }else if activeTextField == txtbloodgroup{
                return bloodgroupary[row].name
            }else if activeTextField == txtGender{
                return arrGender[row]
            }else{
                return arrRelation[row]
            }
       // }
       
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView == pickerview1)
        {
            if(row == professionary.count + 1)
            {
                txtprofession.text =  "other"
                professiongroupId = 0

            }
            else
            {
               // txtprofession.text = professionary[row].name

            professiongroupId = professionary[row].id //row

            }
        }else{
            if activeTextField == txtbloodgroup{
                txtbloodgroup.text = bloodgroupary[row].name
                SelectedBlodGroup = row
            }else if activeTextField == txtGender{
                SelectedGender = row
            }else{
                SelectedRelation = row
            }
            
        }
        
    }
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }

        
        //ToolBar
        let toolbar = UIToolbar();
        
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.tintColor = UIColor.black
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
        
        var str1 = ""
               if txtProfessionOther.text!.count > 0{
                   str1 = txtProfessionOther.text!
               }else{
                   str1 = ""
               }
        
        if txtprofession.text == "other" {
            professiongroupId = 0
        }
        
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
        
        
       /* let param : Parameters = [
            "family_member_name" : txtname.text!,
            "family_member_phone" : txtnum.text!,
            "family_member_gender" : strGender,
            "profession":txtprofession.text!,
            "profession_other" : str1,
           // "profession_detail":txtViewProfessionDetail.text!,
            "family_member_dob" : str,
            "family_member_bloodgroup" : txtbloodgroup.text!,
            "family_member_relation" : txtRelation.text!
        ] */
        
        let param : Parameters = [
           // "ProfilePicture" : "",
            "Name" : txtname.text!,
            "Email" : txtemail.text!,
            "Phone" : txtnum.text!,
            "DateOfBirth" : str,
            "BloodGroup" : bloodgroupId,
            "Gender" : strGender,
            "Profession":professiongroupId,
            "ProfessionDetails" : str1,
           // "profession_detail":txtViewProfessionDetail.text!,
            "Relation" : txtRelation.text!
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
                    MultipartFormData.append(imgData!, withName: "ProfilePicture", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
                
                
        }, to: webservices().baseurl + API_ADD_FAMILY_MEMBER,headers:["Authorization": "Bearer " + token]).uploadProgress(queue: .main, closure: { progress in
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
                            let alert = UIAlertController(title: Alert_Titel, message:((response.result.value as! NSDictionary).value(forKey: "message") as! String) , preferredStyle: UIAlertController.Style.alert)
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
        let strFamilyMemberID = member!.guid // 24/10/20. //String(format: "/%d", member!.guid)
        
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
        
        // 5/10/20.
                
       /* let param : Parameters = [
            "family_member_name" : txtname.text!,
            "family_member_phone" : txtnum.text!,
            "family_member_gender" : strGender,
            "family_member_dob" : str,
           // "profession_detail":txtViewProfessionDetail.text!,
            "family_member_bloodgroup" : txtbloodgroup.text!,
            "family_member_relation" : txtRelation.text!
        ] */
        
        let param : Parameters = [
           // "ProfilePicture" : "",
            "Name" : txtname.text!,
            "Email" : txtemail.text!,
            "Phone" : txtnum.text!,
            "DateOfBirth" : str,
            "BloodGroup" : bloodgroupId,
            "Gender" : strGender,
            "Profession":professiongroupId,
            "ProfessionDetails" : txtViewProfessionDetail.text!, // str1,
           // "profession_detail":txtViewProfessionDetail.text!,
            "Relation" : txtRelation.text!,
            "guid" : strFamilyMemberID!
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
                    MultipartFormData.append(imgData!, withName: "ProfilePicture", fileName: "swift_file.jpeg", mimeType: "image/jpeg")
                }
                
                
                
            }, to: webservices().baseurl + API_UPDATE_FAMILY_MEMBER ,headers:["Authorization": "Bearer " + token]).uploadProgress(queue: .main, closure: { progress in
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
    
    
    // MARK: - get Professsion
       
       func ApiCallGetProfession()
       {
             if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
               webservices().StartSpinner()
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        print("token Professsion : ",token as! String)

        Apicallhandler().ApiGetProfession(URL: webservices().baseurl + "communei/professions", token: token as! String) { JSON in
           
        //ApiGetProfession(URL: webservices().baseurl + "communei/professions") { JSON in
                   switch JSON.result{
                   case .success(let resp):
                       
                       webservices().StopSpinner()
                       if(JSON.response?.statusCode == 200)
                       {
                           
                           self.professionary = resp.data
                        self.pickerview1.reloadAllComponents()
                           
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
    

// MARK: - get Blood
   
   func ApiCallGetBlood()
   {
         if !NetworkState().isInternetAvailable {
                        ShowNoInternetAlert()
                        return
                    }
           webservices().StartSpinner()
    
    let token = UserDefaults.standard.value(forKey: USER_TOKEN)
    
    print("token : ",token as! String)

    Apicallhandler().ApiCallGetBlood(URL: webservices().baseurl + "communei/blood-groups", token: token as! String) { JSON in
       
               switch JSON.result{
               case .success(let resp):
                   
                   webservices().StopSpinner()
                   if(JSON.response?.statusCode == 200)
                   {
                       
                       self.bloodgroupary = resp.data
                       self.pickerview.reloadAllComponents()
                       
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


