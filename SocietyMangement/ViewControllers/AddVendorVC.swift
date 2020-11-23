//
//  AddVendorVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

class AddVendorVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    
    
    var isfrom = 0
    var dic:Vendor?

    @IBOutlet weak var txtphone: GBTextField!
    
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var txtname: GBTextField!
    
    @IBOutlet weak var txtemail: GBTextField!
    
    @IBOutlet weak var txtprofession: GBTextField!
    
    @IBAction func ChangeAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func saveaction(_ sender: Any) {
        
        if(txtname.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter name")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtemail.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter email")
            self.present(alert, animated: true, completion: nil)
            
        }
        else if(txtphone.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter phone")
            self.present(alert, animated: true, completion: nil)
            
        }
        
        else if(txtprofession.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter profession")
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            if(isfrom == 0)
            {
             apicalladdvendor()
            }
            else
            {
                
                apicallEditVendor()
            }
            
        }
    }
    
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        

        if(isfrom == 1)
        {
            
            txtname.text = dic?.vendorName
            txtemail.text = dic?.vendorEmail
            txtprofession.text = dic?.vendorProfession
           txtphone.text = dic?.vendorPhone
            imgview.sd_setImage(with: URL(string: dic!.vendorProfile), placeholderImage: UIImage(named: "img_default"))

            
        }
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
            
            var image = info[UIImagePickerControllerEditedImage] as! UIImage
            imgview.image =  image
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    //MARK:-User define functions
    
    func camera()
    {
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myPickerController.mediaTypes = ["public.image"]
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Api call add vednor
    
    func apicalladdvendor()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        webservices().StartSpinner()
            Apicallhandler().AddVendor(URL:  webservices().baseurl + "addVendor", society_id: UserDefaults.standard.value(forKey:"societyid")! as! String, user_id: UserDefaults.standard.value(forKey:"id")! as! String, vendor_name:txtname.text!, vendor_email: txtemail.text!, vendor_profession: txtprofession.text!,vendor_phone: txtphone.text!, file:imgview.image!) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    print(resp)
                case .failure(let err):
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
        
    }
    
    
    
    // MARK: - Api call edit vednor
    
    func apicallEditVendor()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().EditVendor(URL:  webservices().baseurl + "updateVendor", vendor_id: dic!.id, society_id: UserDefaults.standard.value(forKey:"societyid")! as! String, user_id: UserDefaults.standard.value(forKey:"id")! as! String, vendor_name:txtname.text!, vendor_email: txtemail.text!, vendor_profession: txtprofession.text!,vendor_phone: txtphone.text!, file:imgview.image!) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    print(resp)
                case .failure(let err):
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
   
        
    }


    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
