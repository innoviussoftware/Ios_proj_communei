//
//  CabEntryVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 23/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import ScrollPager
import Alamofire



class CabEntryVC: UIViewController, ScrollPagerDelegate , UITextFieldDelegate,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, DeliveryCompanyListProtocol
{
    
    var selectedindex : Int = 0
    
    var index:Int?
    var index1:Int?

    var isfrom = ""
    
    var isfrom_entry = 0

    var hourary = ["2 Hr" , "4 Hr" , "6 Hr" , "8 Hr" , "10 Hr" , "12 Hr"  ,"Day End"]
    
    var arrDays = [GetDays]()
        // ["Mon" , "Tue" , "Wed" , "Thu" , "Fri" , "Sat"  ,"Sun"]
    
    var arrSelectionCheck = NSMutableArray()

    var arrSelectionDayId = NSMutableArray()


    @IBOutlet weak var lblTitleName: UILabel!

    @IBOutlet weak var collectionHours: UICollectionView!

    @IBOutlet weak var collectionDays: UICollectionView!

    @IBOutlet weak var topConstraint: NSLayoutConstraint!

    @IBOutlet weak var topConstraint1: NSLayoutConstraint!

    @IBOutlet weak var btnDropclick: UIButton!
    
    @IBOutlet weak var btnDropclick1: UIButton!

    @IBOutlet weak var btnAddCab: UIButton!

    @IBOutlet weak var btnAddCab1: UIButton!

    @IBOutlet weak var lblVehicleNo: UILabel!

    @IBOutlet weak var pager: ScrollPager!
       
    @IBOutlet weak var viewbottom: UIView!

    @IBOutlet weak var viewbottom1: UIView!
    
    @IBOutlet var ViewSingle: UIView!
    
    @IBOutlet var ViewMultiple: UIView!

    @IBOutlet weak var txtdate: UITextField!
    
    @IBOutlet weak var txttime: UITextField!
    
    @IBOutlet weak var txtvaildtill: UITextField!

    @IBOutlet weak var txtCabCompanyName: UITextField!
      
    @IBOutlet weak var txtVehicleNumber: UITextField!

    @IBOutlet weak var txtAllWeek: UITextField!

    @IBOutlet weak var txtstartdate: UITextField!
    
    @IBOutlet weak var txtenddate: UITextField!
    
    @IBOutlet weak var txtStartTime: UITextField!

    @IBOutlet weak var txtEndTime: UITextField!
    
    @IBOutlet weak var txtCabCompanyName1: UITextField!
    
    var vendorID:Int?
    var isPublic:Int?
    
    var vendorID1:Int?
    var isPublic1:Int?

    
    var textfield = UITextField()
       var datePicker = UIDatePicker()
       var timePicker = UIDatePicker()
       var date1 = Date()
       var date2 = Date()
    
    let datePicker_start = UIDatePicker()
    let datePicker_end = UIDatePicker()


    func isValidVehicle(vehicleStr:String) -> Bool {
        
       // let vehicleRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let vehicleRegEx = "[a-z]{2}[0-9]{2}[a-z]{1,2}[0-9]{3,4}"
        
        let vehiclePred = NSPredicate(format:"SELF MATCHES %@", vehicleRegEx)
        return vehiclePred.evaluate(with: vehicleStr)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pager.delegate = self
        
        pager.addSegmentsWithTitlesAndViews(segments: [
            ("Single", ViewSingle),
            ("Multiple", ViewMultiple)
        ])
        

        
        if isfrom_entry == 0 {
            lblTitleName.text = "Cab Entry"
        }else{
            lblTitleName.text = "Domestic Helper Entry"
            txtCabCompanyName.isHidden = true
            txtVehicleNumber.isHidden = true
            lblVehicleNo.isHidden = true
            txtCabCompanyName1.isHidden = true
            btnAddCab.setTitle("Add Helper", for: .normal)
            btnAddCab1.setTitle("Add Helper", for: .normal)
            topConstraint.constant = 30
            
            topConstraint1.constant = 30
            btnDropclick.isHidden = true
            btnDropclick1.isHidden = true
        }
               
        if(isfrom == "") {
            pager.setSelectedIndex(index: 0, animated: true)
        }
               
        if(isfrom == "Single")
        {
            pager.setSelectedIndex(index: 0, animated: true)
        }
               
        if(isfrom == "Multiple") {
            pager.setSelectedIndex(index: 1, animated: true)
        }
               
              
               viewbottom.isHidden = true
               viewbottom1.isHidden = true
               
               
               self.viewbottom.frame.size.width = self.view.frame.size.width
               self.viewbottom1.frame.size.width = self.view.frame.size.width
              

               
               setborders(textfield: txtdate)
               setborders(textfield: txttime)
               setborders(textfield: txtvaildtill)
               setborders(textfield: txtCabCompanyName)
               setborders(textfield: txtVehicleNumber)
        

               setborders(textfield: txtAllWeek)
               setborders(textfield: txtstartdate)
               setborders(textfield: txtenddate)
               setborders(textfield: txtStartTime)
               setborders(textfield: txtEndTime)
               setborders(textfield: txtCabCompanyName1)

               
               txtdate.delegate = self
               txttime.delegate = self
               txtvaildtill.delegate = self
               txtCabCompanyName.delegate = self
               txtVehicleNumber.delegate = self
        
               txtAllWeek.delegate = self
               txtstartdate.delegate = self
               txtenddate.delegate = self
               txtStartTime.delegate = self
               txtEndTime.delegate = self
               txtCabCompanyName1.delegate = self

               
               webservices.sharedInstance.PaddingTextfiled(textfield: txtdate)
               webservices.sharedInstance.PaddingTextfiled(textfield: txttime)
               webservices.sharedInstance.PaddingTextfiled(textfield: txtvaildtill)
               webservices.sharedInstance.PaddingTextfiled(textfield: txtCabCompanyName)
            webservices.sharedInstance.PaddingTextfiled(textfield: txtVehicleNumber)

        

               webservices.sharedInstance.PaddingTextfiled(textfield: txtAllWeek)
               webservices.sharedInstance.PaddingTextfiled(textfield: txtstartdate)
               webservices.sharedInstance.PaddingTextfiled(textfield: txtenddate)
               webservices.sharedInstance.PaddingTextfiled(textfield: txtStartTime)
               webservices.sharedInstance.PaddingTextfiled(textfield: txtEndTime)

               webservices.sharedInstance.PaddingTextfiled(textfield: txtCabCompanyName1)

               self.apiCallGetDays()
               
               let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left, verticalAlignment: .center)
               
               collectionHours.collectionViewLayout = alignedFlowLayout
               
               let alignedFlowLayout1 = AlignedCollectionViewFlowLayout(horizontalAlignment:.left, verticalAlignment: .center)
                      
               collectionDays.collectionViewLayout = alignedFlowLayout1
                      
               showTimepPicker()
               showDatePicker()

               showTimepPicker_Multiple()
               
               let datee = Date()
               let formatter = DateFormatter()
               formatter.dateFormat = "dd-MM-yyyy"
               txtdate.text = formatter.string(from: datee)

               txtstartdate.text = formatter.string(from: datee)
               txtenddate.text = formatter.string(from: datee)
               date = txtdate.text!
               
               let formatt = DateFormatter()
               formatt.dateFormat = "hh:mm a"
               txttime.text = formatt.string(from: datee)
               time =  txttime.text!

        
        txtStartTime.text = formatt.string(from: datee)
        time =  txtStartTime.text!

        txtEndTime.text = formatt.string(from: datee)
        time =  txtEndTime.text!

        txtvaildtill.text = hourary[0]


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
            
        }
       
        override func viewWillDisappear(_ animated: Bool) {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
            
        }
    
    func showTimepPicker_Multiple(){
           //Formate Date
        datePicker_start.datePickerMode = .time
        
        datePicker_end.datePickerMode = .time
        

        if #available(iOS 13.4, *) {
            datePicker_start.preferredDatePickerStyle = .wheels
            datePicker_end.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
                
           //ToolBar
           let toolbar = UIToolbar();
           toolbar.sizeToFit()
           
           //done button & cancel button
           let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action:#selector(doneTimePicker_Multiple))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action:#selector(cancelTimePicker_Multiple))
           toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
           //timePicker.minimumDate = Date()
           // add toolbar to textField
           txtStartTime.inputAccessoryView = toolbar
           // add datepicker to textField
           txtStartTime.inputView = datePicker_start
        
            txtEndTime.inputAccessoryView = toolbar
                  // add datepicker to textField
            txtEndTime.inputView = datePicker_end
        
       }
       
    @objc func doneTimePicker_Multiple(){
              //For date formate
              let formatter = DateFormatter()
              formatter.dateFormat = "hh:mm a"
           
              txtStartTime.text = formatter.string(from: datePicker_start.date)
              
              txtEndTime.text = formatter.string(from: datePicker_end.date)
              
              //dismiss date picker dialog
              self.view.endEditing(true)
          }
          
          @objc func cancelTimePicker_Multiple(){
              //cancel button dismiss datepicker dialog
              self.view.endEditing(true)
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
       
    func showDatePicker() {
              //Formate Date
              datePicker.datePickerMode = .date
        
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
              toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
              
              // add toolbar to textField
              txtdate.inputAccessoryView = toolbar
              // add datepicker to textField
              txtdate.inputView = datePicker
              
              // add toolbar to textField
              txtenddate.inputAccessoryView = toolbar
              // add datepicker to textField
              txtenddate.inputView = datePicker
              
              // add toolbar to textField
              txtstartdate.inputAccessoryView = toolbar
              // add datepicker to textField
              txtstartdate.inputView = datePicker
             
              datePicker.minimumDate = Date()
              
    }
    
          func showTimepPicker() {
              //Formate Date
              timePicker.datePickerMode = .time
            
            if #available(iOS 13.4, *) {
                timePicker.preferredDatePickerStyle = .wheels
            } else {
                // Fallback on earlier versions
            }
              
              //ToolBar
              let toolbar = UIToolbar();
              toolbar.sizeToFit()
              
              //done button & cancel button
              let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action:#selector(doneTimePicker))
              let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
              let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action:#selector(cancelTimePicker))
              toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
              //timePicker.minimumDate = Date()
              // add toolbar to textField
              txttime.inputAccessoryView = toolbar
              // add datepicker to textField
              txttime.inputView = timePicker
              
          }
          
          @objc  func doneTimePicker(){
              //For date formate
              let formatter = DateFormatter()
              formatter.dateFormat = "hh:mm a"
              txttime.text = formatter.string(from: timePicker.date)
              //dismiss date picker dialog
              self.view.endEditing(true)
          }
          
          @objc func cancelTimePicker(){
              //cancel button dismiss datepicker dialog
              self.view.endEditing(true)
          }
          
          @objc  func donedatePicker(){
              //For date formate
              let formatter = DateFormatter()
              formatter.dateFormat = "dd-MM-yyyy"
              if(textfield == txtdate)
              {
                  txtdate.text = formatter.string(from: datePicker.date)
                  
              }
              if(textfield == txtenddate)
              {
                  txtenddate.text = formatter.string(from: datePicker.date)
                  date2 = datePicker.date
                  let cal = NSCalendar.current
                  
                  let components = cal.dateComponents([.day], from: date1, to: date2)
                  
                  if (components.day! >= 0)
                  {
                     // lbldays.text =  (components.day! as NSNumber).stringValue + "days"
                   //   days = lbldays.text!
                  }
                  else{
                      let alert = UIAlertController(title: Alert_Titel, message:"Please select end date greater than start date" , preferredStyle: UIAlertController.Style.alert)
                      alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                        //  self.txtenddate.text = ""
                      }))
                      self.present(alert, animated: true, completion: nil)
                  }
                  
              }
              if(textfield == txtstartdate)
              {
                  txtstartdate.text = formatter.string(from: datePicker.date)
                  date1 = datePicker.date
                  
              }
              self.view.endEditing(true)
          }
          
       @objc func cancelDatePicker(){
              //cancel button dismiss datepicker dialog
           self.view.endEditing(true)
       }

    @IBAction func backaction(_ sender: UIButton) {
        view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnaddCabaction(_ sender: UIButton) {
        
        if txtCabCompanyName.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Cab Company Name")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtVehicleNumber.hasText) {
            if (isValidVehicle(vehicleStr: txtVehicleNumber.text!) == false) {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter vaild Vehicle Number")
                self.present(alert, animated: true, completion: nil)
            }
            else{
                self.apicallCabSingleEntry()
            }
        }
        else{
            self.apicallCabSingleEntry()
        }
        
        print("btnaddCabaction")
        
    }
       
    @IBAction func btnaddCabaction_1(_ sender: UIButton) {
        
       /* let strStartDate = txtstartdate.text! // first date
        let strEndDate = txtenddate.text! // end date
        
        print("strStartDate ",strStartDate)
        
        print("strEndDate ",strEndDate)

       /* let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
       let startdate = formatter.date(from: strStartDate)
       let enddate = formatter.date(from: strEndDate)
     
        print("startdate ",date1)
        print("enddate ",date2) */
        
        let startdate = strChangeDateFormate(strDateeee: strStartDate)
        let enddate = strChangeDateFormate(strDateeee: strEndDate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
          
        let startD = formatter.date(from: startdate)!
        let endD = formatter.date(from: enddate)!
      
        print("startdate ",startdate)
        print("enddate ",enddate)
        
        print("startD ",startD)
        print("endD ",endD) */
        
        /* if arrSelectionDayId.count == 0 {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"select must be at least one day")
            self.present(alert, animated: true, completion: nil)
      } */
        
        if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
       // }else if(startD > endD) {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }else if(txtStartTime.text! > txtEndTime.text!) {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedSame {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }
        else if txtCabCompanyName1.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Cab Company Name")
            self.present(alert, animated: true, completion: nil)
        }else{
            self.apicallCabMultipleEntry()
        }
        
        print("btnaddCabaction_1")
        
    }
    
    @IBAction func btnClose_hour(_ sender: UIButton) {
             self.viewbottom.isHidden = true
      }
         
      @IBAction func btnApply(_ sender: UIButton) {
        
           txtvaildtill.text = hourary[selectedindex]

       // selectedindex = 0
        
             collectionHours.reloadData()
        
             self.viewbottom.isHidden = true
      }
         
      @IBAction func btnReset(_ sender: UIButton) {
             
             txtvaildtill.text = hourary[0]

             selectedindex = 0
             
             collectionHours.reloadData()

             self.viewbottom.isHidden = true
      }
      
      
      @IBAction func btnClose_days(_ sender: UIButton) {
          self.viewbottom1.isHidden = true
      }
            
      @IBAction func btnApply_days(_ sender: UIButton) {
        
        self.txtAllWeek.text = arrSelectionCheck.componentsJoined(by:",")
        collectionDays.reloadData()

          self.viewbottom1.isHidden = true
      }
            
    @IBAction func btnReset_days(_ sender: UIButton) {
                
        txtAllWeek.text = ""
        
        arrSelectionDayId.removeAllObjects()
        
       // arrDays.removeAllObjects()
        arrSelectionCheck.removeAllObjects()
                
        collectionDays.reloadData()

        self.viewbottom1.isHidden = true
    }
         
    // MARK: - APICallGetDays
    
    func apiCallGetDays() {
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
       
        webservices().StartSpinner()
    
        Apicallhandler().APICallGetDays(URL: webservices().baseurl + API_GET_WEEKDAYD, token: token as! String) { JSON in
            
            let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
                if statusCode == 200{
                    
                    self.arrDays = resp.data!
                    if self.arrDays.count > 0{
                        self.collectionDays.dataSource = self
                        self.collectionDays.delegate = self
                        self.collectionDays.reloadData()
                    }else{
                        self.collectionDays.isHidden = true
                    }
                    
                }
                if statusCode == 401{
                   
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
                            
                     //   }
                  //  })
                    
                }
            case .failure(let err):
                
                if JSON.response?.statusCode == 401{
                   
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
                   // })
                    webservices().StopSpinner()
                   // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                    
               // }
            }
            
            
            
        }
        
        
    }

    // MARK: - deliveryList delegate methods

    func deliveryList(name:String,VendorID:Int,IsPublic:Int, selectNumber:Int)
    {
        index = selectNumber

        if(isfrom == "Single") {
            self.txtCabCompanyName.text = name
            vendorID = VendorID
             isPublic = IsPublic
        }
    }
    
    func deliveryList1(name1:String,VendorID1:Int,IsPublic1:Int, selectNumber1:Int)
        {
           index1 = selectNumber1

         if(isfrom == "Multiple"){
            self.txtCabCompanyName1.text = name1
             vendorID1 = VendorID1
             isPublic1 = IsPublic1
        }
    }
    
    func messageClicked() {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  "Successfully Added"
        avc?.subtitleStr = "Your Cab will be allowed"
        avc?.isfrom = 4

        avc?.yesAct = {
           
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
                                         
        }
        avc?.noAct = {
            
        }
        
        present(avc!, animated: true)
    }
    
    // MARK: - get Cab Single Entry
    
    func apicallCabSingleEntry()
    {
           if !NetworkState().isInternetAvailable {
                ShowNoInternetAlert()
                return
            }
        
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
            var strDateee = ""
          
           date = txtdate.text!
            strDateee = strChangeDateFormate(strDateeee: date)
                
        
        var after_add_time = ""

        if txtvaildtill.text == "Day End" {
            validtill = time
            
            let dateFormatter = DateFormatter()
            
            let isoDate = time //strDateee //"2016-04-14T10:44:00+0000"

            //dateFormatter.dateFormat = "h:mm:ss a" // "yyyy-MM-dd" // h:mm"
            
            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"

            let date = dateFormatter.date(from:isoDate)!
            print("date :- ",date)
            
            after_add_time = "11:59 PM" //"23:59:00"
             
        }else{
            
            txtvaildtill.text?.removeLast(3)

            let myInt = Int(txtvaildtill.text!)!
            
            let dateFormatter = DateFormatter()
            
           // let valid =  time + ":00"
            
            let isoDate = time //validtill // valid  //"2016-04-14T10:44:00+0000"

           // dateFormatter.dateFormat = "h:mm:ss a" // "yyyy-MM-dd"  //h:mm"
            
            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"

            let date = dateFormatter.date(from:isoDate)!
            
            let addminutes = date.addingTimeInterval(TimeInterval(myInt*60*60))
            after_add_time = dateFormatter.string(from: addminutes)
            
            print("after add time 3 --> ",after_add_time)
        }
       
        var param = Parameters()
        
        var vendorServiceTypeID:Int?
        vendorServiceTypeID = 2
        
            param  = [
                "VisitStartDate": strDateee, // date = txtdate.text!
                "FromTime": txttime.text!, //time, // start time
                "ToTime": after_add_time,  //validtill,  // to time
                "VendorID":vendorID!,
                "VendorName": self.txtCabCompanyName.text!,
                "VendorServiceTypeID": vendorServiceTypeID!,
                "IsPublicVendor":isPublic!,
                "VehicleNumber": txtVehicleNumber.text!

            ]
        
        print("param Single Cab Entry : ",param)
        
            webservices().StartSpinner()
        
        Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_CABENTRY, param: param, token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.messageClicked()
                        
                       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)

                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "InvitationPopUpVC") as! InvitationPopUpVC
                                                
                        self.navigationController?.pushViewController(initialViewController, animated: true) */
                     
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
                        
                    }
                case .failure(let err):
                    if JSON.response?.statusCode == 401{
                       
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
                                                              
                        
                        return
                    }
                    
                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
    }
    
    // MARK: - get Cab Multiple Entry

    func apicallCabMultipleEntry()
    {
        if !NetworkState().isInternetAvailable {
                        ShowNoInternetAlert()
                        return
                    }
        
           let token = UserDefaults.standard.value(forKey: USER_TOKEN)
       
           var strDateee = ""
           var endDate = ""
        
           date = txtdate.text!
           enddate = txtenddate.text!
        
           strDateee = strChangeDateFormate(strDateeee: date)
           endDate = strChangeDateFormate(strDateeee: enddate)
        
      /*  var after_add_time = ""
        
        if txtvaildtill.text == "Day End" {
            validtill = time
            
            let dateFormatter = DateFormatter()
            
            let isoDate = time

            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"

            let date = dateFormatter.date(from:isoDate)!
            
            print("date :- ",date)
 
            after_add_time = "11:59 PM" //"23:59:00"
             
        }else{
            
            txtvaildtill.text?.removeLast(3)

            let myInt = Int(txtvaildtill.text!)!
            
            let dateFormatter = DateFormatter()
            
            let isoDate = time //validtill // valid  //"2016-04-14T10:44:00+0000"

            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"

            let date = dateFormatter.date(from:isoDate)!
            
            let addminutes = date.addingTimeInterval(TimeInterval(myInt*60*60))
            after_add_time = dateFormatter.string(from: addminutes)
            
            print("after add time 3 --> ",after_add_time)
        } */
        

        if arrSelectionDayId.count == 0 {
            for dic in arrDays {
                arrSelectionDayId.add(dic.daysTypeID!)
            }
        }
        
        var param = Parameters()
        
        var vendorServiceTypeID:Int?
        vendorServiceTypeID = 2
        
            param  = [
                "VisitStartDate": strDateee, // date = txtdate.text!
                "VisitEndDate": endDate,
                "FromTime": txtStartTime.text!, // time, //txtStartTime.text!, //time, // start time
                "ToTime": txtEndTime.text!, // after_add_time, // txtEndTime.text!, //validtill,  // to time
                "VendorID":vendorID1!,
                "VendorName": self.txtCabCompanyName1.text!,
                "VendorServiceTypeID": vendorServiceTypeID!,
               // "IsLeaveAtGate": singleDeliveryCheckGate!,
                "IsPublicVendor":isPublic1!,
                "DaysOfWeek": arrSelectionDayId.componentsJoined(by: ",")
            ]
        
           print("param Multiple Cab Entry : ",param)
        
           webservices().StartSpinner()
        
        Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_CABENTRY, param: param, token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.messageClicked()

                      /*  let storyboard = UIStoryboard(name: "Main", bundle: nil)

                        let initialViewController = storyboard.instantiateViewController(withIdentifier: "InvitationPopUpVC") as! InvitationPopUpVC
                                                
                        self.navigationController?.pushViewController(initialViewController, animated: true) */
                
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
                        
                    }
                case .failure(let err):
                    if JSON.response?.statusCode == 401{
                       
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
                                                              
                         //   }
                      //  })
                        
                        return
                    }
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
    }
    
    // MARK: - textField delegate methods

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
       /* if textfield == txtstartdate {
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
           //view.endEditing(true)
        }else if textfield == txtenddate {
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
        }else if textfield == txtStartTime {
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
        }else if textfield == txtdate {
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
        }else if textfield == txttime {
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
        }else if textfield == txtCabCompanyName {
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
        }else if textfield == txtCabCompanyName1 {
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
        }else if textfield == txtvaildtill {
            viewbottom.isHidden = false
            viewbottom1.isHidden = true
           // self.view.endEditing(true)
        }else if textfield == txtAllWeek {
            viewbottom.isHidden = true
            viewbottom1.isHidden = false
           // self.view.endEditing(true)
        } */
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
        if(textField == txtCabCompanyName)
            {
                   let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                   popOverConfirmVC.delegate = self
                    isfrom = "Single"
                
                    popOverConfirmVC.selectedindex = index
            
                popOverConfirmVC.isfrom = "Single"

                popOverConfirmVC.strTitleName = "Select Your Cab"

                popOverConfirmVC.api_Company_Selection = "user/vendors/3"

                popOverConfirmVC.visitorTypeID = 3

                  /* if(txtCabCompanyName.text != "")
                   {
                        print("Single Select Your Cab")

                      // popOverConfirmVC.selectedary = self.selectedary
                       // popOverConfirmVC.entryary = txtDeliveryCompanyName.text
                   } */
            
                self.navigationController?.pushViewController(popOverConfirmVC, animated: true)
            
                txtCabCompanyName.resignFirstResponder()

        }
        
        if (textField == txtCabCompanyName1)
            {
                   let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                   popOverConfirmVC.delegate = self
                isfrom = "Multiple"
                
                    popOverConfirmVC.selectedindex1 = index1
               
            popOverConfirmVC.isfrom = "Multiple"

            popOverConfirmVC.strTitleName = "Select Your Cab"

            popOverConfirmVC.api_Company_Selection = "user/vendors/3"
            
            popOverConfirmVC.visitorTypeID = 3

           // popOverConfirmVC. = "user/vendor/add"

                  /* if(txtCabCompanyName1.text != "")
                   {
                        print("Multiple Select Your Cab")

                       // popOverConfirmVC.alertGuardary = self.nameary
                   } */
            
                self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

            viewbottom1.isHidden = true
            
            txtCabCompanyName1.resignFirstResponder()


        }
        
        if(textField == txtAllWeek)
        {
            textfield = txtAllWeek

            viewbottom1.isHidden = false
            txtAllWeek.resignFirstResponder()
                
            txtAllWeek.endEditing(true)

               // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        
        if(textField == txtvaildtill)
        {
                
            textfield = txtvaildtill

            viewbottom.isHidden = false
            txtvaildtill.resignFirstResponder()
            
            txtvaildtill.endEditing(true)

               // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
            if(textField == txtdate)
            {
                textfield = txtdate
                
              //  txtdate.endEditing(false)
            }
        
        if(textField == txtStartTime)
        {
            textfield = txtStartTime
            
          //  txtStartTime.endEditing(false)
        }
        
        if(textField == txttime)
        {
            textfield = txttime
            
          //  txttime.endEditing(false)
        }
        
        if(textField == txtEndTime)
        {
            textfield = txtEndTime
           // txtEndTime.endEditing(false)

        }
        
            if(textField == txtstartdate)
            {
                //datePicker.minimumDate = Date()
                textfield = txtstartdate
              //  txtstartdate.endEditing(false)

            }
            if(textField == txtenddate)
            {
    //            let formatter = DateFormatter()
    //            if txtstartdate.hasText{
    //                 datePicker.minimumDate = formatter.date(from: txtstartdate.text!)
    //            }
                
                textfield = txtenddate
                
                let cal = NSCalendar.current
                
                let components = cal.dateComponents([.day], from: date1, to: date2)
              //  lbldays.text =  (components.day! as NSNumber).stringValue
             //   txtenddate.endEditing(false)

            }
            
    }
    
    func setborders(textfield:UITextField)
      {
          
         // textfield.layer.borderColor =  AppColor.appcolor.cgColor
           textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
          
          textfield.layer.borderWidth = 1.0
          
      }
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        
        if changedIndex == 0{
            view.endEditing(true)
        }else{
            view.endEditing(true)
        }
        
    }
    
    // MARK: - Change Date Formate
    
    func strChangeDateFormate(strDateeee:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let strDate = formatter.date(from: strDateeee)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "yyyy-MM-dd"
            str = formatter.string(from: strDate!)
        }else{
            str = strDateeee
        }
        
        
        return str
    }
    
    
    // MARK: - Collectionview delegate and datasource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == collectionHours) {
            return hourary.count
        }else{
             return arrDays.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == collectionHours) {

            let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell

            cell.lblname.text = hourary[indexPath.row] as! String
            if(selectedindex == indexPath.row)
            {
                
              //  cell.lblname.backgroundColor = AppColor.appcolor
                
                cell.lblname.backgroundColor = AppColor.borderColor
                cell.lblname.textColor = UIColor.white
               // cell.lblname.layer.borderWidth = 0.0
            }
            else{
                
                cell.lblname.backgroundColor = AppColor.lblFilterUnselect
                cell.lblname.textColor = UIColor.white
               // cell.lblname.layer.borderColor = UIColor.lightGray.cgColor
              //  cell.lblname.layer.borderWidth = 1.0
            }
            
            return cell

        }else{
            let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell

             cell.lblname.text = arrDays[indexPath.row].daysName
                                   
                   if(arrSelectionCheck.contains(arrDays[indexPath.row].daysName!))
                       {
                         //  cell.lblname.backgroundColor = AppColor.appcolor
                           
                           cell.lblname.backgroundColor = AppColor.borderColor
                           cell.lblname.textColor = UIColor.white
                          // cell.lblname.layer.borderWidth = 0.0
                       }
                       else{
                           
                           cell.lblname.backgroundColor = AppColor.lblFilterUnselect
                           cell.lblname.textColor = UIColor.white
                          // cell.lblname.layer.borderColor = UIColor.lightGray.cgColor
                         //  cell.lblname.layer.borderWidth = 1.0
                       }
                       
                       return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (collectionView == collectionHours) {
            let numberOfSets = CGFloat(4.0)
            let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 31))/numberOfSets
            return CGSize(width:width,height: 42)
        }else{
            let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
            let contentNSString = arrDays[indexPath.row].daysName
            let expectedLabelSize = contentNSString?.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 16)!], context: nil)
            
            print("\(String(describing: expectedLabelSize))")
            return CGSize(width:(expectedLabelSize?.size.width)! + 22, height: expectedLabelSize!.size.height + 25)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == collectionHours) {
            txtvaildtill.text = hourary[indexPath.row]
              
              selectedindex = indexPath.row
             // viewbottom.isHidden = true
            //  viewmain.backgroundColor = UIColor.white
              collectionHours.reloadData()
        }else{
            
            if arrSelectionCheck.contains(arrDays[indexPath.row].daysName!){
                arrSelectionCheck.remove(arrDays[indexPath.row].daysName!)
                arrSelectionDayId.remove(arrDays[indexPath.row].daysTypeID!)
            }else{
                arrSelectionCheck.add(arrDays[indexPath.row].daysName!)
                arrSelectionDayId.add(arrDays[indexPath.row].daysTypeID!)
            }
            
         //   self.txtAllWeek.text = arrSelectionCheck.componentsJoined(by:",")

              
           //   selectedindex = indexPath.row
            
             // viewbottom.isHidden = true
            //  viewmain.backgroundColor = UIColor.white
            
              collectionDays.reloadData()
        }
        
    }
    
    
}
