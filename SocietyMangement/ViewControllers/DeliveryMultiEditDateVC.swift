//
//  DeliveryMultiEditDateVC.swift
//  SocietyMangement
//
//  Created by Macmini on 17/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire

protocol addDeliveryMultiDate {
    func addedDeliveryMultiDate()
}

@available(iOS 13.0, *)
class DeliveryMultiEditDateVC: UIViewController, UITextFieldDelegate , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var delegate : addDeliveryMultiDate?
    
    @IBOutlet weak var viewinner: UIView!
    
    @IBOutlet weak var txtAllWeek: UITextField!

    @IBOutlet weak var txtstartdate: UITextField!
    
    @IBOutlet weak var txtenddate: UITextField!
    
    @IBOutlet weak var txtStartTime: UITextField!

    @IBOutlet weak var txtEndTime: UITextField!
    
    @IBOutlet weak var btncheckMark: UIButton!

    @IBOutlet weak var lblDeliveryName: UILabel!
    
    @IBOutlet weak var collectionDays: UICollectionView!
    
    @IBOutlet weak var viewbottom1: UIView!
    
    @IBOutlet weak var viewinnerHeightCons: NSLayoutConstraint!
    
    @IBOutlet weak var btnUpdateTopCons: NSLayoutConstraint!


    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
    
    let datePicker_start = UIDatePicker()
    let datePicker_end = UIDatePicker()


    var textfield = UITextField()
    
    var VisitFlatPreApprovalID:Int?
    var UserActivityID:Int?
    var VisitorEntryTypeID:Int?

    var multiDeliveryCheckGate = ""

    var strStartDate = ""
    var StrEndDate = ""
    
    var strStartTime = ""
    var strEndTime = ""
    
    var daysOfWeek = ""
    
    var isfrom = 1
    
    var arrDays = [GetDays]()
    
    var arrSelectionCheck = NSMutableArray()
    
    var arrSelectionDayId = NSMutableArray()

    var date1 = Date()
    var date2 = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewbottom1.isHidden = true
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        
        setborders(textfield: txtAllWeek)
        setborders(textfield: txtstartdate)
        setborders(textfield: txtenddate)
        setborders(textfield: txtStartTime)
        setborders(textfield: txtEndTime)
        
        txtAllWeek.delegate = self
        txtstartdate.delegate = self
        txtenddate.delegate = self
        txtStartTime.delegate = self
        txtEndTime.delegate = self
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtstartdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtenddate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtenddate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtStartTime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtEndTime)

        txtstartdate.text = strStartDate
        
        txtenddate.text = StrEndDate
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "h:mm a"
        
        
        var Msg_Date = strStartTime
        
        var Msg_Date1 = strEndTime


           let dateFormatterGet = DateFormatter()
           dateFormatterGet.dateFormat = "HH:mm:ss"
           let dateFormatterPrint = DateFormatter()
           dateFormatterPrint.dateFormat = "h:mm a"
           let datee = dateFormatterGet.date(from: Msg_Date)
           Msg_Date =  dateFormatterPrint.string(from: datee ?? Date())
        
           txtStartTime.text = Msg_Date
        
        let datees = dateFormatterGet.date(from: Msg_Date1)
        Msg_Date1 =  dateFormatterPrint.string(from: datees ?? Date())
     
        txtEndTime.text = Msg_Date1
        
        showDatePicker()
        
        showTimepPicker_Multiple()
        
        if isfrom == 2 {
            
            viewinnerHeightCons.constant = 390
            btnUpdateTopCons.constant = 60
            
            btncheckMark.isHidden = false
            lblDeliveryName.isHidden = false
            
            if multiDeliveryCheckGate == "0" {
                btncheckMark.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
                btncheckMark.isSelected = false
            }else if multiDeliveryCheckGate == "1" {
                btncheckMark.setImage(UIImage(named: "ic_radiobuttonselect"), for: .normal)
                btncheckMark.isSelected = true
            }
        }else if isfrom == 3 {
            
            viewinnerHeightCons.constant = 350
            btnUpdateTopCons.constant = 20
            btncheckMark.isHidden = true
            lblDeliveryName.isHidden = true
            
        }
        
        self.apiCallGetDays()
        
        let alignedFlowLayout1 = AlignedCollectionViewFlowLayout(horizontalAlignment:.left, verticalAlignment: .center)
               
        collectionDays.collectionViewLayout = alignedFlowLayout1
               
        // Do any additional setup after loading the view.
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
        txtstartdate.inputAccessoryView = toolbar
        // add datepicker to textField
        txtstartdate.inputView = datePicker
       
        datePicker.minimumDate = Date()
        
              // add toolbar to textField
              txtenddate.inputAccessoryView = toolbar
              // add datepicker to textField
              txtenddate.inputView = datePicker
              
    }
    
    @objc  func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if(textfield == txtenddate)
        {
            txtenddate.text = formatter.string(from: datePicker.date)
          /*  date2 = datePicker.date
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
            } */
            
        }
        if(textfield == txtstartdate)
        {
            txtstartdate.text = formatter.string(from: datePicker.date)
           // date1 = datePicker.date
            
        }
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
           //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
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
              
                if(textfield == txtStartTime) {
                    txtStartTime.text = formatter.string(from: datePicker_start.date)
                }
        
                if(textfield == txtEndTime) {
                    txtEndTime.text = formatter.string(from: datePicker_end.date)
                }
        
                 //dismiss date picker dialog
                 self.view.endEditing(true)
             }
             
    @objc func cancelTimePicker_Multiple(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
          
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        removeAnimate()
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
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
    }
    
    @IBAction func btnCheckaction(_ sender: UIButton) {
        if btncheckMark.isSelected == false {
            multiDeliveryCheckGate = "1"
            btncheckMark.setImage(UIImage(named: "ic_radiobuttonselect"), for: .normal)
            btncheckMark.isSelected = true
        }else{
            multiDeliveryCheckGate = "0"
            btncheckMark.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
            btncheckMark.isSelected = false
        }
        
        self.view.endEditing(true)
    }
    
    @IBAction func btnaddDateDeliveryAction(_ sender: UIButton) {
        
        if arrSelectionDayId.count == 0 {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"select must be at least one day")
            self.present(alert, animated: true, completion: nil)
        }else if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text! == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Enter Start time")
            self.present(alert, animated: true, completion: nil)
        }else if txtEndTime.text! == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Enter End time")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedSame  {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            self.apicallDeliveryMultipleEditDate()
        }
        

    }
    
    // MARK: - get Add Date Multi
    
    func apicallDeliveryMultipleEditDate()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
        var param = Parameters()

        if isfrom == 2 {
             param  = [
                "VisitStartDate": txtstartdate.text!,
                "VisitEndDate": txtenddate.text!,
                "FromTime": txtStartTime.text!,
                "ToTime": txtEndTime.text!,
                "VisitFlatPreApprovalID": VisitFlatPreApprovalID!,
                "UserActivityID": UserActivityID!,
                "VisitorEntryTypeID": VisitorEntryTypeID!,
                "IsLeaveAtGate": multiDeliveryCheckGate,
                "DaysOfWeek": arrSelectionDayId.componentsJoined(by: ",")
            ]
        }else if isfrom == 3 {
            param  = [
                "VisitStartDate": txtstartdate.text!,
                "VisitEndDate": txtenddate.text!,
                "FromTime": txtStartTime.text!,
                "ToTime": txtEndTime.text!,
                "VisitFlatPreApprovalID": VisitFlatPreApprovalID!,
                "UserActivityID": UserActivityID!,
                "VisitorEntryTypeID": VisitorEntryTypeID!,
                "DaysOfWeek": arrSelectionDayId.componentsJoined(by: ",")
            ]
        }
        
        print("param Multi Delivery add date : ",param)
        
            webservices().StartSpinner()
            
        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + "user/pre-approved/edit" ,token: token as! String, param: param) { JSON in

                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    
                            if(JSON.response?.statusCode == 200)
                            {
                                self.delegate?.addedDeliveryMultiDate()
                                self.removeAnimate()
                                self.dismiss(animated: false, completion: nil)
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
                                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter valid data")
                                self.present(alert, animated: true, completion: nil)
                            }
                        
                    
                    print(resp)
                case .failure(let err):
                    webservices().StopSpinner()
                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                }
            }
            
       
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
                    
                  /*  for dic in self.arrDays
                    {
                        if(self.arrSelectionDayId.contains(dic.daysTypeID!))
                        {
                            
                            self.arrSelectionCheck.add(dic.daysName!)
                            self.arrSelectionCheck.add(dic.daysTypeID!)

                        }
                        
                    } */
                    
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
                    
                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                 //   self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                    
                }
            }
            
        }
        
    }
    

    
    // MARK: - Collectionview delegate and datasource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
             return arrDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
                       else if(arrSelectionDayId.contains(arrDays[indexPath.row].daysTypeID!))
                       {
                       
                        cell.lblname.backgroundColor = AppColor.borderColor
                        cell.lblname.textColor = UIColor.white
                   }
                   else{
                       
                       cell.lblname.backgroundColor = AppColor.lblFilterUnselect
                       cell.lblname.textColor = UIColor.white
                      // cell.lblname.layer.borderColor = UIColor.lightGray.cgColor
                     //  cell.lblname.layer.borderWidth = 1.0
                   }
                       
                       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
           // txtAllWeek.text = arrDays[indexPath.row].daysName
            
            if arrSelectionCheck.contains(arrDays[indexPath.row].daysName!){
                arrSelectionCheck.remove(arrDays[indexPath.row].daysName!)
                arrSelectionDayId.remove(arrDays[indexPath.row].daysTypeID!)
            }else{
                arrSelectionCheck.add(arrDays[indexPath.row].daysName!)
                arrSelectionDayId.add(arrDays[indexPath.row].daysTypeID!)
            }
            
            // 15/2/21 comment check
        
          //  self.txtAllWeek.text = arrSelectionCheck.componentsJoined(by:",")

             // selectedindex = indexPath.row
            
             // viewbottom.isHidden = true
            //  viewmain.backgroundColor = UIColor.white
        
              collectionDays.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
            let contentNSString = arrDays[indexPath.row].daysName
            let expectedLabelSize = contentNSString?.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont(name: "Gotham-Book", size: 16)!], context: nil)
            
            print("\(String(describing: expectedLabelSize))")
            return CGSize(width:(expectedLabelSize?.size.width)! + 25, height: expectedLabelSize!.size.height + 25)
        
    }
    
    
    // MARK: - textField delegate methods

    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if(textField == txtAllWeek)
        {
            viewbottom1.isHidden = false
            txtAllWeek.resignFirstResponder()
                
            // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
        
        if(textField == txtStartTime) {
            textfield = txtStartTime
        }
             
        if(textField == txtEndTime) {
            textfield = txtEndTime
        }
            
    }
    
    func setborders(textfield:UITextField)
      {
          
         // textfield.layer.borderColor =  AppColor.appcolor.cgColor
           textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
          
          textfield.layer.borderWidth = 1.0
          
      }
  
}
