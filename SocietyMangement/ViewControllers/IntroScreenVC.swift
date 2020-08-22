//
//  IntroScreenVC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 13/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class IntroScreenVC: BaseVC {

    @IBOutlet weak var lblhighligh1: RSLabelCustomisation!
    
    @IBOutlet weak var lblhighlight3: RSLabelCustomisation!
    @IBOutlet weak var lblhighlight2: RSLabelCustomisation!
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
        let nextVC = self.pushViewController(withName:MobileNumberVC.id(), fromStoryboard:"Main")
    }
    
    @IBAction func SignUPAction(_ sender: Any) {
                let nextVC = self.pushViewController(withName:SignUPOTPVC.id(), fromStoryboard:"Main")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

                  lblhighligh1.backgroundColor = UIColor(named:"Orange")
                   lblhighlight2.backgroundColor = UIColor.lightGray
                   lblhighlight3.backgroundColor = UIColor.lightGray

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
@available(iOS 13.0, *)
extension IntroScreenVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:IntroscreenCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! IntroscreenCell
        
        if(indexPath.row == 0)
        {
            cell.imgview.image = UIImage(named:"ic_splash1")
            cell.lbltitle.text = "Visitor Management"
            cell.lblcontent.text = "Visitor Management Ensure your guests feel welcome. With a simple passcode, your guests are through to your door instantly. No need for manual register."
        }
        else if(indexPath.row == 1)
        {
            cell.imgview.image = UIImage(named:"ic_splash2")
                       cell.lbltitle.text = "Daily Staff Management"
                       cell.lblcontent.text = "Daily Staff Management Record attendance for staff and find best-rated helper in the community."
        }
        else if(indexPath.row == 2)
               {
                   cell.imgview.image = UIImage(named:"ic_splash3")
                              cell.lbltitle.text = "Delivery Management & more..."
                              cell.lblcontent.text = "Delivery Managements & more... Verify entry of every delivery executive and, if needed, instruct them to leave the package at the gate and pick it up at your convenience."
               }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:collectionView.frame.width, height: 442)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 0
     }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let scrollPos = scrollView.contentOffset.x / view.frame.width

        if(Int(scrollPos) == 0)
        {
            lblhighligh1.backgroundColor = UIColor(named:"Orange")
            lblhighlight2.backgroundColor = UIColor.lightGray
            lblhighlight3.backgroundColor = UIColor.lightGray

        }
        else if(Int(scrollPos) == 1)
        {
            lblhighligh1.backgroundColor =  UIColor.lightGray
            lblhighlight2.backgroundColor = UIColor(named:"Orange")
            lblhighlight3.backgroundColor = UIColor.lightGray

        }
        else if(Int(scrollPos) == 2)
               {
                   lblhighligh1.backgroundColor =  UIColor.lightGray
                   lblhighlight2.backgroundColor = UIColor.lightGray
                   lblhighlight3.backgroundColor = UIColor(named:"Orange")

               }
      }
      
    
}
