//
//  DeliveryCompanyListVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 18/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

protocol DeliveryCompanyListProtocol {
    
    func deliveryList(name:String, selectNumber:Int)
    
  //  func deliveryList(name:[String])
    
   // func deliveryList(ary:NSMutableArray,name:[String])

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
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class DeliveryCompanyListVC: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    var delegate:DeliveryCompanyListProtocol?
    
    var strlbl = String()
    
    var selectedindex:Int?
    
    var selectedindex1:Int?
            
  //  var isfromNumber: Bool?

    var entryary = ["Cab","Delivery","Visitor","Service provider"]
    
    var alertGuardary = ["Emergency Alerts","Message Guard","Cab","Complaint Management","Visitor","Message Guard","Complaint Management"]
    
    var iconentryary = [UIImage(named:"ic_cab"),UIImage (named:"ic_delivery"),UIImage (named:"ic_user"),UIImage (named:"ic_domestic")]
    
    var iconalertGuardary = [UIImage(named:"ic_alerts"),UIImage (named:"ic_message"),UIImage (named:"ic_cab"),UIImage (named:"ic_complaint"),UIImage(named:"ic_user"),UIImage (named:"ic_message"),UIImage (named:"ic_complaint")]

    
    @IBOutlet weak var collectionFrequent_Deliveries: UICollectionView!

    @IBOutlet weak var collectionOther_Deliveries: UICollectionView!
    
    @IBOutlet weak var txtOtherName: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setborders(textfield: txtOtherName)
        
        print("strlbl :- ",strlbl)
        
        txtOtherName.delegate = self

       // webservices.sharedInstance.PaddingTextfiled(textfield: txtOtherName)

        collectionFrequent_Deliveries.reloadData()
        collectionOther_Deliveries.reloadData()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backaction(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }
    
    @IBAction func btnAddPressed(_ sender: Any) {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                  avc?.titleStr = "Successfully added"
        
        avc?.isfrom = 4
                  avc?.subtitleStr = "Your delivery will be allowed"
                  avc?.yesAct = {
                    
                     let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC
                                   
                    let navgitaionCon = UINavigationController(rootViewController: homeViewController!)

                    navgitaionCon.popViewController(animated: true)
                  

                    //  self.ApiCallDeleteFrequentEntry(guestId: strGuestId!)
                  }
                  avc?.noAct = {
                    
                  }
                  present(avc!, animated: true)
    }
    
    func setborders(textfield:UITextField) {
        textfield.layer.borderColor =  AppColor.txtbgColor.cgColor
        textfield.layer.borderWidth = 1.0
    }
    
    // MARK: - Collectionview delegate and datasource methods
      
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionFrequent_Deliveries){
            return entryary.count
        }else{
            return alertGuardary.count
        }
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
         if(collectionView == collectionFrequent_Deliveries)
         {
             
             let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
            
            cell.imgview.image = iconentryary[indexPath.row]
            cell.lblname.text = entryary[indexPath.row]
                        
            if(selectedindex == indexPath.row) &&  (cell.lblname.text!.contains(strlbl)) {
                
                cell.imgview.layer.borderColor = AppColor.orangeColor.cgColor
                //UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0).cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 1.0
            }else {
                cell.imgview.layer.borderColor = UIColor.clear.cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 0.0
            }
            
        
             return cell
             
         }
         else{

             let cell:ShortCutCells = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCells
                    
             cell.imgview.image = iconalertGuardary[indexPath.row]
             cell.lblname.text = alertGuardary[indexPath.row]
                
           if(selectedindex1 == indexPath.row)  &&  (cell.lblname.text!.contains(strlbl)) {
                                    
                cell.imgview.layer.borderColor = AppColor.orangeColor.cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 1.0
            }else {
                cell.imgview.layer.borderColor = UIColor.clear.cgColor
                cell.imgview.layer.masksToBounds = true
                cell.imgview.contentMode = .scaleToFill
                cell.imgview.layer.borderWidth = 0.0
            }
            
             return cell
         }
                 
     }
          
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
          if(collectionView == collectionFrequent_Deliveries){
              return CGSize(width: 84, height: 92)
          }else{
              return CGSize(width: 84, height: 92)
          }
                  
      }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == collectionFrequent_Deliveries){
            selectedindex = indexPath.row
        }else{
            selectedindex1 = indexPath.row
        }

        collectionView.reloadData()

        if(collectionView == collectionFrequent_Deliveries){
            
            delegate?.deliveryList(name: entryary[indexPath.row], selectNumber: selectedindex!)
            
            strlbl = entryary[indexPath.row]
            print("strlbl : ",strlbl)
        }else{
            delegate?.deliveryList(name: alertGuardary[indexPath.row], selectNumber: selectedindex1!)
            strlbl = alertGuardary[indexPath.row]
            print("strlbl : ",strlbl)
        }
        

        self.navigationController?.popViewController(animated: true)

    }

}
