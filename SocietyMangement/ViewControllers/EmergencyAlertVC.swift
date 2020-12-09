//
//  EmergencyAlertVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 29/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire


class EmergencyAlertVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    @IBOutlet weak var collectionEmergencyAlert: UICollectionView!
    
    @IBOutlet weak var collHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var textViewReasion: UITextView!

    @IBOutlet weak var btnattechment: UIButton!
    
    @IBOutlet weak var btnattechment_update: UIButton!
    
    @IBOutlet weak var viewCamera: UIView!

    
    var imgData : Data?
    
    var selectedindex : Int?
    
    var emergencyAlertId : Int?

    var emergencyAlertName = ""

    var EmergencyAlertary = ["Fire","Lift","Animal","Human", "Accident","Medical", "Water"]

    var iconEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewReasion.layer.borderWidth = 1
                
        textViewReasion.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5

        textViewReasion.layer.cornerRadius = 10
        
        viewCamera.isHidden = true
        
        btnattechment.isHidden = false

        btnattechment_update.isHidden = true
        
        self.collectionEmergencyAlert.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
      @objc func tapviewCameraimage() {
          viewCamera.isHidden = true
      }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        collectionEmergencyAlert.layer.removeAllAnimations()
        print("tblview contentSize height :- ",collectionEmergencyAlert.contentSize.height)
        collHeightConstraint.constant = collectionEmergencyAlert.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @available(iOS 13.0, *)
    func apiCallEmergencyRaiseAlarm() {
        
        if !NetworkState().isInternetAvailable {
                ShowNoInternetAlert()
                return
        }
       
        webservices().StartSpinner()
        
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String

       let param:Parameters = [
            "Message": textViewReasion.text!,
            "EmergencyAlertTypeID":emergencyAlertId!,
            "EmergencyAlertTypeName":emergencyAlertName
        ]
    
        print("param emergency : ",param)
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                for (key, value) in param {
                    
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHH:mm:ss"
                let strFileName = formatter.string(from: date)
                
                if self.imgData!.count != 0{
                    MultipartFormData.append(self.imgData!, withName: "Attachments[]", fileName: strFileName, mimeType: "image/png/jpeg/application/pdf")
                }

                
        }, to:  webservices().baseurl + "user/send/emergency-alert" ,headers:["Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            print("Upload Progress emergency alert : \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(resp)
                        
                        // create the alert
                        let alert = UIAlertController(title: Alert_Titel, message:"Sent emergency alert." , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                        self.textViewReasion.text = ""
                       // self.imgview.setBackgroundImage(nil, for: .normal)
                        
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
    
    @available(iOS 13.0, *)
    @IBAction func btnRaiseAlarmClicked(_ sender: Any) {
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmergencyRespondPopUpVC") as! EmergencyRespondPopUpVC
        // vc.isfrom = 1
       // self.navigationController?.pushViewController(vc, animated: false)
        
        if emergencyAlertName == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please Select one Alert")
            self.present(alert, animated: true, completion: nil)
        }else if textViewReasion.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Message")
            self.present(alert, animated: true, completion: nil)
        }else if (btnattechment.imageView!.image == nil) || (self.imgData == nil) {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please Select Image")
            self.present(alert, animated: true, completion: nil)
        }else{
            apiCallEmergencyRaiseAlarm()
        }
            
        print("btnRaiseAlarmClicked")
    }
        
    @IBAction func btnCameraClicked(_ sender: UIButton) {
        viewCamera.isHidden = false
    }

    @IBAction func btnOpenCameraClicked(_ sender: UIButton) {
        camera()
        viewCamera.isHidden = true
    }
       
    @IBAction func btnOpenGalleryClicked(_ sender: UIButton) {
        photoLibrary()
        viewCamera.isHidden = true
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
    
    
    //MARK:-User define functions
       
       func camera()
       {
           let myPickerController = UIImagePickerController()
           myPickerController.delegate = self;
           myPickerController.allowsEditing = true
           myPickerController.sourceType = UIImagePickerControllerSourceType.camera
           
           self.present(myPickerController, animated: true, completion: nil)
           
       }
    
    // MARK: - Image Picker delegate and datasource methods
       func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           
           self.dismiss(animated: true, completion: nil)
       }
    
    //MARK:- imagePicker delegate methods
    
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
           if (info[UIImagePickerControllerMediaType] as? String) != nil {
               
               let image = info[UIImagePickerControllerEditedImage] as! UIImage
               
                btnattechment.setTitle("", for: .normal)
               // btnattechment.setBackgroundImage(image, for: .normal)
            
                btnattechment.isHidden = true
            
                btnattechment_update.isHidden = false
            
                btnattechment_update.setBackgroundImage(image, for: .normal)

                imgData = (UIImagePNGRepresentation(image)! as NSData) as Data
               
                self.dismiss(animated: true, completion: nil)
            }
           
       }
    
    // MARK: - Collectionview delegate and datasource methods
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return EmergencyAlertary.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
             let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
            
            cell.imgview.image = iconEmergencyAlertary[indexPath.row]
            cell.lblname.text = EmergencyAlertary[indexPath.row]
        
        if(selectedindex == indexPath.row) {
            if indexPath.item == 0{ // ic_Fire_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire_selected"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]
                emergencyAlertId = 1
                emergencyAlertName = "Fire"
            }else if indexPath.item == 1{ // ic_Lift_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift_selected"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]
                emergencyAlertId = 2
                emergencyAlertName = "Lift"
            }else if indexPath.item == 2{ // ic_Animal_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal_selected"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]
                emergencyAlertId = 3
                emergencyAlertName = "Animal"

            }else if indexPath.item == 3{ // ic_Human_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human_selected"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]
                emergencyAlertId = 4
                emergencyAlertName = "Human"
            }else if indexPath.item == 4{ // ic_Accident_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident_selected"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]
                emergencyAlertId = 5
                emergencyAlertName = "Accident"
            }else if indexPath.item == 5{ // ic_Medical_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical_selected"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]
                emergencyAlertId = 6
                emergencyAlertName = "Medical"
            }else if indexPath.item == 6{ // ic_Water_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water_selected")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]
                emergencyAlertId = 7
                emergencyAlertName = "Water"
                
            }
        }

    
            return cell
             
     }
          
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 84, height: 92)
      }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedindex = indexPath.row
        collectionEmergencyAlert.reloadData()
                
    }
    

}
