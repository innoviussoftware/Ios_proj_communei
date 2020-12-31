//
//  NewHomeVC.swift
//  SocietyMangement
//
//  Created by MacMini on 01/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
import SWRevealViewController
import ScrollPager
import Alamofire



var ChangedIndex:Int = 0

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
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)

class HomeVC: UIViewController  , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITableViewDelegate , UITableViewDataSource , Invite,addedVehicle{
    
    @IBOutlet weak var hightscrollview: NSLayoutConstraint!
    
    @IBOutlet var viewactivity: UIView!
    
    @IBOutlet weak var btnOutDummy: UIButton!
    @IBOutlet weak var constrainthelperHight: NSLayoutConstraint!
    
    @IBOutlet weak var lblHelperDetailsStatic: UILabel!
    @IBOutlet weak var collectionHelper: UICollectionView!
    @IBOutlet weak var helperView: UIView!
    
    @IBOutlet weak var viewStaticAddFrequentGuest: UIView!
    @IBOutlet weak var collectionFrequentGuest: UICollectionView!
    
    @IBOutlet weak var lblAddFrequentguest: UILabel!
    @IBOutlet weak var pager: ScrollPager!
    
    @IBOutlet weak var btnAddFrequentguest: UIButton!
    @IBOutlet weak var btnAddFamily: UIButton!
    @IBOutlet weak var collectionfamily: UICollectionView!
    
    @IBOutlet weak var collectiontitle: UICollectionView!
    
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var collectionmenu: UICollectionView!
    
    @IBOutlet weak var viewprofile: UIScrollView!
    
    @IBOutlet weak var menuaction: UIButton!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblflatno: UILabel!
    
    @IBOutlet weak var lblflattype: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var viewStaticAddVhicle: UIView!
    @IBOutlet weak var lblStaticAddVhicleDetail: UILabel!
    
    @IBOutlet weak var btnAddFamilyBottom: UIButton!
    @IBOutlet weak var viewcollection: UIView!
    @IBOutlet weak var viewmembers: UIView!
    
    var arrGuestList = [guestData]()
    var arrFrequentGuestData = [GetFrequentEntryListData]()
    var arrNotificationCountData = [NotificationCountData]()
    
    var arrHelperList = [MyHelperListData]()
    
    @IBOutlet weak var btnNoti: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var viewGuestCollection: UIView!
    @IBOutlet weak var collectionGuest: UICollectionView!
    
    @IBOutlet weak var collectionVehicle: UICollectionView!
    
    
    @IBAction func ViewPastRecordAction(_ sender: Any) {
        
        let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewPastActivityVC") as! ViewPastActivityVC
             
        self.addChildViewController(otpVC)
               self.view.addSubview(otpVC.view)
               let height = self.view.bounds.height
               otpVC.view.frame = CGRect(x: 0, y: height, width: self.view.bounds.width, height: height)
               
               UIView.animate(withDuration: 0.4, animations: {
                   otpVC.view.frame = self.view.bounds
               })
         
        
        
        
    }
    
    
    
    @IBAction func AddfamilyAction(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFamilyMemberVC") as! AddFamilyMemberVC
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func AddGuestAction(_ sender: Any) {
        
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddguestPopup") as! AddguestPopup
        popOverConfirmVC.delegate = self
        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)
        
        
    }
    
    var titieary = ["Activity","Household","Community"]
    var menuary = ["Buildings","Members","Notices","Events","Circulars"]//,"Vendors"]
    var meimagesary = ["ic_building","ic_member","ic_notice","ic_event","ic_circular"]//,"ic_vendor"]
    
    var arrData = ["Members","Notices","Events","Circulars"]//,"Vendors"]
    var arrImage = ["ic_member","ic_notice","ic_event","ic_circular"]//,"ic_vendor"]
    
    var familymeberary = [FamilyMember]()
    var arrVehicleList = [VehicleData]()
    
    var selectedindex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
        
        self.lblNoDataFound.isHidden = true
        
        collectionVehicle.register(UINib(nibName: "VehicleCollectionCell", bundle: nil), forCellWithReuseIdentifier: "VehicleCollectionCell")
       // collectionFrequentGuest.register(UINib(nibName: "FrequentGuestEntryCell", bundle: nil), forCellWithReuseIdentifier: "FrequentGuestEntryCell")
        
        collectionfamily.register(UINib(nibName: "FamilyCell", bundle: nil), forCellWithReuseIdentifier: "FamilyCell")
        
        collectionFrequentGuest.register(UINib(nibName: "FamilyCell", bundle: nil), forCellWithReuseIdentifier: "FamilyCell")

        
        
        //5-11-19
        collectionHelper.register(UINib(nibName: "HelperDeskCell", bundle: nil), forCellWithReuseIdentifier: "HelperDeskCell")
        
        tblview.separatorStyle = .none
        apicallUserMe()
        
        
        pager.addSegmentsWithTitlesAndViews(segments: [
            ("Acitivity", viewactivity),
            ("Household",viewprofile),
            ("Community",collectionmenu)
        ])
        pager.delegate = self
        
        if(revealViewController() != nil)
        {
            menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tblview.addSubview(refreshControl)
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
        apicallNotificationCount()
        apicallGuestList()
        apicallGetFamilyMembers(id: "")
        apicallGetFrequentGuestList()
        apicallGetMyHelperList()
        
        // Mark :Check label no data found is hidden or not

        if ChangedIndex == 0{
            if arrGuestList.count > 0{
                lblNoDataFound.isHidden = true
            }else{
                lblNoDataFound.isHidden = false
            }
            
        }else{
            lblNoDataFound.isHidden = true
        }
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
        
    }
    
    @IBAction func actionNotification(_ sender: Any) {
         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    @objc func refresh(sender:AnyObject) {
        apicallGuestList()
    }
    
    @objc func AcceptRequest(notification: NSNotification) {
        
        let object = notification.object as! NSDictionary
        
        if let key = object.object(forKey: "notification_type")
        {
            let value = object.value(forKey: "notification_type") as! String
            
            if(value == "security")
            {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GuestPopVC") as! GuestPopVC
                nextViewController.guestdic = object
                nextViewController.isfromnotification = 0
                navigationController?.pushViewController(nextViewController, animated: true)
                
            }
            
              else  if object.value(forKey: "notification_type") as! String == "Notice"{
                         
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                              
                              let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                              nextViewController.isFrormDashboard = 0
                              navigationController?.pushViewController(nextViewController, animated: true)
                         
                         
                     }else if object.value(forKey: "notification_type") as! String == "Circular"{
                         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                                              nextViewController.isfrom = 0
                                                              navigationController?.pushViewController(nextViewController, animated: true)
                
                         
                         
                     }else if object.value(forKey: "notification_type") as! String == "Event"{
                         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                                                                           nextViewController.isfrom = 1
                                                                           navigationController?.pushViewController(nextViewController, animated: true)
                
                     }
                
                
                
                
            else
            {
                apicallNotificationCount()
                
            }
            
        }
        
    }
    
    
    func addedNewVehicle() {
        apicallGetVehicleList()
    }
    
    
    func inviteaction(from: String) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "InviteVC") as! InviteVC
        nextViewController.isfrom = from
        navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    @IBAction func nextaction(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfiledetailVC") as! ProfiledetailVC
        nextViewController.isfrom = 2
        navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    @IBAction func actionAdd(_ sender: Any) {
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "EntryVehicleDetailPopUpVC") as! EntryVehicleDetailPopUpVC
        popOverConfirmVC.delegate = self
        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)
        
    }
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if(selectedindex <= 0)
                {
                    
                }
                else
                {
                    selectedindex = selectedindex - 1
                    collectiontitle.reloadData()
                    
                    if selectedindex == 0{
                        
                        self.view.bringSubview(toFront: tblview)
                        tblview.isHidden = false
                        
                        collectionmenu.isHidden = true
                        viewprofile.isHidden = true
                        //self.view.layer.add(swipeTransitionToLeftSide(false), forKey: nil)
                        
                        
                    }else if selectedindex == 1{
                        
                        self.view.bringSubview(toFront: viewprofile)
                        viewprofile.isHidden = false
                        
                        collectionmenu.isHidden = true
                        tblview.isHidden = true
                        
                        //self.view.layer.add(swipeTransitionToLeftSide(false), forKey: nil)
                        
                    }else if selectedindex == 2{
                        
                        
                        self.view.bringSubview(toFront: collectionmenu)
                        collectionmenu.isHidden = false
                        viewprofile.isHidden = true
                        tblview.isHidden = true
                        //self.view.layer.add(swipeTransitionToLeftSide(false), forKey: nil)
                        
                        
                    }else{
                        
                    }
                    
                    
                    
                }
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                
                if(selectedindex >= 2)
                {
                    
                }
                else
                {
                    selectedindex = selectedindex + 1
                    collectiontitle.reloadData()
                    
                    if selectedindex == 0{
                        self.view.bringSubview(toFront: tblview)
                        tblview.isHidden = false
                        
                        collectionmenu.isHidden = true
                        viewprofile.isHidden = true
                        //    self.view.layer.add(swipeTransitionToLeftSide(true), forKey: nil)
                        
                    }else if selectedindex == 1{
                        
                        
                        self.view.bringSubview(toFront: viewprofile)
                        viewprofile.isHidden = false
                        
                        collectionmenu.isHidden = true
                        tblview.isHidden = true
                        // self.view.layer.add(swipeTransitionToLeftSide(true), forKey: nil)
                        
                    }else if selectedindex == 2{
                        
                        self.view.bringSubview(toFront: collectionmenu)
                        collectionmenu.isHidden = false
                        viewprofile.isHidden = true
                        tblview.isHidden = true
                        
                        //  self.view.layer.add(swipeTransitionToLeftSide(true), forKey: nil)
                        
                    }else{
                        
                    }
                    
                }
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    
    func swipeTransitionToLeftSide(_ leftSide: Bool) -> CATransition {
        let transition = CATransition()
        transition.startProgress = 0.0
        transition.endProgress = 1.0
        transition.type = kCATransitionPush
        transition.subtype = leftSide ? kCATransitionFromRight : kCATransitionFromLeft
        transition.duration = 0.3
        
        return transition
    }
    
    @objc func aceeptRequest(sender:UIButton) {
        let strGuestId = arrGuestList[sender.tag].id
        ApiCallAccepGuest(type: 1, guestId: strGuestId!)
        
    }
    
    @objc func DeclineRequest(sender:UIButton) {
        let strGuestId = arrGuestList[sender.tag].id
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                             let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                             avc?.titleStr = "Communei"
                             avc?.subtitleStr = "Are you sure you want to decline entry request?"
                             avc?.yesAct = {
                             
                                           self.ApiCallAccepGuest(type: 2, guestId: strGuestId!)

                              
                                 }
                             avc?.noAct = {
                               
                             }
                             present(avc!, animated: true)
        
        
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to decline entry request?" , preferredStyle: UIAlertController.Style.alert)
//               alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
//                self.ApiCallAccepGuest(type: 2, guestId: strGuestId!)
//               }))
//               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//               self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func DeleteFrequentEntry(sender:UIButton) {
        let strGuestId = arrFrequentGuestData[sender.tag].visitorID

           let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
           avc?.titleStr = "Communei"
           avc?.subtitleStr = "Are you sure you want to delete this record?"
           avc?.yesAct = {
           
               self.ApiCallDeleteFrequentEntry(guestId: strGuestId!)
           }
           avc?.noAct = {
             
           }
           present(avc!, animated: true)
        
        
//
//
//
//        let strGuestId = arrFrequentGuestData[sender.tag].id
//
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to delete this record?" , preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
//            self.ApiCallDeleteFrequentEntry(guestId: strGuestId!)
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
    }
    
    @objc func EditFrequentEntry(sender:UIButton) {
//        let strType = arrFrequentGuestData[sender.tag].type
//        let popup = self.storyboard?.instantiateViewController(withIdentifier: "EditFrequentEntryPopUp") as! EditFrequentEntryPopUp
//        popup.strType = strType!
//        let navigationController = UINavigationController(rootViewController: popup)
//        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        self.present(navigationController, animated: true)
        
        
       }
    
    @objc func DeleteGuest(sender:UIButton) {
        let strType = arrGuestList[sender.tag].type!
        let strId = String(format: "%d", arrGuestList[sender.tag].id!)
        
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure want to delete this record?" , preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
//            self.apicallDeleteGuest(strType: strType, strId: strId)
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                         let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                         avc?.titleStr = "Communei"
                         avc?.subtitleStr = "Are you sure want to delete this record?"
                         avc?.yesAct = {
                         
                                      self.apicallDeleteGuest(strType: strType, strId: strId)

                             }
                         avc?.noAct = {
                           
                         }
                         present(avc!, animated: true)
        
        
        
    }
    
    
    @objc func OutguestByMember(sender:UIButton) {
           let strType = arrGuestList[sender.tag].type!
           let strId = String(format: "%d", arrGuestList[sender.tag].id!)
           let strGurdId = String(format: "%d", arrGuestList[sender.tag].guard_id!)
           let strBuildingId = arrGuestList[sender.tag].buildingname!
           let strFlatId = arrGuestList[sender.tag].flatname!
        
        let date = Date()
        let formater = DateFormatter()
        formater.dateFormat = "dd-MM-yyyy hh:mm a"
        let outTime = formater.string(from: date)
        
           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                      let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                      avc?.titleStr = "Communei"
                                      avc?.subtitleStr = "Are you sure you want to OUT this guest?"
                                      avc?.yesAct = {
                                      
                                                 self.apicallOutMember(strGaurdID: strGurdId, strRequestId: strId, outTime: outTime, userTye: strType, strbuildingID: strBuildingId, strflatID: strFlatId, strType: "")
                                          }
                                      avc?.noAct = {
                                        
                                      }
                                      present(avc!, animated: true)
        
//
//
//           let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to OUT this guest?" , preferredStyle: UIAlertController.Style.alert)
//           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
//
//            self.apicallOutMember(strGaurdID: strGurdId, strRequestId: strId, outTime: outTime, userTye: strType, strbuildingID: strBuildingId, strflatID: strFlatId, strType: "")
//
//           }))
//           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//           self.present(alert, animated: true, completion: nil)
           
       }
    
    
    //MARK:- collection view delegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == collectionmenu)
        {
            
            let cell : Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
            
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            if(str.contains("Secretory") || str.contains("Chairman"))
            {
                cell.lblname.text = menuary[indexPath.row]
                cell.imgview.image = UIImage(named:meimagesary[indexPath.row])
                
                
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
                               
                               if indexPath.row == 3{ // event
                                   if arrNotificationCountData[0].count == 0{
                                    cell.lblBadgeCount?.isHidden = true
                                   }else{
                                    cell.lblBadgeCount?.text = "\(arrNotificationCountData[0].count!)"
                                    cell.lblBadgeCount?.isHidden = false

                                   }
                               }
                if indexPath.row == 4{ // circular
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
            
        } else if(collectionView == collectionVehicle)
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"VehicleCollectionCell", for: indexPath) as! VehicleCollectionCell
            
            if arrVehicleList[indexPath.row].type == "Two Wheeler"{
                cell.imgVehicle.image = #imageLiteral(resourceName: "Group 271")
            }
            
            if arrVehicleList[indexPath.row].type == "Four Wheeler"{
                cell.imgVehicle.image = #imageLiteral(resourceName: "cab")
            }
            
            cell.lblVehicleType.text = arrVehicleList[indexPath.row].type
            cell.lblVehicleNumber.text = arrVehicleList[indexPath.row].dClass
            
            cell.btndelete.tag = indexPath.row
            cell.btndelete.addTarget(self, action: #selector(deletevehicle), for:.touchUpInside)
            return cell
            
            
            
            
            
        }else if collectionView == collectionFrequentGuest{
            
          //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"FrequentGuestEntryCell", for: indexPath) as! FrequentGuestEntryCell
//
//            cell.lblName.text =  arrFrequentGuestData[indexPath.row].contactName
//            cell.lblCode.text = arrFrequentGuestData[indexPath.row].code
//            cell.btnEdit.tag = indexPath.row
//            cell.btnEdit.isHidden = true
//            cell.btnCall.tag = indexPath.row
//            cell.btnDelete.tag = indexPath.row
//            //cell.imgUser.sd_setImage(with: URL(string:webservices().imgurl + familymeberary[indexPath.row].image!), placeholderImage: UIImage(named: "vendor-1"))
//            //
//            cell.btnEdit.addTarget(self, action:#selector(EditFrequentEntry(sender:)), for: .touchUpInside)
//            cell.btnDelete.addTarget(self, action:#selector(DeleteFrequentEntry(sender:)), for: .touchUpInside)
//            cell.btnCall.addTarget(self, action:#selector(callFrequentGuestmember(sender:)), for: .touchUpInside)
//
//
            //let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
            
            let cell: FamilyCell = collectionView.dequeueReusableCell(withReuseIdentifier:"FamilyCell", for: indexPath) as! FamilyCell
            
            
            // webservices.sharedInstance.setShadow(view:cell.innerview)
            
            //cell.lblBadgeCount?.isHidden = true
            
           // cell.lblname.text =  arrFrequentGuestData[indexPath.row].activity
          //  cell.lblMobilenumber.text = arrFrequentGuestData[indexPath.row].code
            cell.btnEdit.tag = indexPath.row
            cell.btnCall.tag = indexPath.row
            cell.btnDelete.tag = indexPath.row
            
         
                cell.imguser.image = UIImage(named:"vendor profile")
         
            cell.btnEdit.addTarget(self, action:#selector(EditFrequentEntry(sender:)), for: .touchUpInside)
            cell.btnCall.addTarget(self, action:#selector(callFrequentGuestmember(sender:)), for: .touchUpInside)
             cell.btnDelete.addTarget(self, action:#selector(DeleteFrequentEntry(sender:)), for: .touchUpInside)

            cell.widthedit.constant = 0
            //cell.btnDelete.isHidden = true
            cell.btnEdit.isHidden = true
            
            return cell
            
        
        }else if collectionView == collectionHelper{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HelperDeskCell", for: indexPath) as! HelperDeskCell
            
         
          /*  if arrHelperList[indexPath.row].photos != nil{
                cell.imgMaid.sd_setImage(with: URL(string: arrHelperList[indexPath.row].photos!), placeholderImage: UIImage(named: "vendor profile"))
             }
            
            cell.btnCall.tag = indexPath.row
            
            cell.ratingView.rating = arrHelperList[indexPath.row].averageRating!
            cell.lblName.text = arrHelperList[indexPath.row].name
            cell.lblMaidType.text = arrHelperList[indexPath.row].typename
            cell.lblCode.text = arrHelperList[indexPath.row].pin */
            cell.imgMaid.isUserInteractionEnabled = true
            
        let tap = UITapGestureRecognizer()
            tap.addTarget(self, action:#selector(tapmaid))
            cell.imgMaid.addGestureRecognizer(tap)
            cell.imgMaid.tag = indexPath.row
            cell.btnCall.addTarget(self, action:#selector(callMaid(sender:)), for: .touchUpInside)
            
            return cell
        }
        else
        {
            
            //let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
            
            let cell: FamilyCell = collectionView.dequeueReusableCell(withReuseIdentifier:"FamilyCell", for: indexPath) as! FamilyCell
            
            
            // webservices.sharedInstance.setShadow(view:cell.innerview)
            
            //cell.lblBadgeCount?.isHidden = true
            
            cell.lblname.text =  familymeberary[indexPath.row].name
            cell.lblMobilenumber.text = familymeberary[indexPath.row].phone
            cell.btnEdit.tag = indexPath.row
            cell.btnCall.tag = indexPath.row
            cell.btnDelete.tag = indexPath.row
            
            if(familymeberary[indexPath.row].profilePhotoPath != nil)
            {
            cell.imguser.sd_setImage(with: URL(string: familymeberary[indexPath.row].profilePhotoPath!), placeholderImage: UIImage(named: "vendor profile"))
            }
            cell.btnEdit.addTarget(self, action:#selector(editmember), for: .touchUpInside)
            cell.btnCall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
            
            cell.btnDelete.addTarget(self, action:#selector(deleteFamilyMember(sender:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == collectionmenu)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            if(str.contains("Secretory") || str.contains("Chairman"))
            {
                return menuary.count
                
            }else{
                return arrData.count
            }
            
            
        }
        else if collectionView == collectionVehicle{
            
            return arrVehicleList.count
        }else if collectionView == collectionFrequentGuest{
            return arrFrequentGuestData.count
        }else if collectionView == collectionHelper{
            return arrHelperList.count
        }
        else{
            return familymeberary.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == collectionmenu)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            if(str.contains("Secretory") || str.contains("Chairman")){
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
            }else{
                if indexPath.item == 0{ //Member
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MembersVC") as! MembersVC
                    vc.isFromDash = 1
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else if indexPath.item == 1{//Notice
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                    vc.isFrormDashboard = 1
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else if indexPath.item == 2{//Events
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                    vc.isfrom = 0
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }else{//Circular
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                    vc.isfrom = 0
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
            
        }
        if(collectionView == collectionHelper)
        {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MaidProfileDetailsVC") as! MaidProfileDetailsVC
          //  nextViewController.HelperId = arrHelperList[indexPath.row].id
                                                          self.navigationController?.pushViewController(nextViewController, animated: true)
            
            
            
            
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == collectionmenu)
        {
            let collectionViewWidth = self.view.bounds.width
            return CGSize(width: collectionViewWidth/2 - 10, height: collectionViewWidth/2
                + 10)
        }else if(collectionView == collectionVehicle){
            return CGSize(width: 170, height:124)
        }else if(collectionView == collectionFrequentGuest){
            return CGSize(width: 220, height:130)
        }else if(collectionView == collectionHelper){
            return CGSize(width: 207, height:172)
        }
        else{
            //let collectionViewWidth = collectionView.bounds.width
            return CGSize(width: 220, height:130)
        }
    }
    @objc func tapmaid(sender:UITapGestureRecognizer)
    {
        
        let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "ImagePopUP") as! ImagePopUP
       // otpVC.imgurl =  arrHelperList[sender.view!.tag].photos!
           self.addChildViewController(otpVC)
                  self.view.addSubview(otpVC.view)
                  let height = self.view.bounds.height
                  otpVC.view.frame = CGRect(x: 0, y: height, width: self.view.bounds.width, height: height)
                  
                  UIView.animate(withDuration: 0.4, animations: {
                      otpVC.view.frame = self.view.bounds
                  })
            
        
        
    }
    @objc func tapguest(sender:UITapGestureRecognizer)
    {
        
        let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "ImagePopUP") as! ImagePopUP
        otpVC.imgurl = arrGuestList[sender.view!.tag].photos!
           self.addChildViewController(otpVC)
                  self.view.addSubview(otpVC.view)
                  let height = self.view.bounds.height
                  otpVC.view.frame = CGRect(x: 0, y: height, width: self.view.bounds.width, height: height)
                  
                  UIView.animate(withDuration: 0.4, animations: {
                      otpVC.view.frame = self.view.bounds
                  })
            
        
        
    }
    
    
    //MARK:- tableView method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return arrGuestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"GuestListCell", for: indexPath) as! GuestListCell
        
        cell.imgUser.layer.cornerRadius =  cell.imgUser.frame.size.height/2
        cell.imgUser.clipsToBounds = true
        
        cell.imgUser.isUserInteractionEnabled = true
                   
               let tap = UITapGestureRecognizer()
                   tap.addTarget(self, action:#selector(tapguest))
                   cell.imgUser.addGestureRecognizer(tap)
                   cell.imgUser.tag = indexPath.row
        //        2019-10-01 05:41:53"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if arrGuestList[indexPath.row].type == "1"{
            if arrGuestList[indexPath.row].inOutFlag == 0{
                
            }else if arrGuestList[indexPath.row].inOutFlag == 1{ //in
                cell.lblTime.isHidden = true
                cell.viewDecline.isHidden = false
                cell.AcceptView.isHidden = false
                cell.lblOutTime.isHidden = true
                cell.btnWaiting.text = "INVITED"
                cell.btnWaiting.backgroundColor = AppColor.appcolor
                cell.lblName.text = arrGuestList[indexPath.row].name
                
                cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                cell.btnGuestWaitingIcon.isHidden = true
                
                
                cell.btnAccept.isHidden = true
                cell.btnOut.isHidden = false
                
                cell.btnDecline.setTitle("Delete", for: .normal)
                cell.btnOut.setTitle("OUT", for: .normal)
                cell.btnOut.backgroundColor = AppColor.orangeColor
                cell.btnOut.layer.cornerRadius = 8
                cell.btnOut.clipsToBounds = true
                
                cell.lblStack.isHidden = false
                cell.btnDecline.tag = indexPath.row
                
                cell.btnOut.tag = indexPath.row
                
                cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
                
                                                    
                cell.btnOut.addTarget(self, action: #selector(OutguestByMember(sender:)), for: .touchUpInside)
                
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                
                var attributedString1 = NSMutableAttributedString()
                
                if arrGuestList[indexPath.row].intime != nil ||  arrGuestList[indexPath.row].intime != ""{
                    cell.lblINTIme.isHidden = false
                    cell.lblGuestWaiting.isHidden = true
                    let dateFormaINOUT = DateFormatter()
                    dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                    //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                    let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                    //let timeInterval = date!.timeIntervalSinceNow
                    //print("=========>\(dayDifference(from: timeInterval))")
                    
                    if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                        let formater = DateFormatter()
                        formater.dateFormat = "hh:mm a"
                        let strIN = formater.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblINTIme.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                    }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                        let format = DateFormatter()
                        format.dateFormat = "hh:mm a"
                        let strIN = format.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblINTIme.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                    }else{
                        dateFormaINOUT.dateFormat = "dd-MMM-yy HH:mm a"
                        let strIN = dateFormaINOUT.string(from: date!)
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblINTIme.attributedText = attributedString1
                        
                        //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                    }
                    
                }else{
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    //cell.lblINTIme.isHidden = true
                    cell.lblGuestWaiting.isHidden = true
                }
                
            }else{ //in and OUT both
                           cell.lblTime.isHidden = true
                           cell.viewDecline.isHidden = false
                           cell.AcceptView.isHidden = true
                           cell.btnWaiting.text = "INVITED"
                cell.btnWaiting.backgroundColor = AppColor.appcolor
                           cell.lblName.text = arrGuestList[indexPath.row].name
                           
                           cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                           cell.btnGuestWaitingIcon.isHidden = true
                           
                           cell.btnDecline.setTitle("Delete", for: .normal)
                           cell.lblStack.isHidden = true
                            cell.btnDecline.tag = indexPath.row
                            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
                           
                           let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                           let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                           
                           var attributedString1 = NSMutableAttributedString()
                           
                           if arrGuestList[indexPath.row].intime != nil || arrGuestList[indexPath.row].intime != "" {
                               cell.lblINTIme.isHidden = false
                               cell.lblGuestWaiting.isHidden = true
                               let dateFormaINOUT = DateFormatter()
                               dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                               //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                               let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                               //let timeInterval = date!.timeIntervalSinceNow
                               //print("=========>\(dayDifference(from: timeInterval))")
                               
                               if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                                   let formater = DateFormatter()
                                   formater.dateFormat = "hh:mm a"
                                   let strIN = formater.string(from: date!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                                   let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                                   attributedString1.append(attributedString2)
                                   cell.lblINTIme.attributedText = attributedString1
                                   
                                   // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                               }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                                   let format = DateFormatter()
                                   format.dateFormat = "hh:mm a"
                                   let strIN = format.string(from: date!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                                   let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                                   attributedString1.append(attributedString2)
                                   cell.lblINTIme.attributedText = attributedString1
                                   
                                   // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                               }else{
                                   dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                                   let strIN = dateFormaINOUT.string(from: date!)
                                   attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                                   let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                                   attributedString1.append(attributedString2)
                                   cell.lblINTIme.attributedText = attributedString1
                                   
                                   //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                               }
                               
                           }else{
                               attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                               let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                               attributedString1.append(attributedString2)
                               cell.lblINTIme.attributedText = attributedString1
                               cell.lblGuestWaiting.isHidden = true
                           }
                           
                           
                           
                           if arrGuestList[indexPath.row].outtime != nil || arrGuestList[indexPath.row].outtime != "" {
                               cell.lblOutTime.isHidden = false
                               cell.lblGuestWaiting.isHidden = true
                               let dateFormaINOUT = DateFormatter()
                               dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                               // dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                               let dates = dateFormaINOUT.date(from: arrGuestList[indexPath.row].outtime!)
                               
                               if dayDifference(from: 0000, date: dates! as NSDate) == "Today"{
                                   let formateee = DateFormatter()
                                   formateee.dateFormat = "hh:mm a"
                                   let strOut = formateee.string(from: dates!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                                   let attributedString3 = NSMutableAttributedString(string:String(format: "Today  %@ ", strOut), attributes:attrs2)
                                   attributedString1.append(attributedString3)
                                   cell.lblOutTime.attributedText = attributedString1
                                   
                                   //cell.lblOutTime.text = String(format: "OUT: %@ Today", strOut)
                               }else if dayDifference(from: 0000, date: dates! as NSDate) == "Yesterday"{
                                   let formateees = DateFormatter()
                                   formateees.dateFormat = "hh:mm a"
                                   let strOut = formateees.string(from: dates!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                                   let attributedString3 = NSMutableAttributedString(string:String(format: "Yesterday  %@ ", strOut), attributes:attrs2)
                                   attributedString1.append(attributedString3)
                                   cell.lblOutTime.attributedText = attributedString1
                                   
                                   //cell.lblOutTime.text = String(format: "OUT: %@ Yesterday", strOut)
                               }else{
                                   dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                                   let strOut = dateFormaINOUT.string(from: dates!)
                                   
                                   attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                                   let attributedString3 = NSMutableAttributedString(string:String(format: "%@", strOut), attributes:attrs2)
                                   attributedString1.append(attributedString3)
                                   cell.lblOutTime.attributedText = attributedString1
                                   //cell.lblOutTime.text = String(format: "OUt: %@", strOut)
                               }
                               
                           }else{
                               attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                               let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                               attributedString1.append(attributedString2)
                               cell.lblOutTime.attributedText = attributedString1
                               //cell.lblOutTime.text = "00:00 PM"
                               cell.lblGuestWaiting.isHidden = true
                           }
            }
            
            
        }else{
        
        if arrGuestList[indexPath.row].flag == 0 && arrGuestList[indexPath.row].inOutFlag == 0{ //IN
             cell.btnAccept.isHidden = false
             cell.btnOut.isHidden = true
            
            cell.lblINTIme.isHidden = false
            cell.lblOutTime.isHidden = true
            cell.lblTime.isHidden = true
            cell.btnDecline.tag = indexPath.row
            cell.btnAccept.tag = indexPath.row
            cell.lblStack.isHidden = false
            cell.btnGuestWaitingIcon.isHidden = false
            cell.lblGuestWaiting.isHidden = false
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = false
            cell.btnWaiting.text = "WAITING"
            cell.lblGuestWaiting.text = "Guest is waiting at gate"
            cell.btnWaiting.backgroundColor = AppColor.appcolor
            cell.lblName.text = arrGuestList[indexPath.row].name
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
            dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
            cell.lblINTIme.text = dateFormatterGet.string(from: date!)
            cell.btnDecline.setTitle("Decline", for: .normal)
            
             cell.btnDecline.removeTarget(self, action: #selector(DeleteGuest(sender:)), for: .allEvents)
             cell.btnAccept.removeTarget(self, action: #selector(OutguestByMember(sender:)), for: .allEvents)
            
            cell.btnAccept.addTarget(self, action: #selector(aceeptRequest(sender:)), for: .touchUpInside)
            cell.btnDecline.addTarget(self, action: #selector(DeclineRequest(sender:)), for: .touchUpInside)
            
        }else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 0{ //approve but not IN
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = true
            cell.btnWaiting.text = "APPROVED"
            cell.btnWaiting.backgroundColor = UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            cell.lblGuestWaiting.isHidden = true
            
             cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.lblStack.isHidden = true
            
            cell.btnDecline.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            
            let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
            dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
            cell.lblINTIme.text = dateFormatterGet.string(from: date!)
            
            cell.lblINTIme.isHidden = false
            cell.lblTime.isHidden = true
            cell.lblOutTime.isHidden = true
           
            
        }else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 1{ //approve and IN
            
            cell.lblTime.isHidden = true
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = false
            cell.lblOutTime.isHidden = true
            cell.btnWaiting.text = "APPROVED"
            cell.btnWaiting.backgroundColor = UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            
            cell.btnAccept.isHidden = true
            cell.btnOut.isHidden = false
            
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.btnOut.setTitle("OUT", for: .normal)
            cell.btnOut.backgroundColor = UIColor(red: 249.0/255.0, green: 164.0/255.0, blue: 49.0/255.0, alpha: 1)
            cell.btnOut.layer.cornerRadius = 8
            cell.btnOut.clipsToBounds = true
            
            
            cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            cell.btnOut.removeTarget(self, action: #selector(aceeptRequest(sender:)), for: .allEvents)
            
            cell.lblStack.isHidden = false
            cell.btnDecline.tag = indexPath.row
            cell.btnOut.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            cell.btnOut.addTarget(self, action: #selector(OutguestByMember(sender:)), for: .touchUpInside)
            
            let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
            let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
            
            var attributedString1 = NSMutableAttributedString()
            
            if arrGuestList[indexPath.row].intime != nil ||  arrGuestList[indexPath.row].intime != ""{
                cell.lblINTIme.isHidden = false
                cell.lblGuestWaiting.isHidden = true
                let dateFormaINOUT = DateFormatter()
                dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                //let timeInterval = date!.timeIntervalSinceNow
                //print("=========>\(dayDifference(from: timeInterval))")
                
                if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                    let formater = DateFormatter()
                    formater.dateFormat = "hh:mm a"
                    let strIN = formater.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                    let format = DateFormatter()
                    format.dateFormat = "hh:mm a"
                    let strIN = format.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                }else{
                    dateFormaINOUT.dateFormat = "dd-MMM-yy HH:mm a"
                    let strIN = dateFormaINOUT.string(from: date!)
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                }
                
            }else{
                
                attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                attributedString1.append(attributedString2)
                cell.lblINTIme.attributedText = attributedString1
                //cell.lblINTIme.isHidden = true
                cell.lblGuestWaiting.isHidden = true
            }
            
            
            
        }else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 2 { //approve and OUT
            cell.lblTime.isHidden = true
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = true
            cell.btnWaiting.text = "APPROVED"
            cell.btnWaiting.backgroundColor = UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            
            cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.lblStack.isHidden = true
            cell.btnDecline.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            
            let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
            let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
            
            var attributedString1 = NSMutableAttributedString()
            
            if arrGuestList[indexPath.row].intime != nil || arrGuestList[indexPath.row].intime != "" {
                cell.lblINTIme.isHidden = false
                cell.lblGuestWaiting.isHidden = true
                let dateFormaINOUT = DateFormatter()
                dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                //let timeInterval = date!.timeIntervalSinceNow
                //print("=========>\(dayDifference(from: timeInterval))")
                
                if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                    let formater = DateFormatter()
                    formater.dateFormat = "hh:mm a"
                    let strIN = formater.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                    let format = DateFormatter()
                    format.dateFormat = "hh:mm a"
                    let strIN = format.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                }else{
                    dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                    let strIN = dateFormaINOUT.string(from: date!)
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblINTIme.attributedText = attributedString1
                    
                    //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                }
                
            }else{
                attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                attributedString1.append(attributedString2)
                cell.lblINTIme.attributedText = attributedString1
                cell.lblGuestWaiting.isHidden = true
            }
            
            
            
            if arrGuestList[indexPath.row].outtime != nil || arrGuestList[indexPath.row].outtime != "" {
                cell.lblOutTime.isHidden = false
                cell.lblGuestWaiting.isHidden = true
                let dateFormaINOUT = DateFormatter()
                dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                // dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                let dates = dateFormaINOUT.date(from: arrGuestList[indexPath.row].outtime!)
                
                if dates != nil{
                    
                if dayDifference(from: 0000, date: dates! as NSDate) == "Today"{
                    let formateee = DateFormatter()
                    formateee.dateFormat = "hh:mm a"
                    let strOut = formateee.string(from: dates!)
                    
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString3 = NSMutableAttributedString(string:String(format: "Today  %@ ", strOut), attributes:attrs2)
                    attributedString1.append(attributedString3)
                    cell.lblOutTime.attributedText = attributedString1
                    
                    //cell.lblOutTime.text = String(format: "OUT: %@ Today", strOut)
                }else if dayDifference(from: 0000, date: dates! as NSDate) == "Yesterday"{
                    let formateees = DateFormatter()
                    formateees.dateFormat = "hh:mm a"
                    let strOut = formateees.string(from: dates!)
                    
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString3 = NSMutableAttributedString(string:String(format: "Yesterday  %@ ", strOut), attributes:attrs2)
                    attributedString1.append(attributedString3)
                    cell.lblOutTime.attributedText = attributedString1
                    
                    //cell.lblOutTime.text = String(format: "OUT: %@ Yesterday", strOut)
                }else{
                    dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                    let strOut = dateFormaINOUT.string(from: dates!)
                    
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString3 = NSMutableAttributedString(string:String(format: "%@", strOut), attributes:attrs2)
                    attributedString1.append(attributedString3)
                    cell.lblOutTime.attributedText = attributedString1
                    //cell.lblOutTime.text = String(format: "OUt: %@", strOut)
                }
                
            }
                
            }else{
                attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                attributedString1.append(attributedString2)
                cell.lblOutTime.attributedText = attributedString1
                //cell.lblOutTime.text = "00:00 PM"
                cell.lblGuestWaiting.isHidden = true
            }
            
            
            
        }else if arrGuestList[indexPath.row].flag == 2{ //Declined
            
            cell.lblTime.isHidden = true
            cell.lblOutTime.isHidden = true
            cell.lblINTIme.isHidden = true
            cell.viewDecline.isHidden = false
            cell.AcceptView.isHidden = true
            cell.btnWaiting.text = "Decline"
            cell.btnWaiting.backgroundColor =  UIColor.red //UIColor(red: 0.0/255.0, green: 138.0/255.0, blue: 6.0/255.0, alpha: 1)
            cell.lblName.text = arrGuestList[indexPath.row].name
            
            cell.imgUser.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
            cell.btnGuestWaitingIcon.isHidden = true
            cell.lblGuestWaiting.isHidden = true
            
             cell.btnDecline.removeTarget(self, action: #selector(DeclineRequest(sender:)), for: .allEvents)
            
            
            cell.btnDecline.setTitle("Delete", for: .normal)
            cell.lblStack.isHidden = true
            cell.btnDecline.tag = indexPath.row
            cell.btnDecline.addTarget(self, action: #selector(DeleteGuest(sender:)), for: .touchUpInside)
            
        }
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if arrGuestList[indexPath.row].type == "1" && arrGuestList[indexPath.row].inOutFlag == 0{
        return 0
     }else{
       return UITableViewAutomaticDimension
    }
    }
    
    
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//         if arrGuestList[indexPath.row].type == "1" && arrGuestList[indexPath.row].inOutFlag == 0{
//            return 0
//         }else{
//           return UITableViewAutomaticDimension
//        }
//
//
//    }
//
    
    @objc func deletevehicle(sender:UIButton)
    {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                         let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                         avc?.titleStr = "Communei"
                                         avc?.subtitleStr = "Are you sure you want to delete this vehicle?"
                                         avc?.yesAct = {
                                         
                                            self.ApiCallDeleteVehicle(id: self.arrVehicleList[sender.tag].id)

                                             }
                                         avc?.noAct = {
                                           
                                         }
                                         present(avc!, animated: true)
           
        
//      // Declare Alert
//            let dialogMessage = UIAlertController(title:Alert_Titel, message: "Are you sure you want to delete this vehicle?", preferredStyle: .alert)
//
//            // Create OK button with action handler
//            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
//                 print("Ok button click...")
//                self.ApiCallDeleteVehicle(id: self.arrVehicleList[sender.tag].id!)
//            })
//
//            // Create Cancel button with action handlder
//            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//                print("Cancel button click...")
//            }
//
//            //Add OK and Cancel button to dialog message
//            dialogMessage.addAction(ok)
//            dialogMessage.addAction(cancel)
//
//            // Present dialog message to user
//            self.present(dialogMessage, animated: true, completion: nil)
        
        
        
        
    }
    
    func ApiCallDeleteVehicle(id:Int)
    {
        
        
              if !NetworkState().isInternetAvailable {
                                      ShowNoInternetAlert()
                                      return
                                  }
        
        webservices().StartSpinner()

        let param : Parameters = [
            "VehicleID" : id
         ]
                         
                         let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        // 26/10/20. know
            //  Apicallhandler.sharedInstance.ApiCallDeleteVehicle(Vehicleid:(id as! NSNumber).stringValue, token: token as! String) { JSON in
            
                Apicallhandler.sharedInstance.ApiCallDeleteVehicle(Vehicleid:id , token: token as! String,param: param) { JSON in

                             
                             let statusCode = JSON.response?.statusCode
                             
                             switch JSON.result{
                             case .success(let resp):
                                 webservices().StopSpinner()
                                 
                                 if statusCode == 200{
                                  
                                  self.apicallGetVehicleList()
                                  
                                   
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
    
    // MARK: - User me
    
    func apicallUserMe()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()

            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
           // Apicallhandler.sharedInstance.ApiCallUserMe(token: token as! String) { JSON in
             
            Apicallhandler().ApiCallUserMe(URL: webservices().baseurl + "user", token: token as! String) { JSON in

                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                   webservices().StopSpinner()
                    
                    if statusCode == 200{
                        
                        // 21/10/20. temp comment

                      /*  UserDefaults.standard.set(resp.data!.societyID, forKey: USER_SOCIETY_ID)
                        UserDefaults.standard.set(resp.data!.id, forKey: USER_ID)
                        UserDefaults.standard.set(resp.data!.role, forKey: USER_ROLE)
                        UserDefaults.standard.set(resp.data!.buildingID, forKey: USER_BUILDING_ID)
                        UserDefaults.standard.synchronize()
                        
                        self.apicallGetVehicleList()
                        
                        UsermeResponse = resp
                        self.lbltitle.text = "Welcome, \(resp.data!.name!)"
                        
                        self.lblname.text = "Hello, \(resp.data!.name)"
                        if(UsermeResponse?.data!.image != nil)
                        {
                            self.imgview.sd_setImage(with: URL(string: (UsermeResponse!.data!.image)!), placeholderImage: UIImage(named: "vendor-1"))
                        }
                        //self.lblflatno.text = "Flat no: \(UsermeResponse!.data.flatNo!)"
                        self.lblflatno.text = String(format: "Flat No: %@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)
                        self.lblflattype.text = "Contact no: \(UsermeResponse!.data!.phone!)"
                        
                        
                        if UsermeResponse?.data?.relation == "self"{
                            self.btnAddFamily.isHidden = false
                            self.btnAddFamilyBottom.isHidden = false
                        }else{
                            self.btnAddFamily.isHidden = true
                            self.btnAddFamilyBottom.isHidden = true
                        } */
                        
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
    
    
    func apicallGuestList()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            webservices().StartSpinner()
        Apicallhandler.sharedInstance.ApiCallGuestList(type:1, token: token as! String) { JSON in
                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    self.refreshControl.endRefreshing()
                    if statusCode == 200{
                        
                        self.arrGuestList = resp.data!
                        if self.arrGuestList.count > 0{
                            self.tblview.dataSource = self
                            self.tblview.delegate = self
                            self.tblview.reloadData()
                            
                            self.lblNoDataFound.isHidden = true

                            
                        }else{
                            self.lblNoDataFound.isHidden = false
                        }
                        
                    }
                case .failure(let err):
                    
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    
                    
                }
            }
            
       
        
    }
    
    
    
    
    func apicallDeleteGuest(strType:String , strId:String)
       {
            if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
               let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            let param : Parameters = [
                "type" : strType,
                "request_id" : strId
             ]
            
            webservices().StartSpinner()
            Apicallhandler.sharedInstance.ApiCallDeleteGuest(token: token as! String, param: param) { JSON in
                   
                   let statusCode = JSON.response?.statusCode
                   
                   switch JSON.result{
                   case .success(let resp):
                       //webservices().StopSpinner()
                       self.refreshControl.endRefreshing()
                       if statusCode == 200{
                        self.apicallGuestList()
                       }
                   case .failure(let err):
                       
                       webservices().StopSpinner()
                       let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       self.present(alert, animated: true, completion: nil)
                       print(err.asAFError)
                       
                       
                   }
               }
               
       
           
       }
    
    
    func apicallDeleteFamilyMember(strId:String)
          {
               if !NetworkState().isInternetAvailable {
                               ShowNoInternetAlert()
                               return
                           }
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
               let param : Parameters = [
                   "id" : strId
                ]
               
               webservices().StartSpinner()
               Apicallhandler.sharedInstance.ApiCallDeleteFamilyMember(token: token as! String, param: param) { JSON in
                      
                      let statusCode = JSON.response?.statusCode
                      
                      switch JSON.result{
                      case .success(let resp):
                          //webservices().StopSpinner()
                          self.refreshControl.endRefreshing()
                          if statusCode == 200{
                            self.apicallGetFamilyMembers(id: "")
                            
                          }
                      case .failure(let err):
                          
                          webservices().StopSpinner()
                          let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                          self.present(alert, animated: true, completion: nil)
                          print(err.asAFError)
                          
                          
                      }
                  }
                  
          
              
          }
    
    
    
    
    
    
    func apicallOutMember(strGaurdID:String,strRequestId:String,outTime:String,userTye:String,strbuildingID:String,strflatID:String,strType:String)
       {
            if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
            let societyID = UserDefaults.standard.value(forKey: USER_SOCIETY_ID)
            let param : Parameters = [
                "type" : "2",
                "request_id" : strRequestId,
                "outtime" : outTime,
                "user_type" : userTye,
                "society_id" : "\(societyID!)",
                "guard_id" : strGaurdID,
                "building_id" : strbuildingID,
                "flat_id" : strflatID
               
             ]
            
            webservices().StartSpinner()
            Apicallhandler.sharedInstance.ApiCallOUTMember(token:"", param: param) { JSON in
                   
                   let statusCode = JSON.response?.statusCode
                   
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if (JSON.result.value as! NSDictionary).value(forKey:"status") as! Int == 1{
                        self.apicallGuestList()
                       } else if (JSON.result.value as! NSDictionary).value(forKey:"status") as! Int == 0 {
//                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
//                        self.present(alert, animated: true, completion: nil)
                        
                        let alert = UIAlertController(title: Alert_Titel, message:(JSON.result.value as! NSDictionary).value(forKey:"message") as? String, preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                            self.apicallGuestList()
                        }))
                        // show the alert
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }
                   case .failure(let err):
                       
                       webservices().StopSpinner()
                       let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       self.present(alert, animated: true, completion: nil)
                       print(err.asAFError as Any)
                       
                   }
               }
        
       }
    
    
    
    
    func apicallGetMyHelperList()
          {
              if !NetworkState().isInternetAvailable {
                               ShowNoInternetAlert()
                               return
                           }
                  
               let token = UserDefaults.standard.value(forKey: USER_TOKEN)
              
               webservices().StartSpinner()
                Apicallhandler.sharedInstance.ApiCallMyHelperList(token: token as! String) { JSON in
                      
                      let statusCode = JSON.response?.statusCode
                      
                      switch JSON.result{
                      case .success(let resp):
                          webservices().StopSpinner()
                          if statusCode == 200{
                           
                            self.arrHelperList = resp.data!
                            
                            
                            if self.arrHelperList.count > 0{
                                self.collectionHelper.dataSource = self
                                self.collectionHelper.delegate = self
                                self.collectionHelper.reloadData()
                                self.constrainthelperHight.constant = 175
                                self.hightscrollview.constant = 950
                                
                                self.helperView.isHidden = false
                            }else{
                                self.constrainthelperHight.constant = 0
                                self.hightscrollview.constant = 750
                                
                                self.helperView.isHidden = true
                            }
                            
                            
                          }
                      case .failure(let err):
                          
                          webservices().StopSpinner()
                          let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                          self.present(alert, animated: true, completion: nil)
                          print(err.asAFError)
                          
                          
                      }
                  }
                  
             
              
          }
          
       
    
       
    
    
    // MARK: - Delete circulars
    func ApiCallAccepGuest(type:Int,guestId : Int)
    {
        
        let strGuestId = (guestId as NSNumber).stringValue
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().ApiAcceptGuestRequest(URL: webservices().baseurl + API_ACCEPT_DECLINE, token: token as! String,type: type, guest_id: strGuestId) { JSON in
                switch JSON.result{
                case .success(let resp):
                     webservices().StopSpinner()
                    
                    if(resp.status == 1)
                    {
                        self.apicallGuestList()
                    }else if (resp.status == 0){
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    
                    if JSON.response?.statusCode == 401{
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
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
     
    }
    
    
    // MARK: - Delete circulars
    func ApiCallDeleteFrequentEntry(guestId : Int)
    {
        let strGuestId = (guestId as NSNumber).stringValue
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().ApiDeleteFrequentEntry(URL: webservices().baseurl + API_DELETE_FREQUENTGUEST_ENTRY, token: token as! String, guest_id: strGuestId) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    if(JSON.response?.statusCode == 200)
                    {
                        self.apicallGetFrequentGuestList()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"")
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    
                    if JSON.response?.statusCode == 401{
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
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
            }
    }
    
    
    // MARK: - get Notices
    
    func apicallGetVehicleList()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            Apicallhandler().GetVehicleList(URL: webservices().baseurl + API_GET_VEHICLELIST, token:token as! String) { JSON in
                switch JSON.result{
                    
                case .success(let resp):
                    
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.arrVehicleList = resp.data
                        if self.arrVehicleList.count > 0{
                            self.collectionVehicle.isHidden = false
                            self.viewStaticAddVhicle.isHidden = true
                            self.lblStaticAddVhicleDetail.isHidden = true
                            self.collectionVehicle.dataSource = self
                            self.collectionVehicle.delegate = self
                            self.collectionVehicle.reloadData()
                        }else{
                            self.viewStaticAddVhicle.isHidden = false
                            self.lblStaticAddVhicleDetail.isHidden = false
                            self.collectionVehicle.isHidden = true
                        }
                        
                    }
                    else
                    {
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    self.viewStaticAddVhicle.isHidden = false
                    self.lblStaticAddVhicleDetail.isHidden = false
                    self.collectionVehicle.isHidden = true
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
     
    }
    
    
    
    func apicallGetFrequentGuestList()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            webservices().StartSpinner()
            Apicallhandler.sharedInstance.ApiCallGetFrequentguestList(token: token as! String) { JSON in
                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if statusCode == 200{
                        self.arrFrequentGuestData = resp.data!
                        
                        if self.arrFrequentGuestData.count > 0{
                            self.viewStaticAddFrequentGuest.isHidden = true
                            self.lblAddFrequentguest.isHidden = true
                            self.collectionFrequentGuest.dataSource = self
                            self.collectionFrequentGuest.delegate = self
                            self.collectionFrequentGuest.reloadData()
                        }else{
                            self.viewStaticAddFrequentGuest.isHidden = false
                            self.lblAddFrequentguest.isHidden = false
                            self.collectionFrequentGuest.isHidden = true
                        }
                        
                        
                        
                    }
                    
                    
                case .failure(let err):
                    
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    
                    
                }
            }
       
        
    }
    
    func apicallNotificationCount()
       {
           if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
        
           /*    let token = UserDefaults.standard.value(forKey: USER_TOKEN)

               webservices().StartSpinner()
            
            Apicallhandler.sharedInstance.GetNotifyCount(URL: webservices().baseurl + API_NOTIFY_COUNT, token: token as! String) { JSON in
            
                   let statusCode = JSON.response?.statusCode
                   
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if statusCode == 200{
                           
                        self.arrNotificationCountData = resp.data
                        self.collectionmenu.delegate = self
                        self.collectionmenu.dataSource = self
                        self.collectionmenu.reloadData()
                        
                       }
                       
                   case .failure(let err):
                       
                       webservices().StopSpinner()
                       let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       self.present(alert, animated: true, completion: nil)
                       print(err.asAFError)
                       
                       
                   }
               }
               
          */
           
       }
    
    
    
    
    
    
    // MARK: - get Members
    
    func apicallGetFamilyMembers(id:String)
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            webservices().StartSpinner()
            
            
            Apicallhandler().APIGetFamilyMember(URL: webservices().baseurl + API_GET_FAMAILY_MEMBER, token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.familymeberary = resp.data!
                        
                        self.lblNoDataFound.isHidden = true
                        self.collectionfamily.reloadData()
                        if(resp.data!.count == 0)
                        {
                            self.viewcollection.isHidden = true
                            self.viewmembers.isHidden = false
                            self.view.bringSubview(toFront:self.viewmembers)
                        }
                        else
                        {
                            self.viewcollection.isHidden = false
                            self.viewmembers.isHidden = true
                            self.viewprofile.bringSubview(toFront:self.viewcollection)
                            
                        }
                    }
                        
                    else
                    {
                        if(resp.data!.count == 0)
                        {
                            self.viewcollection.isHidden = true
                            self.viewmembers.isHidden = false
                            self.viewprofile.bringSubview(toFront:self.viewmembers)
                            
                        }
                        else
                        {
                            self.viewcollection.isHidden = false
                            self.viewmembers.isHidden = true
                            self.viewprofile.bringSubview(toFront:self.viewcollection)
                            
                            
                            
                        }
                        
                    }
                    
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
        
    }
    
    //MARK:- cutome method for call and edit
    
    @objc func callmember(sender:UIButton)
    {
        dialNumber(number:familymeberary[sender.tag].phone!)
    }
    
    @objc func callFrequentGuestmember(sender:UIButton)
    {
        dialNumber(number:(arrFrequentGuestData[sender.tag].activity?.phone!)!)
    }
    
    @objc func editmember(sender:UIButton)
    {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFamilyMemberVC") as! AddFamilyMemberVC
        nextViewController.isfrom = 1
        nextViewController.member = familymeberary[sender.tag]
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    @objc func callMaid(sender:UIButton)
       {
          // dialNumber(number:arrHelperList[sender.tag].mobile!)
       }
    
    @objc func deleteFamilyMember(sender:UIButton)
    {
        
        
             let id =  familymeberary[sender.tag].guid
        let strId = "\(id)"
               // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                avc?.titleStr = "Communei"
                avc?.subtitleStr = "Are you sure you want to delete this family member?"
                avc?.yesAct = {
                
                    self.apicallDeleteFamilyMember(strId: strId)
                }
                avc?.noAct = {
                  
                }
                present(avc!, animated: true)
                
        
        
        
//
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to delete this family member?" , preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
//            self.apicallDeleteFamilyMember(strId: strId)
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    
    func dayDifference(from interval : TimeInterval , date : NSDate) -> String
    {
        let calendar = Calendar.current
        //let date = Date(timeIntervalSinceNow: interval)
        if calendar.isDateInYesterday(date as Date) { return "Yesterday" }
        else if calendar.isDateInToday(date as Date) { return "Today" }
        else if calendar.isDateInTomorrow(date as Date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date as Date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(-day) days ago" }
            else { return "In \(day) days" }
        }
    }
    
    
}



@available(iOS 13.0, *)
extension HomeVC : ScrollPagerDelegate{
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        
        ChangedIndex = changedIndex
        if changedIndex == 0{
            if arrGuestList.count > 0{
                lblNoDataFound.isHidden = true
            }else{
                lblNoDataFound.isHidden = false
            }
            
        }else{
            lblNoDataFound.isHidden = true
        }
    }
    
    
}
