//
//  AddMemberVC.swift
//  SocietyMangement
//
//  Created by MacMini on 04/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SDWebImage

import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AddMemberVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDataSource , UIPickerViewDelegate , UITextFieldDelegate {
 
    
    @IBOutlet weak var imgvie: UIImageView!
    
    var iconclick1 = 0

    var buildingary = [Building]()
    var genderary = ["Male" ,"Female"]
    var professionary = ["Government job" ,"Business" ,"Teacher" ,"Doctor","Other"]
    var flatary = ["Owner" ,"Rent"]
    var Roleary  = ["Member" ,"Comimitee member" ,"Secretory" ,"Join Secretory" ,"President" ,"Treasure"]

    
    var buildingid: String?
    var selectedindex = 0
    var isfrom = 0
    var dic:Members?
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changepicture(_ sender: Any) {
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
    

    @IBOutlet weak var txtbuilding: GBTextField!
    
    @IBOutlet weak var txtname: GBTextField!
    
    
    @IBOutlet weak var txtgender: GBTextField!
    
    
    @IBOutlet weak var txtmobile: GBTextField!
    
    @IBOutlet weak var txtemail: GBTextField!
    
    
    @IBOutlet weak var txtprofession: GBTextField!
    
    @IBOutlet weak var txtprofdetail: GBTextField!
    
    
    @IBOutlet weak var txtflatno: GBTextField!
    
    
    @IBOutlet weak var txtflattype: GBTextField!
    
    @IBOutlet weak var txtmemberrole: GBTextField!
    
    
    @IBOutlet weak var txtusername: GBTextField!
    
    @IBOutlet weak var txtpassword: GBTextField!
    
    var pickerview = UIPickerView()
    
    @IBAction func saveaction(_ sender: Any) {
        
        if(txtbuilding.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select building")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
            
        }else if(txtgender.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select gender")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtmobile.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter mobile no")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtemail.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter email")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtprofession.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select your profession")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtprofdetail.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter your profession detail")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtflatno.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter flat no")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtflattype.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select flat type")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtmemberrole.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select flat type")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtusername.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter username")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtpassword.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter password")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            if(isfrom == 0)
            {
            apicallAddemembser()
            }
            else{
                
                 //apicallUpdateMember()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        pickerview.delegate = self
        pickerview.dataSource = self

        apicallGetBuildings()
        pickerview.delegate = self
        pickerview.dataSource = self
        txtpassword.rightView?.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action:#selector(tapimage1))
        txtpassword.rightView?.addGestureRecognizer(tap)
        
        addtoolbar(textfield:txtbuilding)
        addtoolbar(textfield:txtgender)
        addtoolbar(textfield:txtprofession)
        addtoolbar(textfield:txtflattype)
        addtoolbar(textfield:txtmemberrole)
        
        
        txtbuilding.delegate = self
        txtname.delegate = self
        txtgender.delegate = self
        txtmobile.delegate = self
        txtemail.delegate = self
        txtprofession.delegate = self
        txtprofdetail.delegate = self
        txtflatno.delegate = self
        txtflattype.delegate = self
        txtmemberrole.delegate = self
        txtusername.delegate = self
        txtpassword.delegate = self

        if(isfrom == 1)
        {
            txtname.text = dic?.name
            txtgender.text = dic?.gender
            txtmobile.text = dic?.phone
            txtemail.text = dic?.email
            txtprofession.text = dic?.profession
            txtprofdetail.text = dic?.professionDetail
            txtflatno.text = dic?.name
            txtflattype.text = dic?.flatType
            txtmemberrole.text = dic?.role
            txtusername.text = dic?.name
           // txtpassword.text = dic?.memberPassword
            
            if dic!.image != nil{
                 imgvie.sd_setImage(with: URL(string: webservices().imgurl + dic!.image!), placeholderImage: UIImage(named: "img_default"))
            }
            
           

        }

        
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
    
    
  

   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == txtbuilding)
        {
        selectedindex =  1
        pickerview.tag = 1
        pickerview.reloadAllComponents()
        }
        if(textField == txtgender)
        {
            selectedindex =  2
            pickerview.tag = 2
            pickerview.reloadAllComponents()
        }
        if(textField == txtprofession)
        {
            selectedindex =  3
            pickerview.tag = 3
            pickerview.reloadAllComponents()
        }

        if(textField == txtflattype)
        {
            selectedindex =  4
            pickerview.tag = 4
            pickerview.reloadAllComponents()
        }
        if(textField == txtmemberrole)
        {
            txtmemberrole.resignFirstResponder()
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "MemberRoleVC") as! MemberRoleVC
           // popOverConfirmVC.delegate = self
            if(txtmemberrole.text != "")
            {
            popOverConfirmVC.selectedary = (txtmemberrole.text?.components(separatedBy:",") as! NSArray).mutableCopy() as! NSMutableArray
            }
            self.addChildViewController(popOverConfirmVC)
            popOverConfirmVC.view.frame = self.view.frame
            self.view.center = popOverConfirmVC.view.center
            self.view.addSubview(popOverConfirmVC.view)
            popOverConfirmVC.didMove(toParentViewController: self)
        }
        
    }
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
            
            var image = info[UIImagePickerControllerEditedImage] as! UIImage
            imgvie.image =  image
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    //MARK:-User define functions
    
    func camera()
    {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myPickerController.mediaTypes = ["public.image"]
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    // MARK: - pickerview delegate and data source methods
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     if(pickerview.tag == 1)
     {
        return buildingary.count
        }
        else if(pickerview.tag == 2)
     {
        return genderary.count

        
        }
     else if(pickerview.tag == 3)
     {
        return professionary.count
        
        
        }
     else if(pickerview.tag == 4)
     {
        return flatary.count
        
        
        }
     else if(pickerview.tag == 5)
     {
        return Roleary.count
        
        
        }
        else
     {
        
        return 0
        }
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerview.tag == 1)
        {
        return buildingary[row].PropertyName
        }
        else  if(pickerview.tag == 2)
        {
            return genderary[row]
        }
        else  if(pickerview.tag == 3)
        {
            return professionary[row]
        }
        else  if(pickerview.tag == 4)
        {
            return flatary[row]
        }
        else  if(pickerview.tag == 5)
        {
            return Roleary[row]
        }
        else
        {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerview.tag == 1)
        {
        txtbuilding.text = buildingary[row].PropertyName
        buildingid = String(buildingary[row].PropertyID)
        }
        if(pickerview.tag == 2)
        {
            txtgender.text = genderary[row]
        }
        if(pickerview.tag == 3)
        {
            txtprofession.text = professionary[row]
        }
        if(pickerview.tag == 4)
        {
            txtflattype.text = flatary[row]
        }
        if(pickerview.tag == 5)
        {
            txtmemberrole.text = Roleary[row]
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
           // Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, societyid:UserDefaults.standard.value(forKey:"societyid")! as! String) { JSON in
        
        let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
    
        // not any use in this error societyid pass future time
        
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
                        self.buildingary = resp.data
                        self.pickerview.reloadAllComponents()
                        if(resp.data.count > 0)
                        {
                            self.txtbuilding.text = resp.data[0].PropertyName
                            self.buildingid = String(resp.data[0].PropertyID)
                            
                        }
                      var nameary = NSMutableArray()
                        if(self.isfrom == 1)
                    {
                        for new in resp.data
                        {
                           // if((self.dic?.buildingID.contains((new.id as NSNumber).stringValue))!)
                         if self.dic?.buildingID == new.PropertyID
                         {
                            nameary.add(new.PropertyName)
                            self.buildingid = String(new.PropertyID)
                            }
                         }
                         self.txtbuilding.text =  nameary.componentsJoined(by:",")
                        
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
    
    func addtoolbar(textfield:UITextField)
    {
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
    
    textfield.delegate = self
    textfield.inputAccessoryView = toolBar
    textfield.inputView = pickerview
    }
    
    
    @objc func donePressed()
    {
        if(selectedindex == 1)
        {
            if(txtbuilding.text == "")
            {
                txtbuilding.text = buildingary[0].PropertyName
                buildingid = (buildingary[0].PropertyID as NSNumber).stringValue
                //apicallGetMembers()
                
            }
            
        }
        if(selectedindex == 2)
        {
            if(txtgender.text == "")
            {
                txtgender.text = genderary[0]
                //apicallGetMembers()
                
            }
            
        }
        if(selectedindex == 3)
        {
            
           
            if(txtprofession.text == "")
            {
                txtprofession.text = professionary[0]
                //apicallGetMembers()
                
            }
            
            
        }
        if(selectedindex == 4)
        {
            if(txtflattype.text == "")
            {
                txtflattype.text = flatary[0]
                //apicallGetMembers()
                
            }
            
        }
        if(selectedindex == 5)
        {
            if(txtmemberrole.text == "")
            {
                txtmemberrole.text = Roleary[0]
                //apicallGetMembers()
                
            }
            
        }
        
        view.endEditing(true) // or do something

    }
    @objc func cancelPressed()
    {
        view.endEditing(true) // or do something

    }
    
    // MARK: - image tap gesture
    
    @objc func tapimage1(sender:UITapGestureRecognizer)
    {
        if(iconclick1 == 0)
        {
            iconclick1 = 1
            txtpassword.isSecureTextEntry = false
            txtpassword.rightImage = #imageLiteral(resourceName: "ic_eye_open")
            txtpassword.rightView?.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer()
            tap.addTarget(self, action:#selector(tapimage1))
            txtpassword.rightView?.addGestureRecognizer(tap)
            
        }else
        {
            iconclick1 = 0
            txtpassword.isSecureTextEntry = true
            txtpassword.rightImage = #imageLiteral(resourceName: "ic_eye_cloese")
            txtpassword.rightView?.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer()
            tap.addTarget(self, action:#selector(tapimage1))
            txtpassword.rightView?.addGestureRecognizer(tap)
            
        }
        
    }
    
    
    // MARK: - Add Member
    
    func apicallAddemembser()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().AddMember(URL: webservices().baseurl + "addMember", society_id:UserDefaults.standard.value(forKey:"societyid")! as! String, building_id: self.buildingid!, member_id: UserDefaults.standard.value(forKey:"id")! as! String, member_name: txtname.text!, member_phone: txtmobile.text!, member_email: txtemail.text!, member_house_no: txtflatno.text!, member_house_type: txtflattype.text!, member_role: txtmemberrole.text!, member_profession: txtprofession.text!, member_profession_detail: txtprofdetail.text!, member_username: txtusername.text!, member_password: txtpassword.text!, member_gender: txtgender.text!, file: imgvie.image!) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                   self.navigationController?.popViewController(animated: true)
                        
                    }
                    else
                    {  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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
    
//     MARK: - Update Member
//
//    func apicallUpdateMember()
//    {
//        if(webservices().isConnectedToNetwork())
//        {
//            webservices().StartSpinner()
//            Apicallhandler().UPdateMember(URL: webservices().baseurl + "editMember", user_id: UserDefaults.standard.value(forKey:"id")! as! String, society_id:UserDefaults.standard.value(forKey:"societyid")! as! String, building_id: self.buildingid!, member_id:dic!.id , member_name: txtname.text!, member_phone: txtmobile.text!, member_email: txtemail.text!, member_house_no: txtflatno.text!, member_house_type: txtflattype.text!, member_role: txtmemberrole.text!, member_profession: txtprofession.text!, member_profession_detail: txtprofdetail.text!, member_username: txtusername.text!, member_password: txtpassword.text!, member_gender: txtgender.text!, file: imgvie.image!) { JSON in
//                switch JSON.result{
//                case .success(let resp):
//
//                    webservices().StopSpinner()
//                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
//                    {
//                        self.navigationController?.popViewController(animated: true)
//
//                    }
//                    else
//                    {  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
//                        self.present(alert, animated: true, completion: nil)
//
//                    }
//
//                    print(resp)
//                case .failure(let err):
//                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
//                    self.present(alert, animated: true, completion: nil)
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

    
    

}
