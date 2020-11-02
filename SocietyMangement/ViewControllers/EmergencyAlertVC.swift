//
//  EmergencyAlertVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 29/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit


class EmergencyAlertVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource, UIImagePickerControllerDelegate , UINavigationControllerDelegate  {
    
    @IBOutlet weak var collectionEmergencyAlert: UICollectionView!

    @IBOutlet weak var textViewReasion: UITextView!

    @IBOutlet weak var btnattechment: UIButton!
    
    var imgData : Data?
    
    var selectedindex : Int?


    var EmergencyAlertary = ["Fire","Lift","Animal","Human", "Accident","Medical", "Water"]

    var iconEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewReasion.layer.borderWidth = 1
                
        textViewReasion.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5

        textViewReasion.layer.cornerRadius = 10
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRaiseAlarmClicked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EmergencyRespondPopUpVC") as! EmergencyRespondPopUpVC
        // vc.isfrom = 1
        self.navigationController?.pushViewController(vc, animated: false)
        
        print("btnRaiseAlarmClicked")
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

            }else if indexPath.item == 1{ // ic_Lift_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift_selected"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]

            }else if indexPath.item == 2{ // ic_Animal_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal_selected"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]

            }else if indexPath.item == 3{ // ic_Human_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human_selected"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]

            }else if indexPath.item == 4{ // ic_Accident_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident_selected"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]

            }else if indexPath.item == 5{ // ic_Medical_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical_selected"),UIImage (named:"ic_Water")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]

            }else if indexPath.item == 6{ // ic_Water_selected
                let iconSelectEmergencyAlertary = [UIImage(named:"ic_Fire"),UIImage (named:"ic_Lift"),UIImage (named:"ic_Animal"),UIImage (named:"ic_Human"),UIImage (named:"ic_Accident"),UIImage (named:"ic_Medical"),UIImage (named:"ic_Water_selected")]
                
                cell.imgview.image = iconSelectEmergencyAlertary[indexPath.row]

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
