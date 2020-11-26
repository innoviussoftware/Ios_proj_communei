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
    
    @IBOutlet weak var menuaction: UIButton!


    var titieary = ["Activity","Household","Community"]
  //  var menuary = ["Buildings","Members","Notices","Events","Circulars"]//,"Vendors"]
 //   var meimagesary = ["ic_building","ic_member","ic_notice","ic_event","ic_circular"]//,"ic_vendor"]
    
  //  var arrData = ["Members","Notices","Events","Circulars"]//,"Vendors"]
   // var arrImage = ["ic_member","ic_notice","ic_event","ic_circular"]//,"ic_vendor"]
    
     var arrData = ["Residents","Notices","Events","Circulars","Emergency No's","Domestic Helper"]//,"Vendors"]
       var arrImage = ["ic_residents","ic_notice","ic_event","ic_circular","ic_emergency_no","ic_domestic_help"]//,"ic_vendor"]
       
        
    var arrNotificationCountData = [NotificationCountData]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if(revealViewController() != nil)
            {
                menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
                
                print("revealViewController auto")

            }

        // lblname.text = String(format: "%@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        apicallUserMe()
        
        apicallNotificationCount()
    }
    
    // MARK: - User me
    
    func apicallUserMe()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()

            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
          //  Apicallhandler.sharedInstance.ApiCallUserMe(token: token as! String) { JSON in
            
        Apicallhandler().ApiCallUserMe(URL: webservices().baseurl + "user", token: token as! String) { JSON in

                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                   webservices().StopSpinner()
                    
                    if statusCode == 200{
                        UserDefaults.standard.set(resp.data!.society?.societyID, forKey: USER_SOCIETY_ID)
                        UserDefaults.standard.set(resp.data!.guid, forKey: USER_ID)
                        UserDefaults.standard.set(resp.data!.role, forKey: USER_ROLE)
                        UserDefaults.standard.set(resp.data!.society?.propertyID, forKey: USER_BUILDING_ID)
                        UserDefaults.standard.synchronize()
                        
                        UsermeResponse = resp
                      //  self.lbltitle.text = "Welcome, \(resp.data!.name!)"
                        
                        // 21/10/20. temp comment
                        
                        self.lblname.text = "\(resp.data!.society?.parentProperty ?? "")-\(resp.data!.society?.property ?? "")"


                      //  self.lblname.text = String(format: "%@-%@", UsermeResponse!.data!.society?.propertyID!,UsermeResponse!.data!.society?.society!)

                        print(resp)
                    }
                    
                case .failure(let err):
                    webservices().StopSpinner()
                    if statusCode == 401{
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                            }
                        })
                        
                        return
                    }
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError as Any)
                    
                }
            }
        
    }
    
    func apicallNotificationCount()
       {
           if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
        
               let token = UserDefaults.standard.value(forKey: USER_TOKEN)

               webservices().StartSpinner()
            
           // Apicallhandler.sharedInstance.GetNotifyCount(URL: webservices().baseurl + API_NOTIFY_COUNT) { JSON in
                
            Apicallhandler.sharedInstance.GetNotifyCount(URL: webservices().baseurl + API_NOTIFY_COUNT, token: token as! String) { JSON in

            
                   let statusCode = JSON.response?.statusCode
                   
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if statusCode == 200{
                           
                        self.arrNotificationCountData = resp.data!
                        self.collectionmenu.delegate = self
                        self.collectionmenu.dataSource = self
                        self.collectionmenu.reloadData()
                        
                       }
                       
                   case .failure(let err):
                       
                       webservices().StopSpinner()
                       let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                       
                       
                   }
               }
               
          
           
       }
    
    @IBAction func btnZendeskPressed(_ sender: Any) {
        // let vc =
        _ = self.pushViewController(withName:SupportZendeskVC.id(), fromStoryboard: "Main") as! SupportZendeskVC
    }
    
    @IBAction func actionNotification(_ sender: Any) {
              let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
               vc.isfrom = 0
            }
           
           @IBAction func btnOpenQRCodePressed(_ sender: Any) {
               let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
               vc.isfrom = 0
           }

     //MARK:- collection view delegate
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            
                 
                let cell : Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
            
            cell.layer.shadowColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.16).cgColor
            cell.layer.shadowOpacity = 1
            cell.layer.shadowRadius = 1.0
            cell.layer.shadowOffset = CGSize(width:0, height: 1)
            
                cell.lblname.font = UIFont(name: "Gotham-Book", size: 16)

                
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
            if(str.contains("society_admin"))
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
                                   
                                  else if indexPath.row == 1{ // Notice
                                       
                                       if arrNotificationCountData[0].count == 0{
                                        cell.lblBadgeCount?.isHidden = true
                                       }else{
                                        cell.lblBadgeCount?.text = "\(arrNotificationCountData[0].count!)"
                                        cell.lblBadgeCount?.isHidden = false

                                       }
                                       
                                    }
                                   
                                  else if indexPath.row == 2{ // event
                                       if arrNotificationCountData[2].count == 0{
                                        cell.lblBadgeCount?.isHidden = true
                                       }else{
                                        cell.lblBadgeCount?.text = "\(arrNotificationCountData[2].count!)"
                                        cell.lblBadgeCount?.isHidden = false

                                       }
                                   }
                                 
                                  else if indexPath.row == 3{ // circular
                        if arrNotificationCountData[1].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[1].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                    }else{
                        cell.lblBadgeCount?.isHidden = true
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
                    
                    
                    else if indexPath.row == 1{ //Notice
                        
                        if arrNotificationCountData[0].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[0].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                       
                     }
                    
                    else if indexPath.row == 2{ // Event
                        
                        if arrNotificationCountData[2].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[2].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                        
                     }
                                                            
                    else if indexPath.row == 3{ // Circular
                        if arrNotificationCountData[1].count == 0{
                            cell.lblBadgeCount?.isHidden = true
                        }else{
                            cell.lblBadgeCount?.text = "\(arrNotificationCountData[1].count!)"
                            cell.lblBadgeCount?.isHidden = false

                        }
                    }else{
                        cell.lblBadgeCount?.isHidden = true
                    }
                    }else{
                        cell.lblBadgeCount?.isHidden = true
                    }
                    
                }
                
                
                return cell
                
            
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
                let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                
                 if(str.contains("society_admin"))
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
                        
                        // temp comment live app 26/11/20.

                       /* let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpDeskVC") as! HelpDeskVC
                        vc.isfrom = 1
                        self.navigationController?.pushViewController(vc, animated: true) */
                    }else{  // DomesticHelpVC
                        // temp comment live app 26/11/20.

                      /* let vc = self.storyboard?.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
                        vc.isfrom = 1
                        self.navigationController?.pushViewController(vc, animated: true) */
                    }
               
                
            }
            
            
        }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        /*   let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
           let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
           let size:CGFloat = (collectionmenu.frame.size.width - space) / 2.0
           return CGSize(width: size, height: size) */
        
        
            let collectionViewWidth = self.view.bounds.width - 10
            return CGSize(width: collectionViewWidth/2 - 2, height: collectionViewWidth/2
                       + 2)
        
           // let collectionWidth = collectionView.bounds.width

          //  return  CGSize(width: collectionWidth/2-8, height: 150)

       }
    
    
    
        

}
