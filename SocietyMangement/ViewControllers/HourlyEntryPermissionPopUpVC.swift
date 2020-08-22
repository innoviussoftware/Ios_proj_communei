//
//  HourlyEntryPermissionPopUpVC.swift
//  SocietyMangement
//
//  Created by Innovius on 04/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class HourlyEntryPermissionPopUpVC: UIViewController {

    @IBOutlet weak var txtSelectHours: UITextField!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblBottomFrequently: UILabel!
    @IBOutlet weak var viewAdvance: UIView!
    
    @IBOutlet weak var lblBottomOnce: UILabel!
    
    @IBOutlet weak var btnOnce: UIButton!
    @IBOutlet weak var btnFrequently: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var txtValidTime: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtSelectTime: UITextField!
    
    
    ////***********************////////
    @IBOutlet weak var viewFrequently: UIView!
    @IBOutlet weak var txtSelectFreDays: UITextField!
    @IBOutlet weak var txtSelectFreqValidTime: UITextField!
    @IBOutlet weak var txtSelecttimeFreq: UITextField!
    
    @IBOutlet weak var txtHoursFreqnt: UITextField!
    
    @IBOutlet weak var txtCompanynameFreqnt: UITextField!
    
    ///**************///
    @IBOutlet weak var viewPopUpDaysOfWeek: UIView!
    @IBOutlet weak var collectionDays: UICollectionView!
    var arrDays = NSMutableArray()
    
    @IBOutlet weak var constraintHightCollection: NSLayoutConstraint!
    
    @IBOutlet weak var btnWeekDaysPopUpView: UIButton!
    @IBOutlet weak var lblStaticDaysOfWeekPOpUp: UILabel!
    
    var activeTextField = UITextField()
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()
   
    var selectedHours : Int! = 0
    var selectedDate : Int! = 0
    var selectedTime : Int! = 0
    var selectedValidTime : Int! = 0
    
    var hourary = ["1 hour" , "2 hour" , "4 hour" , "8 hour" , "12 hour"  ,"24 hour"]
    var selectedHoursindex : Int = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        setViewData()
        self.navigationController?.navigationBar.isHidden = true
        
        txtSelectFreDays.addTarget(self, action: #selector(selectDays(txtField:)), for: .editingDidBegin)
        txtSelectHours.addTarget(self, action: #selector(selectHours(txtField:)), for: .editingDidBegin)
        txtValidTime.addTarget(self, action: #selector(selectHours(txtField:)), for: .editingDidBegin)
        
        txtDate.addTarget(self, action: #selector(showDatePicker(textfield:)), for: .editingDidBegin)
        txtDate.addDoneOnKeyboardWithTarget(self, action: #selector(donedatePicker), shouldShowPlaceholder: true)
        txtSelectTime.addTarget(self, action: #selector(showTimepPicker(txt:)), for: .editingDidBegin)
        txtSelectTime.addDoneOnKeyboardWithTarget(self, action: #selector(doneTimePicker), shouldShowPlaceholder: true)

    }
    
    func setViewData() {
        
        collectionDays.register(UINib(nibName: "DaysCell", bundle: nil), forCellWithReuseIdentifier: "DaysCell")
        
        
        viewAdvance.isHidden = true
        viewFrequently.isHidden = true
        viewPopUpDaysOfWeek.isHidden = true
        
        setrightviewnew(textfield: txtSelectHours, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtDate, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtSelectTime, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtValidTime, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtCompanyName, image: UIImage(named:"ic_down_blue")!)
        
        ///Freqently
        setrightviewnew(textfield: txtSelectFreDays, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtSelectFreqValidTime, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtSelecttimeFreq, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtHoursFreqnt, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtCompanynameFreqnt, image: UIImage(named:"ic_down_blue")!)
        
        setborders(textfield: txtSelectFreDays)
        setborders(textfield: txtSelectFreqValidTime)
        setborders(textfield: txtSelecttimeFreq)
        setborders(textfield: txtHoursFreqnt)
        setborders(textfield: txtCompanynameFreqnt)
        
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtSelectFreDays)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtSelectFreqValidTime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtSelecttimeFreq)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtHoursFreqnt)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtCompanynameFreqnt)
        
        /////////////
        
         setborders(textfield: txtSelectHours)
         setborders(textfield: txtDate)
         setborders(textfield: txtSelectTime)
         setborders(textfield: txtValidTime)
         setborders(textfield: txtCompanyName)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtSelectHours)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtDate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtSelectTime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtValidTime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtCompanyName)
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        lblBottomFrequently.isHidden = true
        
        
        
       let dict  = NSMutableDictionary()
        dict.setValue("Sunday", forKey: "day")
        dict.setValue("0", forKey: "is_selected")
        arrDays.add(dict)
        
        let dict1  = NSMutableDictionary()
        dict1.setValue("Monday", forKey: "day")
        dict1.setValue("0", forKey: "is_selected")
        arrDays.add(dict1)
        
        let dict2  = NSMutableDictionary()
        dict2.setValue("Tuesday", forKey: "day")
        dict2.setValue("0", forKey: "is_selected")
        arrDays.add(dict2)

        
        let dict3  = NSMutableDictionary()
        dict3.setValue("Wednesday", forKey: "day")
        dict3.setValue("0", forKey: "is_selected")
        arrDays.add(dict3)

        
        let dict4  = NSMutableDictionary()
        dict4.setValue("Thursday", forKey: "day")
        dict4.setValue("0", forKey: "is_selected")
        arrDays.add(dict4)

        
        let dict5  = NSMutableDictionary()
        dict5.setValue("Friday", forKey: "day")
        dict5.setValue("0", forKey: "is_selected")
        arrDays.add(dict5)

        let dict6  = NSMutableDictionary()
        dict6.setValue("Saturday", forKey: "day")
        dict6.setValue("0", forKey: "is_selected")
        arrDays.add(dict6)

        
        collectionDays.dataSource = self
        collectionDays.delegate = self
        collectionDays.reloadData()
        
        constraintHightCollection.constant = 140
        
    }

    //MARK:- action method
    @IBAction func actionOnce(_ sender: Any) {
        lblBottomFrequently.isHidden = true
        lblBottomOnce.isHidden = false
        viewFrequently.isHidden = true
    }
    
    @IBAction func actionFrequently(_ sender: Any) {
         lblBottomFrequently.isHidden = false
         lblBottomOnce.isHidden = true
         viewAdvance.isHidden = true
         viewFrequently.isHidden = false
        
    }
    @IBAction func actonToday(_ sender: Any) {
    }
    
    @IBAction func actionAdvanceOptions(_ sender: Any) {
        viewAdvance.isHidden = false
    }
    
    @IBAction func actionNext(_ sender: Any) {
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func actionDoneDaysOfWeekPopUp(_ sender: Any) {
        selectDaysDone()
    }
    
    
    
    //MARK:- custome Method
    func setborders(textfield:UITextField)
    {
        
        textfield.layer.borderColor =  AppColor.appcolor.cgColor
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
    
    @objc func selectDays(txtField:UITextField) {
        activeTextField = txtField
        viewPopUpDaysOfWeek.isHidden = false
        collectionDays.reloadData()
        lblStaticDaysOfWeekPOpUp.isHidden = false
        btnWeekDaysPopUpView.isHidden = false
    }
    
    @objc func selectHours(txtField:UITextField) {
        activeTextField = txtField
        viewPopUpDaysOfWeek.isHidden = false
        collectionDays.reloadData()
        lblStaticDaysOfWeekPOpUp.isHidden = true
        btnWeekDaysPopUpView.isHidden = true
    }
    
    @objc func selectDaysDone() {
        viewPopUpDaysOfWeek.isHidden = true
    }
    
    @objc func showDatePicker(textfield : UITextField){
         activeTextField = textfield
        //Formate Date
        
        if datePicker != nil{
            datePicker.removeFromSuperview()
        }
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date()
        activeTextField.inputView = datePicker
        
    }
    @objc func showTimepPicker(txt:UITextField){
        
        activeTextField = txt
        
        if timePicker != nil{
            timePicker.removeFromSuperview()
        }
        //Formate Date
        timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.minimumDate = Date()
        txtSelectTime.inputView = timePicker
        
    }
    
    @objc  func doneTimePicker(){
        //For date formate
        activeTextField.resignFirstResponder()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss"
        txtSelectTime.text = formatter.string(from: timePicker.date)
    }
    
    @objc  func donedatePicker(){
        //For date formate
        activeTextField.resignFirstResponder()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDate.text = formatter.string(from: datePicker.date)
       
    }
    
   
    
    
}



extension HourlyEntryPermissionPopUpVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if activeTextField == txtSelectHours || activeTextField == txtValidTime {
             return hourary.count
        }else{
             return arrDays.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCell", for: indexPath) as! DaysCell
         if activeTextField == txtSelectHours  || activeTextField == txtValidTime{
            cell.lblDaysName.text = hourary[indexPath.row] 
            if(selectedHoursindex == indexPath.row)
            {
                cell.lblDaysName.backgroundColor = AppColor.appcolor
                cell.lblDaysName.textColor = UIColor.white
                
            }
            else{
                
                cell.lblDaysName.backgroundColor = UIColor.white
                cell.lblDaysName.textColor = UIColor.darkGray
               
            }
            
         }else{
            
            cell.lblDaysName.text = (arrDays[indexPath.row] as! NSMutableDictionary).value(forKey: "day") as? String
            
            if (arrDays[indexPath.row] as! NSMutableDictionary).value(forKey: "is_selected") as! String == "0"{
                
                cell.lblDaysName.backgroundColor = UIColor.white
                cell.lblDaysName.textColor = UIColor.darkGray
            }else{
                cell.lblDaysName.backgroundColor = AppColor.appcolor
                cell.lblDaysName.textColor = UIColor.white
            }
            
        }
        
        
            
     return cell
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        if activeTextField == txtSelectHours  || activeTextField == txtValidTime{
            
            if   activeTextField == txtValidTime{
                 txtValidTime.text = hourary[indexPath.row]
            }
            
            if   activeTextField == txtSelectHours{
                txtSelectHours.text = hourary[indexPath.row]
            }
            selectedHoursindex = indexPath.row
            viewPopUpDaysOfWeek.isHidden = true
            
        }else{
        
        if (arrDays[indexPath.row] as! NSMutableDictionary).value(forKey: "is_selected") as! String == "0"{
            
            let dict = arrDays[indexPath.row] as! NSMutableDictionary
            dict.setValue("1", forKey: "is_selected")
            arrDays.replaceObject(at: indexPath.row, with: dict)
            
            
        }else{
            let dict = arrDays[indexPath.row] as! NSMutableDictionary
            dict.setValue("0", forKey: "is_selected")
            arrDays.replaceObject(at: indexPath.row, with: dict)
        }
            
        }
        
        collectionDays.reloadData()
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        //return CGSize(width: 100, height: 128)
        
       
        return  CGSize(width: collectionWidth/3-8, height: 40)
     
    }
    
    
    
    
    
    
}

