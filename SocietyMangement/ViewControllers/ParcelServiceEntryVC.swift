//
//  ParcelServiceEntryVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 24/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SWRevealViewController

import Alamofire



@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ParcelServiceEntryVC: UIViewController, UITextFieldDelegate,  UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, SWRevealViewControllerDelegate {
//, DeliveryCompanyListProtocol {
    
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
    
    var dailyHelperID:Int?
    var vendorServiceTypeID:Int?


    var textfield = UITextField()
       var datePicker = UIDatePicker()
       var timePicker = UIDatePicker()
       var date1 = Date()
       var date2 = Date()
    
    

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
            
        showDatePicker()
        
        showTimepPicker()
        
        let datee = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtdate.text = formatter.string(from: datee)

               
        let formatt = DateFormatter()
        formatt.dateFormat = "hh:mm a"
        txttime.text = formatt.string(from: datee)
        time =  txttime.text!
        
        txtvaildtill.text = hourary[0]

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
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action:#selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(cancelDatePicker))

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
    
    
    
    @IBAction func btnAddPickUpaction(_ sender: UIButton) {
        
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr = "Communei"
       // avc?.isfrom = 3
        avc?.subtitleStr = "Are you sure you want to add on - demand helper?"

                        avc?.yesAct = {
                            self.apicallHelperEntryAdd()
                        }

                        avc?.noAct = {
                          
                        }
                        present(avc!, animated: true)

        print("btnAddPickUpaction")

    }
    
    func strChangeDateFormate(strDateeee:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let strDate = formatter.date(from: strDateeee)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "yyyy-MM-dd"
            str = formatter.string(from: strDate!)
        }else{
            str = strDateeee
        }
        
        return str
    }
    
    func messageClicked() {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  "Successfully Added"
        avc?.subtitleStr = "Your daily helper will be allowed"
        avc?.isfrom = 4

        avc?.yesAct = {
           
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            
            let navController = UINavigationController(rootViewController: nextViewController)
                                            
            navController.isNavigationBarHidden = true
            
            self.appDelegate.window!.rootViewController  = navController

        }
        avc?.noAct = {
            
        }
        
        present(avc!, animated: true)
    }
    
    // MARK: - get Helper Entry Add
    
    func apicallHelperEntryAdd()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        var strDateee = ""
           
           date = txtdate.text!
        
        strDateee = strChangeDateFormate(strDateeee: date)
        
        var after_add_time = ""
        
        var preApprovedInTime = ""
        
        preApprovedInTime = "\(txtdate.text!) \(txttime.text!)"
        
        print("preApprovedInTime --> ",preApprovedInTime)

        var preApprovedOutTime = ""
        
        if txtvaildtill.text == "Day End" {
            validtill = time
            
            let dateFormatter = DateFormatter()
            
            let isoDate = txttime.text!
            dateFormatter.dateFormat = "h:mm a"

            let date = dateFormatter.date(from:isoDate)!
            print("date :- ",date)
     
            after_add_time = "11:59 PM" //"23:59:00"
            
            preApprovedOutTime = "\(txtdate.text!) \(after_add_time)"

            print("preApprovedOutTime --> ",preApprovedOutTime)
             
        }else{
            
            txtvaildtill.text?.removeLast(3)

            let myInt = Int(txtvaildtill.text!)!
            
            let dateFormatter = DateFormatter()
                        
            let isoDate = txttime.text!

            dateFormatter.dateFormat = "h:mm a"

            let date = dateFormatter.date(from:isoDate)!
            
            let addminutes = date.addingTimeInterval(TimeInterval(myInt*60*60))
            after_add_time = dateFormatter.string(from: addminutes)
            
            print("after add time 3 --> ",after_add_time)
            
            preApprovedOutTime = "\(txtdate.text!) \(after_add_time)"
            print("preApprovedOutTime --> ",preApprovedOutTime)

        }
        
       
        var param = Parameters()
        
            param  = [
                "DailyHelperID":dailyHelperID!,
                "VendorServiceTypeID": vendorServiceTypeID!,
                "PreApprovedInTime": preApprovedInTime,
                "PreApprovedOutTime": preApprovedOutTime
            ]
        
        print("param Helper Entry Add : ",param)
        
     
            webservices().StartSpinner()
        
        Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_HELPER_ENTRY, param: param, token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.messageClicked()
                    }
                    else
                    {
                        
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
                                                              
                      
                        return
                    }
                    
                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
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

      
    
    // MARK: - textField delegate methods

      
      func textFieldDidBeginEditing(_ textField: UITextField) {
          
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
               //  viewmain.backgroundColor = UIColor.white
                 collectionHours.reloadData()
           
       }

}
