//
//  QuickActionVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 17/08/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

import SWRevealViewController


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class QuickActionVC: UIViewController , UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var menuaction: UIButton!
    
    @IBOutlet weak var collectionAddEntry: UICollectionView!
    
    @IBOutlet weak var collectionGuard: UICollectionView!
    
    @IBOutlet weak var collectionUpcomingServices: UICollectionView!

    
       var shortcutary = ["Add Visitor","Buy/Sell","Help Desk","Amenities Booking","Domestic Helper"]
    
       var iconary =
           [UIImage(named:"ic_user"),UIImage (named:"ic_buysell"),UIImage (named:"ic_helpdesk"),UIImage (named:"ic_aminities"),UIImage (named:"ic_domestic")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionAddEntry.layer.shadowColor = UIColor.lightGray.cgColor
               collectionAddEntry.layer.shadowOffset = CGSize(width:0, height: 1)
               collectionAddEntry.layer.shadowOpacity = 1
               collectionAddEntry.layer.shadowRadius = 1.0
               collectionAddEntry.clipsToBounds = false
               collectionAddEntry.layer.masksToBounds = false
        
        if(revealViewController() != nil)
               {
                   menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                   
                   self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                   self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
               }
               

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMenuActionPressed(_ sender: Any) {
        revealViewController()?.revealToggle(self)
    }
      

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == collectionAddEntry)
        
        {
            
            let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
            cell.imgview.image = iconary[indexPath.row]
            cell.lblname.text = shortcutary[indexPath.row]
            
            return cell
            
        }
        else if(collectionView == collectionGuard){

            let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
            cell.imgview.image = iconary[indexPath.row]
            cell.lblname.text = shortcutary[indexPath.row]
                   
            return cell
        }
        else
        {
           // let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath)
            
            let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
            cell.imgview.image = iconary[indexPath.row]
            cell.lblname.text = shortcutary[indexPath.row]
            
            return cell
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionAddEntry){
            return shortcutary.count
        }else if(collectionView == collectionGuard){
            return shortcutary.count
        }else{
            return shortcutary.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == collectionAddEntry)
        {
            if indexPath.item == 0{ // "Add Visitor"
                
              /*  let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddguestPopup") as! AddguestPopup
                popOverConfirmVC.delegate = self
                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self) */
                print("Add Visitor")

            }else if indexPath.item == 1 { // "Buy/Sell"
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuySellVC") as! BuySellVC
                vc.isfrom = 1
                self.navigationController?.pushViewController(vc, animated: true)
                print("Buy/Sell")
                
            }else if indexPath.item == 2 { // "Help Desk"
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpDeskVC") as! HelpDeskVC
                vc.isfrom = 1
                self.navigationController?.pushViewController(vc, animated: true)
                print("Help Desk")
                
            }else if indexPath.item == 3 { // "Amenities Booking"
                print("Amenities Booking")
            }else if indexPath.item == 4 { // "Domestic Helper"
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
                vc.isfrom = 1
                self.navigationController?.pushViewController(vc, animated: true)
                print("Domestic Helper")
            }
            
            
        }
        else if(collectionView == collectionGuard){
            print("collection Guard")
        }
        else
        {
            print("collection Upcoming Services")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if(collectionView == collectionAddEntry){
            return CGSize(width: 84, height: 92)
        }else if(collectionView == collectionGuard){
            return CGSize(width: 84, height: 92)
        }else{
            return CGSize(width: 84, height: 92)
        }
                
    }
    
    
}
