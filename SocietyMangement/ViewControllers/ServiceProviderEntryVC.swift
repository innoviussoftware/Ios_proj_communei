//
//  ServiceProviderEntryVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 23/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import ScrollPager

import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ServiceProviderEntryVC: UIViewController, ScrollPagerDelegate, UITextFieldDelegate, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, DeliveryCompanyListProtocol, ServiceTypeListProtocol {
    
    var selectedindex : Int = 0
      
    var index:Int?
    var index1:Int?
    
    var indexservice:Int?
    var indexservice1:Int?
    
    var vendorServiceID:Int?
    var vendorServiceID1:Int?

      var isfrom = ""
      
      var hourary = ["2 Hr" , "4 Hr" , "6 Hr" , "8 Hr" , "10 Hr" , "12 Hr"  ,"Day End"]
      
      var arrDays = [GetDays]()

    //  var arrDays = ["Mon" , "Tue" , "Wed" , "Thu" , "Fri" , "Sat"  ,"Sun"]

  //  var ServiceTypeAry = ["Service Type","Service 1", "Service 2", "Service 3"]

      
      @IBOutlet weak var collectionHours: UICollectionView!

      @IBOutlet weak var collectionDays: UICollectionView!

         
      @IBOutlet weak var pager: ScrollPager!
         
      @IBOutlet weak var viewbottom: UIView!

      @IBOutlet weak var viewbottom1: UIView!
      
      @IBOutlet var ViewSingle: UIView!
      
      @IBOutlet var ViewMultiple: UIView!

      @IBOutlet weak var txtdate: UITextField!
      
      @IBOutlet weak var txttime: UITextField!
      
      @IBOutlet weak var txtvaildtill: UITextField!

      @IBOutlet weak var txtCompanyName: UITextField!
            
      @IBOutlet weak var txtServiceType: UITextField!
    
    @IBOutlet weak var txtFullName: UITextField!

    @IBOutlet weak var txtMobileNumber: UITextField!

      
      @IBOutlet weak var txtAllWeek: UITextField!

      @IBOutlet weak var txtstartdate: UITextField!
      
      @IBOutlet weak var txtenddate: UITextField!
      
      @IBOutlet weak var txtStartTime: UITextField!

      @IBOutlet weak var txtEndTime: UITextField!
      
      @IBOutlet weak var txtCompanyName1: UITextField!
    
    @IBOutlet weak var txtServiceType1: UITextField!
      
      @IBOutlet weak var txtFullName1: UITextField!

      @IBOutlet weak var txtMobileNumber1: UITextField!
    
    var vendorID:Int?
    var isPublic:Int?
    
    var vendorID1:Int?
    var isPublic1:Int?


    var pickerview = UIPickerView()

    var textfield = UITextField()
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    var date1 = Date()
    var date2 = Date()

    let datePicker_start = UIDatePicker()
      
    let datePicker_end = UIDatePicker()

    var arrSelectionCheck = NSMutableArray()
    
    var arrSelectionDayId = NSMutableArray()

    var arrCotactSingle = NSMutableArray()

    var arrCotactMultiple = NSMutableArray()

    
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
                            
                    
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                    
                }
            }
            
            
            
        }
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pager.delegate = self
        
        pager.addSegmentsWithTitlesAndViews(segments: [
                   ("Single", ViewSingle),
                   ("Multiple", ViewMultiple)
               ])
        

                      
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
                    
        txtvaildtill.text = hourary[0]

        selectedindex = 0

                      
                      setborders(textfield: txtdate)
                      setborders(textfield: txttime)
                      setborders(textfield: txtvaildtill)
                      setborders(textfield: txtCompanyName)
                      setborders(textfield: txtServiceType)
               

                      setborders(textfield: txtAllWeek)
                      setborders(textfield: txtstartdate)
                      setborders(textfield: txtenddate)
                      setborders(textfield: txtStartTime)
                      setborders(textfield: txtEndTime)
                      setborders(textfield: txtCompanyName1)
                    setborders(textfield: txtServiceType1)

                      
                      txtdate.delegate = self
                      txttime.delegate = self
                      txtvaildtill.delegate = self
                      txtCompanyName.delegate = self
                      txtServiceType.delegate = self
               
                      txtAllWeek.delegate = self
                      txtstartdate.delegate = self
                      txtenddate.delegate = self
                      txtStartTime.delegate = self
                      txtEndTime.delegate = self
                      txtCompanyName1.delegate = self
                       txtServiceType1.delegate = self

                      
                      webservices.sharedInstance.PaddingTextfiled(textfield: txtdate)
                      webservices.sharedInstance.PaddingTextfiled(textfield: txttime)
                      webservices.sharedInstance.PaddingTextfiled(textfield: txtvaildtill)
                      webservices.sharedInstance.PaddingTextfiled(textfield: txtCompanyName)
                   webservices.sharedInstance.PaddingTextfiled(textfield: txtServiceType)

               

                      webservices.sharedInstance.PaddingTextfiled(textfield: txtAllWeek)
                      webservices.sharedInstance.PaddingTextfiled(textfield: txtstartdate)
                      webservices.sharedInstance.PaddingTextfiled(textfield: txtenddate)
                      webservices.sharedInstance.PaddingTextfiled(textfield: txtStartTime)
                      webservices.sharedInstance.PaddingTextfiled(textfield: txtEndTime)

                      webservices.sharedInstance.PaddingTextfiled(textfield: txtCompanyName1)
                     webservices.sharedInstance.PaddingTextfiled(textfield: txtServiceType1)

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

               
        // Do any additional setup after loading the view.
    }
    
    @objc func donePressed() {
           
           // tblview.reloadData()
           view.endEditing(true)
       }
       
       @objc  func cancelPressed() {
           view.endEditing(true) // or do something
       }
       
    
    override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
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
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donedatePicker))
                let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
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
                let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(doneTimePicker))
                let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
                let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(cancelTimePicker))
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
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(doneTimePicker_Multiple))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(cancelTimePicker_Multiple))
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
                           // self.txtenddate.text = ""
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
    
    @IBAction func btnaddServiceProvideraction(_ sender: UIButton) {
        
        if txtdate.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Date")
            self.present(alert, animated: true, completion: nil)
        }else if txttime.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Time")
            self.present(alert, animated: true, completion: nil)
        }else if txtCompanyName.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Company Name")
            self.present(alert, animated: true, completion: nil)
        }else if txtServiceType.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Service Name")
            self.present(alert, animated: true, completion: nil)
        }else if txtFullName.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Name")
            self.present(alert, animated: true, completion: nil)
        }else if txtMobileNumber.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Mobile Number")
            self.present(alert, animated: true, completion: nil)
        }else if (txtMobileNumber.text!.count < 10){
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter contact number 10 digit")
            self.present(alert, animated: true, completion: nil)
        }else{
            arrCotactSingle.removeAllObjects()
            
            let dict = NSMutableDictionary()
            dict.setValue(txtFullName.text, forKey: "Name")
            dict.setValue(txtMobileNumber.text, forKey: "Mobile")
            arrCotactSingle.add(dict)
            
            self.apicallServiceProvideSingleEntry()
        }
        
         print("btnaddServiceProvideraction")
    }
       
    @IBAction func btnaddServiceProvideraction_1(_ sender: UIButton) {
        
       /* let strStartTime = txtStartTime.text! // first Time
        let strEndTime = txtEndTime.text! // end Time
        
        print("strStartTime ",strStartTime)
        
        print("strEndTime ",strEndTime)

       /* let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
       let startdate = formatter.date(from: strStartDate)
       let enddate = formatter.date(from: strEndDate)
     
        print("startdate ",date1)
        print("enddate ",date2) */
        
        let startTime = strChangeTimeFormate(strDateeee: strStartTime)
        let endTime = strChangeTimeFormate(strDateeee: strEndTime)
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // "dd-MM-yyyy"
        
        let startT = formatter.date(from: startTime)!
        let endT = formatter.date(from: endTime)!
      
        print("startTime ",startTime)
        print("endTime ",endTime)
        
        print("startT ",startT)
        print("endT ",endT) */
        
        if arrSelectionDayId.count == 0 {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"select must be at least one day")
            self.present(alert, animated: true, completion: nil)
        }else if txtstartdate.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Start Date")
            self.present(alert, animated: true, completion: nil)
        }else if txtenddate.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter End Date")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Start Time")
            self.present(alert, animated: true, completion: nil)
        }else if txtEndTime.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter End Time")
            self.present(alert, animated: true, completion: nil)
        }else if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedSame  {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }
        else if txtCompanyName1.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Company Name")
            self.present(alert, animated: true, completion: nil)
        }else if txtServiceType1.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Service Name")
            self.present(alert, animated: true, completion: nil)
        }else if txtFullName1.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Name")
            self.present(alert, animated: true, completion: nil)
        }else if txtMobileNumber1.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Mobile Number")
            self.present(alert, animated: true, completion: nil)
        }else if (txtMobileNumber1.text!.count < 10) {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter contact number 10 digit")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            
            arrCotactMultiple.removeAllObjects()

            let dict = NSMutableDictionary()
            dict.setValue(txtFullName1.text, forKey: "Name")
            dict.setValue(txtMobileNumber1.text, forKey: "Mobile")
            arrCotactMultiple.add(dict)
            
            self.apicallServiceProvideMultipleEntry()
        }
                    
        print("btnaddServiceProvideraction_1")

    }
    
    // MARK: - Change Time Formate
    
    func strChangeTimeFormate(strDateeee: String) -> String
    {
            let dateFormatter = DateFormatter()
          //  dateFormatter.dateFormat = "HH:mm:ss"
            dateFormatter.dateFormat = "hh:mm a"
            let date = dateFormatter.date(from: strDateeee)
           // dateFormatter.dateFormat = "hh:mm a"
            return  dateFormatter.string(from: date!)

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
    
    //MARK: convert arr to json
       func GetJsonString(arrObje : Any) -> String? {
           guard let dataInvestigation = try? JSONSerialization.data(withJSONObject: arrObje, options: []) else {
               return nil
           }
           return String(data: dataInvestigation, encoding: String.Encoding.utf8)
       }
    
    
    func messageClicked() {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  "Successfully Added"
        avc?.subtitleStr = "Your Service Provider will be allowed an entry"
        avc?.isfrom = 4

        avc?.yesAct = {
           
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
                                         
        }
        avc?.noAct = {
            
        }
        
        present(avc!, animated: true)
    }
    
    // MARK: - get ServiceProvide Single Entry
    
    func apicallServiceProvideSingleEntry()
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
        
      //  var vendorServiceTypeID:Int?
       // vendorServiceTypeID = 5
        
        var strJsonInvetigationSingle = ""
        
        strJsonInvetigationSingle = GetJsonString(arrObje: arrCotactSingle)!
        
            param  = [
                "VisitStartDate": strDateee, // date = txtdate.text!
                "FromTime": txttime.text!, //time, // start time
                "ToTime": after_add_time,  //validtill,  // to time
                "Visitors":strJsonInvetigationSingle,
                "VendorID":vendorID!,
                "VendorName": self.txtServiceType.text!,
                "VendorServiceTypeID": vendorServiceID!,
                "IsPublicVendor":isPublic!
            ]
        
        print("param Single ServiceType Entry : ",param)
        
            webservices().StartSpinner()
        
        Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_SERVICE_PROVIDER, param: param, token: token as! String) { JSON in
                
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
    
    
    // MARK: - get ServiceProvide Multiple Entry

    func apicallServiceProvideMultipleEntry()
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
        
        var strJsonInvetigationMuliple = ""
        
        strJsonInvetigationMuliple = GetJsonString(arrObje: arrCotactMultiple)!
        
        var param = Parameters()
      
            param  = [
                "VisitStartDate": strDateee, // date = txtdate.text!
                "VisitEndDate": endDate,
                "FromTime": txtStartTime.text!, // time, //txtStartTime.text!, //time, // start time
                "ToTime": txtEndTime.text!, // after_add_time, // txtEndTime.text!, //validtill,  // to time
                "VendorID":vendorID1!,
                "VendorName": self.txtServiceType1.text!,
                "VendorServiceTypeID": vendorServiceID1!,
                "IsPublicVendor":isPublic1!,
                "Visitors":strJsonInvetigationMuliple,
                "DaysOfWeek": arrSelectionDayId.componentsJoined(by: ",")

            ]
        
           print("param Multiple ServiceType Entry : ",param)
        
           webservices().StartSpinner()
        
        Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_SERVICE_PROVIDER, param: param, token: token as! String) { JSON in
                
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
                                                              
                        
                        return
                    }
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
    }
    
    
    @IBAction func backaction(_ sender: UIButton) {
        view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClose_hour(_ sender: UIButton) {
                self.viewbottom.isHidden = true
         }
            
    @IBAction func btnApply(_ sender: UIButton) {
        txtvaildtill.text = hourary[selectedindex]

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
        
         txtAllWeek.text = "" //arrDays[0]
         
        // arrDays.removeAllObjects()
         arrSelectionCheck.removeAllObjects()

        // selectedindex = 0
               
        collectionDays.reloadData()

        self.viewbottom1.isHidden = true
    }
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        
        if changedIndex == 0{
            view.endEditing(true)
        }else{
            view.endEditing(true)
        }
        
    }
                   
    
    // MARK: - DeliveryList delegate methods

       //func deliveryList(name: String)
     //  func deliveryList(name:String, selectNumber:Int)
      func deliveryList(name:String,VendorID:Int,IsPublic:Int, selectNumber:Int)
       {
            index = selectNumber
        
        if(isfrom == "Single") {
            self.txtCompanyName.text = name
            vendorID = VendorID
             isPublic = IsPublic
        }
        
        print("txtCompanyName vendorID isPublic",txtCompanyName.text! , vendorID! , isPublic!)

      }
    
    func deliveryList1(name1:String,VendorID1:Int,IsPublic1:Int, selectNumber1:Int)
    {
        index1 = selectNumber1

        if(isfrom == "Multiple"){
            self.txtCompanyName1.text = name1
             vendorID1 = VendorID1
             isPublic1 = IsPublic1
        }
        
        print("txtCompanyName1 vendorID1 isPublic1",txtCompanyName1.text! , vendorID1! , isPublic1!)

    }
        
    
    // MARK: - ServiceTypeList delegate methods

    func serviceTypeList(name:String,vendorServiceTypeID:Int, selectNumber:Int) {
        if(isfrom == "Single") {
            self.txtServiceType.text = name
            vendorServiceID = vendorServiceTypeID
        }
        indexservice = selectNumber
        
    }
       
    func serviceTypeList1(name1:String,vendorServiceTypeID1:Int, selectNumber1:Int) {
         if(isfrom == "Multiple"){
            self.txtServiceType1.text = name1
            vendorServiceID1 = vendorServiceTypeID1
         }
        indexservice1 = selectNumber1
        
    }
    
    
       // MARK: - textField delegate methods
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
               
           if(textField == txtCompanyName)
               {
                      txtCompanyName.resignFirstResponder()
            
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC

                      popOverConfirmVC.delegate = self
                       isfrom = "Single"
                   
                       popOverConfirmVC.selectedindex = index
            
            popOverConfirmVC.isfrom = "Single"

            popOverConfirmVC.strTitleName = "Select Service Provider"

            popOverConfirmVC.api_Company_Selection = "user/vendors/5"

            popOverConfirmVC.visitorTypeID = 5

                     /* if(txtCompanyName.text != "")
                      {

                        print("Single Select Service Provider")

                         // popOverConfirmVC.selectedary = self.selectedary
                          // popOverConfirmVC.entryary = txtDeliveryCompanyName.text
                      } */
            
                   self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

           }
           
           if (textField == txtCompanyName1)
               {
                      txtCompanyName1.resignFirstResponder()
                      let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                      popOverConfirmVC.delegate = self
                   isfrom = "Multiple"
                   
                       popOverConfirmVC.selectedindex1 = index1
                  
            popOverConfirmVC.isfrom = "Multiple"

            popOverConfirmVC.strTitleName = "Select Service Provider"

            popOverConfirmVC.api_Company_Selection = "user/vendors/5"

            popOverConfirmVC.visitorTypeID = 5

                     /* if(txtCompanyName1.text != "")
                      {
                        
                            print("Multiple Select Service Provider")
                        
                          // popOverConfirmVC.alertGuardary = self.nameary
                      } */
            
                   self.navigationController?.pushViewController(popOverConfirmVC, animated: true)
            
           }
        
        if(textField == txtServiceType)
        {
            txtServiceType.resignFirstResponder()
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "ServiceTypeVC") as! ServiceTypeVC
            popOverConfirmVC.delegate = self
             isfrom = "Single"
            
            popOverConfirmVC.isfrom = "Single"
            
            popOverConfirmVC.selectedindex = indexservice
            
           /* if(txtServiceType.text != "")
            {
                print("Single Select Service Provider Service")
         
                // popOverConfirmVC.alertGuardary = self.nameary
            } */
            
          self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

        }
           
        if(textField == txtServiceType1)
        {
            txtServiceType1.resignFirstResponder()
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "ServiceTypeVC") as! ServiceTypeVC
            popOverConfirmVC.delegate = self
             isfrom = "Multiple"
            
            popOverConfirmVC.isfrom = "Multiple"

            popOverConfirmVC.selectedindex1 = indexservice1
            
           /* if(txtServiceType1.text != "")
            {
                print("Multiple Select Service Provider Service")

                // popOverConfirmVC.alertGuardary = self.nameary
            } */
            
            self.navigationController?.pushViewController(popOverConfirmVC, animated: true)
            
        }
        
           if(textField == txtAllWeek)
           {
                   
            viewbottom.isHidden = true
            viewbottom1.isHidden = false
            
               txtAllWeek.resignFirstResponder()
                   
                  // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
           }
           
           if(textField == txtvaildtill)
           {
                 
               viewbottom1.isHidden = true
               viewbottom.isHidden = false
               txtvaildtill.resignFirstResponder()
                   
                  // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
           }
               if(textField == txtdate)
               {
                   textfield = txtdate
               }
               if(textField == txtstartdate)
               {
                   //datePicker.minimumDate = Date()
                   textfield = txtstartdate
                   
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
                   
               }
        
        if(textField == txtStartTime)
               {
                   textfield = txtStartTime
               }
               
               if(textField == txtEndTime)
               {
                   textfield = txtEndTime
               }
               
       }
       
       func setborders(textfield:UITextField)
         {
             
            // textfield.layer.borderColor =  AppColor.appcolor.cgColor
              textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
             
             textfield.layer.borderWidth = 1.0
             
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

            cell.lblname.text = hourary[indexPath.row]
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

                     //  if(selectedindex == indexPath.row)
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
            return CGSize(width:(expectedLabelSize?.size.width)! + 25, height: expectedLabelSize!.size.height + 25)
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
           // txtAllWeek.text = arrDays[indexPath.row].daysName
            
            if arrSelectionCheck.contains(arrDays[indexPath.row].daysName!){
                arrSelectionCheck.remove(arrDays[indexPath.row].daysName!)
                arrSelectionDayId.remove(arrDays[indexPath.row].daysTypeID!)
            }else{
                arrSelectionCheck.add(arrDays[indexPath.row].daysName!)
                arrSelectionDayId.add(arrDays[indexPath.row].daysTypeID!)
            }
            
          //  self.txtAllWeek.text = arrSelectionCheck.componentsJoined(by:",")

             // selectedindex = indexPath.row
            
             // viewbottom.isHidden = true
            //  viewmain.backgroundColor = UIColor.white
              collectionDays.reloadData()
        }
        
    }
    
    // MARK: - pickerview delegate and data source methods
    
       // Number of columns of data
    
    /*   func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }
       
       // The number of rows of data
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return ServiceTypeAry.count
       }
       
       // The data to return fopr the row and component (column) that's being passed in
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return ServiceTypeAry[row]
       }
       
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           
           txtServiceType.text = ServiceTypeAry[row]
       } */
       

}
