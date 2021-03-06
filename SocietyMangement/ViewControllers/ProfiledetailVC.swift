//
//  ProfiledetailVC.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire
import IQKeyboardManagerSwift
import SWRevealViewController



class ProfiledetailVC: BaseVC , UIPickerViewDelegate , UIPickerViewDataSource  ,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate,memberrole
                       //,addedOther
    {
   
    @IBOutlet weak var txtViewProfessionDetail: IQTextView!
    
    @IBOutlet weak var btnNotification: UIButton!
    
    var pickerview = UIPickerView()
    var pickerview1 = UIPickerView() // profession
    var pickerview2 = UIPickerView() // flat
    var pickerview3 = UIPickerView() // blood

    
    var isfrom : Int? = 0
    
  //  var imgData = Data()
    
    var imgData : Data?
        
    var member : Members?
    
    var professionary = [Profession]()
    
    var selectedary = NSMutableArray()
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var txtcontact: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtprofession: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtprofdetail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtbirthDate: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtGender: SkyFloatingLabelTextField!

  //  @IBOutlet weak var txtflattype: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtaddress: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtmember: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtbloodgroup: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var viewCamera: UIView!

    @IBOutlet weak var constraintHeightProfessionOther: NSLayoutConstraint!
    
    @IBOutlet weak var txtProfessionOther: SkyFloatingLabelTextField!
    
    @IBOutlet weak var constraintTopProfessionOther: NSLayoutConstraint!
    
    var strFlatType = ""
    
    var datePicker = UIDatePicker()
    
    var activeTextField : UITextField!
    
    var SelectedGender : Int! = 0
    
    var professiongroupId = Int()
    
    var strGender = "Male"

    var arrGender = ["Male","Female","Prefer not to say"]
    
    var UserType = Int()
    
    var bloodgroupId = Int()

    var SelectedBlodGroup = Int() //! = 0

    var bloodgroupary = [BloodGroup]()
   // ["O+","O-","A-","A+","AB-","AB+","B-","B+"]
    
    var flatary = ["Owner" ,"Tenant"]
    var Roleary  = ["Member" ,"Comimitee member" ,"Secretory" ,"Join Secretory" ,"President" ,"Treasure"]
    
    @IBAction func backaction(_ sender: Any) {
        if isfrom == 2{
          self.navigationController?.popViewController(animated: true)
        }
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
    
    @IBAction func saveaction(_ sender: UIButton) {
        
        if !txtname.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
        }else if txtemail.text  == ""{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter email")
            self.present(alert, animated: true, completion: nil)
        }else if txtemail.hasText{
            
         if(isValidEmail(emailStr: txtemail.text!) == false)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter vaild email")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if !txtcontact.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter mobile number")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtbirthDate.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select birthdate")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtbloodgroup.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select bloodgroup")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtGender.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select Gender")
            self.present(alert, animated: true, completion: nil)
        }
        else if !txtprofession.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtViewProfessionDetail.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession details")
            self.present(alert, animated: true, completion: nil)
            
        }
       /* else if !txtprofession.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtViewProfessionDetail.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession details")
            self.present(alert, animated: true, completion: nil)
            
        }*/
       /* else if(UsermeResponse?.data!.userTypeName == "Resident Owner")
         {
           if !txtflattype.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter flat type")
            self.present(alert, animated: true, completion: nil)
           }else if !txtbloodgroup.hasText {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select bloodgroup")
            self.present(alert, animated: true, completion: nil)
           } */
            else{
                apicallUpdateProfile()
                return
               }
           // }
        
        }else if !txtcontact.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter mobile number")
            self.present(alert, animated: true, completion: nil)
            
        }else if(txtbirthDate.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select birthdate")
            self.present(alert, animated: true, completion: nil)
        }else if !txtprofession.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtViewProfessionDetail.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession details")
            self.present(alert, animated: true, completion: nil)
            
        } // flatType = UserTypeName
       /* else if(UsermeResponse?.data!.userTypeName == "Owner of flat")
               {
                 if !txtflattype.hasText{
                  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter flat type")
                  self.present(alert, animated: true, completion: nil)
                  } else if !txtbloodgroup.hasText{
                             let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your bloodgroup")
                             self.present(alert, animated: true, completion: nil)
                         }
                         else
                         {
                             // apicallUpateProfile()
                             apicallUpdateProfile()
                            return
                         }
        } */
        
        
       /* else if !txtflattype.hasText{
           let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter flat type")
           self.present(alert, animated: true, completion: nil)
           }
        else if(txtflattype.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter flat type")
            self.present(alert, animated: true, completion: nil)
        } */
           else{
               apicallUpdateProfile()
               return
            }
                   
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        // get the array of viewControllers

        // a now contains  [vc1, vc2, vcA, vcB, vc4]


        // set the controllers array
        
        
        viewCamera.isHidden = true
        txtProfessionOther.isHidden = true
        constraintHeightProfessionOther.constant = 0
        constraintTopProfessionOther.constant = 0
        
        ApiCallGetProfession()
        //ApiCallGetRoles()
        txtmember.delegate = self
        // 11/8/20.
       // setrightviewnew(textfield:txtmember, image: #imageLiteral(resourceName: "ic_next"))
      //  setrightviewnew(textfield:txtbloodgroup, image: #imageLiteral(resourceName: "icons8-chevron-down-30"))
        
        
        ApiCallGetBlood()
        
        pickerview.delegate = self
        pickerview.dataSource = self
        
        pickerview1.delegate = self
        pickerview1.dataSource = self
        
        pickerview2.delegate = self
        pickerview2.dataSource = self
        
        pickerview3.delegate = self
        pickerview3.dataSource = self
        
        
        if(isfrom == 0) || (isfrom == 1) || (isfrom == 3)
        {
            
              if(revealViewController() != nil)
                   {
                       btnBack.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                       
                       self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                       self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
                   }
            
            btnBack.setImage(UIImage(named:"menu"), for: .normal)
            
            btnsave.isHidden = false
            txtname.isUserInteractionEnabled = true
            txtemail.isUserInteractionEnabled = true
            txtcontact.isUserInteractionEnabled = true
            txtprofession.isUserInteractionEnabled = true
            txtprofdetail.isUserInteractionEnabled = true
           // txtflattype.isUserInteractionEnabled = true
            txtbloodgroup.isUserInteractionEnabled = true
            txtmember.isUserInteractionEnabled = true
            txtaddress.isUserInteractionEnabled = true
            imgview.isUserInteractionEnabled = true
            
            txtGender.isUserInteractionEnabled = true
            txtbirthDate.isUserInteractionEnabled = true

            
            if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
            {
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
               // if(str.contains("Chairman") || str.contains("Secretory"))
                if(str.contains("society_admin"))
                {
                    txtmember.isUserInteractionEnabled = true
                    btnsave.isHidden = false
                }
                else
                {
                    txtmember.isUserInteractionEnabled = false
                    
                }
            }
            
        }else if isfrom == 2{
                      btnBack.setImage(UIImage(named:"ic_back-1"), for: .normal)
                       btnsave.isHidden = false
                       txtname.isUserInteractionEnabled = true
                       txtemail.isUserInteractionEnabled = true
                       txtcontact.isUserInteractionEnabled = false
                       txtprofession.isUserInteractionEnabled = true
                       txtprofdetail.isUserInteractionEnabled = true
                    //   txtflattype.isUserInteractionEnabled = true
                       txtbloodgroup.isUserInteractionEnabled = true
                       txtmember.isUserInteractionEnabled = true
                       txtaddress.isUserInteractionEnabled = true
                        txtbirthDate.isUserInteractionEnabled = true
                        txtGender.isUserInteractionEnabled = true
                       imgview.isUserInteractionEnabled = true
                       
                       if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
                       {
                           let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                           
                         // if(str.contains("Chairman") || str.contains("Secretory"))
                        if(str.contains("society_admin"))

                           {
                               txtmember.isUserInteractionEnabled = true
                               btnsave.isHidden = false
                           }
                           else
                           {
                               txtmember.isUserInteractionEnabled = false
                               
                           }
                       }
        }
        else
        {
            btnsave.isHidden = true
            btnBack.setImage(UIImage(named:"ic_back-1"), for: .normal)
            txtname.isUserInteractionEnabled = false
            txtemail.isUserInteractionEnabled = false
            txtcontact.isUserInteractionEnabled = false
            txtprofession.isUserInteractionEnabled = false
            txtprofdetail.isUserInteractionEnabled = false
         //   txtflattype.isUserInteractionEnabled = false
            txtbloodgroup.isUserInteractionEnabled = false
            txtmember.isUserInteractionEnabled = false
            txtaddress.isUserInteractionEnabled = false
            imgview.isUserInteractionEnabled = false
            if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
            {
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
                
             // if(str.contains("Chairman") || str.contains("Secretory"))
                if(str.contains("society_admin"))
                {
                    txtmember.isUserInteractionEnabled = true
                    btnsave.isHidden = false
                }
                else
                {
                    txtmember.isUserInteractionEnabled = false
                    
                }
            }
        }
        
        
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
        txtbloodgroup.inputAccessoryView = toolBar
        txtbloodgroup.inputView = pickerview3
        pickerview3.backgroundColor = UIColor.white

        
        
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
        
        
        
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = .default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = AppColor.appcolor
        let doneButton2 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed2))
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar2.setItems([cancelButton2, spaceButton2, doneButton2], animated: false)
        
        
        toolBar2.isUserInteractionEnabled = true
        toolBar2.sizeToFit()
      //  txtflattype.inputAccessoryView = toolBar2
    //    txtflattype.inputView = pickerview2
        
        
        if(isfrom == 0) || (isfrom == 1)
        {
            txtname.text = UsermeResponse?.data!.name
            
            txtcontact.text = UsermeResponse?.data!.phone
            
            lblname.text = UsermeResponse?.data!.name
            
            if UsermeResponse?.data!.profilePhotoPath != nil{
                imgview.sd_setImage(with: URL(string: (UsermeResponse?.data!.profilePhotoPath)!), placeholderImage: UIImage(named: "img_default"))
            }
            
            lblcontact.text = UsermeResponse?.data!.phone
            
            txtemail.text = UsermeResponse?.data!.email
            
            // 21/10/20. temp comment
            
           /* if UsermeResponse?.data!.profession == "other"{
                 txtprofession.text = setOptionalStr(value: UsermeResponse?.data!.profession_other)
            }else{
                txtprofession.text = setOptionalStr(value: UsermeResponse?.data!.profession)
            }
           

            txtViewProfessionDetail.text = setOptionalStr(value: UsermeResponse?.data!.professionDetail)
            
            if UsermeResponse?.data!.flatType == "Owner of flat"{
                txtflattype.text = "Owner"
                txtflattype.isUserInteractionEnabled = true
                txtflattype.heightAnchor.constraint(equalToConstant: 50).isActive = true
                txtflattype.isHidden = false
            }else{
                txtflattype.isUserInteractionEnabled = false
                txtflattype.heightAnchor.constraint(equalToConstant: 0).isActive = true
                txtflattype.isHidden = true
                
            } */
            if(UsermeResponse != nil)
            {
                if(UsermeResponse?.data!.userTypeName != nil)
                {
                    strFlatType = (UsermeResponse?.data!.userTypeName)!
                }
                
                if(UsermeResponse?.data!.userTypeName != nil)
                {
                    UserType = (UsermeResponse?.data?.society?.userTypeID)!
         //   txtflattype.text = UsermeResponse?.data!.userTypeName
                }
//                if(UsermeResponse?.data!.occupancy != nil)
//                {
//                    txtflattype.text = setOptionalStr(value: UsermeResponse?.data!.occupancy)
//                }
                if(UsermeResponse?.data!.bloodGroupID != nil)
                {
                    bloodgroupId = (UsermeResponse?.data!.bloodGroupID)!
                    txtbloodgroup.text = UsermeResponse?.data!.bloodGroupName
                }
                
            }
            
            // txtaddress.text = UsermeResponse?.data.address
            
            
        }else if isfrom == 2 || isfrom == 3 {
            
                        txtname.text = UsermeResponse?.data!.name
                        
                        txtcontact.text = UsermeResponse?.data!.phone
                        
                        lblname.text = UsermeResponse?.data!.name
                        
                        if UsermeResponse?.data!.profilePhotoPath != nil{
                            imgview.sd_setImage(with: URL(string: (UsermeResponse?.data!.profilePhotoPath)!), placeholderImage: UIImage(named: "img_default"))
                        }
                        
                        lblcontact.text = UsermeResponse?.data!.phone
                        
                        txtemail.text = UsermeResponse?.data!.email
            
            txtprofession.text = UsermeResponse?.data?.professionName //member?.professionName
            txtViewProfessionDetail.text = UsermeResponse?.data?.professionDetails //member?.professionDetails
            
            professiongroupId = (UsermeResponse?.data?.professionID)!
            
            txtGender.text = UsermeResponse?.data!.gender
            
            if UsermeResponse?.data!.dateOfBirth != nil {
                let date =  UsermeResponse?.data!.dateOfBirth  // "2016-02-10 00:00:00"
                let dateFormatter = DateFormatter()

                  dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
                let dateFromString : NSDate = dateFormatter.date(from: date!)! as NSDate
                  dateFormatter.dateFormat = "yyyy-MM-dd"
                let datenew = dateFormatter.string(from: dateFromString as Date)
                txtbirthDate.text = datenew //UsermeResponse?.data!.dateOfBirth
            }
               
                     /*   if UsermeResponse?.data!.profession == "other"{
                             txtprofession.text = setOptionalStr(value: UsermeResponse?.data!.profession_other)
                        }else{
                            txtprofession.text = setOptionalStr(value: UsermeResponse?.data!.profession)
                        }
                       

                        txtViewProfessionDetail.text = setOptionalStr(value: UsermeResponse?.data!.professionDetail)
                        
                        if UsermeResponse?.data!.flatType == "Owner of flat"{
                            txtflattype.text = "Owner"
                            txtflattype.isUserInteractionEnabled = true
                            txtflattype.heightAnchor.constraint(equalToConstant: 50).isActive = true
                            txtflattype.isHidden = false
                        }else{
                            txtflattype.isUserInteractionEnabled = false
                            txtflattype.heightAnchor.constraint(equalToConstant: 0).isActive = true
                            txtflattype.isHidden = true
                            
                        } */
                        if(UsermeResponse != nil)
                        {
                            if(UsermeResponse?.data!.userTypeName != nil)
                            {
                        strFlatType = (UsermeResponse?.data!.userTypeName)!
                            }
                            if(UsermeResponse?.data!.userTypeName != nil)
                            {
                                UserType = (UsermeResponse?.data?.society?.userTypeID)!
                     //   txtflattype.text = UsermeResponse?.data!.userTypeName
                            }
                            if(UsermeResponse?.data!.bloodGroupID != nil)
                                         {
                                bloodgroupId = (UsermeResponse?.data!.bloodGroupID)!
                        txtbloodgroup.text =  UsermeResponse?.data!.bloodGroupName
                            }
                        }

        }
        else
        {
            
            //Manish 07-09-19
            
            txtname.text = member?.name
            
            txtcontact.text = member?.phone
            
            lblname.text = member?.name
            
            if member?.profilePhotoPath != nil{
                imgview.sd_setImage(with: URL(string: (member?.profilePhotoPath)!), placeholderImage: UIImage(named: "vendor profile"))
            }
            
            if(UsermeResponse?.data!.userTypeName != nil)
            {
                UserType = (UsermeResponse?.data?.society?.userTypeID)!
            }
            
            lblcontact.text = member?.phone
            
            txtemail.text = member?.email
            txtprofession.text = member?.professionName
            txtViewProfessionDetail.text = member?.professionDetails
            //txtViewProfessionDetail.placeholder = ""
            
            // 22/10/20. temp comment
          /*  txtflattype.text = member?.flatType
            strFlatType = (member?.flatType)!
            txtbloodgroup.text = member?.bloodgroup */
            // txtaddress.text = member?.ad
            
        }
        
        txtcontact.isUserInteractionEnabled = false

        
        txtGender.addTarget(self, action: #selector(OpenPicker(txt:)), for: .editingDidBegin)
        txtGender.addDoneOnKeyboardWithTarget(self, action: #selector(DoneGender), shouldShowPlaceholder: true)
        
        showDatePicker()

      //  self.txtbirthDate.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1

        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)
        
        // 7/8/20.
        
       /* let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapimage))
        imgview.addGestureRecognizer(tap) */
        
    // imgview.isUserInteractionEnabled = true
        
    }
    
    
   /* @objc func tapDone() {
        if let datePicker = self.txtbirthDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.txtbirthDate.text = dateformatter.string(from: datePicker.date) //2-4
        }
        self.txtbirthDate.resignFirstResponder() // 2-5
    } */
    
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
        txtbirthDate.inputAccessoryView = toolbar
        txtbirthDate.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" //"dd-MM-yyyy"
        txtbirthDate.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
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
                           self.pickerview3.reloadAllComponents()
                           
                       }
                       else if(JSON.response?.statusCode == 401)
                       {
                        
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                           
                                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                 let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                              let navController = UINavigationController(rootViewController: aVC)
                                                                              navController.isNavigationBarHidden = true
                                                                 self.appDelegate.window!.rootViewController  = navController
                                                                 
                              
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
                    print(err.asAFError!)
                       webservices().StopSpinner()
                       
                   }
                   
               }
               
           
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
    
    func setOptionalStr(value : Any?) -> String?{
        guard let string = value as! String?, !string.isEmpty else {
            return nil
        }
        return  value as? String
    }
    
    
    
    func displarrole(ary: NSMutableArray, name: [String]) {
        
        selectedary = ary
        
        self.txtmember.text = ((name as! NSArray).mutableCopy() as! NSMutableArray).componentsJoined(by: ",")
        
    }
    
    @objc func tapviewCameraimage() {
        viewCamera.isHidden = true
    }

    
    
    /*@objc func tapimage()
        
    {
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
    
    @IBAction func actionNotification(_ sender: Any) {
             let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
              vc.isfrom = 0
           }
          
          @IBAction func btnOpenQRCodePressed(_ sender: Any) {
              let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
              vc.isfrom = 0
          }
    
    @objc func donePressed() {
            txtbloodgroup.resignFirstResponder()
            txtbloodgroup.text = bloodgroupary[SelectedBlodGroup].name
            bloodgroupId = bloodgroupary[SelectedBlodGroup].id
    }
    
    @objc func donePressed1()
    {
         if(txtprofession.text == "")
              {
                  
                txtProfessionOther.isHidden = true
                constraintHeightProfessionOther.constant = 0
                constraintTopProfessionOther.constant = 0
        
       // activeTextField.resignFirstResponder()
            
        let row = self.pickerview1.selectedRow(inComponent: 0)
        txtprofession.text! = professionary[row].name
        professiongroupId = professionary[row].id
        
                
               // txtprofession.text = professionary[0].name
                  
         //   professiongroupId = professionary[0].id

                  txtprofession.resignFirstResponder()
        
           }
//              else
//              {
//                  txtprofession.resignFirstResponder()
//
//            }
              
     /*   if(txtprofession.text == "other")
        {
            txtProfessionOther.isHidden = false
            constraintHeightProfessionOther.constant = 50
            constraintTopProfessionOther.constant = 10
            
            professiongroupId = 0

            
//            let avc = storyboard?.instantiateViewController(withClass: ProfessionPopUP.self)
//            avc!.delegate = self
//            avc?.yesAct = {
//            }
//            avc?.noAct = {
//            }
//            present(avc!, animated: true)
            
        }*/
        else{
            txtProfessionOther.isHidden = true
            constraintHeightProfessionOther.constant = 0
            constraintTopProfessionOther.constant = 0
            
          //  activeTextField.resignFirstResponder()
            let row = self.pickerview1.selectedRow(inComponent: 0)
            txtprofession.text! = professionary[row].name
            professiongroupId = professionary[row].id
            
            txtprofession.resignFirstResponder()

        }
        
        
      
    }
    @objc func donePressed2()
        
    {
     /*   if(txtflattype.text == "")
        {
           // UserType = (UsermeResponse?.data?.society?.userTypeID)!
            
            txtflattype.text = flatary[0]
            
            txtflattype.resignFirstResponder()
        }
        else
        {
            txtflattype.resignFirstResponder()
            
        } */
    }
    
    @objc func DoneGender()  {
       // activeTextField.resignFirstResponder()
        txtGender.text = arrGender[SelectedGender]
        
        if arrGender[SelectedGender] == "Male"{
            strGender = "Male"
        }else if arrGender[SelectedGender] == "Female"{
            strGender = "Female"
        }else{
            strGender = "Prefer not to say"
        }
        
        txtGender.resignFirstResponder()

    }
    
   /* @IBAction func actionNotification_clickbtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    } */
    
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
   /* func addOtherProfession(str: String) {
        txtprofession.text = str
        txtprofession.resignFirstResponder()
    } */
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if(textField == txtmember)
        {
            txtmember.resignFirstResponder()
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberRoleVC") as! MemberRoleVC
            popOverConfirmVC.delegate = self
            if(txtmember.text != "")
            {
                popOverConfirmVC.selectedary = self.selectedary
            }
            self.addChildViewController(popOverConfirmVC)
            popOverConfirmVC.view.frame = self.view.frame
            self.view.center = popOverConfirmVC.view.center
            self.view.addSubview(popOverConfirmVC.view)
            popOverConfirmVC.didMove(toParentViewController: self)
        }
        
        
        
    }
    
    
    // MARK: - pickerview delegate and data source methods
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pickerview1)
        {
            return professionary.count //+ 1
        }
        else if(pickerView == pickerview2)
        {
            return flatary.count
        }
       // else if activeTextField == txtGender{
        else if(pickerView == pickerview3) {
          //  activeTextField == txtGender{
            return bloodgroupary.count
        }
        else{
            return arrGender.count
        }
        
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == pickerview1)
        {
//            if(row == professionary.count)
//            {
//                return "other"
//            }else
//            {
                return professionary[row].name
           // }
        }
        else if(pickerView == pickerview2)
        {
            return flatary[row]
            
        }
       // else if activeTextField == txtGender{
        else if(pickerView == pickerview3) {
            return bloodgroupary[row].name
        }
        else
        {
            return arrGender[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == pickerview1)
        {
//            if(row == professionary.count)
//            {
//                txtprofession.text =  "other"
//            }
//            else
//            {
                txtprofession.text = professionary[row].name
           // }
        }
        else if(pickerView == pickerview2)
        {
           // txtflattype.text = flatary[row]
            
        }
        else if(pickerView == pickerview3) {

      //  else if activeTextField == txtGender{
            txtbloodgroup.text = bloodgroupary[row].name
            SelectedBlodGroup = row
        }
        else
        {
            SelectedGender = row
        }
        
    }
    
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if (info[UIImagePickerControllerMediaType] as? String) != nil {
            
            let image = info[UIImagePickerControllerEditedImage] as! UIImage
            imgview.image =  image
            
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
    
    
    //MARK:- Add Circilar API
    func apicallUpdateProfile() {
        
        let token = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
        
        var str = ""
        if txtProfessionOther.text!.count > 0{
            str = txtProfessionOther.text!
        }else{
            str = ""
        }
        
        if txtprofession.text == "other" {
            professiongroupId = 0
        }
        
       /* if(txtflattype.text == "Owner"){
            UserType = 1
        }else if(txtflattype.text == "Tenant"){
            UserType = 3
        }else if(txtflattype.text == "Resident Owner"){
            UserType = 1
        }else{
            UserType = 3
        } */
        
        webservices().StartSpinner()
//        let param : Parameters = [
//            "name":txtname.text!,
//            "email":txtemail.text!,
//            "phone":txtcontact.text!,
//            "profession":txtprofession.text!,
//            "profession_detail":txtViewProfessionDetail.text!,
//            "bloodgroup":txtbloodgroup.text!,
//            "profession_other" : str,
//            "flattype":strFlatType,
//            "occupancy":txtflattype.text!
//        ]
        
        
        let param : Parameters = [
           // "ProfilePicture": imgData,
            "Name":txtname.text!,
            "Email":txtemail.text!,
            "Phone":txtcontact.text!,
            "DateOfBirth": txtbirthDate.text!,
            "BloodGroup": bloodgroupId, //txtbloodgroup.text!,
            "Gender": txtGender.text!,
            "Profession": professiongroupId, //txtprofession.text!,
            "ProfessionDetails":txtViewProfessionDetail.text!,
            "UserType": UserType //txtflattype.text!
        ]
        
        print("param profile : ",param)
        
        AF.upload(
            multipartFormData: { [self] MultipartFormData in
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let strFileName = formatter.string(from: date)
                
                
                for (key, value) in param {
                 //   MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
                    
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)

                }
                
                // if UsermeResponse?.data!.profilePhotoPath != nil
                
                 if (self.imgData == nil)
                 {
                    print("empty image data")
                }else {
                    
                   // imgData = (UIImagePNGRepresentation(self.imgview.image!)! as NSData) as Data
                    
                   // let imgData = UIImageJPEGRepresentation(self.imgview.image!, 1.0)

                    MultipartFormData.append(imgData!, withName: "ProfilePicture", fileName: "\(strFileName).png", mimeType: "image/jpeg/png")
                }
                
                
        }, to:  webservices().baseurl + API_UPDATE_PROFILE , headers:["Authorization": "Bearer "+token]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            print("Upload Progress: \(progress.fractionCompleted)")
            
           // webservices().StopSpinner()

        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
               // .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                
                print("statusCode :- ",statusCode!)
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(resp)
                        self.apicallUserMe()
                        
                    }
                    else if(statusCode == 401)
                    {
                        
                        
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                              let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                        
                        
                    }
                    else{
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:(response.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    break
                    
                }
                
            })
        
    }
    
    
    
    // MARK: - User me
    
    
    func apicallUserMe()
    {
        if(webservices().isConnectedToNetwork())
        {
            
            let token = UserDefaults.standard.value(forKey: USER_TOKEN) as! String
            webservices().StartSpinner()
            
           // Apicallhandler.sharedInstance.ApiCallUserMe(token: token) { JSON in
             
            Apicallhandler().ApiCallUserMe(URL: webservices().baseurl + "user", token: token ) { JSON in
                
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        UsermeResponse = resp
                        
                         //  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        //  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        
                       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC

                       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                        
                        if(self.isfrom == 3){
                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                            
                            self.revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                            
                            self.navigationController?.pushViewController(nextViewController, animated: true)
                            
                        }else{
                            
                            self.navigationController?.popViewController(animated: true)
                        }

//                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
//
//                            self.revealViewController()?.pushFrontViewController(nextViewController, animated: true)
//
//                            self.navigationController?.popViewController(animated: true)


                        
                                
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
           // webservices.sharedInstance.nointernetconnection()
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                                                                                                                                                                                                                                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoInternetVC") as! NoInternetVC
                                                                                                                                                                                                                                                     nextViewController.TryAgian = {
                                                                                                                                                                                                                                                         //self.apicallGetBuildings()

                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                     self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        
    }
    
    
    // MARK: - Userdefilne function
    
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
    
    
    // MARK: - get roles
    
    func ApiCallGetRoles()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().ApiGetRole(URL: webservices().baseurl + "Auth/getRoleList") { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.errorCode == 0)
                    {
                        var roleary = NSMutableArray()
                        for dic in resp.data
                        {
                            
                            if(self.isfrom == 0) || (self.isfrom == 1)
                            {
                                
                                //                            if((UsermeResponse?.data.memberRole.contains(dic.id))!)
                                //                          {
                                //                            roleary.add(dic.name)
                                //                            self.selectedary.add(dic.id)
                                //                            }
                            }
                            else
                            {
                                //Manish
                                //                            if(self.member!.memberRole.contains(dic.id))
                                //                            {
                                //                                roleary.add(dic.name)
                                //                                self.selectedary.add(dic.id)
                                //
                                //                            }
                                
                                
                            }
                        }
                        self.txtmember.text = roleary.componentsJoined(by:",")
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
    
    
    // MARK: - get Professsion
    
    func ApiCallGetProfession()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
           // Apicallhandler().ApiGetProfession(URL: webservices().baseurl + "communei/professions") { JSON in
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        print("token : ",token as! String)

        Apicallhandler().ApiGetProfession(URL: webservices().baseurl + "communei/professions", token: token as! String) { JSON in
           
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.professionary = resp.data
                        self.pickerview1.reloadAllComponents()
                        
                    }
                    else if(JSON.response?.statusCode == 401)
                    {
                        
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                        
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                              let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                         
                        
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


extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date //2
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
