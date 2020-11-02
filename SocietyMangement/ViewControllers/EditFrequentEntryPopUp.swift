//
//  EditFrequentEntryPopUp.swift
//  SocietyMangement
//
//  Created by Innovius on 17/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class EditFrequentEntryPopUp: UIViewController {
    
    @IBOutlet weak var lblStartDateStatic: UILabel!
    @IBOutlet weak var lblEndDateStatic: UILabel!
    
    @IBOutlet weak var txtStartDate: UITextField!
    
    @IBOutlet weak var txtEndDate: UITextField!
    
    @IBOutlet weak var btnUpdate: UIButton!
    
    
    @IBOutlet weak var lblStaticSelectDate: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var btnToday: UIButton!
    
    @IBOutlet weak var viewSelectDate: UIView!
    
    @IBOutlet weak var txtSelectDate: UITextField!
    
    @IBOutlet weak var collectionHours: UICollectionView!

    
    var strType = ""
    var strEntryLimit = ""
    
    @IBOutlet weak var viewBottom: UIView!
    var hourary = ["1 hour" , "2 hour" , "4 hour" , "8 hour" , "12 hour"  ,"24 hour"]
    var selectedindex : Int = 0
    
       var textfield = UITextField()
       var datePicker = UIDatePicker()
       var timePicker = UIDatePicker()
       var date1 = Date()
       var date2 = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        btnUpdate.layer.cornerRadius = 12
        btnUpdate.clipsToBounds = true
        
        if strType == "once"{
            viewSelectDate.isHidden = false
          //  btnToday.setTitle("Today", for: .normal)
            
            lblStartDateStatic.text = "Start Time"
            lblEndDateStatic.text = "Valid for next"
            
        }else{
            viewSelectDate.isHidden = true
           // btnToday.setTitle(strEntryLimit, for: .normal)
            
            lblStartDateStatic.text = "Start Date"
            lblEndDateStatic.text = "End Date"
        }
        
        
        
        
        setrightviewnew(textfield: txtSelectDate, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtStartDate, image: UIImage(named:"ic_down_blue")!)
        setrightviewnew(textfield: txtEndDate, image: UIImage(named:"ic_down_blue")!)
       
        
        setborders(textfield: txtSelectDate)
        setborders(textfield: txtStartDate)
        setborders(textfield: txtEndDate)
       
        
        txtSelectDate.delegate = self
        txtStartDate.delegate = self
        txtEndDate.delegate = self
       
        
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtSelectDate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtStartDate)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtEndDate)
    
        
        
        
    }
    
    
    @IBAction func btnClose_hour(_ sender: Any) {
        self.viewBottom.isHidden = true
    }
    
    @IBAction func btnApply(_ sender: Any) {
        self.viewBottom.isHidden = true
    }
    
    @IBAction func btnReset(_ sender: Any) {
        
        txtEndDate.text = hourary[0]

        selectedindex = 0
        
        collectionHours.reloadData()

        self.viewBottom.isHidden = true
    }

    
    @IBAction func actionUpdate(_ sender: Any) {
        
        if strType == "once"{
            
            if !txtSelectDate.hasText{
                
                let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select date")
                self.present(alert, animated: true, completion: nil)
                
                
            }else if !txtStartDate.hasText{
                let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select start time")
                self.present(alert, animated: true, completion: nil)
                
            }else if !txtEndDate.hasText{
                let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select valid for next")
                self.present(alert, animated: true, completion: nil)
            }else{
                
            }
                        
            
        }else{
                    if !txtStartDate.hasText{
                           let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select start date")
                            self.present(alert, animated: true, completion: nil)
                           
                       }else if !txtEndDate.hasText{
                           let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select end date")
                            self.present(alert, animated: true, completion: nil)
                       }else{
                           
                       }
        }
        
        
        
    }
    @IBAction func actionClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
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
    
    
    
    
    
}

extension EditFrequentEntryPopUp : UITextFieldDelegate{
     func textFieldDidBeginEditing(_ textField: UITextField) {
            
        
        if strType == "once"{
            
            if(textField == txtEndDate) // valid For next
            {
                viewBottom.isHidden = false
                txtEndDate.resignFirstResponder()
            }
            
        }else{
            if(textField == txtEndDate)
                    {
                        textfield = txtEndDate
                        let cal = NSCalendar.current
                        let components = cal.dateComponents([.day], from: date1, to: date2)
                        //lbldays.text =  (components.day! as NSNumber).stringValue
                        
                    }
        }
            
            if(textField == txtSelectDate)
            {
                textfield = txtSelectDate
            }
            if(textField == txtStartDate)
            {
                //datePicker.minimumDate = Date()
                textfield = txtStartDate
                
            }
            
            
        }
        
}



extension EditFrequentEntryPopUp : UICollectionViewDelegate,UICollectionViewDataSource{
    
    // MARK: - Collectionview delegate and datasource methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourary.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
        
        cell.lblname.text = hourary[indexPath.row] as! String
        if(selectedindex == indexPath.row)
        {
            
            cell.lblname.backgroundColor = AppColor.appcolor
            cell.lblname.textColor = UIColor.white
            cell.lblname.layer.borderWidth = 0.0
            
        }
        else{
            
            cell.lblname.backgroundColor = UIColor.white
            cell.lblname.textColor = UIColor.darkGray
            cell.lblname.layer.borderColor = UIColor.lightGray.cgColor
            cell.lblname.layer.borderWidth = 1.0
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let numberOfSets = CGFloat(3.0)
        
        let width = (collectionView.frame.size.width - (numberOfSets * view.frame.size.width / 45))/numberOfSets
        
        return CGSize(width:width,height: 38);
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        txtEndDate.text = hourary[indexPath.row]
        
        selectedindex = indexPath.row
      //  viewBottom.isHidden = true
        //viewmain.backgroundColor = UIColor.white
        collectionView.reloadData()
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
}
