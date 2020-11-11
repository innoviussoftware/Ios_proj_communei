//
//  CategoryListVC.swift
//  SocietyMangement
//
//  Created by Innovius on 03/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import ScrollPager

class CategoryListVC: UIViewController {
    
    @IBOutlet var viewData: UIView!
    
    @IBOutlet weak var pager: ScrollPager!
    
    @IBOutlet weak var collectionCategory: UICollectionView!
    @IBOutlet weak var collectionRecommendation: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        

        pager.addSegmentsWithTitlesAndViews(segments: [
            ("Buy", viewData),
            ("Sell",viewData)
            ])
        
        pager.font = UIFont(name: "GothamMedium", size: 16)!

        collectionCategory.register(UINib(nibName: "categoryCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")
        collectionRecommendation.register(UINib(nibName: "RecommendationCell", bundle: nil), forCellWithReuseIdentifier: "RecommendationCell")
        
        
    }
    

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension CategoryListVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionCategory{
            return 8
        }else{
            return 10
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == collectionCategory{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
            
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendationCell", for: indexPath) as! RecommendationCell
            
            
            return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionCategory{
            
            if #available(iOS 13.0, *) {
                   let vc = self.storyboard?.instantiateViewController(identifier: "CategoryDetailsVC") as! CategoryDetailsVC
                    vc.strCategoryName = "Car"

                   self.navigationController?.pushViewController(vc, animated: true)
               } else {
                   // Fallback on earlier versions
               }
            
            
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





