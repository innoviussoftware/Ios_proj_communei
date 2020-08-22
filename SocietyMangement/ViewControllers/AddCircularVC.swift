//
//  AddCircularVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import IQKeyboardManagerSwift
import Alamofire
import MobileCoreServices


@available(iOS 13.0, *)
class AddCircularVC: UIViewController , UITextFieldDelegate , Buildings , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var menuaction: UIButton!

    @IBOutlet weak var btnsave: UIButton!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var imgview: UIButton!
    @IBOutlet weak var CircularView: UIView!

    @IBOutlet weak var txtdes: IQTextView!
    
    @IBOutlet weak var txtsendto: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txttitle: SkyFloatingLabelTextField!
    
    @IBOutlet weak var innerview: UIView!

    @IBOutlet weak var viewdocument: UIView!
    var isfrom = 0
    var dic:Circular?
    var selectedary = NSMutableArray()
    
    var imgData = Data()
    var strPdfUrl : URL?
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SaveAction(_ sender: Any) {
        if(txtsendto.text == "")
        {
            
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter sendto option")
            self.present(alert, animated: true, completion: nil)
        }
        else if(txttitle.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter title")
            self.present(alert, animated: true, completion: nil)
            
        }   else if(txtdes.text == "")
        {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please enter description")
            self.present(alert, animated: true, completion: nil)
            
        }
//        else if(imgview.backgroundImage(for: .normal) == nil)
//        {
//            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:" Please select image")
//            self.present(alert, animated: true, completion: nil)
//
//        }
        else{
            if(isfrom == 1)
            {
                apicallEditcircular()
            }else{
                
                apicalladdcircula()
            }
        }
    }
    
    func selectedbuildings(selectedary: NSMutableArray,nameary:NSMutableArray) {
        
        self.selectedary =  selectedary
        self.txtsendto.text = nameary.componentsJoined(by:",")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
        
        
        if(isfrom == 1)
        {
            lbltitle.text = "Update Circular"
            btnsave.setTitle("Update", for: .normal)
            txttitle.text = dic?.title
            txtdes.text = dic?.datumDescription
            txtsendto.text = dic?.buildingID
            txtdes.placeholder = ""
           // apicallGetBuildings()
            
        }
        else
        {
            lbltitle.text = "Add Circular"
            btnsave.setTitle("Save", for: .normal)
            
        }
        
        setrightviewnew(textfield:txtsendto, image: #imageLiteral(resourceName: "ic_nxt_click"))
        
        
        //webservices().setShadow(view: innerview)
        CircularView.layer.borderColor = AppColor.appcolor.cgColor
        CircularView.layer.borderWidth = 2.0
        CircularView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(uploadImage1))
        CircularView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    
    @objc func AcceptRequest(notification: NSNotification) {
        
        let object = notification.object as! NSDictionary
        
        if let key = object.object(forKey: "notification_type")
        {
            let value = object.value(forKey: "notification_type") as! String
            
            if(value == "security")
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GuestPopVC") as! GuestPopVC
                nextViewController.guestdic = object
                nextViewController.isfromnotification = 0
                navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            else  if object.value(forKey: "notification_type") as! String == "Notice"{
                                   
                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                        
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                                        nextViewController.isFrormDashboard = 0
                                        navigationController?.pushViewController(nextViewController, animated: true)
                                   
                                   
                               }else if object.value(forKey: "notification_type") as! String == "Circular"{
                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                                                        nextViewController.isfrom = 0
                                                                        navigationController?.pushViewController(nextViewController, animated: true)
                          
                                   
                                   
                               }else if object.value(forKey: "notification_type") as! String == "Event"{
                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                                                                                     nextViewController.isfrom = 1
                                                                                     navigationController?.pushViewController(nextViewController, animated: true)
                          
                              
                                   
                               }
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtsendto.resignFirstResponder()
            NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField == txtsendto)
        {
            
            self.view.endEditing(true)

            txtsendto.resignFirstResponder()
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SendtoPopUP") as! SendtoPopUP
            popOverConfirmVC.delegate = self
            popOverConfirmVC.selectedary = self.selectedary
            self.addChildViewController(popOverConfirmVC)
            popOverConfirmVC.view.frame = self.view.frame
            self.view.center = popOverConfirmVC.view.center
            self.view.addSubview(popOverConfirmVC.view)
            popOverConfirmVC.didMove(toParentViewController: self)
             return false
        }else{
            return true
        }
        
    }

    
    @objc func uploadImage1(sender: UITapGestureRecognizer)
    {
//        let importMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
//        importMenu.delegate = self
//        importMenu.modalPresentationStyle = .formSheet
//        self.present(importMenu, animated: true, completion: nil)
        
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
    
    // MARK: - Image Picker delegate and datasource methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- imagePicker delegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let mediaType = info[UIImagePickerControllerMediaType] as? String {
            
            var image = info[UIImagePickerControllerEditedImage] as! UIImage
            imgview.setBackgroundImage(image, for: .normal)
            imgview.setTitle("", for: .normal)
            
            imgData = (UIImagePNGRepresentation(image)! as NSData) as Data

            self.dismiss(animated: true, completion: nil)
        }
    }
    //MARK:-User define functions
    
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myPickerController.mediaTypes = ["public.image"]
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func setrightviewnew(textfield: UITextField ,image:UIImage)
    {
        let imageView = UIImageView.init(image: image)
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
           imageView.isUserInteractionEnabled = false
        view.isUserInteractionEnabled = false
        view.addSubview(imageView)
        textfield.rightViewMode = UITextFieldViewMode.always
        
        textfield.rightView = view
    }
    

    
    //MARK:- Add Circilar API
    func apicalladdcircula() {
        
        
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
        let strSocietyId = String(format: "%d", UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int)
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
        
        webservices().StartSpinner()
        let param : Parameters = [
            "society_id" : strSocietyId,
            "building_id" : selectedary.componentsJoined(by: ","),
            "title" : txttitle.text!,
            "description" : txtdes.text!
            //"pdffile" : ""
        ]
        
        AF.upload(
            multipartFormData: { MultipartFormData in

                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let strFileName = formatter.string(from: date)
                
                
                
                for (key, value) in param {
                     MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
                }
                
                if self.imgData.count != 0{
                    MultipartFormData.append(self.imgData, withName: "pdffile", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                }
                
                
    
                
        }, to:  webservices().baseurl + API_ADD_CIRCULAR,headers:["Accept": "application/json","Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            
            print("Upload Progress: \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(resp)
                        
                        self.txtsendto.text = ""
                        self.txttitle.text = ""
                        self.txtdes.text = ""
                        // create the alert
                        let alert = UIAlertController(title: Alert_Titel, message:"Circular added Successfully." , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }else{
                    }
                    
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    if statusCode == 401{
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                            }
                        })
                        
                        return
                    }
                    break
                    
                }
                
            })
        
    }
    
    // MARK: - Api call Edit Circular

    func apicallEditcircular()
    {
        
            if !NetworkState().isInternetAvailable {
                             ShowNoInternetAlert()
                             return
                         }
           // circular_id, society_id, building_id, title, description
            let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String
            
            let SociyID = UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
            let strSocietyId = (SociyID as NSNumber).stringValue
            
//            let buildingId = UserDefaults.standard.value(forKey:USER_BUILDING_ID) as! Int
//            let strBuildingID = (buildingId as NSNumber).stringValue
            
            let circularId = dic?.id
            let strCircularId = (circularId! as NSNumber).stringValue
            
            webservices().StartSpinner()
            
           let param:Parameters = [
            "circular_id":strCircularId,
            "society_id":strSocietyId,
            "building_id":txtsendto.text!,
            "title":txttitle.text!,
            "description":txtdes.text!
            ]
            
            AF.upload(
                multipartFormData: { MultipartFormData in
                    
                    for (key, value) in param {
                        MultipartFormData.append(((value as? String)?.data(using: .utf8))!, withName: key)
                    }
                    
                    
                    let date = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyyMMddHH:mm:ss"
                    let strFileName = formatter.string(from: date)
                    
                    MultipartFormData.append(self.imgData, withName: "pdffile", fileName: "\(strFileName).jpeg", mimeType:"image/jpeg")
                    
                    
                    
                    
            }, to:  webservices().baseurl + API_EDIT_CIRCULAR,headers:["Accept": "application/json","Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
                //Current upload progress of file
                
                print("Upload Progress: \(progress.fractionCompleted)")
            })
                .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                    
                    webservices().StopSpinner()
                    let statusCode = response.response?.statusCode
                    switch(response.result) {
                    case .success(let resp):
                        if statusCode == 200{
                            print(resp)
                            
                            // create the alert
                            let alert = UIAlertController(title: Alert_Titel, message:"Circular updated successfully" , preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                self.navigationController?.popViewController(animated: true)
                            }))
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                            
                            
                        }else{
                        }
                        
                        break
                    case .failure(let err):
                        print(err.localizedDescription)
                        if statusCode == 401{
                            APPDELEGATE.ApiLogout(onCompletion: { int in
                                if int == 1{
                                     let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                               let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                               let navController = UINavigationController(rootViewController: aVC)
                                                                               navController.isNavigationBarHidden = true
                                                                  self.appDelegate.window!.rootViewController  = navController
                                                                  
                                }
                            })
                            
                            return
                        }
                        break
                        
                    }
                    
                })

      
    }



}




@available(iOS 13.0, *)
extension AddCircularVC : UIDocumentMenuDelegate,UIDocumentPickerDelegate
{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let myURL = urls.first else {
            return
        }
        print("import result : \(myURL)")
        
        strPdfUrl = myURL
    }
    
    
    public func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
