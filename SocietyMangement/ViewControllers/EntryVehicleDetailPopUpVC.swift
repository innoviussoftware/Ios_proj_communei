//
//  EntryVehicleDetailPopUpVC.swift
//  SocietyMangement
//
//  Created by Innovius on 18/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire

protocol addedVehicle {
    func addedNewVehicle()
}

class EntryVehicleDetailPopUpVC: UIViewController {
    var delegate : addedVehicle?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var txtVehicleType: UITextField!
    @IBOutlet weak var txtVehicleNumber: UITextField!
    
    var arrVehicleType = ["Two Wheeler","Four Wheeler"]
    
    var activeTextField = UITextField()
    var picker : UIPickerView!
    var selectedType : Int! = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.showAnimate()
        
        txtVehicleType.addTarget(self, action: #selector(openPicker(txt:)), for: .editingDidBegin)
        txtVehicleType.addDoneOnKeyboardWithTarget(self, action: #selector(DoneVehicleType), shouldShowPlaceholder: true)
        
      //  setrightviewnew(textfield: txtVehicleType, image: UIImage(named:"ic_down_blue")!)
        
        setborders(textfield: txtVehicleType)
        setborders(textfield: txtVehicleNumber)
        
        webservices.sharedInstance.PaddingTextfiled(textfield: txtVehicleType)
        webservices.sharedInstance.PaddingTextfiled(textfield: txtVehicleNumber)
        
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
    }
    
    //MARK:- action method
    
    @IBAction func actionSubmit(_ sender: Any) {
        
        if !txtVehicleType.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please select vehicle type")
            self.present(alert, animated: true, completion: nil)
        }else if !txtVehicleNumber.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter vehcle number")
            self.present(alert, animated: true, completion: nil)
        }else{
            apicallAddVehicle()
        }
        
    }
    
    @IBAction func actionClose(_ sender: Any) {
        self.removeAnimate()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- open picker
    @objc func openPicker(txt:UITextField) {
        
        activeTextField = txt
        
        if picker != nil{
            picker.removeFromSuperview()
        }
        
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        
        txtVehicleType.inputView = picker
        picker.backgroundColor = UIColor.white
        
    }
    
    @objc func DoneVehicleType() {
        activeTextField.resignFirstResponder()
        txtVehicleType.text = arrVehicleType[selectedType]
    }
    
    
    func setborders(textfield:UITextField)
    {
        
        textfield.layer.borderColor =  AppColor.lightgray.cgColor
        textfield.layer.borderWidth = 1.0
        
        
    }
    func setrightviewnew(textfield: UITextField ,image:UIImage)
    {
        let imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 10, y: 5, width: 20, height: 20)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        
        view.addSubview(imageView)
        view.isUserInteractionEnabled = false
        imageView.isUserInteractionEnabled = false
        
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
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
    
    
    // MARK: - get Notices
    
    func apicallAddVehicle()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            let param : Parameters = [
                "type":txtVehicleType.text!,
                "number":txtVehicleNumber.text!
            ]
            webservices().StartSpinner()
            
            Apicallhandler().GetADDVehicle(URL: webservices().baseurl + API_ADD_VEHICLE, param: param, token:token as! String) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.delegate?.addedNewVehicle()
                        self.removeAnimate()
                        self.txtVehicleType.text = ""
                        self.txtVehicleNumber.text = ""
                        self.dismiss(animated: true, completion: nil)
                    }
                    else
                    {
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    
                }
            }
            
       
    }
    
    
}


extension EntryVehicleDetailPopUpVC : UIPickerViewDelegate , UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrVehicleType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrVehicleType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = row
    }
    
}


extension EntryVehicleDetailPopUpVC : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == " ") {
            return false
        }
        return true
    }
    
}
