//
//  CommunityVC.swift
//  SocietyMangement
//
//  Created by MacMini on 04/08/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

// design follow link

//  https://xd.adobe.com/view/eaa45464-e6b4-4098-abbd-03ceef40cfc5-bff7/screen/745f0562-5406-4485-a09f-1a4f75f8abf2/specs/

import UIKit

import SDWebImage
import SWRevealViewController
import Alamofire


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class CommunityVC: BaseVC , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var collectionmenu: UICollectionView!

    @IBOutlet weak var lblname: UILabel!

    var titieary = ["Activity","Household","Community"]
  //  var menuary = ["Buildings","Members","Notices","Events","Circulars"]//,"Vendors"]
 //   var meimagesary = ["ic_building","ic_member","ic_notice","ic_event","ic_circular"]//,"ic_vendor"]
    
  //  var arrData = ["Members","Notices","Events","Circulars"]//,"Vendors"]
   // var arrImage = ["ic_member","ic_notice","ic_event","ic_circular"]//,"ic_vendor"]
    
     var arrData = ["Residents","Notices","Events","Circulars","Emergency No's","Local Services"]//,"Vendors"]
       var arrImage = ["ic_residents","ic_notice","ic_event","ic_circular","ic_emergency_no","ic_local_services"]//,"ic_vendor"]
       
    
    var arrNotificationCountData = [NotificationCountData]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblname.text = String(format: "%@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)

    }
    

     //MARK:- collection view delegate
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
                 
                let cell : Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
            
              //  cell.lblname.font = UIFont(name: "Gotham-Black", size: 18)

                
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
                if(str.contains("Secretory") || str.contains("Chairman"))
                {
                  //  cell.lblname.text = menuary[indexPath.row]
                  //  cell.imgview.image = UIImage(named:meimagesary[indexPath.row])
                    
                    cell.lblname.text = arrData[indexPath.row]
                    cell.imgview.image = UIImage(named:arrImage[indexPath.row])

                     if arrNotificationCountData.count > 0 {
                    
                              if indexPath.row == 0{ // Building
                                       
                                cell.lblBadgeCount?.isHidden = true
                                       //cell.lblBadgeCount.text = arrNotificationCountData[0]
                                   }
                                   
                                   
                                   if indexPath.row == 1{ //member
                                    cell.lblBadgeCount?.isHidden = true
                                    }
                                   
                                   if indexPath.row == 2{ // Notice
                                       
                                       if arrNotificationCountData[1].count == 0{
                                        cell.lblBadgeCount?.isHidden = true
                                       }else{
                                        cell.lblBadgeCount?.text = "\(arrNotificationCountData[1].count!)"
                                        cell.lblBadgeCount?.isHidden = false

                                       }
                                       
                                    }
                                   
                                   if indexPath.row == 4{ // event
                                       if arrNotificationCountData[0].count == 0{
                                        cell.lblBadgeCount?.isHidden = true
                                       }else{
                                        cell.lblBadgeCount?.text = "\(arrNotificationCountData[0].count!)"
                                        cell.lblBadgeCount?.isHidden = false

                                       }
                                   }
                    if indexPath.row == 3{ // circular
                        if arrNotificationCountData[2].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[2].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                    }
                     }else{
                        
                        cell.lblBadgeCount?.isHidden = true
                    }
                    
                    
                }else{
                    cell.lblname.text = arrData[indexPath.row]
                    cell.imgview.image = UIImage(named:arrImage[indexPath.row])
                    
                    if arrNotificationCountData.count > 0 {
                    if indexPath.row == 0{ // Member
                        cell.lblBadgeCount?.isHidden = true
                    }
                    
                    
                    if indexPath.row == 1{ //Notice
                        
                        if arrNotificationCountData[1].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[1].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                       
                     }
                    
                    if indexPath.row == 2{ // Event
                        
                        if arrNotificationCountData[0].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[0].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                        
                     }
                                                            
                    if indexPath.row == 3{ // Circular
                        if arrNotificationCountData[2].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[2].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                    }
                    }else{
                        cell.lblBadgeCount?.isHidden = true
                    }
                    
                }
                
                
                return cell
                
            
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
                if(str.contains("Secretory") || str.contains("Chairman"))
                {
                   // return menuary.count
                    return arrData.count
                    
                }else{
                    return arrData.count
                }
                
           
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            if(collectionView == collectionmenu)
            {
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
              /*  if(str.contains("Secretory") || str.contains("Chairman")){
                    if indexPath.item == 0{//Buildings
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuildingsVC") as! BuildingsVC
                        vc.isFrom = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if indexPath.item == 1{ //Member
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MembersVC") as! MembersVC
                        vc.isFromDash = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if indexPath.item == 2{//Notice
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                        vc.isFrormDashboard = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if indexPath.item == 3{//Events
                        
                       // APPDELEGATE.api
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                        vc.isfrom = 0
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else{//Circular
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                        vc.isfrom = 0
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }
                }else{ */
                    if indexPath.item == 0{ //Member
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MembersVC") as! MembersVC
                        vc.isFromDash = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if indexPath.item == 1{//Notice
                        
                        // 13/8/20.
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                        
                      //  let vc = self.pushViewController(withName:NoticeVC.id(), fromStoryboard: "Main") as! NoticeVC

                        vc.isFrormDashboard = 1
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if indexPath.item == 2{//Events
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC

                        vc.isfrom = 0
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if indexPath.item == 3{//Circular

                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC

                        vc.isfrom = 0
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }else if indexPath.item == 4{
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpDeskVC") as! HelpDeskVC
                        vc.isfrom = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{  // DomesticHelpVC
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
                        vc.isfrom = 1
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
               // }
                
            }
            
            
        }
        
        
    /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
                let collectionViewWidth = self.view.bounds.width
                return CGSize(width: collectionViewWidth/2 - 10, height: collectionViewWidth/2 + 10)
            
        
            } */
    
   /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          return CGSize(width: (collectionmenu.frame.size.width - 10) / 2, height: (collectionmenu.frame.size.width - 10) / 2)

      } */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
           let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionmenu.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size)
        
           // let collectionWidth = collectionView.bounds.width

          //  return  CGSize(width: collectionWidth/2-8, height: 150)

       }
    
    
    
        

}
