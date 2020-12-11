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

class AmenitiesClenderBookVC: UIViewController, UITextFieldDelegate,FSCalendarDelegate,FSCalendarDataSource {
    
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
    
    var isfrom = 1
        
    var amenityID:Int?
    
    var amount:Int?

    var strName = ""

    var strNotes = ""
    
    var strDescription = ""
    
    var dicAddBook : AddBookingNow?
    
    let datePicker = UIDatePicker()
    
    let datePicker_end = UIDatePicker()

    var activeTexfield :UITextField! = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTimepPicker()
        
        setUpView()
        
        calenderView.dataSource = self
        calenderView.delegate = self
        
       if isfrom == 1 {
            lblName.text = strName
            lblNotes.text = strNotes
            lblDescription.text = strDescription
        
       // self.calenderView.deselect(currentDate)

            btnDone.setTitle("Book Now", for: .normal)
        // API_ADD_BOOKINGS_NOW
        // user/amenity/bookings/add
        }else{
            btnDone.setTitle("Update", for: .normal)
        }

    }
    
    @IBAction func backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
    func calendar(calendar: FSCalendar!, appearance: FSCalendarAppearance, borderDefaultColorForDate date: NSDate!) -> UIColor {
        if self.calenderView.contains(date as! UIFocusEnvironment) {
            print("date is selectable")
            return UIColor.gray.withAlphaComponent(0.5)
           }
        return UIColor.black.withAlphaComponent(0)
       }

    func calendar(calendar: FSCalendar!, shouldSelectDate date: NSDate!) -> Bool {
        if self.calenderView.contains(date as! UIFocusEnvironment) {
               print("date is not selectable")
               return false
           }
           return true
    }
    
   /* func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int
    {
        return 1
    } */
        
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
        
        txtStartTime.text = outTime
        
        txtEndTime.text = outTime
            
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
           let toolbar = UIToolbar();
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
    
    @objc  func doneTimePicker(){
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
    
    func dateAndTimeCombine() {
        let date = "2017-12-24"
        let time = "7:00 AM"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-mm-dd h:mm a"
        let string = date + time                  // "2017-12-24 7:00 AM"
        let finalDate = dateFormatter.date(from: string)
        print("finalDate : ",finalDate!)

        print("finalDate description : ",finalDate?.description(with: .current) ?? "")
    }
    
    func ApiCallAmenityBookingsAdd() {
            if !NetworkState().isInternetAvailable {
                    ShowNoInternetAlert()
                    return
            }

           webservices().StartSpinner()
               
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                    let param : Parameters = [
                        "AmenityID" : amenityID!,
                        "BookingNotes" : txtviewBookingNotes.text!,
                        "Amount" : amount!,
                        "StartDate" : "",
                        "EndDate" : ""
                    ]
                   
                  print("Parameters : ",param)
        
                                   
        Apicallhandler.sharedInstance.ApiAddBookingNow(token: token as! String, param: param) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
               // let nameary = NSMutableArray()
                if(resp.status == 1)
                {
                    if(self.isfrom == 1)
                    {
                        print("1 : ")
                    }else{
                        print("2 : ")
                    }
                }else{
                    
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
        
        if txtStartTime.text!.compare(txtEndTime.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End time must be greater than Start time")
            self.present(alert, animated: true, completion: nil)
        }else if txtviewBookingNotes.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please write reason why you want to book this amentity")
            self.present(alert, animated: true, completion: nil)
        }else{
            ApiCallAmenityBookingsAdd()
        }
       // self.dismiss(animated: true, completion: nil)
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
