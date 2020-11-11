//
//  SignUPVC.swift
//  SocietyMangement
//
//  Created by MacMini on 21/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SWRevealViewController
import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class SignUPVC: UIViewController,  UITableViewDelegate , UITableViewDataSource , UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate {
    
    
    @IBOutlet weak var lblYouRStatic: UILabel!
    
    var strmobile = ""
    
    
    var cityary = [City]()

    var arearary = [Area]()
    
    var societyary = [Society]()
    var buildingary = [Building]()
    var newbuildingary = [Building]()
    var Flatary = [Flat]()
    var NewFlatary = [Flat]()
    
    var cityid = ""
    var areaid = ""
    var societyid = ""
    var buildingid = ""
    var Flatid = ""
    
    @IBOutlet weak var txtemail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtname: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tblbuilding: UITableView!
    
    @IBOutlet weak var tblflat: UITableView!
    
    @IBOutlet weak var cbagree: Checkbox!
    
    @IBOutlet weak var cbowner: Checkbox!
    
    @IBOutlet weak var cbrenter: Checkbox!
    
    @IBOutlet weak var cbother: Checkbox!
    
    @IBOutlet weak var viewstep1: UIView!
    
    @IBOutlet weak var viewstep2: UIScrollView!
    
    @IBOutlet weak var lblstep1: UILabel!
    
    @IBOutlet weak var line1: UILabel!
    
    @IBOutlet weak var lblstep2: UILabel!
    
    @IBOutlet weak var line2: UILabel!
    
    @IBOutlet weak var txtcity: UITextField!
    
    @IBOutlet weak var txtarea: UITextField!
    
    @IBOutlet weak var txtcommunity: UITextField!
    
    
    @IBOutlet weak var txtblockname: UITextField!
    
    @IBOutlet weak var txtsearchbuilding: UITextField!
    
    @IBOutlet weak var txtflats: UITextField!
    
    
    @IBOutlet weak var txtsearchflat: UITextField!
    
    @IBOutlet weak var btnOwner: UIButton!
    @IBOutlet weak var viewbuilding: UIView!
    @IBOutlet weak var btnRentingFlat: UIButton!
    
    @IBOutlet weak var viewflat: UIView!
    
    @IBOutlet weak var viewyouare: UIView!
    
    @IBOutlet weak var btnsignup: UIButton!
    
    @IBOutlet weak var hightxtbuilding: NSLayoutConstraint!
    
    @IBOutlet weak var hightbuilding: NSLayoutConstraint!
    
    @IBOutlet weak var highttxtflat: NSLayoutConstraint!
    
    @IBOutlet weak var hightflat: NSLayoutConstraint!
    
    @IBOutlet weak var hightyouare: NSLayoutConstraint!
    
    
    
    @IBAction func signup(_ sender: Any) {
        
        if cbowner.isChecked == false && cbrenter.isChecked == false{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"This flat is already booked.")
            self.present(alert, animated: true, completion: nil)
        }else{
             ApiCallSignUp2()
        }
        
    }
    
    
    @IBAction func OwnerAction(_ sender: Any) {
        
        cbowner.isChecked = true
        cbrenter.isChecked = false
        cbother.isChecked = false
        
    }
    @IBAction func actionTC(_ sender: Any) {
        
        let pdffile = "http://societybuddy.in/privacy-policy"
        guard let url = URL(string:pdffile) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    
    @IBAction func RenterAction(_ sender: Any) {
        
        cbowner.isChecked = false
        cbrenter.isChecked = true
        cbother.isChecked = false
    }
    
    @IBAction func OtherAction(_ sender: Any) {
        
        cbowner.isChecked = false
        cbrenter.isChecked = false
        cbother.isChecked = true
        
    }
    @IBAction func NextAction(_ sender: Any) {
        
        
        if(txtname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txtemail.hasText)
        {
             if(isValidEmail(emailStr:txtemail.text!) == false)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter vaild email")
                self.present(alert, animated: true, completion: nil)
                
             }else if(cbagree.isChecked == false)
             {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please accept terms and conditions")
                self.present(alert, animated: true, completion: nil)
                
             }
             else
             {
                self.viewstep2.isHidden = false
                                       self.viewstep1.isHidden = true
                                       self.view.bringSubview(toFront:self.viewstep2)
                                       self.line2.isHidden = false
                                       self.line1.isHidden = true
                                       self.lblstep2.isUserInteractionEnabled = true
                
                
                //ApiCallCheckEmailExist()
                
            }
        }else{
            txtemail.text = ""
            txtname.resignFirstResponder()
            
            if(cbagree.isChecked == false)
            {
               let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please accept terms and conditions")
               self.present(alert, animated: true, completion: nil)
               
            }
            else
            {
            self.viewstep2.isHidden = false
                                   self.viewstep1.isHidden = true
                                   self.view.bringSubview(toFront:self.viewstep2)
                                   self.line2.isHidden = false
                                   self.line1.isHidden = true
                                   self.lblstep2.isUserInteractionEnabled = true
            }
            //ApiCallCheckEmailExist()
        }
        
        
    }
    
    
    var blogsary = ["Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1","Blog 1"]
    
    //  var Flatary = ["101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101","101",]
    
    var pickerview1 = UIPickerView()
    var pickerview2 = UIPickerView()
    var pickerview3 = UIPickerView()
    
    //var citary = ["Ahmedabad","Baroda","Pune","Mumbai","Surat"]
    // var finallocationary = ["test"]
    
    var locationary1 = ["Gota","Paldi","Sarkhej","Maninagar","Vastrapur"]
    var locationary2 = ["Akota","L&T Circile","Vaghodiya road","Gotri","Karelibagh"]
    var locationary3 =  ["Hadapsar","Hingne Khurd","Jangali Maharaj Road","Karve Nagar","Karve Road"]
    var locationary4 = ["Matunga","Dadar","Borivali","kandivali","Badra","Bhilad"]
    var locationary5 = ["Athwalines","Dumas","Katargam","Katargam","Adajan"]
    
    //  var societyary = ["Satva Society"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblflat.tableFooterView = UIView()
        tblbuilding.tableFooterView = UIView()
        
        
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
        //setleftview(textfield:txtname, image: UIImage(named: "user_white")!)
        //setleftview(textfield:txtemail, image: UIImage(named: "email-1")!)
        
        ApiCallGetCity()
        lblstep1.isUserInteractionEnabled = true
        lblstep2.isUserInteractionEnabled = false
        
        tblbuilding.separatorColor = AppColor.appcolor
        tblflat.separatorColor = AppColor.appcolor
        
        self.viewstep1.isHidden = false
        self.viewstep2.isHidden = true
        self.view.bringSubview(toFront:viewstep1)
        self.line1.isHidden = false
        self.line2.isHidden = true
        
        checkbox(cb: cbowner)
        checkbox(cb: cbrenter)
        checkbox(cb: cbother)
        checkbox(cb: cbagree)
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapline1))
        
        lblstep1.addGestureRecognizer(tap)
        
        
        let tap1 = UITapGestureRecognizer()
        tap1.addTarget(self, action: #selector(tapline2))
        
        lblstep2.addGestureRecognizer(tap1)
        
        pickerview1.delegate = self
        pickerview1.dataSource = self
        pickerview2.delegate = self
        pickerview2.dataSource = self
        
        pickerview3.delegate = self
        pickerview3.dataSource = self
        txtsearchbuilding.delegate = self
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = AppColor.appcolor
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
        
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        txtcity.inputAccessoryView = toolBar
        txtcity.inputView = pickerview1
        
        
        let toolBar1 = UIToolbar()
        toolBar1.barStyle = .default
        toolBar1.isTranslucent = true
        toolBar1.tintColor = AppColor.appcolor
        let doneButton1 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed1))
        let cancelButton1 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar1.setItems([cancelButton1, spaceButton1, doneButton1], animated: false)
        toolBar1.isUserInteractionEnabled = true
        toolBar1.sizeToFit()
        txtarea.inputAccessoryView = toolBar1
        txtarea.inputView = pickerview2
        
        
        
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = .default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = AppColor.appcolor
        let doneButton2 = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed2))
        let cancelButton2 = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let spaceButton2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar2.setItems([cancelButton2, spaceButton2, doneButton2], animated: false)
        
        
        toolBar2.isUserInteractionEnabled = true
        toolBar2.sizeToFit()
        txtcommunity.inputAccessoryView = toolBar2
        txtcommunity.inputView = pickerview3
        
        setdefaultvalues()
    }
    func setdefaultvalues()
    {
        
        UIView.animate(withDuration: 0.3, delay: 0.2, options:
            UIViewAnimationOptions.curveEaseOut, animations: {
                
                self.btnsignup.isHidden = true
                self.hightxtbuilding.constant = 0
                self.hightbuilding.constant = 0
                self.highttxtflat.constant = 0
                self.hightflat.constant = 0
                self.hightyouare.constant = 0
                
                self.viewbuilding.isHidden = true
                self.viewflat.isHidden = true
                self.viewyouare.isHidden = true
                self.txtblockname.isHidden = true
                self.txtflats.isHidden = true
                self.tblflat.reloadData()
                self.tblbuilding.reloadData()
                
                self.cbother.isChecked = false
                self.cbowner.isChecked = false
                self.cbrenter.isChecked = false
                
        }, completion: { finished in
            
        })
        
        
    }
    
    
    // MARK: - Textfield delegate and datasource methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        if(textField == txtcity)
        {
            setdefaultvalues()
            if(cityary.count == 0)
                       {
                           let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No cities found")
                           self.present(alert, animated: true, completion: nil)
                           
                           txtcity.resignFirstResponder()
                       }
            
        }
        if(textField == txtarea)
        {
            setdefaultvalues()
            if(arearary.count == 0)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No area found")
                self.present(alert, animated: true, completion: nil)
                
                txtarea.resignFirstResponder()
            }
            if(txtcity.text == "" )
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select city")
                self.present(alert, animated: true, completion: nil)
                
                txtarea.resignFirstResponder()
            }
            
        }
        if(textField == txtcommunity )
        {
            
            setdefaultvalues()
            if(societyary.count == 0)
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"No Society found")
                             self.present(alert, animated: true, completion: nil)
                             txtcommunity.resignFirstResponder()
            }
            if(txtarea.text == "")
            {
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select area")
                self.present(alert, animated: true, completion: nil)
                txtcommunity.resignFirstResponder()
                
            }
        }
        if(textField == txtblockname)
        {
            
            txtblockname.resignFirstResponder()
            UIView.animate(withDuration: 0.3, delay: 0.2, options:
                UIViewAnimationOptions.curveEaseOut, animations: {
                    self.txtblockname.isHidden = true
                    self.hightxtbuilding.constant = 0
                    
                    self.hightbuilding.constant = 210
                    
                    self.viewbuilding.isHidden = false
                    self.hightflat.constant = 0
                    self.viewflat.isHidden = true
                    self.hightyouare.constant = 0
                    self.viewyouare.isHidden = true
                    self.highttxtflat.constant = 0
                    self.txtflats.isHidden = true
                    self.btnsignup.isHidden = true
                    
                    self.cbother.isChecked = false
                    self.cbowner.isChecked = false
                    self.cbrenter.isChecked = false
                    self.tblflat.reloadData()
                    self.tblbuilding.reloadData()
                    
            }, completion: { finished in
                
            })
            
            
        }
        
        if(textField == txtflats)
        {
            
            txtflats.resignFirstResponder()
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options:
                UIViewAnimationOptions.curveEaseOut, animations: {
                    
                    self.highttxtflat.constant = 0
                    self.txtflats.isHidden = true
                    self.hightyouare.constant = 0
                    self.viewyouare.isHidden = true
                    self.btnsignup.isHidden = true
                    self.hightflat.constant = 210
                    self.viewflat.isHidden = false
                    
                    self.cbother.isChecked = false
                    self.cbowner.isChecked = false
                    self.cbrenter.isChecked = false
                    self.tblflat.reloadData()
                    self.tblbuilding.reloadData()
                    
                    
                    
            }, completion: { finished in
                
            })
            
            
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == txtsearchbuilding)
        {
            var substring = (textField.text as! NSString).replacingCharacters(in: range, with: string)
            
            if(substring != ""){
                buildingary.removeAll()
                for dic in newbuildingary
                {
                    let str = dic.PropertyName
                    if(str.lowercased().contains(substring.lowercased()))
                    {
                        buildingary.append(dic)
                    }
                    
                    tblbuilding.reloadData()
                }
            }
            else
            {
                buildingary = newbuildingary
                tblbuilding.reloadData()
                
            }
        }
        
        if(textField == txtsearchflat)
        {
            let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            
            if(substring != ""){
                Flatary.removeAll()
                for dic in NewFlatary
                {
                    let str = dic.PropertyName
                    if(str!.lowercased().contains(substring.lowercased()))
                    {
                        Flatary.append(dic)
                    }
                    
                    tblflat.reloadData()
                }
            }
            else
            {
                Flatary = NewFlatary
                tblflat.reloadData()
                
            }
        }
        return true
    }
    
    
    @objc func donePressed()
        
    {
        if(txtcity.text == "")
        {
            txtcity.text = cityary[0].Name
            cityid = String(cityary[0].CityID!)
            txtcity.resignFirstResponder()
            ApiCallGetArea()
        }
        else
        {
            txtcity.resignFirstResponder()
            ApiCallGetArea()
            
        }
    }
    
    @objc func donePressed1()
        
    {
        if(txtarea.text == "")
        {
            txtarea.resignFirstResponder()
            areaid = String(arearary[0].AreaID)
            txtarea.text = arearary[0].AreaName
            ApiCallGetSociety()
        }
        else
        {
            txtarea.resignFirstResponder()
            ApiCallGetSociety()
        }
    }
    @objc func donePressed2()
        
    {
        if(txtcommunity.text == "")
        {
              self.txtcommunity.resignFirstResponder()
            if societyary.count > 0{
                self.txtcommunity.text = self.societyary[0].SocietyName
                //self.txtcommunity.resignFirstResponder()
                self.societyid =  String(self.societyary[0].SocietyID)
                self.apicallGetBuildings()
            }
            
        }
        else
        {
            txtcommunity.resignFirstResponder()
            apicallGetBuildings()
            
        }
        viewbuilding.isHidden = false
        hightbuilding.constant = 210
    }
    
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
    
    func setleftview(textfield: UITextField ,image:UIImage)
    {
        var imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        
        view.addSubview(imageView)
        textfield.leftViewMode = UITextFieldViewMode.always
        
        textfield.leftView = view
    }
    
    
    // MARK: - pickerview delegate and data source methods
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView == pickerview1)
        {
            return cityary.count
        }
        else if  (pickerView == pickerview2)
        {
            return arearary.count
            
        }
        else
        {
            return societyary.count
        }
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView == pickerview1)
        {
            return cityary[row].Name
        }
        else if  (pickerView == pickerview2)
        {
            return arearary[row].AreaName
        }
        else
        {
            return societyary[row].SocietyName
            
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView == pickerview1)
        {
            txtcity.text = cityary[row].Name
            cityid = String(cityary[row].CityID!)
        }
        if(pickerView == pickerview2)
        {
            txtarea.text = arearary[row].AreaName
            areaid = String(arearary[row].AreaID)
            
        }
        if(pickerView == pickerview3)
        {
            txtcommunity.text = societyary[row].SocietyName
            societyid =  String(societyary[row].SocietyID)
        }
    }
    
    
    @objc func tapline1(sender: UITapGestureRecognizer)
    {
        
        self.viewstep1.isHidden = false
        self.viewstep2.isHidden = true
        self.view.bringSubview(toFront:viewstep1)
        self.line1.isHidden = false
        self.line2.isHidden = true
        
    }
    
    @objc func tapline2(sender: UITapGestureRecognizer)
    {
        
        self.viewstep2.isHidden = false
        self.viewstep1.isHidden = true
        self.view.bringSubview(toFront:viewstep2)
        self.line2.isHidden = false
        self.line1.isHidden = true
        
    }
    func checkbox(cb:Checkbox)
    {
        cb.borderStyle = .square
        cb.checkmarkStyle = .tick
        cb.uncheckedBorderColor = .black
        cb.borderWidth = 1
        cb.uncheckedBorderColor = .black
        cb.checkedBorderColor = .black
        cb.backgroundColor = .clear
        cb.checkboxBackgroundColor = UIColor.clear
        cb.checkmarkColor = AppColor.appcolor
        
    }
    
    // MARK: = tableview delegate and datasource mehthods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if(tableView == tblbuilding)
        {
            
            return buildingary.count
        }
        else
        {
            return Flatary.count
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(tableView == tblbuilding)
        {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
            
            cell.textLabel?.text = buildingary[indexPath.row].PropertyName
            return cell
        }
        else
        {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath)
            
            cell.textLabel?.text = Flatary[indexPath.row].PropertyName
            return cell
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tableView == tblbuilding)
        {
            
            txtblockname.text = buildingary[indexPath.row].PropertyName
            
            buildingid =  String(buildingary[indexPath.row].PropertyID)
            apicallGetFlat()
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options:
                UIViewAnimationOptions.curveEaseOut, animations: {
                    
                    self.viewbuilding.isHidden = true
                    self.hightbuilding.constant = 0
                    
                    self.txtblockname.isHidden = false
                    self.hightxtbuilding.constant = 50
                    
                    self.viewflat.isHidden = false
                    self.hightflat.constant = 210
                    
            }, completion: { finished in
                
                
                
            })
            
        }
        
        if(tableView == tblflat)
        {
            
            self.txtflats.text = self.Flatary[indexPath.row].PropertyName
            Flatid = String(self.Flatary[indexPath.row].PropertyID!)
            
            // 20/10/20. comments temp
            
            /*
            if self.Flatary[indexPath.row].booked == "no" {
                cbowner.isHidden = false
                cbrenter.isHidden = false
                btnOwner.isHidden = false
                btnRentingFlat.isHidden = false
            }else{
                
                if self.Flatary[indexPath.row].bookType == "Owner of flat"{
                    cbowner.isHidden = true
                    cbrenter.isHidden = false
                    btnOwner.isHidden = true
                    btnRentingFlat.isHidden = false
                }
                
                if self.Flatary[indexPath.row].bookType == "Renting the flat"{
                    cbowner.isHidden = true
                    cbrenter.isHidden = true
                    btnOwner.isHidden = true
                    btnRentingFlat.isHidden = true
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"This flat is already booked")
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
            } */
            
            
            UIView.animate(withDuration: 0.3, delay: 0.2, options:
                UIViewAnimationOptions.curveEaseOut, animations: {
                    
                    
                    self.viewflat.isHidden = true
                    self.hightflat.constant = 0
                    
                    self.txtflats.isHidden = false
                    self.highttxtflat.constant = 50
                    
                    self.viewyouare.isHidden = false
                    self.hightyouare.constant = 178
                    self.btnsignup.isHidden = false
                    
                    
            }, completion: { finished in
                
                
            })
            
        }
    }
    
    
    // MARK: - Delete circulars
    
    func ApiCallCheckEmailExist()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().ApiCallCheckMailExists(URL: webservices().baseurl + API_EMAIL_VERIFY, email:txtemail.text!) { JSON in
                
                let statusCode = JSON.response?.statusCode
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(statusCode == 200)
                    {
                        
                        self.viewstep2.isHidden = false
                        self.viewstep1.isHidden = true
                        self.view.bringSubview(toFront:self.viewstep2)
                        self.line2.isHidden = false
                        self.line1.isHidden = true
                        self.lblstep2.isUserInteractionEnabled = true
                        
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.errors!)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
        
    }
    
    
    
    
    // MARK: - Api call signup step2
    
    @available(iOS 13.0, *)
    func ApiCallSignUp2()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        webservices().StartSpinner()
            
            
            var role = ""
            
            if(cbowner.isChecked)
            {
                role = "Owner of flat"
            }
            if(cbrenter.isChecked)
            {
                role = "Renting the flat"
            }
            if(cbother.isChecked)
            {
                role = "Renting the flat with other tenants"
            }
            
 
             var strFCmToken = ""
            if UserDefaults.standard.value(forKey: "FcmToken") != nil{
                strFCmToken = UserDefaults.standard.value(forKey: "FcmToken") as! String
            }else{
                strFCmToken = "abc"
            }
            
            
            //NEW
            let parameter:Parameters = ["phone":strmobile,"username":txtname.text!,"email":txtemail.text!,"society_id":societyid,"building_id":buildingid,"flat_id":Flatid,"fcm_token":strFCmToken,"flatType" : role,"city_id":cityid,"area_id":areaid,"profession_detail":"","profession":""]
            
            Apicallhandler().ApiCallSignUp2(URL: webservices().baseurl + APIRegister, param: parameter) { response in
                
               // let statusCode = response.response?.statusCode

                switch response.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    
                 if resp.status == 1
                    {
//                        UserDefaults.standard.set(resp.data.role, forKey: USER_ROLE)
//                        UserDefaults.standard.set(resp.data.token, forKey: USER_TOKEN)
//                        UserDefaults.standard.set(resp.data.id, forKey:USER_ID)
//                        UserDefaults.standard.set(resp.data.email, forKey:USER_EMAIL)
//                        UserDefaults.standard.set(resp.data.name, forKey:USER_NAME)
//                        UserDefaults.standard.set(resp.data.phone, forKey:USER_PHONE)
//                        UserDefaults.standard.set(resp.data.societyID, forKey:USER_SOCIETY_ID)
//                        UserDefaults.standard.set(resp.data.image, forKey:USER_PROFILE_PIC)
//                        UserDefaults.standard.synchronize()
//
//
//                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
//                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        let alert = UIAlertController(title: Alert_Titel, message:"Thank you for registering. You can login once your society admin approve your account" , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            //self.navigationController?.popToRootViewController(animated: true)
                            for controller in self.navigationController!.viewControllers as Array {
                                if controller.isKind(of: MobileNumberVC.self) {
                                    self.navigationController!.popToViewController(controller, animated: true)
                                    break
                                }
                            }
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                        
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"")//resp.message!)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
            }
            
      
        
    }
    // MARK: - Api call get city
    
    func ApiCallGetCity()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
        let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
        
        let param : Parameters = [
            "Phone" : mobile!,
            "Secret" : secret
        ]
                
            Apicallhandler.sharedInstance.ApiCallGetCity(URL: webservices().baseurl + API_GET_CITY, param: param) { response in
          //  Apicallhandler().ApiCallGetCity(URL: webservices().baseurl + API_GET_CITY) { response in
                
                webservices().StopSpinner()
                switch(response.result) {
                case .success(let resp):
                    if resp.status == 1{
                        self.cityary = resp.data
                        self.txtarea.text = ""
                        self.txtcommunity.text = ""
                        self.pickerview1.reloadAllComponents()
                        
                    }else{
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    break
                case .failure(let err):
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    
                    
                }
                
            }
            
       
    }
    
    
    // MARK: - Api call get area by city
    
    func ApiCallGetArea()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
          //  Apicallhandler().ApiCallGetArea(URL: webservices().baseurl + API_GET_AREA, city_id: cityid) { response in
           
        let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
                
                let param : Parameters = [
                    "Phone" : mobile!,
                    "Secret" : secret,
                    "City" : cityid
                ]
                        
            
            Apicallhandler.sharedInstance.ApiCallGetArea(URL: webservices().baseurl + API_GET_AREA, param: param) { response in
                
                
                switch response.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        self.arearary = resp.data
                        self.txtarea.text = ""
                        self.txtcommunity.text = ""
                        self.pickerview2.reloadAllComponents()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Area is not found for selected city")
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
      
    }
    
    // MARK: - Api call get Society by area
    
    func ApiCallGetSociety()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
          //  Apicallhandler().ApiCallGetSociety(URL: webservices().baseurl + API_GET_SOCIETY, city_id: cityid, area_id: areaid) { JSON in
        
            let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
        
             let param : Parameters = [
                 "Phone" : mobile!,
                 "Secret" : secret,
                 "City" : cityid,
                 "Area" : areaid
             ]
            
            Apicallhandler.sharedInstance.ApiCallGetSociety(URL: webservices().baseurl + API_GET_SOCIETY, param: param) { JSON in
            
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        
                        self.societyary = resp.data
                        self.txtcommunity.text = ""
                        self.pickerview3.reloadAllComponents()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
            }
      
    }
    
    
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        
          //  Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, societyid:societyid) { JSON in
                
                let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
            
                 let param : Parameters = [
                     "Phone" : mobile!,
                     "Secret" : secret,
                     "Society" : societyid
                 ]
                        
            Apicallhandler.sharedInstance.GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, param: param) { JSON in
                   
                
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        self.buildingary = resp.data
                        self.newbuildingary = resp.data
                        self.tblbuilding.reloadData()
                    }
                        
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
    }
    
    /// MARK: - get Flat
    
    func apicallGetFlat()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
           // Apicallhandler().ApiCallGetFlat(URL: webservices().baseurl + API_GET_FLAT, society_id:"", building_id: buildingid) { JSON in
                
            let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
          
            let param : Parameters = [
                  "Phone" : mobile!,
                   "Secret" : secret,
                   "Society" : societyid,
                   "Parent" : buildingid
            ]
              
                  Apicallhandler.sharedInstance.ApiCallGetFlat(URL: webservices().baseurl + API_GET_FLAT, param: param) { JSON in
                    
                
                let statusCode = JSON.response?.statusCode
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(resp.status == 1)
                    {
                        self.Flatary = resp.data!
                        self.NewFlatary = resp.data!
                        self.tblflat.reloadData()
                    }
                        
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
      
    }
    
    
    // MARK: - Userdefilne function
    
    func isValidEmail(emailStr:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: emailStr)
    }
    
   
    
}
