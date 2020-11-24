//
//  AddguestPopup.swift
//  SocietyMangement
//
//  Created by MacMini on 02/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SDWebImage


var frequencyType = ""
var date = ""
var time = ""
var validtill = ""
var startdate = ""
var enddate = ""
var days = ""

protocol  Invite {
    
    func inviteaction(from:String)
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AddguestPopup: BaseVC  , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITextFieldDelegate{
    
 //   @IBOutlet weak var lbldays: UILabel!
    
    @IBOutlet weak var lblonce: UIView!
    
    @IBOutlet weak var lblfrequent: UIView!
    
    @IBOutlet weak var lbllineonce: UILabel!
    
    @IBOutlet weak var lbllineSingle: UILabel!

    @IBOutlet weak var lbllineMulti: UILabel!

    
    @IBOutlet weak var lbllinefrequent: UILabel!
    
    @IBOutlet weak var viewfrequent: UIView!
    
    @IBOutlet weak var viewonce: UIView!
    
    @IBOutlet weak var viewstatic: UIView!
    
    @IBOutlet weak var viewselection: UIView!
    
    @IBOutlet weak var viewmain: UIView!
    
    @IBOutlet weak var viewbottom: UIView!
    @IBOutlet weak var txtdate: UITextField!
    
    
    @IBOutlet weak var txttime: UITextField!
    
    @IBOutlet weak var txtvaildtill: UITextField!
    
    @IBOutlet weak var txtstartdate: UITextField!
    
    @IBOutlet weak var txtenddate: UITextField!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBOutlet weak var lblmanually: UILabel!
    
    @IBOutlet weak var lblrecent: UILabel!

    
    @IBOutlet weak var txtcontact1: UITextField!
       

    @IBOutlet weak var txtmanually1: UITextField!
    
    @IBOutlet weak var txtRecentally1: UITextField!

    
    @IBOutlet weak var txtcontact12: UITextField!
          
    @IBOutlet weak var txtRecentally12: UITextField!

    @IBOutlet weak var txtmanually12: UITextField!
    
    @IBOutlet weak var lblfrecontact: UILabel!
    
    @IBOutlet weak var lblfreemanually: UILabel!
    
    @IBOutlet weak var collectionHours: UICollectionView!

    
    var hourary = ["2 Hr" , "4 Hr" , "6 Hr" , "8 Hr" , "10 Hr" , "12 Hr"  ,"Day End"]
    
   // var hourary = ["1 hour" , "2 hour" , "4 hour" , "8 hour" , "12 hour"  ,"24 hour"]

    
    var selectedindex : Int = 0
    
    var delegate:Invite?
    
    var isfrom = 1
    
    
    @IBAction func AddFromcontact(_ sender: Any) {
        if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else{
            validtill = txtvaildtill.text!
            startdate = txtstartdate.text!
            enddate = txtenddate.text!
            delegate?.inviteaction(from: "contact")
        }
    }
    
    @IBAction func AddFromRecent(_ sender: Any) {
        if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else{
            validtill = txtvaildtill.text!
            startdate = txtstartdate.text!
            enddate = txtenddate.text!
            delegate?.inviteaction(from: "recent")
        }
      }
    
    @IBAction func ManuallyAction(_ sender: Any) {
        if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else{
            validtill = txtvaildtill.text!
            startdate = txtstartdate.text!
            enddate = txtenddate.text!
            delegate?.inviteaction(from: "Manually")
        }
    }
    
    @IBAction func AdOptionAction(_ sender: Any) {
        
        
        viewstatic.isHidden = true
        self.viewonce.bringSubview(toFront:viewselection)
        
        viewselection.isHidden = false
    }
    
    @IBAction func CloseAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

//        removeAnimate()
//
//        if isfrom == 0 {
//            tabbarEnabled()
//        }
        
        
    }
    
    @IBAction func btnClose_hour(_ sender: Any) {
        self.viewbottom.isHidden = true
    }
    
    @IBAction func btnApply(_ sender: UIButton) {
        
        txtvaildtill.text = hourary[selectedindex]

       // selectedindex = 0
        
        collectionHours.reloadData()

        self.viewbottom.isHidden = true
    }
    
    @IBAction func btnReset(_ sender: Any) {
        
        self.viewbottom.isHidden = true
    }
    
    var textfield = UITextField()
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    var date1 = Date()
    var date2 = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        viewstatic.isHidden = true
        self.viewonce.bringSubview(toFront:viewselection)
        viewselection.isHidden = false
        
        
        frequencyType = "once"
      //  self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    //    self.showAnimate()
        
        self.viewmain.bringSubview(toFront:viewonce)
        viewonce.isHidden = false
        viewfrequent.isHidden = true
        
//        viewstatic.isHidden = false
//        self.viewonce.bringSubview(toFront:viewstatic)
//
        //viewselection.isHidden = true
        lbllineonce.isHidden = false
        lbllinefrequent.isHidden = true
        
        lbllineSingle.textColor = AppColor.borderColor
        lbllineMulti.textColor = AppColor.lineSingleColor

        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(taponce))
        lblonce.addGestureRecognizer(tap)
        
        
        let tap1 = UITapGestureRecognizer()
        tap1.addTarget(self, action: #selector(tapfrequent))
        lblfrequent.addGestureRecognizer(tap1)
        
       /* setrightviewnew(textfield: txtdate, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txttime, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtvaildtill, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtstartdate, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtenddate, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtenddate, image: UIImage(named:"ic_down_blue")!) */
        
        setborders(textfield: txtdate)
        setborders(textfield: txttime)
        setborders(textfield: txtvaildtill)
        setborders(textfield: txtstartdate)
        setborders(textfield: txtenddate)
        
        setborders(textfield: txtcontact1)
        setborders(textfield: txtRecentally1)
        setborders(textfield: txtmanually1)

        setborders(textfield: txtcontact12)
        setborders(textfield: txtmanually12)
        setborders(textfield: txtRecentally12)
        
        txtdate.delegate = self
        txttime.delegate = self
        txtvaildtill.delegate = self
        txtstartdate.delegate = self
        txtenddate.delegate = self
        
        viewbottom.isHidden = true
        
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txttime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtvaildtill)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtstartdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtenddate)
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtcontact1)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtmanually1)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtRecentally1)
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtcontact12)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtmanually12)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtRecentally12)

        showTimepPicker()
        showDatePicker()
        
        txtvaildtill.text = hourary[0]

        
        let tap2 = UITapGestureRecognizer()
        tap2.addTarget(self, action: #selector(tapcontact))
        lblcontact.addGestureRecognizer(tap2)
        
        let tap4 = UITapGestureRecognizer()
        tap4.addTarget(self, action: #selector(tapcontact))
        lblfrecontact.addGestureRecognizer(tap4)
        
        lblcontact.isUserInteractionEnabled = true
        lblfrecontact.isUserInteractionEnabled = true
        
        lblrecent.isUserInteractionEnabled = true

        
        let tap12 = UITapGestureRecognizer()
        tap12.addTarget(self, action: #selector(taprecent))
        lblrecent.addGestureRecognizer(tap12)
        
        
        let tap3 = UITapGestureRecognizer()
        tap3.addTarget(self, action: #selector(tapmanually))
        lblmanually.isUserInteractionEnabled = true
        lblfreemanually.isUserInteractionEnabled = true
        
        let tap5 = UITapGestureRecognizer()
        tap5.addTarget(self, action: #selector(tapmanually))
        
        lblmanually.addGestureRecognizer(tap5)
        
        lblfreemanually.addGestureRecognizer(tap3)
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left, verticalAlignment: .center)
               
        collectionHours.collectionViewLayout = alignedFlowLayout
         
        
        
        let datee = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtdate.text = formatter.string(from: datee)
        txtstartdate.text = formatter.string(from: datee)
        txtenddate.text = formatter.string(from: datee)
        date = txtdate.text!
        
        txtdate.text = "Today"
        
        let formatt = DateFormatter()
        formatt.dateFormat = "hh:mm:ss a"
        txttime.text = formatt.string(from: datee)
        time =  txttime.text!
        
       

        
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
    
    @objc func taprecent()
    {
        if(frequencyType == "once"){
            if(txtdate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txttime.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter time")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txtvaildtill.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter valid entry hours")
                self.present(alert, animated: true, completion: nil)
                
            }else
            {
                if txtdate.text == "Today" {
                    let datee = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    txtdate.text = formatter.string(from: datee)
                    date = txtdate.text!
                }else{
                    date = txtdate.text!
                }
                time = txttime.text!
                validtill = txtvaildtill.text!
                
                startdate = txtstartdate.text!
                enddate = txtenddate.text!
                
                print("recent once")
                
                delegate?.inviteaction(from: "recent")
            }
        }
        else{
            
            if(txtstartdate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter start date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txtenddate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please end date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                                
                if txtdate.text == "Today" {
                    let datee = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    txtdate.text = formatter.string(from: datee)
                    date = txtdate.text!
                }else{
                    date = txtdate.text!
                }
                time = txttime.text!
                validtill = txtvaildtill.text!
                
                startdate = txtstartdate.text!
                enddate = txtenddate.text!
                
                print("recent multi")

                delegate?.inviteaction(from: "recent")
                
            }
            
        }
        
    }
    
    @objc func tapcontact()
    {
        if(frequencyType == "once"){
            if(txtdate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txttime.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter time")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txtvaildtill.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter valid entry hours")
                self.present(alert, animated: true, completion: nil)
                
            }else
            {
                
                if txtdate.text == "Today" {
                    let datee = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    txtdate.text = formatter.string(from: datee)
                    date = txtdate.text!
                }else{
                    date = txtdate.text!
                }
                time = txttime.text!
                validtill = txtvaildtill.text!
                
                startdate = txtstartdate.text!
                
                enddate = txtenddate.text!
                
                print("contact once")
                
                delegate?.inviteaction(from: "contact")

                
            }
        }
        else{
            
            if(txtstartdate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter start date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txtenddate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please end date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                
                if txtdate.text == "Today" {
                    let datee = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    txtdate.text = formatter.string(from: datee)
                    date = txtdate.text!
                }else{
                    date = txtdate.text!
                }
                time = txttime.text!
                validtill = txtvaildtill.text!
                
                startdate = txtstartdate.text!
                
                enddate = txtenddate.text!
                
                print("contact multi")
                
                delegate?.inviteaction(from: "contact")
                
            }
            
        }
        
    }
    
    @objc func tapmanually()
    {
        if(frequencyType == "once"){
            if(txtdate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txttime.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter time")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txtvaildtill.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter valid entry hours")
                self.present(alert, animated: true, completion: nil)
                
            }else
            {
                if txtdate.text == "Today" {
                    let datee = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    txtdate.text = formatter.string(from: datee)
                    date = txtdate.text!
                }else{
                    date = txtdate.text!
                }
                time = txttime.text!
                validtill = txtvaildtill.text!
                
                startdate = txtstartdate.text!
                
                enddate = txtenddate.text!
                
                print("manually once")
                
                delegate?.inviteaction(from: "manually")
                
            }
        }
        else{
            
            if(txtstartdate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter start date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else if(txtenddate.text!.isEmpty)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please end date")
                self.present(alert, animated: true, completion: nil)
                
            }
            else
            {
                
                if txtdate.text == "Today" {
                    let datee = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd-MM-yyyy"
                    txtdate.text = formatter.string(from: datee)
                    date = txtdate.text!
                }else{
                    date = txtdate.text!
                }
                time = txttime.text!
                validtill = txtvaildtill.text!
                
                startdate = txtstartdate.text!
                enddate = txtenddate.text!
                
                print("manually multi")
                
                delegate?.inviteaction(from: "manually")
                
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
        
        // add datepicker to textField
     
        
    }
    
    @objc  func doneTimePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss a"
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
                    self.txtenddate.text = ""
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
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == txtvaildtill)
        {
            
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
        
    }
    
    @objc func taponce()
    {
        
        frequencyType = "once"
        self.viewmain.bringSubview(toFront:viewonce)
        viewonce.isHidden = false
        viewfrequent.isHidden = true
        
        viewstatic.isHidden = true
        self.viewonce.bringSubview(toFront:viewselection)
        viewselection.isHidden = false
          
//        viewstatic.isHidden = true
//        self.viewonce.bringSubview(toFront:viewstatic)
//
//        viewselection.isHidden = false
        lbllineonce.isHidden = false
        lbllinefrequent.isHidden = true
        
        lbllineSingle.textColor = AppColor.borderColor
        lbllineMulti.textColor = AppColor.lineSingleColor

        
    }
    
    
    @objc func tapfrequent()
    {
        
        frequencyType = "frequently"
        
        lbllineonce.isHidden = true
        lbllinefrequent.isHidden = false
        
        lbllineSingle.textColor = AppColor.lineSingleColor
        lbllineMulti.textColor = AppColor.borderColor

        self.viewmain.bringSubview(toFront:viewfrequent)
        viewonce.isHidden = true
        viewfrequent.isHidden = false
        
        
    }
    
    
    // MARK: - Collectionview delegate and datasource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourary.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       /* let numberOfSets = CGFloat(4.0)
        
        let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 45))/numberOfSets
        
        return CGSize(width:width,height: 42) */
        
        let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
        let contentNSString = hourary[indexPath.row]
        let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 16)!], context: nil)
        
        print("\(expectedLabelSize)")
        return CGSize(width:expectedLabelSize.size.width + 35, height: expectedLabelSize.size.height + 25) //31
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        txtvaildtill.text = hourary[indexPath.row]
        
        selectedindex = indexPath.row
       // viewbottom.isHidden = true
        viewmain.backgroundColor = UIColor.white
        collectionHours.reloadData()
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
                
            }
        });
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }
    
    func setborders(textfield:UITextField)
    {
        
       // textfield.layer.borderColor =  AppColor.appcolor.cgColor
         textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
        
        textfield.layer.borderWidth = 1.0
        
    }
        
    func setrightviewnew(textfield: UITextField ,image:UIImage)
    {
        var imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.isUserInteractionEnabled = false
        
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
    }
    
    
    
}
