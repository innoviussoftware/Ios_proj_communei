//
//  BuySellVC.swift
//  SocietyMangement
//
//  Created by Innovius on 03/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController


class BuySellVC: UIViewController {
    
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var btnSell: UIButton!
    @IBOutlet weak var lblBottomBuy: UILabel!
    @IBOutlet weak var lblBottomSell: UILabel!
    
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var collectionRecommendation: UICollectionView!
    
    var arrCategory = NSMutableArray()
    var arrRecommend = NSMutableArray()
    
    var isfrom = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionCategory.register(UINib(nibName: "categoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        collectionRecommendation.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCell")
        
        if isfrom == 1{
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }else{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }
        
        if(revealViewController() != nil)
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        setUpViewData()
    }
    
    
    func setUpViewData() {
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        lblBottomSell.isHidden = true
        
        
        let dict = NSMutableDictionary()
        dict.setValue("Furniture", forKey: "cat_name")
        dict.setValue("furniture", forKey: "cat_img")
        arrCategory.add(dict)
        
        let dict1 = NSMutableDictionary()
        dict1.setValue("Electronic", forKey: "cat_name")
        dict1.setValue("electronic", forKey: "cat_img")
        arrCategory.add(dict1)
        
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("Cars", forKey: "cat_name")
        dict2.setValue("cars", forKey: "cat_img")
        arrCategory.add(dict2)
        
        let dict3 = NSMutableDictionary()
        dict3.setValue("Mobile", forKey: "cat_name")
        dict3.setValue("Mobile", forKey: "cat_img")
        arrCategory.add(dict3)
        
        let dict4 = NSMutableDictionary()
        dict4.setValue("Bikes", forKey: "cat_name")
        dict4.setValue("bikes", forKey: "cat_img")
        arrCategory.add(dict4)
        
        
        let dict5 = NSMutableDictionary()
        dict5.setValue("Sports", forKey: "cat_name")
        dict5.setValue("Sports", forKey: "cat_img")
        arrCategory.add(dict5)
        
        let dict6 = NSMutableDictionary()
        dict6.setValue("Music", forKey: "cat_name")
        dict6.setValue("Music", forKey: "cat_img")
        arrCategory.add(dict6)
        
        let dict7 = NSMutableDictionary()
        dict7.setValue("Toys", forKey: "cat_name")
        dict7.setValue("Toys", forKey: "cat_img")
        arrCategory.add(dict7)
        
        let dict8 = NSMutableDictionary()
        dict8.setValue("Fashion", forKey: "cat_name")
        dict8.setValue("Fashion", forKey: "cat_img")
        arrCategory.add(dict8)
        
        collectionCategory.dataSource = self
        collectionCategory.delegate = self
        collectionCategory.reloadData()
        
    }
    
    //MARK:- action method
    @IBAction func actionMenu(_ sender: Any) {
        
        if isfrom == 1{
            self.navigationController?.popViewController(animated: true)
        }else{
            revealViewController()?.revealToggle(self)
        }
                
       // revealViewController()?.revealToggle(self)
    }
    @IBAction func actionBuy(_ sender: Any) {
        lblBottomSell.isHidden = true
        lblBottomBuy.isHidden = false
    }
    @IBAction func actionSell(_ sender: Any) {
        lblBottomSell.isHidden = false
        lblBottomBuy.isHidden = true
    }
    @IBAction func actionViewAll(_ sender: Any) {
    }
    

}


extension BuySellVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionCategory{
            return arrCategory.count
        }else{
          return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
            
            cell.imgProduct.image = UIImage(named: (arrCategory[indexPath.row] as! NSMutableDictionary).value(forKey: "cat_img") as! String)
            cell.lblCategoryName.text = (arrCategory[indexPath.row] as! NSMutableDictionary).value(forKey: "cat_name") as? String
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
            
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         if collectionView == collectionCategory{
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "CategoryDetailsVC") as! CategoryDetailsVC
            vc.strCategoryName = ((arrCategory[indexPath.row] as! NSMutableDictionary).value(forKey: "cat_name") as? String)!
        self.navigationController?.pushViewController(vc, animated: true)
         }else{
           let  vc  = self.storyboard?.instantiateViewController(withIdentifier: "HourlyEntryPermissionPopUpVC") as! HourlyEntryPermissionPopUpVC
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            self.present(navigationController, animated: false, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        //return CGSize(width: 100, height: 128)
        
        if collectionView == collectionCategory{
            return CGSize(width: 100, height: 128)
        }else{
            return  CGSize(width: collectionWidth/2-8, height: 185)
        }
        
        
    }

    
    
    
    
    
}
