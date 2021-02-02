//
//  AmenitiesClenderBookVC.swift
//  SocietyMangement
//
//  Created by MacMini on 03/10/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AmenitiesClenderBookVC: UIViewController, UITextFieldDelegate {
    //,FSCalendarDelegate,FSCalendarDataSource {
    
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtEndTime: UITextField!
    @IBOutlet weak var txtStartTime: UITextField!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNotes: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var txtviewBookingNotes: UITextView!

   // let picker :UIDatePicker! = nil
   // let picker = UIDatePicker()
    
    @IBOutlet weak var lblFinalAmenties: UILabel!
    
    @IBOutlet weak var viewFinalAmenties: UIView!

    
    var isfrom = 1
        
    var amenityID:Int?
    
    var amount:Int?

    var strName = ""

    var strNotes = ""
    
    var strDescription = ""
    
    var strdateandtimeFirst = ""
    
    var strdateandtimeEnd = ""
    
    var strSelectCalendarDate = ""
    
    var strStartTime = ""
    
    var strEndTime = ""
    
   // var startBookinEditDate = ""

    var dicAddBook : AddBookingNow?
    
    let datePicker = UIDatePicker()
    
    let datePicker_end = UIDatePicker()

    var activeTexfield :UITextField! = nil

    var selecteddates = [String]()
    
       fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
       fileprivate lazy var dateFormatter1: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd" //"dd-MM-yyyy"
           return formatter
       }()
       fileprivate lazy var dateFormatter2: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd" // "dd-MM-yyyy"
           return formatter
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTimepPicker()
        
        setUpView()
        
        calenderView.placeholderType = .none
        
       if isfrom == 1 {
        
        calenderView.allowsMultipleSelection = false
        calenderView.swipeToChooseGesture.isEnabled = true
        calenderView.backgroundColor = UIColor.white
      //  calenderView.appearance.weekdayTextColor = UIColor(red:0.89, green:0.45, blue:0.68, alpha:1.0)
      //  calenderView.appearance.headerTitleColor = UIColor(red:0.89, green:0.45, blue:0.68, alpha:1.0)
        calenderView.appearance.selectionColor = UIColor.orange
   // calenderView.appearance.todayColor = UIColor.clear
    //    calenderView.appearance.todaySelectionColor = UIColor.clear
      //  calenderView.appearance.caseOptions = [.headerUsesUpperCase,.weekdayUsesSingleUpperCase]
        
  let date = NSDate()
  let calendar = Calendar.current
 
  
  let year =  calendar.component(.year, from: date as Date)
  let month = calendar.component(.month, from: date as Date)
  let day = calendar.component(.day, from: date as Date)
        
        print("year:month:day : ",year,month,day)

            lblName.text = strName
            lblNotes.text = strNotes
            lblDescription.text = strDescription
        
       // self.calenderView.deselect(currentDate)

            btnDone.setTitle("Book Now", for: .normal)
        // API_ADD_BOOKINGS_NOW
        // user/amenity/bookings/add
        }else{
            
            // user/amenity/bookings/edit
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let result = formatter.string(from: date)
                        
            if result <= strSelectCalendarDate {
                calenderView.select(self.dateFormatter1.date(from: strSelectCalendarDate))
            }else{
                strSelectCalendarDate = ""
            }
            
            lblName.text = strName
            lblNotes.text = strNotes
            
            btnDone.setTitle("Update", for: .normal)
        }
        
          viewFinalAmenties.isHidden = true
        
         calenderView.dataSource = self
         calenderView.delegate = self
         

    }
    
    @IBAction func backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {
        viewFinalAmenties.isHidden = true

        self.navigationController?.popViewController(animated: true)
    }
        
    func setUpView() {
        
        txtStartTime.delegate = self
        
        txtEndTime.delegate = self

       // datePicker.dataSource = datePicker
      //  datePicker.delegate = datePicker
        
      //  setborders(textfield: txtStartTime)
      //  setborders(textfield: txtEndTime)
       // setrightviewnew(textfield: txtStartTime, image: UIImage(named:"ic_downarrow")!)
       // setrightviewnew(textfield: txtEndTime, image: UIImage(named:"ic_downarrow")!)
        
        let date = Date()
        let formater = DateFormatter()
        formater.dateFormat = "hh:mm a"
        let outTime = formater.string(from: date)
        
        if isfrom == 1 {
            txtStartTime.text = outTime
            
            txtEndTime.text = outTime
                
        }else {
            txtStartTime.text = strStartTime
            
            txtEndTime.text = strEndTime
        }
        
       // opentimePicker(txt: txtStartTime)
        
       // opentimePicker(txt: txtEndTime)
        
    }
    
    func showTimepPicker(){
           //Formate Date
        datePicker.datePickerMode = .time
        
        datePicker_end.datePickerMode = .time

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker_end.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }

           //ToolBar
           let toolbar = UIToolbar()
           toolbar.sizeToFit()
           
           //done button & cancel button
           let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(doneTimePicker))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(cancelTimePicker))
           toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
           //timePicker.minimumDate = Date()
           // add toolbar to textField
        
            txtStartTime.inputAccessoryView = toolbar
            // add datepicker to textField
            txtStartTime.inputView = datePicker
         
             txtEndTime.inputAccessoryView = toolbar
                   // add datepicker to textField
             txtEndTime.inputView = datePicker_end
           
        
       }
    
    @objc func doneTimePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        txtStartTime.text = formatter.string(from: datePicker.date)
        
        txtEndTime.text = formatter.string(from: datePicker_end.date)
        
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    @objc func cancelTimePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
   /*
    func opentimePicker(txt:UITextField) {
     
     
        activeTexfield = txt
        
        if (picker != nil) {
            picker.removeFromSuperview()
        }
        
        picker.datePickerMode = .time
        activeTexfield.inputView = picker
        
    } */
    
    func dateAndTimeCombineStartTime() {
        let date = strSelectCalendarDate //"2020-12-24 "
        let time = txtStartTime.text! //"7:00 AM"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-mm-dd h:mm a"
        let string = date + " " + time        // "2017-12-24 7:00 AM"
       // let finalDate = dateFormatter.date(from: string)
      //  print("finalDate : ",finalDate!)
        
        strdateandtimeFirst = string

       // print("finalDate description : ",finalDate?.description(with: .current) ?? "")
    }
    
    func dateAndTimeCombineEndTime() {
        let date = strSelectCalendarDate //"2020-12-24 "
        let time = txtEndTime.text! //"7:00 AM"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-mm-dd h:mm a"
        let string = date + " " + time        // "2017-12-24 7:00 AM"
     //   let finalDate = dateFormatter.date(from: string)
      //  print("finalDate : ",finalDate!)
        
        strdateandtimeEnd = string

       // print("finalDate description : ",finalDate?.description(with: .current) ?? "")
    }
    
    func ApiCallAmenityBookingsAdd() {
           
        if !NetworkState().isInternetAvailable {
                        ShowNoInternetAlert()
                        return
         }
        
        dateAndTimeCombineStartTime()
        
        dateAndTimeCombineEndTime()

           webservices().StartSpinner()
               
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        var param = Parameters()

        if isfrom == 1 {

            param  = [
                        "AmenityID" : amenityID!,
                        "BookingNotes" : txtviewBookingNotes.text!,
                        "Amount" : amount!,
                        "StartDate" : strdateandtimeFirst,
                        "EndDate" : strdateandtimeEnd
                    ]
        }else{
            param  = [
                        "AmenitiesBookingID" : amenityID!,
                        "BookingNotes" : txtviewBookingNotes.text!,
                        "Amount" : amount!,
                        "StartDate" : strdateandtimeFirst,
                        "EndDate" : strdateandtimeEnd
                    ]
        }
                   
                  print("Parameters Booking : ",param)
        
        var strAmenity = ""

        if isfrom == 1 {
            strAmenity = "user/amenity/bookings/add"
        }else{
            strAmenity = "user/amenity/bookings/edit"
        }
        
        Apicallhandler.sharedInstance.ApiAddBookingNow(URL: webservices().baseurl + strAmenity, token: token as! String, param: param) { [self] JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
               // let nameary = NSMutableArray()
                if(resp.status == 1)
                {
                    if(self.isfrom == 1)
                    {
                        self.viewFinalAmenties.isHidden = false

                        self.lblFinalAmenties.text = "Reservation for \(lblName.text!) sent for Approval on \(strSelectCalendarDate), \(txtStartTime.text!) to \(txtEndTime.text!)"
                        
                        print("1 : ")
                    }else{
                        
                        self.viewFinalAmenties.isHidden = false

                        self.lblFinalAmenties.text = "Updated Reservation for \(lblName.text!) sent for Approval on \(strSelectCalendarDate), \(txtStartTime.text!) to \(txtEndTime.text!)"
                        
                        print("2 : ")
                    }
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
                else{
                    
                    print("1 & 2 : ")

                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message!)
                  //  self.present(alert, animated: true, completion: nil)
                }
                print(resp)
            case .failure(let err):
                
                print("1 == 2 : ")

               // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
               // self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                webservices().StopSpinner()
                
            }
                        
        }
                
    }
    
    //MARK:- action method
    
    @IBAction func actionDone(_ sender: UIButton) {
        print("strSelectCalendarDate : ", strSelectCalendarDate)
            if strSelectCalendarDate == "" {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please Select date")
                self.present(alert, animated: true, completion: nil)
            }else if txtStartTime.text!.compare(txtEndTime.text!) == .orderedDescending {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
                self.present(alert, animated: true, completion: nil)
            }else if txtStartTime.text! == txtEndTime.text! {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"start time and end time not same here")
                self.present(alert, animated: true, completion: nil)
            }else if txtviewBookingNotes.text == "" {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please write reason why you want to book this amentity")
                self.present(alert, animated: true, completion: nil)
            }else{
                ApiCallAmenityBookingsAdd()
            }

    }
    
    
    func setborders(textfield:UITextField)
    {
        textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
        textfield.layer.borderWidth = 1.0
    }
    
    func setrightviewnew(textfield: UITextField ,image:UIImage)
    {
        let imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.isUserInteractionEnabled = false
        
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
    }
    
    
}


@available(iOS 13.0, *)
extension  AmenitiesClenderBookVC:FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance
{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
      //  if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
            let calendarnew = Calendar.current

            let year =  calendarnew.component(.year, from: date as Date)
               let month = calendarnew.component(.month, from: date as Date)
               let day = calendarnew.component(.day, from: date as Date)
            
            print("year:month:day :- ",year,month,day)
        
        let dot = "-"
        
        strSelectCalendarDate = "\(year)\(dot)\(month)\(dot)\(day)"
        
      //  }
    }

    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        let key = self.dateFormatter1.string(from: date)
            if(selecteddates.contains(key)) {
                   print("date is not selectable")
                   return false
               }
               return true
    }
 
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 1.0
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
}
