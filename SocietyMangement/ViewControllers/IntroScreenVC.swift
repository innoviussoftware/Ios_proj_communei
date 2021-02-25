//
//  IntroScreenVC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 13/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire


class IntroScreenVC: BaseVC {

//    @IBOutlet weak var lblhighligh1: RSLabelCustomisation!
//
//    @IBOutlet weak var lblhighlight3: RSLabelCustomisation!
//    @IBOutlet weak var lblhighlight2: RSLabelCustomisation!
    
    @IBOutlet weak var widthlblhighligh1: NSLayoutConstraint!
    @IBOutlet weak var heightlblhighligh1: NSLayoutConstraint!

    @IBOutlet weak var widthlblhighlight2: NSLayoutConstraint!
    @IBOutlet weak var heightlblhighlight2: NSLayoutConstraint!

    @IBOutlet weak var widthlblhighlight3: NSLayoutConstraint!
    @IBOutlet weak var heightlblhighlight3: NSLayoutConstraint!
    
    @IBOutlet weak var lblhighligh1: UILabel!
    @IBOutlet weak var lblhighlight3: UILabel!
    @IBOutlet weak var lblhighlight2: UILabel!
    
    
    @IBAction func LoginAction(_ sender: Any) {
        
        _ = self.pushViewController(withName:MobileNumberVC.id(), fromStoryboard:"Main")
    }
    
    @IBAction func SignUPAction(_ sender: Any) {
        _ = self.pushViewController(withName:SignUPOTPVC.id(), fromStoryboard:"Main")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblhighligh1.layer.masksToBounds = true
        lblhighligh1.layer.cornerRadius = 5.0
        
        lblhighlight2.layer.masksToBounds = true
        lblhighlight2.layer.cornerRadius = 5.0
        
        lblhighlight3.layer.masksToBounds = true
        lblhighlight3.layer.cornerRadius = 5.0
        
        self.widthlblhighligh1.constant = 27
        self.heightlblhighligh1.constant = 10

        self.widthlblhighlight2.constant = 17
        self.heightlblhighlight2.constant = 6
        
        self.widthlblhighlight3.constant = 17
        self.heightlblhighlight3.constant = 6
        
        lblhighligh1.backgroundColor = AppColor.borderColor
        lblhighlight2.backgroundColor = AppColor.introlineColor
        lblhighlight3.backgroundColor = AppColor.introlineColor
                
        // Do any additional setup after loading the view.
    }
    
  

}


extension IntroScreenVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:IntroscreenCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! IntroscreenCell
        
      //  cell.lblcontent.font = UIFont.init(name: "Gotham-Light", size: 14.0)
        
        if(indexPath.row == 0)
        {
            cell.imgview.image = UIImage(named:"ic_splash1")
           // cell.lbltitle.text = "Visitor Management"
           // cell.lblcontent.text = "Ensure your guests feel welcome. With a simple passcode, your guests are through to your door instantly. No need for manual register."
        }
        else if(indexPath.row == 1)
        {
            cell.imgview.image = UIImage(named:"ic_splash2")
           // cell.lbltitle.text = "Daily Staff Management"
          //  cell.lblcontent.text = "Record attendance for staff and find best-rated helper in the community."
        }
        else if(indexPath.row == 2)
               {
                   cell.imgview.image = UIImage(named:"ic_splash3")
                  // cell.lbltitle.text = "Delivery Management & more..."
                 //  cell.lblcontent.text = "Verify entry of every delivery executive and, if needed, instruct them to leave the package at the gate and pick it up at your convenience."
               }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width:collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
             return 0
     }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let scrollPos = scrollView.contentOffset.x / view.frame.width

        if(Int(scrollPos) == 0)
        {
           
            self.widthlblhighligh1.constant = 27
            self.heightlblhighligh1.constant = 10

            self.widthlblhighlight2.constant = 17
            self.heightlblhighlight2.constant = 6
            
            self.widthlblhighlight3.constant = 17
            self.heightlblhighlight3.constant = 6
            
            lblhighligh1.backgroundColor = AppColor.borderColor
            lblhighlight2.backgroundColor = AppColor.introlineColor
            lblhighlight3.backgroundColor = AppColor.introlineColor

        }
        else if(Int(scrollPos) == 1)
        {
            
            self.widthlblhighligh1.constant = 17
            self.heightlblhighligh1.constant = 6

            self.widthlblhighlight2.constant = 27
            self.heightlblhighlight2.constant = 10
            
            self.widthlblhighlight3.constant = 17
            self.heightlblhighlight3.constant = 6
            
            lblhighligh1.backgroundColor = AppColor.introlineColor
            lblhighlight2.backgroundColor = AppColor.borderColor
            lblhighlight3.backgroundColor = AppColor.introlineColor
             
           
        }
        else if(Int(scrollPos) == 2)
               {
            
                    self.widthlblhighligh1.constant = 17
                    self.heightlblhighligh1.constant = 6

                    self.widthlblhighlight2.constant = 17
                    self.heightlblhighlight2.constant = 6
                    
                    self.widthlblhighlight3.constant = 27
                    self.heightlblhighlight3.constant = 10
                    
                    lblhighligh1.backgroundColor = AppColor.introlineColor
                    lblhighlight2.backgroundColor = AppColor.introlineColor
                    lblhighlight3.backgroundColor = AppColor.borderColor
                     
                    
               }
      }
      
    
}
