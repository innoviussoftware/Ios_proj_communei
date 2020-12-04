//
//  SignUPStep2.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 14/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class SignUPStep2: BaseVC {

    var cityary = [City]()
       var arearary = [Area]()
       var societyary = [Society]()
       var buildingary = [Building]()
       var newbuildingary = [Building]()
       var Flatary = [Flat]()
       var NewFlatary = [Flat]()
       
       var cityid = ""
       var areaid = ""
      // var societyid = ""
    var societyid = Int()

      // var buildingid = ""
    var buildingid = Int()

       //var Flatid = ""
    var Flatid = Int()
       var role = ""
    var UserType = Int()
    
   // var mobile = ""

    @IBOutlet weak var btnaddfarmviall: RSButtonCustomisation!
    
    @IBOutlet weak var viewcheckbox: UIView!
    
    @IBOutlet weak var hightcheckboxview: NSLayoutConstraint!
    
    @IBOutlet weak var tblbuilding: UITableView!
       
    @IBOutlet weak var tblflat: UITableView!
    
    @IBOutlet weak var txtblockname: RSTextFieldCustomisation!
    @IBOutlet weak var txtflats: RSTextFieldCustomisation!

       @IBOutlet weak var cbowner: Checkbox!
       
       @IBOutlet weak var cbrenter: Checkbox!
       
       @IBOutlet weak var cbother: Checkbox!
    
    @IBOutlet weak var txtcity: RSTextFieldCustomisation!
      
      @IBOutlet weak var txtarea: RSTextFieldCustomisation!
      
      @IBOutlet weak var txtcommunity: RSTextFieldCustomisation!
    
    @IBOutlet weak var btnOwner: UIButton!
    @IBOutlet weak var btnRentingFlat: UIButton!
    

    var pickerview1 = UIPickerView()
    var pickerview2 = UIPickerView()
    var pickerview3 = UIPickerView()
    
    var pickerview4 = UIPickerView()
    var pickerview5 = UIPickerView()
    var pickerview6 = UIPickerView()


    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var hightbottomview: NSLayoutConstraint!
    @IBOutlet weak var hightflat: NSLayoutConstraint!
    @IBOutlet weak var hightbuilding: NSLayoutConstraint!
    
    @IBOutlet weak var highttxtfalt: NSLayoutConstraint!
    
    @IBOutlet weak var imgflatserarch: UIImageView!
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    @IBAction func RenterAction(_ sender: Any) {
        
        cbowner.isChecked = false
        cbrenter.isChecked = true
        cbother.isChecked = false
    }
    
    @IBAction func OtherAction(_ sender: Any) {
        
        cbowner.isChecked = false
        cbrenter.isChecked = false
        cbother.isChecked = true
        
    }
    
    
    @IBAction func OwnerAction(_ sender: Any) {
        
        cbowner.isChecked = true
        cbrenter.isChecked = false
        cbother.isChecked = false
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //  setdefaultvalues()

       // checkbox(cb: cbother)
       // checkbox(cb: cbowner)
      //  checkbox(cb: cbrenter)

        ApiCallGetCity()
        
        pickerview1.delegate = self
              pickerview1.dataSource = self
              pickerview2.delegate = self
              pickerview2.dataSource = self
              
              pickerview3.delegate = self
              pickerview3.dataSource = self
        
        pickerview4.delegate = self
        pickerview4.dataSource = self
        
        pickerview5.delegate = self
        pickerview5.dataSource = self
        
        pickerview6.delegate = self
        pickerview6.dataSource = self
        
        txtcity.delegate = self
        txtarea.delegate = self
        txtcommunity.delegate = self
        txtblockname.delegate = self
        txtflats.delegate = self

        
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
              txtcity.inputAccessoryView = toolBar
              txtcity.inputView = pickerview1
              
              
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
              txtarea.inputAccessoryView = toolBar1
              txtarea.inputView = pickerview2
              
              
              
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
              txtcommunity.inputAccessoryView = toolBar2
              txtcommunity.inputView = pickerview3
        
        
        let toolBar3 = UIToolbar()
        toolBar3.barStyle = .default
        toolBar3.isTranslucent = true
        toolBar3.tintColor = AppColor.appcolor
        let donetxtblockname = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressedtxtblockname))
        let canceltxtblockname = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spacetxtblockname = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar3.setItems([canceltxtblockname, spacetxtblockname, donetxtblockname], animated: false)
        toolBar3.isUserInteractionEnabled = true
        toolBar3.sizeToFit()
        txtblockname.inputAccessoryView = toolBar3
        txtblockname.inputView = pickerview4
        
        
        let toolBar4 = UIToolbar()
        toolBar4.barStyle = .default
        toolBar4.isTranslucent = true
        toolBar4.tintColor = AppColor.appcolor
        let donetxtflats = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressedtxtflats))
        let canceltxtflats = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spacetxtflats = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar4.setItems([canceltxtflats, spacetxtflats, donetxtflats], animated: false)
        toolBar4.isUserInteractionEnabled = true
        toolBar4.sizeToFit()
        txtflats.inputAccessoryView = toolBar4
        txtflats.inputView = pickerview5
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signup(_ sender: Any) {
          
          if cbowner.isChecked == false && cbrenter.isChecked == false{
              let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Select who you are")
              self.present(alert, animated: true, completion: nil)
          }else{
               ApiCallSignUp2()
          }
          
      }

    
          func setdefaultvalues()
          {
            btnaddfarmviall.isHidden = true
            self.viewbottom.isHidden = true
            self.hightbottomview.constant = 0
            
          }
    
        func checkbox(cb:Checkbox)
        {
            cb.borderStyle = .circle
            cb.checkmarkStyle = .circle
            cb.uncheckedBorderColor = AppColor.radioUncheckColor
                //UIColor(named:"Orange")
            cb.borderWidth = 1
            cb.checkedBorderColor = UIColor(named:"Orange")
            cb.backgroundColor = .clear
            cb.checkboxBackgroundColor = UIColor.clear
            cb.checkmarkColor = UIColor(named:"Orange")
            
        }
    
    
      @objc func donePressed()
          
      {
          if(txtcity.text == "")
          {
              let row = self.pickerview1.selectedRow(inComponent: 0)
              txtcity.text = cityary[row].Name
            cityid = String(cityary[row].CityID!)
              txtcity.resignFirstResponder()
              ApiCallGetArea()
          }
          else
          {
               let row = self.pickerview1.selectedRow(inComponent: 0)
                           txtcity.text = cityary[row].Name
            cityid = String(cityary[row].CityID!)
                           txtcity.resignFirstResponder()
                           ApiCallGetArea()
              
          }
      }
      
      @objc func donePressed1()
          
      {
          if(txtarea.text == "")
          {
            let row = self.pickerview2.selectedRow(inComponent: 0)

              txtarea.resignFirstResponder()
              areaid = String(arearary[row].AreaID)
              txtarea.text = arearary[row].AreaName
              ApiCallGetSociety()
          }
          else
          {
               let row = self.pickerview2.selectedRow(inComponent: 0)

                           txtarea.resignFirstResponder()
                           areaid = String(arearary[row].AreaID)
                           txtarea.text = arearary[row].AreaName
                           ApiCallGetSociety()
          }
      }
      @objc func donePressed2()
          
      {
          if(txtcommunity.text == "")
          {
                self.txtcommunity.resignFirstResponder()
              if societyary.count > 0{
                let row = self.pickerview3.selectedRow(inComponent: 0)

                  self.txtcommunity.text = self.societyary[row].SocietyName
                  //self.txtcommunity.resignFirstResponder()
                  self.societyid =  self.societyary[row].SocietyID
                  self.apicallGetBuildings()
              }
            
           /* self.viewbottom.isHidden = false
            self.hightbottomview.constant = 196
            self.hightflat.constant = 0
            self.highttxtfalt.constant = 0
            self.imgflatserarch.isHidden = true
            self.hightcheckboxview.constant = 0
            self.viewcheckbox.isHidden = true
            self.hightbuilding.constant = 137
            self.tblbuilding.isHidden = false */
          }
          else
          {
              txtcommunity.resignFirstResponder()
              if societyary.count > 0{
                let row = self.pickerview3.selectedRow(inComponent: 0)

                  self.txtcommunity.text = self.societyary[row].SocietyName
                  //self.txtcommunity.resignFirstResponder()
                  self.societyid = self.societyary[row].SocietyID
                  self.apicallGetBuildings()
                
          /*  self.viewbottom.isHidden = false
                self.hightbottomview.constant = 196
                self.hightflat.constant = 0
                self.highttxtfalt.constant = 0
                self.imgflatserarch.isHidden = true
               self.hightcheckboxview.constant = 0
                self.viewcheckbox.isHidden = true
                self.hightbuilding.constant = 137
                self.tblbuilding.isHidden = false */
                
              }
          }
         
      }
    
    @objc func donePressedtxtblockname()
        
    {
        if(txtblockname.text == "")
        {
          let row = self.pickerview4.selectedRow(inComponent: 0)

            txtblockname.resignFirstResponder()
            
            txtblockname.text = buildingary[row].PropertyName
            
            buildingid = buildingary[row].PropertyID

           // self.txtblockname.resignFirstResponder()
            
            apicallGetFlat()
        }
        else
        {
             let row = self.pickerview4.selectedRow(inComponent: 0)

            txtblockname.resignFirstResponder()
            
            txtblockname.text = buildingary[row].PropertyName
            
            buildingid = buildingary[row].PropertyID
            
            apicallGetFlat()

        }
    }
    
    
    @objc func donePressedtxtflats() {
        
        if(txtflats.text == "")
        {
          let row = self.pickerview5.selectedRow(inComponent: 0)

            txtflats.resignFirstResponder()
            
            self.txtflats.resignFirstResponder()

            self.txtflats.text = self.Flatary[row].PropertyName
            
            Flatid = self.Flatary[row].PropertyID!

           // self.txtblockname.resignFirstResponder()
            
          //  apicallGetFlat()
            
        }
        else
        {
             let row = self.pickerview5.selectedRow(inComponent: 0)

            txtflats.resignFirstResponder()
            
            self.txtflats.text = self.Flatary[row].PropertyName
            
            Flatid = self.Flatary[row].PropertyID!

          //  apicallGetFlat()

        }
        
    }
      
      @objc  func cancelPressed() {
          view.endEditing(true) // or do something
      }
      
    
    // MARK: - Api call get city
    
    func ApiCallGetCity()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
        let secret = UserDefaults.standard.string(forKey: USER_SECRET)
        
        print("secret :- ",secret!)
        print("mobile :- ",mobile!)
        
        let param : Parameters = [
            "Phone" : mobile!,
            "Secret" : secret!
        ]
        
        print("param :- ",param)

          //  Apicallhandler().ApiCallGetCity(URL: webservices().baseurl + API_GET_CITY) { response in
                
            Apicallhandler.sharedInstance.ApiCallGetCity(URL: webservices().baseurl + API_GET_CITY, param: param) { response in
                
                webservices().StopSpinner()
                switch(response.result) {
                case .success(let resp):
                    if resp.status == 1{
                        self.cityary = resp.data
                        
                        self.txtarea.text = ""
                        self.txtcommunity.text = ""
                        self.pickerview1.reloadAllComponents()
                        
                    }else{
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    break
                case .failure(let err):
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    
                    
                }
                
            }
            
       
    }
    
    
    // MARK: - Api call get area by city
    
    func ApiCallGetArea()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
            let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
        
           // let intUserId = Int(cityid)
           // print("intUserId : ",intUserId! as Int)
             
             let param : Parameters = [
                 "Phone" : mobile!,
                 "Secret" : secret,
                 "City" : cityid
             ]
            
            Apicallhandler.sharedInstance.ApiCallGetArea(URL: webservices().baseurl + API_GET_AREA, param: param) { response in
                
                switch response.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        self.arearary = resp.data
                        self.txtarea.text = ""
                        self.txtcommunity.text = ""
                        self.pickerview2.reloadAllComponents()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Area is not found for selected city")
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
    
    // MARK: - Api call get Society by area
    
    func ApiCallGetSociety()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
                
                let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
            
                 let param : Parameters = [
                     "Phone" : mobile!,
                     "Secret" : secret,
                     "City" : cityid,
                     "Area" : areaid
                 ]
        
                
                Apicallhandler.sharedInstance.ApiCallGetSociety(URL: webservices().baseurl + API_GET_SOCIETY, param: param) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        
                        self.societyary = resp.data
                        self.txtcommunity.text = ""
                        self.pickerview3.reloadAllComponents()
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
    
    
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
        let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
    
         let param : Parameters = [
             "Phone" : mobile!,
             "Secret" : secret,
             "Society" : societyid
         ]
        
        
           // Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, societyid:societyid) { JSON in
                
                Apicallhandler.sharedInstance.GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, param: param) { JSON in
                
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        self.buildingary = resp.data
                        self.newbuildingary = resp.data
                      //  self.tblbuilding.reloadData()
                        
                        self.pickerview4.reloadAllComponents()

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
    
    /// MARK: - get Flat
    
    func apicallGetFlat()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
          //  Apicallhandler().ApiCallGetFlat(URL: webservices().baseurl + API_GET_FLAT, society_id:"", building_id: buildingid) { JSON in
        
          let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
    
             let param : Parameters = [
                 "Phone" : mobile!,
                 "Secret" : secret,
                 "Society" : societyid,
                "Parent" : buildingid
             ]
        
            Apicallhandler.sharedInstance.ApiCallGetFlat(URL: webservices().baseurl + API_GET_FLAT, param: param) { JSON in
                
                let statusCode = JSON.response?.statusCode
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(resp.status == 1)
                    {
                        self.Flatary = resp.data!
                        self.NewFlatary = resp.data!
                       
                      //  self.tblflat.reloadData()
                        
                        self.pickerview5.reloadAllComponents()
                        
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
    // MARK: - Api call signup step2
        
        func ApiCallSignUp2()
        {
              if !NetworkState().isInternetAvailable {
                             ShowNoInternetAlert()
                             return
                         }
            webservices().StartSpinner()
                
                
                if(cbowner.isChecked)
                {
                    role = "Owner of flat"
                    UserType = 1
                }
                if(cbrenter.isChecked)
                {
                    role = "Renting the flat"
                    UserType = 3
                }
//                if(cbother.isChecked)
//                {
//                    role = "Renting the flat with other tenants"
//                }
                
     
                 var strFCmToken = ""
                if UserDefaults.standard.value(forKey: "FcmToken") != nil{
                    strFCmToken = UserDefaults.standard.value(forKey: "FcmToken") as! String
                }else{
                    strFCmToken = "abc"
                }
            //NEW
              //  let parameter:Parameters = ["phone":mobile!,"username":fullname!,"email":email!,"society_id":societyid,"building_id":buildingid,"flat_id":Flatid,"fcm_token":strFCmToken,"flatType" : role,"city_id":cityid,"area_id":areaid,"profession_detail":"","profession":""]
          
            let secret = UserDefaults.standard.string(forKey: USER_SECRET)!

            let parameter:Parameters = [
                "Email": email!,
                "Phone": mobile!,
                "Secret": secret,
                "Name": fullname!,
                "Society": societyid, 
                "Building": buildingid,
                "Flat": Flatid,
                "UserType": UserType,
                "FCMToken": strFCmToken
            ]
                
            print("parameter register :- ",parameter)

                Apicallhandler().ApiCallSignUp2(URL: webservices().baseurl + APIRegister, param: parameter) { response in
                  //  let statusCode = response.response?.statusCode

                    switch response.result{
                    case .success(let resp):
                        webservices().StopSpinner()
                        
                       if resp.status == 1
                        {

                            
                            let alert = UIAlertController(title: Alert_Titel, message:"Thank you for registering. You can login once your Communie admin approve your account" , preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                //self.navigationController?.popToRootViewController(animated: true)
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                              let navController = UINavigationController(rootViewController: aVC)
                                                                                              navController.isNavigationBarHidden = true
                                                                                 self.appDelegate.window!.rootViewController  = navController
                            }))
                            self.present(alert, animated: true, completion: nil)
                                                        
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

@available(iOS 13.0, *)
extension SignUPStep2 :UITextFieldDelegate
{
    
    // MARK: - Textfield delegate and datasource methods
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           
           
           if(textField == txtcity)
           {
            self.viewbottom.isHidden = true
               self.hightbottomview.constant = 0
               
               if(cityary.count == 0)
                          {
                              let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No cities found")
                              self.present(alert, animated: true, completion: nil)
                              
                              txtcity.resignFirstResponder()
                          }
            
               
           }
           if(textField == txtarea)
           {
            self.viewbottom.isHidden = true
                          self.hightbottomview.constant = 0
               if(arearary.count == 0)
               {
                   let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No area found")
                   self.present(alert, animated: true, completion: nil)
                   
                   txtarea.resignFirstResponder()
               }
               if(txtcity.text == "" )
               {
                self.viewbottom.isHidden = true
                              self.hightbottomview.constant = 0
                   let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select city")
                   self.present(alert, animated: true, completion: nil)
                   
                   txtarea.resignFirstResponder()
               }
               
           }
           if(textField == txtcommunity )
           {
               self.viewbottom.isHidden = true
                            self.hightbottomview.constant = 0
               if(societyary.count == 0)
               {
                   let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No Society found")
                                self.present(alert, animated: true, completion: nil)
                                txtcommunity.resignFirstResponder()
               }
               if(txtarea.text == "")
               {
                   let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select area")
                   self.present(alert, animated: true, completion: nil)
                   txtcommunity.resignFirstResponder()
                   
               }
           }
           if(textField == txtblockname)
           {
               
               UIView.animate(withDuration: 0.3, delay: 0.2, options:
                   UIViewAnimationOptions.curveEaseOut, animations: {
                     /*  self.viewbottom.isHidden = false
                                  self.hightbottomview.constant = 250
                                  self.hightflat.constant = 0
                                  self.highttxtfalt.constant = 0
                                  self.imgflatserarch.isHidden = true
                                  self.hightcheckboxview.constant = 0
                                  self.viewcheckbox.isHidden = true
                                  self.hightbuilding.constant = 137
                                  self.tblbuilding.isHidden = false */
                       
               }, completion: { finished in
                   
               })
               
               
           }
           
           if(textField == txtflats)
           {
               
               
               UIView.animate(withDuration: 0.3, delay: 0.2, options:
                   UIViewAnimationOptions.curveEaseOut, animations: {
                      
                     /*  self.viewbottom.isHidden = false
                                            self.hightbottomview.constant = 250
                                            self.hightflat.constant = 137
                                            self.highttxtfalt.constant = 50
                                            self.imgflatserarch.isHidden = false
                                            self.hightcheckboxview.constant = 0
                                            self.viewcheckbox.isHidden = true
                                         self.hightbuilding.constant = 0
                                         self.tblbuilding.isHidden = true
                                         self.hightflat.constant = 137
                                         self.tblflat.isHidden = false */
                       
                       
               }, completion: { finished in
                   
               })
               
               
           }
       }
         
       func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if(textField == txtblockname)
           {
               var substring = (textField.text as! NSString).replacingCharacters(in: range, with: string)
               
               if(substring != ""){
                   buildingary.removeAll()
                   for dic in newbuildingary
                   {
                    let str = dic.PropertyName
                       if(str.lowercased().contains(substring.lowercased()))
                       {
                           buildingary.append(dic)
                       }
                       
                      // tblbuilding.reloadData()
                    
                    self.pickerview4.reloadAllComponents()

                   }
               }
               else
               {
                   buildingary = newbuildingary
                
                  // tblbuilding.reloadData()
                
                  self.pickerview4.reloadAllComponents()

                   
               }
           }
           
           if(textField == txtflats)
           {
               let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
               
               if(substring != ""){
                   Flatary.removeAll()
                   for dic in NewFlatary
                   {
                       let str = dic.PropertyName
                       if(str!.lowercased().contains(substring.lowercased()))
                       {
                           Flatary.append(dic)
                       }
                       
                      // tblflat.reloadData()
                    
                    self.pickerview5.reloadAllComponents()

                   }
               }
               else
               {
                   Flatary = NewFlatary
                  // tblflat.reloadData()
                
                self.pickerview5.reloadAllComponents()

                   
               }
           }
           return true
       }
       
    
}
@available(iOS 13.0, *)
extension SignUPStep2:UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pickerview1)
        {
            return cityary.count
        }
        else if  (pickerView == pickerview2)
        {
            return arearary.count
            
        }
        else if(pickerView == pickerview3)
        {
            return societyary.count
        }
        else if(pickerView == pickerview4)
        {
            return buildingary.count
        }
        else if(pickerView == pickerview5)
        {
            return Flatary.count
        }
        
        else{
            return Flatary.count
        }
        // temp comment 4/12/20.
//        else if(pickerView == pickerview6)
//        {
//
//        }
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == pickerview1)
        {
            return cityary[row].Name
        }
        else if  (pickerView == pickerview2)
        {
            return arearary[row].AreaName
        }
        else if(pickerView == pickerview3)
        {
            return societyary[row].SocietyName
        }
        else if(pickerView == pickerview4)
        {
            return buildingary[row].PropertyName
        }
        else if(pickerView == pickerview5)
        {
            return Flatary[row].PropertyName
        }
        else
        {
            return Flatary[row].PropertyName
        }
        
        // temp comment 4/12/20.
//        else if(pickerView == pickerview6)
//        {
//
//        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == pickerview1)
        {
            txtcity.text = cityary[row].Name
            cityid = String(cityary[row].CityID!)
        }
        if(pickerView == pickerview2)
        {
            txtarea.text = arearary[row].AreaName
            areaid = String(arearary[row].AreaID)
            
        }
        if(pickerView == pickerview3)
        {
            txtcommunity.text = societyary[row].SocietyName
            societyid =  societyary[row].SocietyID
        }
        else if(pickerView == pickerview4)
        {
            txtblockname.text = buildingary[row].PropertyName
            buildingid = buildingary[row].PropertyID
        }
        else if(pickerView == pickerview5)
        {
            self.txtflats.text = self.Flatary[row].PropertyName
            Flatid = self.Flatary[row].PropertyID!
        }
        else if(pickerView == pickerview6)
        {
            
        }
    }
    
    
    
}

/*
@available(iOS 13.0, *)
extension SignUPStep2:UITableViewDelegate , UITableViewDataSource
{
    // MARK: = tableview delegate and datasource methods
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
           
           if(tableView == tblbuilding)
           {
               return buildingary.count
           }
           else
           {
               return Flatary.count
           }
           
       }
       
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           if(tableView == tblbuilding)
           {
            let cell: selectbuildingcelll = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! selectbuildingcelll
               
               cell.lblname.text = buildingary[indexPath.row].PropertyName
               return cell
           }
           else
           {
               let cell: selectbuildingcelll = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! selectbuildingcelll
               
               cell.lblname.text = Flatary[indexPath.row].PropertyName
               return cell
               
               
           }
           
       }
      
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           
           if(tableView == tblbuilding)
           {
               txtblockname.text = buildingary[indexPath.row].PropertyName
               
               buildingid = buildingary[indexPath.row].PropertyID
               apicallGetFlat()
            self.txtblockname.resignFirstResponder()
               UIView.animate(withDuration: 0.3, delay: 0.2, options:
                   UIViewAnimationOptions.curveEaseOut, animations: {
                       self.viewbottom.isHidden = false
                       self.hightbottomview.constant = 250
                       self.hightflat.constant = 137
                       self.highttxtfalt.constant = 50
                       self.imgflatserarch.isHidden = false
                     self.hightcheckboxview.constant = 0
                       self.viewcheckbox.isHidden = true
                    self.hightbuilding.constant = 0
                    self.tblbuilding.isHidden = true
                    self.hightflat.constant = 137
                    self.tblflat.isHidden = false
                       
               }, completion: { finished in
                   
                   
                   
               })
               
           }
           
           if(tableView == tblflat)
           {
            self.btnaddfarmviall.isHidden = false

            self.txtflats.resignFirstResponder()

               self.txtflats.text = self.Flatary[indexPath.row].PropertyName
              // Flatid = String(self.Flatary[indexPath.row].PropertyID!)
            
            Flatid = self.Flatary[indexPath.row].PropertyID!

            self.viewbottom.isHidden = false
                                  self.hightbottomview.constant = 200
                                  self.hightflat.constant = 0
                                  self.highttxtfalt.constant = 50
                                  self.imgflatserarch.isHidden = false
                                 self.hightcheckboxview.constant = 110
                                  self.viewcheckbox.isHidden = false
                               self.hightbuilding.constant = 0
                               self.hightbuilding.constant = 0
                              self.tblbuilding.isHidden = true
                                    self.hightflat.constant = 0
                                            self.tblflat.isHidden = true
               
            // 20/10/20. comments temp
            
            /*
             
             if IsActive = 1 and IsActiveTenant = 1 then show both options
             if IsActive = 0 and IsActiveTenant = 1 then show tenant options
             if IsActive = 0 and IsActiveTenant = 0 then show Flat is booked
             if IsActive = 1 and IsActiveTenant = 0 then show owner options
             
             */
            
            /*
             if IsActiveOwner = 0 and IsActiveTenant = 0 then show both options
             if IsActiveOwner = 1 and IsActiveTenant = 0 then show tenant options
             if IsActiveOwner = 1 and IsActiveTenant = 1 then show Flat is booked
             if IsActiveOwner = 0 and IsActiveTenant = 1 then show owner options
             */
            
            if self.Flatary[indexPath.row].isActiveOwner == 0 && self.Flatary[indexPath.row].isActiveTenant == 0 {
                viewcheckbox.isHidden = false
            }else if self.Flatary[indexPath.row].isActiveOwner == 1 && self.Flatary[indexPath.row].isActiveTenant == 0 {
                cbowner.isHidden = true
                btnOwner.isHidden = true
                
                cbrenter.isHidden = false
                btnRentingFlat.isHidden = false
            }else if self.Flatary[indexPath.row].isActiveOwner == 1 && self.Flatary[indexPath.row].isActiveTenant == 1 {
                viewcheckbox.isHidden = true

                let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"This flat is already booked")
                self.present(alert, animated: true, completion: nil)
            }else if self.Flatary[indexPath.row].isActiveOwner == 0 && self.Flatary[indexPath.row].isActiveTenant == 1 {
                cbowner.isHidden = false
                btnOwner.isHidden = false
                
                cbrenter.isHidden = true
                btnRentingFlat.isHidden = true
            }
            
           /* else{
                viewcheckbox.isHidden = true
                let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"This flat is already booked")
                self.present(alert, animated: true, completion: nil)
            } */

             /*  if self.Flatary[indexPath.row].booked == "no" {
                   cbowner.isHidden = false
                   cbrenter.isHidden = false
                   btnOwner.isHidden = false
                   btnRentingFlat.isHidden = false
               }else{
                   
                   if self.Flatary[indexPath.row].bookType == "Owner of flat"{
                    // 10/9/20.
                    
//                       cbowner.isHidden = true
//                       cbrenter.isHidden = false
//                       btnOwner.isHidden = true
//                       btnRentingFlat.isHidden = false
                    
                     cbowner.isHidden = false
                    cbrenter.isHidden = false
                    btnOwner.isHidden = false
                    btnRentingFlat.isHidden = false
                   }
                   
                   if self.Flatary[indexPath.row].bookType == "Renting the flat"{

                       cbowner.isHidden = true
                       cbrenter.isHidden = true
                       btnOwner.isHidden = true
                       btnRentingFlat.isHidden = true
                    
//                    cbowner.isHidden = false
//                    cbrenter.isHidden = false
//                    btnOwner.isHidden = false
//                    btnRentingFlat.isHidden = false
                    
                       let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"This flat is already booked")
                       self.present(alert, animated: true, completion: nil)
                       
                   }
                   
               } */
               
               
               UIView.animate(withDuration: 0.3, delay: 0.2, options:
                   UIViewAnimationOptions.curveEaseOut, animations: {
                       
                       
                       
                       
               }, completion: { finished in
                   
                   
               })
               
           }
       }
       
       
    
    
}


*/
