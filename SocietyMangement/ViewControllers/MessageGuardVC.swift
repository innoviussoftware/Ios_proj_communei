//
//  MessageGuardVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 30/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class MessageGuardVC: UIViewController, UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var textViewReasion: UITextView!
    
    @IBOutlet weak var btnattechment: UIButton!
       
    var imgData : Data?
       

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewReasion.layer.borderWidth = 1
                       
        textViewReasion.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5
                 
        textViewReasion.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func btnMessageGuardClicked(_ sender: Any) {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  "Successfully Sent"
        avc?.subtitleStr = "Your Message Sent Successfully"
        avc?.isfrom = 4

        avc?.yesAct = {
           /* let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
                                                          
            let navgitaionCon = UINavigationController(rootViewController: homeViewController!)

            navgitaionCon.popViewController(animated: true) */
            
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
                                         
        }
        avc?.noAct = {
            
        }
        
        present(avc!, animated: true)
    }
    
    @IBAction func btnOpenCameraClicked(_ sender: Any) {
                  
         // viewCamera.isHidden = true
               
          camera()
                  
    }
      
    //MARK:-User define functions
         
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
             if (info[UIImagePickerControllerMediaType] as? String) != nil {
                 
                 let image = info[UIImagePickerControllerEditedImage] as! UIImage
                 
                    // btnattechment.setTitle("", for: .normal)
                     btnattechment.setBackgroundImage(image, for: .normal)
                 
                  imgData = (UIImagePNGRepresentation(image)! as NSData) as Data
                 
                  self.dismiss(animated: true, completion: nil)
              }
             
         }
      

}
