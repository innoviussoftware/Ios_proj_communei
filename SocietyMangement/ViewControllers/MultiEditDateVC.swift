//
//  MultiEditDateVC.swift
//  SocietyMangement
//
//  Created by Macmini on 15/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire

protocol addMultiDate {
    func addedMultiDate()
}

class MultiEditDateVC: UIViewController, UITextFieldDelegate{
    
    var delegate : addMultiDate?
    
    @IBOutlet weak var viewinner: UIView!

    @IBOutlet weak var txtstartdate: UITextField!
    
    @IBOutlet weak var txtenddate: UITextField!

    var datePicker = UIDatePicker()

    var textfield = UITextField()
    
    var VisitFlatPreApprovalID:Int?
    var UserActivityID:Int?
    var VisitorEntryTypeID:Int?

    
    var strStartDate = ""
    var StrEndDate = ""

    var date1 = Date()
    var date2 = Date()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        
        setborders(textfield: txtstartdate)
        setborders(textfield: txtenddate)
        
        txtstartdate.delegate = self
        txtenddate.delegate = self
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtstartdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtenddate)
         
        txtstartdate.text = strStartDate
        
        txtenddate.text = StrEndDate
        
        showDatePicker()
        
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
    
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        if txtstartdate.text!.compare(txtenddate.text!) == .orderedDescending {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"End date must be greater than Start date")
            self.present(alert, animated: true, completion: nil)
        }else{
            apicallAddMultiDate()
           // removeAnimate()
        }
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {

        removeAnimate()
    }
    
    // MARK: - get Add Date Multi
    
    func apicallAddMultiDate()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            let param : Parameters = [
                "VisitStartDate": txtstartdate.text!,
                "VisitEndDate": txtenddate.text!,
                "VisitFlatPreApprovalID": VisitFlatPreApprovalID!,
                "UserActivityID": UserActivityID!,
                "VisitorEntryTypeID": VisitorEntryTypeID!
            ]
        
        print("param Multi add date : ",param)

        
            webservices().StartSpinner()
            
            
        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + "user/pre-approved/edit" ,token: token as! String, param: param) { JSON in

                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    
                    
                            if(JSON.response?.statusCode == 200)
                            {
                                self.delegate?.addedMultiDate()
                                self.removeAnimate()
                                self.dismiss(animated: true, completion: nil)
                            }
                            else
                            {
                                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter valid  data")
                                self.present(alert, animated: true, completion: nil)
                            }
                        
                    
                    print(resp)
                case .failure(let err):
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                }
            }
            
       
    }

    func setborders(textfield:UITextField)
      {
          
         // textfield.layer.borderColor =  AppColor.appcolor.cgColor
           textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
          
          textfield.layer.borderWidth = 1.0
          
      }
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
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

}
