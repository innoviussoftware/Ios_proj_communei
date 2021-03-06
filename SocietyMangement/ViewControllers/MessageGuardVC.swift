//
//  MessageGuardVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 30/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire



class MessageGuardVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var collectionMessageImage: UICollectionView!

    @IBOutlet weak var textViewReasion: UITextView!
    
    @IBOutlet weak var btnattechment: UIButton!
    
    @IBOutlet weak var btnattechment_update: UIButton!
    
    @IBOutlet weak var viewCamera: UIView!

    var imgData : Data?
       
    var arrMessageImg = NSMutableArray()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewReasion.layer.borderWidth = 1
                       
        textViewReasion.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5
                 
        textViewReasion.layer.cornerRadius = 10
        
        viewCamera.isHidden = true
        
        btnattechment.isHidden = false

        btnattechment_update.isHidden = true
        
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapviewCameraimage))
        viewCamera.addGestureRecognizer(tap)


        // Do any additional setup after loading the view.
    }
    
    @objc func tapviewCameraimage() {
        viewCamera.isHidden = true
    }
    
    @IBAction func backaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnMessageGuardClicked(_ sender: UIButton) {
        if textViewReasion.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Message")
            self.present(alert, animated: true, completion: nil)
        }
        //else if (btnattechment.imageView!.image == nil) || (self.imgData == nil) {
        else if arrMessageImg.count == 0{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please Select Image")
            self.present(alert, animated: true, completion: nil)
        }else{
            apiCallMessageToGuard()
        }
    }
    
    func messageGuardClicked() {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  "Successfully Sent"
        avc?.subtitleStr = "Your Message Sent Successfully"
        avc?.isfrom = 4

        avc?.yesAct = {
           
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
                                         
        }
        avc?.noAct = {
            
        }
        
        present(avc!, animated: true)
    }

    
    func apiCallMessageToGuard() {
        
        if !NetworkState().isInternetAvailable {
                ShowNoInternetAlert()
                return
        }
       
        webservices().StartSpinner()
        
        let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String

       let param:Parameters = [
            "Message": textViewReasion.text!,
        ]
    
        print("param message : ",param)
        
        AF.upload(
            multipartFormData: { MultipartFormData in
                
                for (key, value) in param {
                    
                    MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
               /* let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHH:mm:ss"
                let strFileName = formatter.string(from: date)
                
                if self.imgData!.count != 0{
                    MultipartFormData.append(self.imgData!, withName: "Attachments[]", fileName: strFileName, mimeType: "image/png/jpeg/application/pdf")
                } */
                
                
                for img in self.arrMessageImg{
                                                       let date = Date()
                                                       let formatter = DateFormatter()
                                                       formatter.dateFormat = "yyyyMMddHHmmss"
                                                       let strFileName = formatter.string(from: date)
                                                       
                                                        let imgData = UIImageJPEGRepresentation(img as! UIImage, 0.2)!
                                                        
                                                         MultipartFormData.append(imgData, withName: "Attachments[]", fileName: "\(strFileName)", mimeType:"image/png/jpeg/application/pdf")
                                                       
                                                    }

                
        }, to:  webservices().baseurl + API_MESSAGE_GUARD ,headers:["Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            
            print("Upload Progress message guard : \(progress.fractionCompleted)")
        })
            .responseJSON (completionHandler: { [self] (response:DataResponse<Any>) in
                
                webservices().StopSpinner()
                let statusCode = response.response?.statusCode
                switch(response.result) {
                case .success(let resp):
                    if statusCode == 200{
                        print(resp)
                        
                        self.messageGuardClicked()
                        
                        // create the alert
                     /*  let alert = UIAlertController(title: Alert_Titel, message:"Sent emergency alert." , preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            self.navigationController?.popViewController(animated: true)
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil) */
                        
                        self.textViewReasion.text = ""
                       // self.imgview.setBackgroundImage(nil, for: .normal)
                        
                    }
                    
                    else if(statusCode == 401)
                    {
                        
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
                          
                        
                    }
                    
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    if statusCode == 401{
                        
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
                    break
                    
                }
                
            })

  
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
    
    //MARK:-User define photo
    
    func photoLibrary()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.allowsEditing = true
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        myPickerController.mediaTypes = ["public.image"]
        
        self.present(myPickerController, animated: true, completion: nil)
    }
      
    //MARK:-User define camera
         
    func camera() {
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
            // if (info[UIImagePickerControllerMediaType] as? String) != nil {
              
              if let originalimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                 
                  arrMessageImg.add(originalimage)

                collectionMessageImage.reloadData()
                
              }
          
            self.dismiss(animated: true, completion: nil)
             
         }
    
    /* {
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
             
         } */
    
    
    // MARK: - Collectionview delegate and datasource methods
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrMessageImg.count
        }

    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                     
            let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
                       
            cell.imgview.image = arrMessageImg[indexPath.row] as? UIImage
            
            return cell
             
     }
          
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 84, height: 92)
      }

}
