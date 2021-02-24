//
//  DeliveryEntryVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 21/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import ScrollPager
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
class DeliveryEntryVC: UIViewController, ScrollPagerDelegate, UITextFieldDelegate,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , DeliveryCompanyListProtocol {
   
    // var selectedindex = NSMutableArray()
    
    var selectedindex : Int = 0
    
    var index:Int?
    var index1:Int?

    var vendorID:Int?
    var isPublic:Int?

    var vendorID1:Int?
    var isPublic1:Int?

    var isfrom = ""
    
    var singleDeliveryCheckGate:Int?

    var multipleDeliveryCheckGate:Int?

    var arrSelectionCheck = NSMutableArray()
    
    var arrSelectionDayId = NSMutableArray()


    var hourary = ["2 Hr" , "4 Hr" , "6 Hr" , "8 Hr" , "10 Hr" , "12 Hr"  ,"Day End"]
    
  //  var arrDays = ["Mon" , "Tue" , "Wed" , "Thu" , "Fri" , "Sat"  ,"Sun"]

    var arrDays = [GetDays]()
        //NSMutableArray()
    
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

    @IBOutlet weak var txtAllWeek: UITextField!

    @IBOutlet weak var txtstartdate: UITextField!
    
    @IBOutlet weak var txtenddate: UITextField!
    
    @IBOutlet weak var txtStartTime: UITextField!

    @IBOutlet weak var txtEndTime: UITextField!

    @IBOutlet weak var btncheckMark: UIButton!
    
    @IBOutlet weak var btncheckMark1: UIButton!
    
    @IBOutlet weak var btnaddDelivery: UIButton!
    
    @IBOutlet weak var btnaddDelivery1: UIButton!
    
    @IBOutlet weak var txtDeliveryCompanyName: UITextField!

    @IBOutlet weak var txtDeliveryCompanyName1: UITextField!


    var textfield = UITextField()
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    var date1 = Date()
    var date2 = Date()
    
    let datePicker_start = UIDatePicker()
    let datePicker_end = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pager.delegate = self

        pager.addSegmentsWithTitlesAndViews(segments: [
            ("Single", ViewSingle),
            ("Multiple", ViewMultiple)
        ])
        
//        if(isfrom == "")
//        {
//            pager.setSelectedIndex(index: 0, animated: true)
//        }
//
//        if(isfrom == "Single")
//        {
//            pager.setSelectedIndex(index: 0, animated: true)
//        }
//
//        if(isfrom == "Multiple")
//        {
//            pager.setSelectedIndex(index: 1, animated: true)
//        }
        
        singleDeliveryCheckGate = 0
        
        multipleDeliveryCheckGate = 0
        
        btncheckMark.isSelected = false

        btncheckMark.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
        
        btncheckMark1.isSelected = false

        btncheckMark1.setImage(UIImage(named: "ic_radiobutton"), for: .normal)

        viewbottom.isHidden = true
        viewbottom1.isHidden = true
        
        
        self.viewbottom.frame.size.width = self.view.frame.size.width
        self.viewbottom1.frame.size.width = self.view.frame.size.width
       
        
        setborders(textfield: txtdate)
        setborders(textfield: txttime)
        setborders(textfield: txtvaildtill)
        setborders(textfield: txtDeliveryCompanyName)

        setborders(textfield: txtAllWeek)
        setborders(textfield: txtstartdate)
        setborders(textfield: txtenddate)
        setborders(textfield: txtStartTime)
        setborders(textfield: txtEndTime)
        setborders(textfield: txtDeliveryCompanyName1)
        
        txtdate.delegate = self
        txttime.delegate = self
        txtvaildtill.delegate = self
        txtDeliveryCompanyName.delegate = self

        txtAllWeek.delegate = self
        txtstartdate.delegate = self
        txtenddate.delegate = self
        txtStartTime.delegate = self
        txtEndTime.delegate = self
        txtDeliveryCompanyName1.delegate = self

        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txttime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtvaildtill)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtDeliveryCompanyName)

        webservices.sharedInstance.PaddingTextfiled(textfield: txtAllWeek)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtstartdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtenddate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtStartTime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtEndTime)

        webservices.sharedInstance.PaddingTextfiled(textfield: txtDeliveryCompanyName1)

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

    }
    
    func showTimepPicker_Multiple() {
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
    
    @IBAction func backaction(_ sender: UIButton) {
        view.endEditing(true) // or do something

        self.navigationController?.popViewController(animated: true)
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
    
       func showTimepPicker(){
           //Formate Date
           timePicker.datePickerMode = .time
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
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
        
        print("txttime text :- ",txttime.text!)
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
    
   /* func setUpDays_Grp() {
                
        let dict1 = NSMutableDictionary()
        dict1.setValue("Sun", forKey: "days_grp")
        dict1.setValue("0", forKey: "is_selected")
        arrDays.add(dict1)
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("Mon", forKey: "days_grp")
        dict2.setValue("0", forKey: "is_selected")
        arrDays.add(dict2)
        
        let dict3 = NSMutableDictionary()
        dict3.setValue("Tue", forKey: "days_grp")
        dict3.setValue("0", forKey: "is_selected")
        arrDays.add(dict3)
        
        let dict4 = NSMutableDictionary()
        dict4.setValue("Wed", forKey: "days_grp")
        dict4.setValue("0", forKey: "is_selected")
        arrDays.add(dict4)
        
        let dict5 = NSMutableDictionary()
        dict5.setValue("Thu", forKey: "days_grp")
        dict5.setValue("0", forKey: "is_selected")
        arrDays.add(dict5)
        
        let dict6 = NSMutableDictionary()
        dict6.setValue("Fri", forKey: "days_grp")
        dict6.setValue("0", forKey: "is_selected")
        arrDays.add(dict6)
        
        let dict7 = NSMutableDictionary()
        dict7.setValue("Sat", forKey: "days_grp")
        dict7.setValue("0", forKey: "is_selected")
        arrDays.add(dict7)
        
    } */
    
    @IBAction func btnClose_hour(_ sender: Any) {
           self.viewbottom.isHidden = true
    }
       
    @IBAction func btnApply(_ sender: Any) {
        
        txtvaildtill.text = hourary[selectedindex]

        collectionHours.reloadData()
     
        self.viewbottom.isHidden = true
    }
       
    @IBAction func btnReset(_ sender: Any) {
           
           txtvaildtill.text = hourary[0]

           selectedindex = 0
           
           collectionHours.reloadData()

           self.viewbottom.isHidden = true
    }
    
    
    @IBAction func btnClose_days(_ sender: Any) {
        self.viewbottom1.isHidden = true
    }
          
    @IBAction func btnApply_days(_ sender: UIButton) {
        
        self.txtAllWeek.text = arrSelectionCheck.componentsJoined(by:",")
        collectionDays.reloadData()

        self.viewbottom1.isHidden = true

    }
          
       @IBAction func btnReset_days(_ sender: Any) {
              
        txtAllWeek.text = "" //arrDays[0]
        
       // arrDays.removeAllObjects()
        arrSelectionCheck.removeAllObjects()

             // selectedindex = 0
              
              collectionDays.reloadData()

            self.viewbottom1.isHidden = true
       }
       
    
    @IBAction func btnCheckaction(_ sender: UIButton) {
        if btncheckMark.isSelected == false {
            singleDeliveryCheckGate = 1
            btncheckMark.setImage(UIImage(named: "ic_radiobuttonselect"), for: .normal)
            btncheckMark.isSelected = true
        }else{
            singleDeliveryCheckGate = 0
            btncheckMark.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
            btncheckMark.isSelected = false
          //  setView(view: filtrview, hidden: true)
        }
        
        self.view.endEditing(true)
    }
    
    @IBAction func btnCheckaction_1(_ sender: UIButton) {
        if btncheckMark1.isSelected == false {
            multipleDeliveryCheckGate = 1
            btncheckMark1.setImage(UIImage(named: "ic_radiobuttonselect"), for: .normal)
            btncheckMark1.isSelected = true
        }else{
            multipleDeliveryCheckGate = 0
            btncheckMark1.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
            btncheckMark1.isSelected = false
          //  setView(view: filtrview, hidden: true)
        }
        self.view.endEditing(true)
    }
    
    @IBAction func btnaddDeliveryaction(_ sender: UIButton) {
        
        if txtDeliveryCompanyName.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Delivery Company Name")
            self.present(alert, animated: true, completion: nil)
        }else{
            self.apicallDeliverySingleEntry()
        }
        print("btnaddDeliveryaction")
    }
       
    @IBAction func btnaddDeliveryaction_1(_ sender: UIButton) {
        
       // arrSelectionDayId.removeAllObjects()
        
        if arrSelectionDayId.count == 0 {
            for dic in arrDays {
                arrSelectionDayId.add(dic.daysTypeID!)
            }
        }
        
       /* if arrSelectionDayId.count == 0 {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"select must be at least one day")
            self.present(alert, animated: true, completion: nil)
        }else */if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedSame {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }
        else if txtDeliveryCompanyName1.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Delivery Company Name")
            self.present(alert, animated: true, completion: nil)
        }else{
            self.apicallDeliveryMultipleEntry()
        }
        
        print("btnaddDeliveryaction_1")

    }
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        
        if changedIndex == 0{
            self.view.endEditing(true)
        }else{
            self.view.endEditing(true)
        }
        
    }
    
    // MARK: - deliveryList delegate methods

    //func deliveryList(name: String)
  //  func deliveryList(name:String, selectNumber:Int)
    
    func deliveryList(name:String,VendorID:Int,IsPublic:Int, selectNumber:Int)
    {
        index = selectNumber

           if(isfrom == "Single") {
               self.txtDeliveryCompanyName.text = name
               vendorID = VendorID
               isPublic = IsPublic
           }
    }
    
    func deliveryList1(name1:String,VendorID1:Int,IsPublic1:Int, selectNumber1:Int)
    {
        index1 = selectNumber1

           if(isfrom == "Multiple"){
               self.txtDeliveryCompanyName1.text = name1
                vendorID1 = VendorID1
                isPublic1 = IsPublic1
           }                 
       }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textfield.resignFirstResponder()
      }
    
    // MARK: - textField delegate methods

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
                    
        if(textField == txtDeliveryCompanyName)
            {
                   let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                   popOverConfirmVC.delegate = self
                    isfrom = "Single"
                                
                popOverConfirmVC.isfrom = "Single"

                popOverConfirmVC.selectedindex = index
            
                popOverConfirmVC.strTitleName = "Select Delivery Company"
                
                popOverConfirmVC.api_Company_Selection = "user/vendors/2"

                popOverConfirmVC.strlbl = txtDeliveryCompanyName.text!
            
                popOverConfirmVC.visitorTypeID = 2

                  /* if(txtDeliveryCompanyName.text == popOverConfirmVC.strlbl)
                   {

                        print("Single Select Delivery Company")

                      // popOverConfirmVC.selectedary = self.selectedary
                       // popOverConfirmVC.entryary = txtDeliveryCompanyName.text
                   } */
            
                self.navigationController?.pushViewController(popOverConfirmVC, animated: true)
            
                txtDeliveryCompanyName.resignFirstResponder()


        }
        
        if (textField == txtDeliveryCompanyName1)
            {
                   let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                   popOverConfirmVC.delegate = self
                isfrom = "Multiple"
                
            popOverConfirmVC.isfrom = "Multiple"

                    popOverConfirmVC.selectedindex1 = index1
            
            popOverConfirmVC.strTitleName = "Select Delivery Company"

            popOverConfirmVC.api_Company_Selection = "user/vendors/2"

                popOverConfirmVC.strlbl = txtDeliveryCompanyName1.text!
            
            popOverConfirmVC.visitorTypeID = 2

                  /* if(txtDeliveryCompanyName1.text != "")
                   {
                        print("Multiple Select Delivery Company")
                       // popOverConfirmVC.alertGuardary = self.nameary
                   } */
            
                self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

                txtDeliveryCompanyName1.resignFirstResponder()

        }
        
        if(textField == txtAllWeek)
        {
            viewbottom1.isHidden = false
            
            viewbottom.isHidden = true
            
           // view.endEditing(true)

           // txtAllWeek.becomeFirstResponder()
                    
            // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        
        if(textField == txtvaildtill)
        {
            viewbottom.isHidden = false
            
            viewbottom1.isHidden = true
            
            view.endEditing(true)

           // txtvaildtill.becomeFirstResponder()

               // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
            if(textField == txtdate)
            {
                textfield = txtdate
                viewbottom.isHidden = true
                viewbottom1.isHidden = true
                
              //  txtdate.becomeFirstResponder()

            }
            if(textField == txtstartdate)
            {
                //datePicker.minimumDate = Date()
                textfield = txtstartdate
                viewbottom.isHidden = true
                viewbottom1.isHidden = true
                
              //  txtstartdate.becomeFirstResponder()


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
                viewbottom.isHidden = true
                viewbottom1.isHidden = true
                
              //  txtenddate.becomeFirstResponder()

            }
        if(textField == txttime) {
            textfield = txttime
            
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
            
           // txttime.becomeFirstResponder()


        }
        
        if(textField == txtStartTime) {
            textfield = txtStartTime
            
            viewbottom.isHidden = true
            viewbottom1.isHidden = true
            
           // txtStartTime.becomeFirstResponder()


        }
             
        if(textField == txtEndTime) {
            textfield = txtEndTime
            
            viewbottom.isHidden = true
            viewbottom1.isHidden = true

           // txtEndTime.becomeFirstResponder()

        }
        
            
    }
    
    func setborders(textfield:UITextField)
      {
          
         // textfield.layer.borderColor =  AppColor.appcolor.cgColor
           textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
          
          textfield.layer.borderWidth = 1.0
          
      }
    
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
    
    func messageClicked() {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  "Successfully Added"
        avc?.subtitleStr = "Your delivery will be allowed"
        avc?.isfrom = 4

        avc?.yesAct = {
           
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
                                         
        }
        avc?.noAct = {
            
        }
        
        present(avc!, animated: true)
    }
    
    // MARK: - get Delivery Multiple Entry

    func apicallDeliveryMultipleEntry()
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
        
        var after_add_time = ""
        
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
        }
        
        if arrSelectionDayId.count == 0 {
            for dic in arrDays {
                arrSelectionDayId.add(dic.daysTypeID!)
            }
        }
        
        var param = Parameters()
        
        var vendorServiceTypeID:Int?
        vendorServiceTypeID = 1
        
        
            param  = [
                "VisitStartDate": strDateee, // date = txtdate.text!
                "VisitEndDate": endDate,
                "FromTime": txtStartTime.text!, //time, // txtStartTime.text!, // // start time
                "ToTime": txtEndTime.text!, //after_add_time, // txtEndTime.text!, // //validtill,  // to time
                "VendorID":vendorID1!,
                "VendorName": self.txtDeliveryCompanyName1.text!,
                "VendorServiceTypeID": vendorServiceTypeID!,
                "IsLeaveAtGate": multipleDeliveryCheckGate!,
                "IsPublicVendor":isPublic1!,
                "DaysOfWeek": arrSelectionDayId.componentsJoined(by: ",")
            ]
        
           print("param Multiple Delivery Entry : ",param)
        
           webservices().StartSpinner()
        
        Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_DELIVERYENTRY, param: param, token: token as! String) { JSON in
                
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
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
    }
    
    // MARK: - get Delivery Single Entry
    
    func apicallDeliverySingleEntry()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
         //  let SocietyId = UserDefaults.standard.value(forKey: USER_SOCIETY_ID) as! Int
          //  let strsocietyId = (SocietyId as NSNumber).stringValue
            
            //            type, contact_array, society_id, start_date, end_date, maxhour, time
            //            date format:- yyyy-mm-dd
        
          //  var string = ""
        
            var strDateee = ""
           // var endDate = ""
            
          //  if frequencyType == "once"{
        
           date = txtdate.text!
            strDateee = strChangeDateFormate(strDateeee: date)
                
        
        var after_add_time = ""

       // if validtill == "Day End" {
        
        if txtvaildtill.text == "Day End" {
            validtill = time
            
            let dateFormatter = DateFormatter()
            
            let isoDate = txttime.text! // time //strDateee //"2016-04-14T10:44:00+0000"
            
            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"

            let date = dateFormatter.date(from:isoDate)!
            print("date :- ",date)
            
//            let date2 = strDateee
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            var date = dateFormatter.date(from: date2)
//
//            date = dateFormatter.date(from:isoDate)!
            
          //  let addminutes = date.addingTimeInterval(TimeInterval(24*60*60))
           // after_add_time = dateFormatter.string(from: addminutes)
              //  print("after add time --> ",after_add_time)
            
            after_add_time = "11:59 PM" //"23:59:00"
             
        }else{
          //  validtill.removeLast(3)
            
            txtvaildtill.text?.removeLast(3)

            let myInt = Int(txtvaildtill.text!)!
            
            let dateFormatter = DateFormatter()
                        
            let isoDate = txttime.text!

            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"

            let date = dateFormatter.date(from:isoDate)!
            
            let addminutes = date.addingTimeInterval(TimeInterval(myInt*60*60))
            after_add_time = dateFormatter.string(from: addminutes)
            
            print("after add time 3 --> ",after_add_time)
        }
       
        var param = Parameters()
        
        var vendorServiceTypeID:Int?
        vendorServiceTypeID = 1

            param  = [
                "VisitStartDate": strDateee, // date = txtdate.text!
                "FromTime": txttime.text!, //time, // start time
                "ToTime": after_add_time,  //validtill,  // to time
                
                "VendorID":vendorID!,
                "VendorName": self.txtDeliveryCompanyName.text!,
                "VendorServiceTypeID": vendorServiceTypeID!,
                "IsLeaveAtGate": singleDeliveryCheckGate!,
                "IsPublicVendor":isPublic!
            ]
        
        print("param Single Delivery Entry : ",param)
        
//        }else{
//            param  = [
//                "VisitStartDate": strDateee,
//                "VisitEndDate": endDate,
//            ]
//        }
        
//        if frequencyType == "once"{
//              print("param once : ",param)
//        }else{
//             print("param multi : ",param)
//        }
            
            webservices().StartSpinner()
        
        Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_DELIVERYENTRY, param: param, token: token as! String) { JSON in
                
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

                        
                     /*   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                        
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                   
                        navigationController.pushViewController(initialViewController, animated: true)
                        
                        self.appDelegate.window?.rootViewController = navigationController
                        
                        self.appDelegate.window?.makeKeyAndVisible()
                     
                        */
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

            cell.lblname.text = hourary[indexPath.row] as? String
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
            
           // self.txtAllWeek.text = arrSelectionCheck.componentsJoined(by:",")

             // selectedindex = indexPath.row
            
             // viewbottom.isHidden = true
            //  viewmain.backgroundColor = UIColor.white
            
              collectionDays.reloadData()
            
        }
        
    }
}
