//
//  AmenitiesClenderBookVC.swift
//  SocietyMangement
//
//  Created by MacMini on 03/10/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import FSCalendar

class AmenitiesClenderBookVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var txtEndTime: UITextField!
    @IBOutlet weak var txtStartTime: UITextField!

   // let picker :UIDatePicker! = nil
   // let picker = UIDatePicker()
    
    let datePicker = UIDatePicker()
    
    let datePicker_end = UIDatePicker()


    var activeTexfield :UITextField! = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTimepPicker()
        
        setUpView()
        
       

    }
    
    @IBAction func backaction(_ sender: Any) {
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
           let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.bordered, target: self, action:#selector(doneTimePicker))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
           let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.bordered, target: self, action:#selector(cancelTimePicker))
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
    

    
    //MARK:- action method
    
    @IBAction func actionDone(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
