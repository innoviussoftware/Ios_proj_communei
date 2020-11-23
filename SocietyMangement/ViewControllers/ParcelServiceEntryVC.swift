//
//  ParcelServiceEntryVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 24/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ParcelServiceEntryVC: UIViewController, UITextFieldDelegate,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, DeliveryCompanyListProtocol {
    
    var hourary = ["2 Hr" , "4 Hr" , "6 Hr" , "8 Hr" , "10 Hr" , "12 Hr"  ,"Day End"]
    
    var selectedindex : Int = 0
    
    var index:Int?

    var isfrom = 0

    @IBOutlet weak var lblTitleName: UILabel!


    @IBOutlet weak var collectionHours: UICollectionView!

    @IBOutlet weak var viewbottom: UIView!

    @IBOutlet weak var txtdate: UITextField!
    
    @IBOutlet weak var txttime: UITextField!
    
    @IBOutlet weak var txtvaildtill: UITextField!
    
    @IBOutlet weak var txtDeliveryCompanyName: UITextField!

    @IBOutlet weak var btncheckMark: UIButton!

    @IBOutlet weak var txtNumberBoxs: SkyFloatingLabelTextField!


    var textfield = UITextField()
       var datePicker = UIDatePicker()
       var timePicker = UIDatePicker()
       var date1 = Date()
       var date2 = Date()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewbottom.isHidden = true
        
        btncheckMark.isSelected = false

        btncheckMark.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
        
        setborders(textfield: txtdate)
        setborders(textfield: txttime)
        setborders(textfield: txtvaildtill)
        setborders(textfield: txtDeliveryCompanyName)
        
        txtdate.delegate = self
        txttime.delegate = self
        txtvaildtill.delegate = self
        txtDeliveryCompanyName.delegate = self

        webservices.sharedInstance.PaddingTextfiled(textfield: txtdate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txttime)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtvaildtill)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtDeliveryCompanyName)
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left, verticalAlignment: .center)
               
        collectionHours.collectionViewLayout = alignedFlowLayout
            
        
        
        let datee = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtdate.text = formatter.string(from: datee)

               
        let formatt = DateFormatter()
        formatt.dateFormat = "hh:mm a"
        txttime.text = formatt.string(from: datee)
        time =  txttime.text!

        // Do any additional setup after loading the view.
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
        
    }

    @objc func doneTimePicker(){
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
           
           self.view.endEditing(true)
       }
       
    @objc func cancelDatePicker(){
           //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckaction(_ sender: Any) {
         if btncheckMark.isSelected == false {
             btncheckMark.setImage(UIImage(named: "ic_radiobuttonselect"), for: .normal)
             btncheckMark.isSelected = true
         }else{
             btncheckMark.setImage(UIImage(named: "ic_radiobutton"), for: .normal)
             btncheckMark.isSelected = false
         }
         
         self.view.endEditing(true)
     }
    
    @IBAction func btnAddPickUpaction(_ sender: Any) {
        print("btnAddPickUpaction")

    }
    
    @IBAction func btnClose_hour(_ sender: Any) {
             self.viewbottom.isHidden = true
      }
         
      @IBAction func btnApply(_ sender: Any) {
             self.viewbottom.isHidden = true
      }
         
      @IBAction func btnReset(_ sender: Any) {
             
             txtvaildtill.text = hourary[0]

             selectedindex = 0
             
             collectionHours.reloadData()

             self.viewbottom.isHidden = true
      }
    
    func setborders(textfield:UITextField) {
            
           // textfield.layer.borderColor =  AppColor.appcolor.cgColor
             textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
            
            textfield.layer.borderWidth = 1.0
            
    }
    
    // MARK: - deliveryList delegate methods

       //func deliveryList(name: String)
       func deliveryList(name:String, selectNumber:Int)
       {
            self.txtDeliveryCompanyName.text = name
            index = selectNumber
        }
    
    // MARK: - textField delegate methods

      
      func textFieldDidBeginEditing(_ textField: UITextField) {
              
          if(textField == txtDeliveryCompanyName)
              {
                     txtDeliveryCompanyName.resignFirstResponder()
                     let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryCompanyListVC") as! DeliveryCompanyListVC
                     popOverConfirmVC.delegate = self
                  
                      popOverConfirmVC.selectedindex = index
                      popOverConfirmVC.selectedindex1 = index

                     if(txtDeliveryCompanyName.text == popOverConfirmVC.strlbl)
                     {

                        // popOverConfirmVC.selectedary = self.selectedary
                         // popOverConfirmVC.entryary = txtDeliveryCompanyName.text
                     }
                  self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

          }
          
          if(textField == txtvaildtill)
          {
                  
              viewbottom.isHidden = false
              txtvaildtill.resignFirstResponder()
                  
                 // viewmain.backgroundColor = UIColor.black.withAlphaComponent(0.5)
          }
        
            if(textField == txtdate) {
                  textfield = txtdate
            }
             
              
      }
       
    
    // MARK: - Collectionview delegate and datasource methods
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
               return hourary.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
               let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell

        cell.lblname.text = (hourary[indexPath.row])
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
           
           let numberOfSets = CGFloat(4.0)
           
           let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 45))/numberOfSets
           
           return CGSize(width:width,height: 42)
           
       }
       
       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           
               txtvaildtill.text = hourary[indexPath.row]
                 
                 selectedindex = indexPath.row
                // viewbottom.isHidden = true
               //  viewmain.backgroundColor = UIColor.white
                 collectionHours.reloadData()
           
       }

}
