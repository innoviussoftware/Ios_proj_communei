//
//  SingleEditDateVC.swift
//  SocietyMangement
//
//  Created by Macmini on 15/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire

protocol addSingleDate {
    func addedSingleDate()
}

class SingleEditDateVC: UIViewController , UITextFieldDelegate , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {

    var delegate : addSingleDate?
    
    var isfrom = 1
    
    @IBOutlet weak var viewinnerHeightCons: NSLayoutConstraint!
    
    @IBOutlet weak var btnUpdateTopCons: NSLayoutConstraint!


    @IBOutlet weak var viewinner: UIView!
    
    @IBOutlet weak var viewbottom: UIView!

    @IBOutlet weak var txtdate: UITextField!
    
    @IBOutlet weak var txttime: UITextField!
    
    @IBOutlet weak var txtvaildtill: UITextField!
    
    @IBOutlet weak var collectionHours: UICollectionView!
    
    @IBOutlet weak var btncheckMark: UIButton!

    @IBOutlet weak var lblDeliveryName: UILabel!


    var hourary = ["2 Hr" , "4 Hr" , "6 Hr" , "8 Hr" , "10 Hr" , "12 Hr"  ,"Day End"]
    
    var selectedindex : Int = 0

    var VisitFlatPreApprovalID:Int?
    var UserActivityID:Int?
    var VisitorEntryTypeID:Int?
    
    var multipleDeliveryCheckGate:Int?
    
    var textfield = UITextField()
    
    var datePicker = UIDatePicker()
    var timePicker = UIDatePicker()

    var strStartDate = ""
    var StrTime = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewbottom.isHidden = true

        setborders(textfield: txtdate)
        setborders(textfield: txttime)
        setborders(textfield: txtvaildtill)
        
        txtdate.delegate = self
        txttime.delegate = self
        txtvaildtill.delegate = self
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txttime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtvaildtill)
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left, verticalAlignment: .center)
               
        collectionHours.collectionViewLayout = alignedFlowLayout
        
        txtvaildtill.text = hourary[0]

         let formatter = DateFormatter()
         formatter.dateFormat = "dd-MM-yyyy"

        txtdate.text = strStartDate
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "h:mm a"
                
        var Msg_Date = StrTime

           let dateFormatterGet = DateFormatter()
           dateFormatterGet.dateFormat = "HH:mm:ss"
           let dateFormatterPrint = DateFormatter()
           dateFormatterPrint.dateFormat = "h:mm a"  //"MMM d, h:mm a" for  Sep 12, 2:11 PM
           let datee = dateFormatterGet.date(from: Msg_Date)
           Msg_Date =  dateFormatterPrint.string(from: datee ?? Date())
        
        txttime.text = Msg_Date
        
        showDatePicker()
        
        showTimepPicker()
        
        if isfrom == 1 {
            viewinnerHeightCons.constant = 255
            btncheckMark.isHidden = true
            lblDeliveryName.isHidden = true
            btnUpdateTopCons.constant = 20
        }else if isfrom == 2 {
            btncheckMark.isHidden = false
            lblDeliveryName.isHidden = false
            viewinnerHeightCons.constant = 300
            btnUpdateTopCons.constant = 60

        }
        
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
              txtdate.inputAccessoryView = toolbar
              // add datepicker to textField
             txtdate.inputView = datePicker
             
            datePicker.minimumDate = Date()
              
    }
    
    @objc  func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        
        if(textfield == txtdate)
        {
            txtdate.text = formatter.string(from: datePicker.date)
           // date1 = datePicker.date
        }
        
        self.view.endEditing(true)
    }
        
    @objc func cancelDatePicker(){
           //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
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
    
    @IBAction func btnCheckaction(_ sender: Any) {
        if btncheckMark.isSelected == false {
           // multipleDeliveryCheckGate = 1
            btncheckMark.setImage(UIImage(named: "ic_radiobuttonselect"), for: .normal)
            btncheckMark.isSelected = true
        }else{
           // multipleDeliveryCheckGate = 0
            btncheckMark.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
            btncheckMark.isSelected = false
        }
        
        self.view.endEditing(true)
    }
    
    @IBAction func btnApply(_ sender: UIButton) {
        
        txtvaildtill.text = hourary[selectedindex]

       // selectedindex = 0
        
        collectionHours.reloadData()

        self.viewbottom.isHidden = true
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        
        txtvaildtill.text = hourary[0]

        self.viewbottom.isHidden = true
    }
    
    @IBAction func btnClose_hour(_ sender: UIButton) {
        
        txtvaildtill.text = hourary[0]

        self.viewbottom.isHidden = true
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
        if txtdate.text! == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Select Start date")
            self.present(alert, animated: true, completion: nil)
        }else if txttime.text! == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Select Start time")
            self.present(alert, animated: true, completion: nil)
        }else{
            apicallAddSingleDate()
            removeAnimate()
        }
    }
    
    @IBAction func btnClosePressed(_ sender: UIButton) {

        removeAnimate()
    }
    
    // MARK: - get Add Date Single
    
    func apicallAddSingleDate()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        var after_add_time = ""

        if txtvaildtill.text == "Day End" {
            txtvaildtill.text = time
            
            
            let dateFormatter = DateFormatter()
            
           // let isoDate = time
            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd" // h:mm"

          //  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          //  let date = dateFormatter.date(from:isoDate)!
            
//            let date2 = strDateee
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            var date = dateFormatter.date(from: date2)
//
//            date = dateFormatter.date(from:isoDate)!
            
         //   let addminutes = date.addingTimeInterval(TimeInterval(24*60*60))
        //    after_add_time = dateFormatter.string(from: addminutes)
         //       print("after add time --> ",after_add_time)
            
            after_add_time = "11:59 PM" //"23:59:00"
            
            print("after add time --> ",after_add_time)

        }else{
            txtvaildtill.text?.removeLast(3)

            let myInt = Int(txtvaildtill.text!)!
            
            let dateFormatter = DateFormatter()
            
            let isoDate = txttime.text!

            dateFormatter.dateFormat = "hh:mm a" // "yyyy-MM-dd"  //h:mm"

            let date = dateFormatter.date(from:isoDate)!
                        
          //  let isoDate = "\(myInt):00" //validtill // valid  //"2016-04-14T10:44:00+0000"

          //  dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"
          
          //  let date = dateFormatter.date(from:isoDate)!
                            
            let addminutes = date.addingTimeInterval(TimeInterval(myInt*60*60))
            after_add_time = dateFormatter.string(from: addminutes)
            
            print("after add time 3 --> ",after_add_time)
        }
            
            let param : Parameters = [
                "VisitStartDate": txtdate.text!,
                "FromTime": txttime.text!,
                "ToTime": after_add_time,
                "VisitFlatPreApprovalID": VisitFlatPreApprovalID!,
                "UserActivityID": UserActivityID!,
                "VisitorEntryTypeID": VisitorEntryTypeID!
            ]
        
        print("param Single add date : ",param)

            webservices().StartSpinner()
            
            
        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + "user/pre-approved/edit" ,token: token as! String, param: param) { JSON in

                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    
                    
                            if(JSON.response?.statusCode == 200)
                            {
                                self.delegate?.addedSingleDate()
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
        
        if(textField == txtvaildtill)
        {
            
            viewbottom.isHidden = false
            txtvaildtill.resignFirstResponder()
            
           // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
        if(textField == txtdate)
        {
            textfield = txtdate
            viewbottom.isHidden = true

           // txtdate.resignFirstResponder()

        }
        
        
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
     //   viewmain.backgroundColor = UIColor.white
        collectionHours.reloadData()
    }
    

}
