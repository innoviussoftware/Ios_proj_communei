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
@available(iOS 13.0, *)
class ProfiledetailVC: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource  ,UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate,memberrole,addedOther{
   
    @IBOutlet weak var txtViewProfessionDetail: IQTextView!
    
    
    @IBOutlet weak var btnNotification: UIButton!
    var pickerview = UIPickerView()
    var pickerview1 = UIPickerView()
    var pickerview2 = UIPickerView()
    var pickerview3 = UIPickerView()
    
    var isfrom : Int? = 0
    var imgData = Data()
    
    @IBOutlet weak var btnBack: UIButton!
    var member : Members?
    var professionary = [Profession]()
    
    var selectedary = NSMutableArray()
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var txtcontact: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtprofession: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtprofdetail: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var txtflattype: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var txtaddress: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtmember: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtbloodgroup: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var viewCamera: UIView!

    @IBOutlet weak var constraintHeightProfessionOther: NSLayoutConstraint!
    @IBOutlet weak var txtProfessionOther: SkyFloatingLabelTextField!
    @IBOutlet weak var constraintTopProfessionOther: NSLayoutConstraint!
    
    var strFlatType = ""
    
    
    var bloodgroupary = ["O+","O-","A-","A+","AB-","AB+","B-","B+"]
    var flatary = ["Owner" ,"Tenant"]
    var Roleary  = ["Member" ,"Comimitee member" ,"Secretory" ,"Join Secretory" ,"President" ,"Treasure"]
    
    @IBAction func backaction(_ sender: Any) {
        if isfrom != 0{
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
    
    @IBAction func saveaction(_ sender: Any) {
        
        if !txtname.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
        }else if txtemail.hasText{
            
         if(isValidEmail(emailStr: txtemail.text!) == false)
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter vaild email")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtcontact.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter mobile number")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtprofession.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtViewProfessionDetail.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession details")
            self.present(alert, animated: true, completion: nil)
            
        }
         else if(UsermeResponse?.data!.flatType == "Owner of flat")
         {
           if !txtflattype.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter flat type")
            self.present(alert, animated: true, completion: nil)
            }else if !txtbloodgroup.hasText{
               let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your bloodgroup")
               self.present(alert, animated: true, completion: nil)
            }else{
                apicallUpdateProfile()
                return
               }
            }
        }else if !txtcontact.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter mobile number")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtprofession.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession")
            self.present(alert, animated: true, completion: nil)
            
        }else if !txtViewProfessionDetail.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession details")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(UsermeResponse?.data!.flatType == "Owner of flat")
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
        
        
        pickerview.delegate = self
        pickerview.dataSource = self
        
        pickerview1.delegate = self
        pickerview1.dataSource = self
        
        pickerview2.delegate = self
        pickerview2.dataSource = self
        
        pickerview3.delegate = self
        pickerview3.dataSource = self
        
        if(isfrom == 0)
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
            txtflattype.isUserInteractionEnabled = true
            txtbloodgroup.isUserInteractionEnabled = true
            txtmember.isUserInteractionEnabled = true
            txtaddress.isUserInteractionEnabled = true
            imgview.isUserInteractionEnabled = true
            
            if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
            {
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
                if(str.contains("Chairman") || str.contains("Secretory"))
                {
                    txtmember.isUserInteractionEnabled = true
                    btnsave.isHidden = false
                }
                else
                {
                    txtmember.isUserInteractionEnabled = false
                    
                }
            }
            
        } else if isfrom == 2{
                      btnBack.setImage(UIImage(named:"ic_back-1"), for: .normal)
                       btnsave.isHidden = false
                       txtname.isUserInteractionEnabled = true
                       txtemail.isUserInteractionEnabled = true
                       txtcontact.isUserInteractionEnabled = true
                       txtprofession.isUserInteractionEnabled = true
                       txtprofdetail.isUserInteractionEnabled = true
                       txtflattype.isUserInteractionEnabled = true
                       txtbloodgroup.isUserInteractionEnabled = true
                       txtmember.isUserInteractionEnabled = true
                       txtaddress.isUserInteractionEnabled = true
                       imgview.isUserInteractionEnabled = true
                       
                       if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
                       {
                           let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                           
                           if(str.contains("Chairman") || str.contains("Secretory"))
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
            txtflattype.isUserInteractionEnabled = false
            txtbloodgroup.isUserInteractionEnabled = false
            txtmember.isUserInteractionEnabled = false
            txtaddress.isUserInteractionEnabled = false
            imgview.isUserInteractionEnabled = false
            if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
            {
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
                if(str.contains("Chairman") || str.contains("Secretory"))
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
        txtbloodgroup.inputView = pickerview
        
        
        
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
        txtflattype.inputAccessoryView = toolBar2
        txtflattype.inputView = pickerview2
        
        
        
        if(isfrom == 0)
        {
            txtname.text = UsermeResponse?.data!.name
            
            txtcontact.text = UsermeResponse?.data!.phone
            
            lblname.text = UsermeResponse?.data!.name
            
            if UsermeResponse?.data!.image != nil{
                imgview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse?.data!.image)!), placeholderImage: UIImage(named: "img_default"))
            }
            
            lblcontact.text = UsermeResponse?.data!.phone
            
            txtemail.text = UsermeResponse?.data!.email
            
            if UsermeResponse?.data!.profession == "other"{
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
                
            }
            if(UsermeResponse != nil)
            {
                if(UsermeResponse?.data!.flatType != nil)
                {
            strFlatType = setOptionalStr(value: UsermeResponse?.data!.flatType)!
                }
                if(UsermeResponse?.data!.occupancy != nil)
                {
            txtflattype.text = setOptionalStr(value: UsermeResponse?.data!.occupancy)
                }
                if(UsermeResponse?.data!.bloodgroup != nil)
                             {
            txtbloodgroup.text = setOptionalStr(value: UsermeResponse?.data!.bloodgroup)
                }
            }
            // txtaddress.text = UsermeResponse?.data.address
            
            
        }else if isfrom == 2{
            
                        txtname.text = UsermeResponse?.data!.name
                        
                        txtcontact.text = UsermeResponse?.data!.phone
                        
                        lblname.text = UsermeResponse?.data!.name
                        
                        if UsermeResponse?.data!.image != nil{
                            imgview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse?.data!.image)!), placeholderImage: UIImage(named: "img_default"))
                        }
                        
                        lblcontact.text = UsermeResponse?.data!.phone
                        
                        txtemail.text = UsermeResponse?.data!.email
                        
                        if UsermeResponse?.data!.profession == "other"{
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
                            
                        }
                        if(UsermeResponse != nil)
                        {
                            if(UsermeResponse?.data!.flatType != nil)
                            {
                        strFlatType = setOptionalStr(value: UsermeResponse?.data!.flatType)!
                            }
                            if(UsermeResponse?.data!.occupancy != nil)
                            {
                        txtflattype.text = setOptionalStr(value: UsermeResponse?.data!.occupancy)
                            }
                            if(UsermeResponse?.data!.bloodgroup != nil)
                                         {
                        txtbloodgroup.text = setOptionalStr(value: UsermeResponse?.data!.bloodgroup)
                            }
                        }

        }
        else
        {
            
            //Manish 07-09-19
            
            txtname.text = member?.name
            
            txtcontact.text = member?.phone
            
            lblname.text = member?.name
            
            if member?.image != nil{
                imgview.sd_setImage(with: URL(string:webservices().imgurl + (member?.image)!), placeholderImage: UIImage(named: "vendor profile"))
            }
            
            
            lblcontact.text = member?.phone
            
            txtemail.text = member?.email
            txtprofession.text = member?.profession
            txtViewProfessionDetail.text = member?.professionDetail
            //txtViewProfessionDetail.placeholder = ""
            
            txtflattype.text = member?.flatType
            strFlatType = (member?.flatType)!
            txtbloodgroup.text = member?.bloodgroup
            // txtaddress.text = member?.ad
            
        }
        
        
        txtcontact.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)
        
        // 7/8/20.
        
       /* let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapimage))
        imgview.addGestureRecognizer(tap) */
        
    // imgview.isUserInteractionEnabled = true
        
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
    @objc func donePressed1()
        
    {
          if(txtprofession.text == "")
              {
                  
                txtProfessionOther.isHidden = true
                constraintHeightProfessionOther.constant = 0
                constraintTopProfessionOther.constant = 0
                
                txtprofession.text = professionary[0].name
                  
                  txtprofession.resignFirstResponder()
              }
              else
              {
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
        }
        
        
      
    }
    @objc func donePressed2()
        
    {
        if(txtflattype.text == "")
        {
            
            txtflattype.text = flatary[0]
            
            txtflattype.resignFirstResponder()
        }
        else
        {
            txtflattype.resignFirstResponder()
            
        }
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
    func addOtherProfession(str: String) {
        txtprofession.text = str
        txtprofession.resignFirstResponder()
    }
    
    
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
            
            return professionary.count + 1
            
        }
        else if(pickerView == pickerview2)
        {
            
            return flatary.count
            
        }
        else{
            return bloodgroupary.count
        }
        
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == pickerview1)
        {
            if(row == professionary.count)
            {
                return "other"
            }else
            {
                return professionary[row].name
            }
        }
        else if(pickerView == pickerview2)
        {
            return flatary[row]
            
        }
        else
        {
            return bloodgroupary[row]
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == pickerview1)
        {
            if(row == professionary.count)
            {
                txtprofession.text =  "other"
            }
            else
            {
                txtprofession.text = professionary[row].name
            }
        }
        else if(pickerView == pickerview2)
        {
            txtflattype.text = flatary[row]
            
        }
        else
        {
            txtbloodgroup.text = bloodgroupary[row]
        }
        
    }
    
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
            
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
        
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
        
        var str = ""
        if txtProfessionOther.text!.count > 0{
            str = txtProfessionOther.text!
        }else{
            str = ""
        }
        
        webservices().StartSpinner()
        let param : Parameters = [
            "name":txtname.text!,
            "email":txtemail.text!,
            "phone":txtcontact.text!,
            "profession":txtprofession.text!,
            "profession_detail":txtViewProfessionDetail.text!,
            "bloodgroup":txtbloodgroup.text!,
            "profession_other" : str,
            "flattype":strFlatType,
            "occupancy":txtflattype.text!
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
                
                if self.imgData.count != 0{
                    MultipartFormData.append(self.imgData, withName: "profile", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                }
                
                
        }, to:  webservices().baseurl + API_UPDATE_PROFILE,headers:["Accept": "application/json","Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                //webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(resp)
                        self.apicallUserMe()
                        
                    }else{
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
            Apicallhandler.sharedInstance.ApiCallUserMe(token: token) { JSON in
                
                
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        UsermeResponse = resp
                        
                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        //  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        
                       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC

                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                    //self.navigationController?.popViewController(animated: true)
                        
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
                            
                            if(self.isfrom == 0)
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
            Apicallhandler().ApiGetProfession(URL: webservices().baseurl + "professional") { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.professionary = resp.data
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
