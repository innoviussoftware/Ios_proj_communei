//
//  CabEntryVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 23/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import ScrollPager

@available(iOS 13.0, *)
class CabEntryVC: UIViewController, ScrollPagerDelegate , UITextFieldDelegate,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, DeliveryCompanyListProtocol
{
    
    var selectedindex : Int = 0
    
    var index:Int?

    var isfrom = ""
    
    var isfrom_entry = 0

    var hourary = ["2 Hr" , "4 Hr" , "6 Hr" , "8 Hr" , "10 Hr" , "12 Hr"  ,"Day End"]
    
    var arrDays = ["Mon" , "Tue" , "Wed" , "Thu" , "Fri" , "Sat"  ,"Sun"]

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
    

    var textfield = UITextField()
       var datePicker = UIDatePicker()
       var timePicker = UIDatePicker()
       var date1 = Date()
       var date2 = Date()
    
    let datePicker_start = UIDatePicker()
    let datePicker_end = UIDatePicker()


    override func viewDidLoad() {
        super.viewDidLoad()
        
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

    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnaddCabaction(_ sender: Any) {
        print("btnaddCabaction")
    }
       
    @IBAction func btnaddCabaction_1(_ sender: Any) {
        print("btnaddCabaction_1")
    }
    
    @IBAction func btnClose_hour(_ sender: Any) {
             self.viewbottom.isHidden = true
      }
         
      @IBAction func btnApply(_ sender: Any) {
        
           txtvaildtill.text = hourary[selectedindex]

       // selectedindex = 0
        
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
            
      @IBAction func btnApply_days(_ sender: Any) {
          self.viewbottom1.isHidden = true
      }
            
    @IBAction func btnReset_days(_ sender: Any) {
                
        txtAllWeek.text = (arrDays[0] as! String)

        selectedindex = 0
                
        collectionDays.reloadData()

        self.viewbottom1.isHidden = true
    }
         

    // MARK: - deliveryList delegate methods

    //func deliveryList(name: String)
   // func deliveryList(name:String, selectNumber:Int)
    func deliveryList(name:String,VendorID:Int,IsPublic:Int, selectNumber:Int)
    {
           if(isfrom == "Single") {
               self.txtCabCompanyName.text = name
           }else if(isfrom == "Multiple"){
               self.txtCabCompanyName1.text = name
           }else{
               self.txtCabCompanyName.text = name
           }
            index = selectNumber
                 
    }
    
    // MARK: - textField delegate methods

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
        if(textField == txtCabCompanyName)
            {
                   txtCabCompanyName.resignFirstResponder()
                   let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                   popOverConfirmVC.delegate = self
                    isfrom = "Single"
                
                    popOverConfirmVC.selectedindex = index
                    popOverConfirmVC.selectedindex1 = index

                   if(txtCabCompanyName.text != "")
                   {

                      // popOverConfirmVC.selectedary = self.selectedary
                       // popOverConfirmVC.entryary = txtDeliveryCompanyName.text
                   }
                self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

        }
        
        if (textField == txtCabCompanyName1)
            {
                   txtCabCompanyName1.resignFirstResponder()
                   let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                   popOverConfirmVC.delegate = self
                isfrom = "Multiple"
                
                    popOverConfirmVC.selectedindex = index
                    popOverConfirmVC.selectedindex1 = index
               
                   if(txtCabCompanyName1.text != "")
                   {
                       // popOverConfirmVC.alertGuardary = self.nameary
                   }
                self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

        }
        
        if(textField == txtAllWeek)
        {
                
            viewbottom1.isHidden = false
            txtAllWeek.resignFirstResponder()
                
               // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        
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
        
        if(textField == txtStartTime)
        {
            textfield = txtStartTime
        }
        
        if(textField == txtEndTime)
        {
            textfield = txtEndTime
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

                       cell.lblname.text = arrDays[indexPath.row] as! String
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfSets = CGFloat(4.0)
        
        let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 45))/numberOfSets
        
        return CGSize(width:width,height: 42);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if (collectionView == collectionHours) {
            txtvaildtill.text = hourary[indexPath.row]
              
              selectedindex = indexPath.row
             // viewbottom.isHidden = true
            //  viewmain.backgroundColor = UIColor.white
              collectionHours.reloadData()
        }else{
            txtAllWeek.text = arrDays[indexPath.row]
              
              selectedindex = indexPath.row
             // viewbottom.isHidden = true
            //  viewmain.backgroundColor = UIColor.white
              collectionDays.reloadData()
        }
        
    }
    
    
}
