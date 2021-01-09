//
//  LeaveNoteGuardVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 01/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

import Alamofire


protocol addLeaveNoteGuard {
    func addedLeaveNoteGuard()
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class LeaveNoteGuardVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UICollectionViewDelegate , UICollectionViewDataSource {

    var delegate : addLeaveNoteGuard?

    @IBOutlet weak var textViewReasion: UITextView!
    
    @IBOutlet weak var btnattechment: UIButton!
    
    @IBOutlet weak var collectionNoteGuard: UICollectionView!
    
    @IBOutlet weak var viewinner: UIView!

    var arrNoteGuardImg = NSMutableArray()

    var userActivityID: Int?
    
    var visitingFlatID: Int?

    var imgData : Data?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewReasion.layer.borderWidth = 1
                       
        textViewReasion.layer.borderColor = AppColor.ratingBorderColor.cgColor
                 
        textViewReasion.layer.cornerRadius = 10


        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(touches.first?.view != viewinner){
            removeAnimate()
        }
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

    @IBAction func backaction(_ sender: Any) {
          removeAnimate()
        //self.navigationController?.popViewController(animated: true)
    }
      
      @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        if textViewReasion.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please enter Message")
            self.present(alert, animated: true, completion: nil)
        }else if arrNoteGuardImg.count == 0{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please Select Image")
            self.present(alert, animated: true, completion: nil)
        }else{
             apiCallGuardToNote()
             removeAnimate()
        }
          print("btnSaveClicked")
      }
    
        func apiCallGuardToNote() {
            
            if !NetworkState().isInternetAvailable {
                    ShowNoInternetAlert()
                    return
            }
           
            webservices().StartSpinner()
            
            let strtoken = UserDefaults.standard.value(forKey:USER_TOKEN) as! String

           let param:Parameters = [
                "Message": textViewReasion.text!,
                "UserActivityID":userActivity!,
                "VisitingFlatsID":visitingFlatID!
            ]
        
            print("param emergency : ",param)
            
            AF.upload(
                multipartFormData: { [self] MultipartFormData in
                    
                    for (key, value) in param {
                        
                        MultipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
   
                    for img in self.arrNoteGuardImg{
                                                           let date = Date()
                                                           let formatter = DateFormatter()
                                                           formatter.dateFormat = "yyyyMMddHHmmss"
                                                           let strFileName = formatter.string(from: date)
                                                           
                                                            let imgData = UIImageJPEGRepresentation(img as! UIImage, 0.2)!
                                                            
                                                             MultipartFormData.append(imgData, withName: "Attachments[]", fileName: "\(strFileName)", mimeType:"image/png/jpeg/application/pdf")
                                                           
                                                        }
                }, to:  webservices().baseurl + "user/send/emergency-alert" ,headers:["Authorization": "Bearer "+strtoken]).uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    
                    print("Upload Progress note to guard : \(progress.fractionCompleted)")
                })
                    .responseJSON (completionHandler: { (response:DataResponse<Any>) in
                        
                        webservices().StopSpinner()
                        let statusCode = response.response?.statusCode
                        switch(response.result) {
                        case .success(let resp):
                            if statusCode == 200{
                                print(resp)
                                
                                // create the alert
                              /*  let alert = UIAlertController(title: Alert_Titel, message:"Sent Note to Guard." , preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                    self.navigationController?.popViewController(animated: true)
                                }))
                                // show the alert
                                self.present(alert, animated: true, completion: nil) */
                                
                                self.delegate?.addedLeaveNoteGuard()
                                self.removeAnimate()
                                self.dismiss(animated: true, completion: nil)
                                
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
      
      @IBAction func btnOpenCameraClicked(_ sender: Any) {
                  
         // viewCamera.isHidden = true
               
          camera()
                  
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
    
    
    // MARK: - Collectionview delegate and datasource methods
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return arrNoteGuardImg.count
    
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
            let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
                       
            cell.imgview.image = arrNoteGuardImg[indexPath.row] as? UIImage
            
            return cell

             
     }
          
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 84, height: 92)
      }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
      
      // MARK: - Image Picker delegate and datasource methods
         func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
             
             self.dismiss(animated: true, completion: nil)
         }
      
      //MARK:- imagePicker delegate methods
      
         func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            // if (info[UIImagePickerControllerMediaType] as? String) != nil {
              
              if let originalimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
              
                 arrNoteGuardImg.add(originalimage)

                  collectionNoteGuard.reloadData()

              }
          
             self.dismiss(animated: true, completion: nil)
             
         }

}
