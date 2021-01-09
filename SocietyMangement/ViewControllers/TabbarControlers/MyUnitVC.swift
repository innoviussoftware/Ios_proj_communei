//
//  MyUnitVC.swift
//  SocietyMangement
//
//  Created by MacMini on 05/08/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
import SWRevealViewController
import ScrollPager
import Alamofire


@available(iOS 13.0, *)
@available(iOS 13.0, *)
class MyUnitVC: BaseVC , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , Invite, addedVehicle {
    
    @IBOutlet weak var menuaction: UIButton!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblflatno: UILabel!
    
    @IBOutlet weak var lblflattype: UILabel!
    
    @IBOutlet weak var lbltitle: UILabel!
    
    @IBOutlet weak var btnAddFrequentguest: UIButton!
    @IBOutlet weak var collectionFrequentGuest: UICollectionView!

    @IBOutlet weak var viewStaticAddFrequentGuest: UIView!
    
    @IBOutlet weak var viewStaticAddFrequentGuestMain: UIView!

    @IBOutlet weak var lblAddFrequentguest: UILabel!
    
    @IBOutlet weak var collectionfamily: UICollectionView!
    
    @IBOutlet weak var viewfamilymembers: UIView!

    @IBOutlet weak var collectionVehicle: UICollectionView!
    
    @IBOutlet weak var viewStaticAddVhicle: UIView!
    @IBOutlet weak var lblStaticAddVhicleDetail: UILabel!
    
    @IBOutlet weak var collectionHelper: UICollectionView!

    @IBOutlet weak var helperView: UIView!
    
    @IBOutlet weak var  helperView_Main: UIView!

    @IBOutlet weak var btnaddfamily1: UIButton!
    @IBOutlet weak var btnaddfamily11: UIButton!


    var refreshControl = UIRefreshControl()

    var familymeberary =  [FamilyMember]()

    var arrFrequentGuestData = [GetFrequentEntryListData]()
    
    var arrVehicleList = [VehicleDataUser]() // [VehicleData]()
    
    var arrHelperList = [MyHelperListData]()

    var dailyHelpPropertyID : Int?
    
    var vendorServiceTypeID : Int?
    
    var indexNotifyOnEntry : Int?
    
    var indexService : Int?

    var isFromService = "false"
    
    var isFromNotice = "false"


    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  apicallUserMe()
        
        if(revealViewController() != nil)
        {
            menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }

      //  collectionFrequentGuest.register(UINib(nibName: "FrequentCell", bundle: nil), forCellWithReuseIdentifier: "FrequentCell")


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        apicallUserMe()
        
        if UsermeResponse?.data?.relation == nil {
            btnaddfamily1.isHidden = false
            btnaddfamily11.isHidden = false
        }else{
            btnaddfamily1.isHidden = true
            btnaddfamily11.isHidden = true
        }
        

           NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
        
     //   let strId = String(format: "%d", (UsermeResponse?.data?.guid)!)

           
          // apicallNotificationCount()
          // apicallGuestList()
        
         //  apicallGetFamilyMembers(id: strId)
        
        // 22/10/20. temp comment
      
        if UsermeResponse?.data?.guid != nil {
            apicallGetFamilyMembers(id: (UsermeResponse?.data?.guid)!)
        }

        // 7/11/20. temp comment 2 lines

         //  apicallGetFrequentGuestList()
        
        apicallGetMyHelperList()
           
           // Mark :Check label no data found is hidden or not

          /* if ChangedIndex == 0{
               if arrGuestList.count > 0{
                   lblNoDataFound.isHidden = true
               }else{
                   lblNoDataFound.isHidden = false
               }
               
           }else{
               lblNoDataFound.isHidden = true
           } */
           
       }
    
    @IBAction func actionNotification(_ sender: Any) {
       let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
        vc.isfrom = 0
     }
    
    @IBAction func btnOpenQRCodePressed(_ sender: Any) {
        let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
        vc.isfrom = 0
    }
    
    @IBAction func btnZendeskPressed(_ sender: Any) {
        // let vc =
        _ = self.pushViewController(withName:SupportZendeskVC.id(), fromStoryboard: "Main") as! SupportZendeskVC
    }
    
       override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: nil)
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
            else  if object.value(forKey: "notification_type") as! String == "alert"{
                       
              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DeliveryWaitingPopupVC") as! DeliveryWaitingPopupVC
                
                nextViewController.deliverydic = object

                          //  nextViewController.isFrormDashboard = 0
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
              //  apicallNotificationCount()
                
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
                        UserDefaults.standard.set(resp.data!.professionID, forKey: USER_BUILDING_ID)
                        UserDefaults.standard.synchronize()
                        
                        self.apicallGetVehicleList()
                        
                        UsermeResponse = resp
                      //  self.lbltitle.text = "Welcome, \(resp.data!.name!)"
                        
                        // 22/10/20. temp comment
                      //  self.lbltitle.text = String(format: "%@-%@", UsermeResponse!.data!.society?.propertyID ,UsermeResponse!.data!.society?.parentProperty)
                        
                        self.lbltitle.text = "\(resp.data!.society?.parentProperty ?? "")-\(resp.data!.society?.property ?? "")"

                        
                        self.lblname.text = resp.data!.name
                        if(UsermeResponse?.data!.profilePhotoPath != nil)
                        {
                            self.imgview.sd_setImage(with: URL(string: (UsermeResponse!.data!.profilePhotoPath)!), placeholderImage: UIImage(named: "vendor-1"))
                        }
                        
                        //self.lblflatno.text = "Flat no: \(UsermeResponse!.data.flatNo!)"
                        
                        // 22/10/20. temp comment
                       // self.lblflatno.text = String(format: "Flat No: %@ - %@", UsermeResponse!.data!.society?.propertyID!,UsermeResponse!.data!.society?.parentProperty as! CVarArg)
                        
                     //   self.lblflatno.text = "Flat No: \( UsermeResponse!.data!.society?.property ?? "")"
                        
                        self.lblflatno.text = "Flat No: \(resp.data!.society?.parentProperty ?? "")-\(resp.data!.society?.property ?? "")"

                        
                        self.lblflattype.text = "Contact No: \(UsermeResponse?.data?.phone ?? "")"
                        
                        
                       /* if UsermeResponse?.data?.relation == "self"{
                            self.btnAddFamily.isHidden = false
                            self.btnAddFamilyBottom.isHidden = false
                        }else{
                            self.btnAddFamily.isHidden = true
                            self.btnAddFamilyBottom.isHidden = true
                        } */
                        
                        print(resp)
                    }
                    
                    else if(JSON.response?.statusCode == 401)
                    {
                       
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                            
                        
                        
                    }
                    
                case .failure(let err):
                    webservices().StopSpinner()
                    if statusCode == 401{
                        
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                       
                        return
                    }
                    
                    if err.asAFError == nil {
                        webservices().StopSpinner()
                    }else {
                       // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                      //  self.present(alert, animated: true, completion: nil)
                        print(err.asAFError!)
                    }
                    
                }
            }
        
    }
    
    func AddfamilyActionbtn() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFamilyMemberVC") as! AddFamilyMemberVC
                 navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func AddfamilyAction(_ sender: Any) {
        AddfamilyActionbtn()
    }
    
    @IBAction func AddfamilyAction_view_btn(_ sender: Any) {
        AddfamilyActionbtn()
    }

    @IBAction func AddfamilyAction_btn(_ sender: Any) {
        AddfamilyActionbtn()
    }
    
    // MARK: - get Family Members
    
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
                        //self.lblNoDataFound.isHidden = true
                        if(resp.data!.count == 0)
                        {
                            self.collectionfamily.isHidden = true
                            self.viewfamilymembers.isHidden = false
                            self.view.bringSubview(toFront:self.viewfamilymembers)
                        }
                        else
                        {
                            self.collectionfamily.reloadData()

                            self.collectionfamily.isHidden = false
                            self.viewfamilymembers.isHidden = true
                           // self.viewprofile.bringSubview(toFront:self.collectionfamily)
                            
                        }
                    }
                     
                    else if(JSON.response?.statusCode == 401)
                    {
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                          
                        
                    }
                    
                    else
                    {
                        if(resp.data!.count == 0)
                        {
                            self.collectionfamily.isHidden = true
                            self.viewfamilymembers.isHidden = false
                          //  self.viewprofile.bringSubview(toFront:self.viewfamilymembers)
                            
                        }
                        else
                        {
                            self.collectionfamily.reloadData()

                            self.collectionfamily.isHidden = false
                            self.viewfamilymembers.isHidden = true
                           // self.viewprofile.bringSubview(toFront:self.collectionfamily)
                            
                            
                        }
                        
                    }
                    

                    
                case .failure(let err):
                    
                    if(self.familymeberary.count == 0) || (self.familymeberary.count == 1)
                    {
                        self.collectionfamily.isHidden = true
                        self.viewfamilymembers.isHidden = false
                    }
                    else
                    {
                        self.collectionfamily.isHidden = false
                        self.viewfamilymembers.isHidden = true
                    }
                    
                    if err.asAFError == nil {
                        webservices().StopSpinner()
                    }else {
                       // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       // self.present(alert, animated: true, completion: nil)
                        print(err.asAFError!)
                        webservices().StopSpinner()
                    }
                }
                
            }
            
        
    }
    
    // MARK: - vehicle
    
    @IBAction func AddVehicleAction_view_btn(_ sender: Any) {
        addVehicleActionbtn()
    }
    
    @IBAction func AddVehicleAction(_ sender: Any) {
        addVehicleActionbtn()
    }
    
    @IBAction func addVehicleAction_btn(_ sender: Any) {
        addVehicleActionbtn()
    }

    
    func addVehicleActionbtn()  {
        
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "EntryVehicleDetailPopUpVC") as! EntryVehicleDetailPopUpVC
        popOverConfirmVC.delegate = self
       
        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)

       // tabbarDisbale()

        
    }
    
    func addedNewVehicle() {
        apicallGetVehicleList()
    }
    
    func apicallGetVehicleList()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            Apicallhandler().GetVehicleUserList(URL: webservices().baseurl + API_GET_VEHICLELIST, token:token as! String) { JSON in
                switch JSON.result{
                    
                case .success(let resp):
                    
                    print(resp)
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.arrVehicleList = resp.data!
                                                
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

                    else if(JSON.response?.statusCode == 401)
                    {
                       
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                        
                        
                    }
                    
                case .failure(let err):
                    self.viewStaticAddVhicle.isHidden = false
                    self.lblStaticAddVhicleDetail.isHidden = false
                    self.collectionVehicle.isHidden = true
                    
                    if err.asAFError == nil {
                        webservices().StopSpinner()
                    }else {
                       // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:err.localizedDescription)
                      //  self.present(alert, animated: true, completion: nil)
                        
                        print(err.asAFError!)
                        webservices().StopSpinner()
                    }
                    
                }
                
            }
     
    }
    
     // MARK: -  Add My Helper
    
    
    func btnAddHelperAction() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
        vc.isfrom = 1
        self.navigationController?.pushViewController(vc, animated: true) 
        
        print("btnAddHelperAction new")
    }

    @IBAction func AddHelperAction_view_btn(_ sender: Any) {
         btnAddHelperAction()
     }
     
     @IBAction func AddHelperAction(_ sender: Any) {
         btnAddHelperAction()
     }
     
     @IBAction func addHelperAction_btn(_ sender: Any) {
         btnAddHelperAction()
     }
    
    // MARK: -  Get My Helper List
    
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
                            
                            print("self.arrHelperList : ", self.arrHelperList)
                            
                            if self.arrHelperList.count > 0{
                                self.collectionHelper.dataSource = self
                                self.collectionHelper.delegate = self
                                self.collectionHelper.reloadData()
                              //  self.constrainthelperHight.constant = 175
                              //  self.hightscrollview.constant = 950
                                
                                self.helperView_Main.isHidden = true
                                self.helperView.isHidden = false
                            }else{
                              //  self.constrainthelperHight.constant = 0
                              //  self.hightscrollview.constant = 750
                                
                                self.helperView_Main.isHidden = false
                                self.helperView.isHidden = true

                            }
                            
                            
                          }
                        
                          else if(JSON.response?.statusCode == 401)
                          {
                              
                            UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                            UserDefaults.standard.removeObject(forKey:USER_ID)
                            UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                            UserDefaults.standard.removeObject(forKey:USER_ROLE)
                            UserDefaults.standard.removeObject(forKey:USER_PHONE)
                            UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                            UserDefaults.standard.removeObject(forKey:USER_NAME)
                            UserDefaults.standard.removeObject(forKey:USER_SECRET)
                            UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                            
                                       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                    let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                 let navController = UINavigationController(rootViewController: aVC)
                                                                                 navController.isNavigationBarHidden = true
                                                                    self.appDelegate.window!.rootViewController  = navController
                                                                    
                                
                              
                          }
                      case .failure(let err):
                          
                        if err.asAFError == nil {
                            webservices().StopSpinner()
                        }else {
                          webservices().StopSpinner()
                       //   let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       //   self.present(alert, animated: true, completion: nil)
                          print(err.asAFError!)
                        }
                          
                      }
                  }
                  
             
              
          }

    @IBAction func nextaction(_ sender: Any) {
        let nextvc = self.pushViewController(withName:ProfiledetailVC.id(), fromStoryboard: "Main") as! ProfiledetailVC
        nextvc.isfrom = 2

        
       // self.tabBarController?.present(nextViewController, animated: true, completion: nil)
    //self.tabBarController?.navigationController?.pushViewController(nextViewController, animated: true)

        
         //  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfiledetailVC") as! ProfiledetailVC
          
       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! ProfiledetailVC
        
       // let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfiledetailVC") as! ProfiledetailVC
        
      //  nextViewController.isfrom = 2
        
       // self.tabBarController?.tabBar.isHidden = false

       // let navController = UINavigationController(rootViewController: nextViewController)
      //  navController.isNavigationBarHidden = true
      //  self.appDelegate.window!.rootViewController  = navController
        
     //   navigationController?.pushViewController(nextViewController, animated: true)
           
    }
    
    func btnAddFrequentActionbtn() {
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddguestPopup") as! AddguestPopup
            
        popOverConfirmVC.delegate = self
        
        popOverConfirmVC.isfrom = 0
        
        self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

        
//                  self.addChildViewController(popOverConfirmVC)
//                  popOverConfirmVC.view.frame = self.view.frame
//                  self.view.center = popOverConfirmVC.view.center
//                  self.view.addSubview(popOverConfirmVC.view)
//                  popOverConfirmVC.didMove(toParentViewController: self)
//
//                  tabbarDisbale()

    }
    
    // MARK: -  Get Add Frequent
    
    
    @IBAction func AddFrequentAction(_ sender: Any) {
           btnAddFrequentActionbtn()
    }
    
    @IBAction func AddFrequentAction_view_btn(_ sender: Any) {
           btnAddFrequentActionbtn()
    }
    
    @IBAction func AddFrequentAction_btn(_ sender: Any) {
       btnAddFrequentActionbtn()
    }
    
    
    func inviteaction(from: String) {
        
        let nextViewController = storyboard?.instantiateViewController(withIdentifier: "InviteVC") as! InviteVC
        nextViewController.isfrom = from
        navigationController?.pushViewController(nextViewController, animated: true)
    }

        
     //MARK:- collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      /*  if(collectionView == collectionmenu)
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
        }else{
            return familymeberary.count
        } */
       
       
       if collectionView == collectionFrequentGuest{
           return arrFrequentGuestData.count
       }else if collectionView == collectionVehicle{
           return arrVehicleList.count
       }else if collectionView == collectionHelper{
           return arrHelperList.count
       }else{
           return familymeberary.count
       }

    }
    
    
         func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
             /* if(collectionView == collectionVehicle)
             {
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"VehicleCollectionCell", for: indexPath) as! VehicleCollectionCell
                 
                 if arrVehicleList[indexPath.row].type == "Two Wheeler"{
                     cell.imgVehicle.image = #imageLiteral(resourceName: "Group 271")
                 }
                 
                 if arrVehicleList[indexPath.row].type == "Four Wheeler"{
                     cell.imgVehicle.image = #imageLiteral(resourceName: "cab")
                 }
                 
                 cell.lblVehicleType.text = arrVehicleList[indexPath.row].type
                 cell.lblVehicleNumber.text = arrVehicleList[indexPath.row].number
                 
                 cell.btndelete.tag = indexPath.row
                 cell.btndelete.addTarget(self, action: #selector(deletevehicle), for:.touchUpInside)
                 return cell
                 
                 
                 
                 // 6/8/20.
             
             
                 
             }else */
             if collectionView == collectionFrequentGuest{
                 
               //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"FrequentGuestEntryCell", for: indexPath) as! FrequentGuestEntryCell
     //
     //            cell.lblName.text =  arrFrequentGuestData[indexPath.row].contactName
     //            cell.lblCode.text = arrFrequentGuestData[indexPath.row].code
     //            cell.btnEdit.tag = indexPath.row
     //            cell.btnEdit.isHidden = true
     //            cell.btnCall.tag = indexPath.row
     //            cell.btnDelete.tag = indexPath.row
     //            //cell.imgUser.sd_setImage(with: URL(string: familymeberary[indexPath.row].image!), placeholderImage: UIImage(named: "vendor-1"))
     //            //
     //            cell.btnEdit.addTarget(self, action:#selector(EditFrequentEntry(sender:)), for: .touchUpInside)
     //            cell.btnDelete.addTarget(self, action:#selector(DeleteFrequentEntry(sender:)), for: .touchUpInside)
     //            cell.btnCall.addTarget(self, action:#selector(callFrequentGuestmember(sender:)), for: .touchUpInside)
     //
     //
                 //let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
            
            
          //  let cell : Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell


                 
               //  let cell: FrequentCell = collectionView.dequeueReusableCell(withReuseIdentifier:"FrequentCell", for: indexPath) as! FrequentCell
                    
                    let cell : FrequentCell = collectionView.dequeueReusableCell(withReuseIdentifier:"FrequentCell", for: indexPath) as! FrequentCell

                 
                 // webservices.sharedInstance.setShadow(view:cell.innerview)
                 
                 //cell.lblBadgeCount?.isHidden = true
                 
                cell.lblname.text =  arrFrequentGuestData[indexPath.row].activity?.name
                cell.lblMobilenumber.text = arrFrequentGuestData[indexPath.row].activity?.phone
               //  cell.btnEdit.tag = indexPath.row
                 cell.btnCall.tag = indexPath.row
                 cell.btnDelete.tag = indexPath.row
                 
              
                cell.imguser.image = UIImage(named:"vendor profile")
              
               //  cell.btnEdit.addTarget(self, action:#selector(EditFrequentEntry(sender:)), for: .touchUpInside)
                

                 cell.btnCall.addTarget(self, action:#selector(callFrequentGuestmember(sender:)), for: .touchUpInside)
                  cell.btnDelete.addTarget(self, action:#selector(DeleteFrequentEntry(sender:)), for: .touchUpInside)

               //  cell.widthedit.constant = 0
                 //cell.btnDelete.isHidden = true
                // cell.btnEdit.isHidden = true
                 
                 return cell
                 
             
             }
                
            else if collectionView == collectionHelper{
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HelperDeskCell", for: indexPath) as! HelperDeskCell
                
             
                if arrHelperList[indexPath.row].dailyHelperCard?.profilePic != nil{
                    cell.imgMaid.sd_setImage(with: URL(string: (arrHelperList[indexPath.row].dailyHelperCard?.profilePic)!), placeholderImage: UIImage(named: "vendor profile"))
                 }
                
                cell.btnCall.tag = indexPath.row
                cell.btnCalenderAttend.tag = indexPath.row
                
                cell.btndelete.tag = indexPath.row
                
                cell.btnNotification.tag = indexPath.row
                
                cell.btnService.tag = indexPath.row

                
                let rating = Double((self.arrHelperList[indexPath.row].dailyHelperCard?.averageRating)!)

                cell.ratingView.rating = rating!
                
                cell.lblName.text = arrHelperList[indexPath.row].dailyHelperCard?.name
                
                cell.lblMaidType.text = arrHelperList[indexPath.row].dailyHelperCard?.vendorServiceTypeName
                
                if isFromNotice == "false" {
                    if ((arrHelperList[indexPath.row].dailyHelperCard?.shouldNotifyOnEntry) == 0) {
                         indexNotifyOnEntry = 1
                         cell.btnNotification.setImage(UIImage(named: "ic_notify_no"), for: .normal)  // stop
                    }else{
                        indexNotifyOnEntry = 0
                        cell.btnNotification.setImage(UIImage(named: "ic_notify_yes"), for: .normal) // start
                    }
                }
                
                
                if isFromService == "false" {

                    if ((arrHelperList[indexPath.row].dailyHelperCard?.holdService) == 0) {
                            indexService = 1
                            cell.btnService.setImage(UIImage(named: "ic_hold"), for: .normal)
                    }else{
                        indexService = 0
                        cell.btnService.setImage(UIImage(named: "ic_Continue"), for: .normal)
                    }
                }
                
                // 25/9/20.
                
              //  cell.lblCode.text = arrHelperList[indexPath.row].pin
                
                cell.lblCode.text = "Attendance"

                cell.imgMaid.isUserInteractionEnabled = true
                
         //   let tap = UITapGestureRecognizer()
          //      tap.addTarget(self, action:#selector(tapmaid))
          //      cell.imgMaid.addGestureRecognizer(tap)
                

                
                cell.imgMaid.tag = indexPath.row
                
                cell.btnNotification.addTarget(self, action:#selector(notifyToggleMyDailyHelper(sender:)), for: .touchUpInside)

                
                cell.btnService.addTarget(self, action:#selector(servicesToggleMyDailyHelper(sender:)), for: .touchUpInside)

                
                cell.btnCall.addTarget(self, action:#selector(callMaid(sender:)), for: .touchUpInside)
                
                cell.btnCalenderAttend.addTarget(self, action:#selector(calenderAttendanceMaid(sender:)), for: .touchUpInside)
                
                cell.btndelete.addTarget(self, action:#selector(deleteMyDailyHelper(sender:)), for: .touchUpInside)


                
                return cell
            }
             
            else if(collectionView == collectionVehicle)
                   {
                       let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"VehicleCollectionCell", for: indexPath) as! VehicleCollectionCell
                       
                       if arrVehicleList[indexPath.row].type == "Two Wheeler"{
                           cell.imgVehicle.image = #imageLiteral(resourceName: "Group 271")
                        
                        cell.lblVehicleType.text = "2 Wheeler"
                       }else{
                       
                      // if arrVehicleList[indexPath.row].type == "Four Wheeler"{
                           cell.imgVehicle.image = #imageLiteral(resourceName: "cab")
                        
                        cell.lblVehicleType.text = "4 Wheeler"
                       }
                       
                     //  cell.lblVehicleType.text = arrVehicleList[indexPath.row].type
                       cell.lblVehicleNumber.text = arrVehicleList[indexPath.row].number
                       
                       cell.btndelete.tag = indexPath.row
                       cell.btndelete.addTarget(self, action: #selector(deletevehicle), for:.touchUpInside)
                       return cell
                       
                       
                       
                       
                       
                   }
             
             else {
                 
                 //let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
                 
                 let cell: FamilyCell = collectionView.dequeueReusableCell(withReuseIdentifier:"FamilyCell", for: indexPath) as! FamilyCell
                 
                 
                 // webservices.sharedInstance.setShadow(view:cell.innerview)
                 
                 //cell.lblBadgeCount?.isHidden = true
                 
                 cell.lblname.text =  familymeberary[indexPath.row].name
                 cell.lblMobilenumber.text = familymeberary[indexPath.row].phone
                
                if UsermeResponse?.data?.relation == nil {
                    cell.btnEdit.isHidden = false
                    cell.lblline.isHidden = false
                    cell.lblline1.isHidden = true
                    cell.lblline2.isHidden = false
                    
                    cell.vwCall.isHidden = false
                    cell.vwEdit.isHidden = false
                    cell.vwDelete.isHidden = false

                }else{
                    cell.btnEdit.isHidden = true
                    cell.lblline.isHidden = true
                    cell.lblline1.isHidden = false
                    cell.lblline2.isHidden = true
                    
                    cell.vwCall.isHidden = false
                    cell.vwEdit.isHidden = true
                    cell.vwDelete.isHidden = false
                }
                
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
             
             // 6/8/20.
             /*    else if collectionView == collectionHelper{
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HelperDeskCell", for: indexPath) as! HelperDeskCell
                 
              
                 if arrHelperList[indexPath.row].photos != nil{
                     cell.imgMaid.sd_setImage(with: URL(string: arrHelperList[indexPath.row].photos!), placeholderImage: UIImage(named: "vendor profile"))
                  }
                 
                 cell.btnCall.tag = indexPath.row
                 
                 cell.ratingView.rating = arrHelperList[indexPath.row].averageRating!
                 cell.lblName.text = arrHelperList[indexPath.row].name
                 cell.lblMaidType.text = arrHelperList[indexPath.row].typename
                 cell.lblCode.text = arrHelperList[indexPath.row].pin
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
                 
                 if(familymeberary[indexPath.row].image != nil)
                 {
                 cell.imguser.sd_setImage(with: URL(string: familymeberary[indexPath.row].image!), placeholderImage: UIImage(named: "vendor-1"))
                 }
                 cell.btnEdit.addTarget(self, action:#selector(editmember), for: .touchUpInside)
                 cell.btnCall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
                 
                 cell.btnDelete.addTarget(self, action:#selector(deleteFamilyMember(sender:)), for: .touchUpInside)
                 
                 return cell
             } */
         }
         
         
         func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
             
             
             if(collectionView == collectionHelper)
             {
                 
                 let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MaidProfileDetailsVC") as! MaidProfileDetailsVC
                 nextViewController.HelperId = arrHelperList[indexPath.row].dailyHelperID
                                                               self.navigationController?.pushViewController(nextViewController, animated: true)
                 
                 
                 
                 
             }
             
         }
         
         
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            /* if(collectionView == collectionmenu)
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
             } */
             
            if(collectionView == collectionFrequentGuest){
                return CGSize(width: 248, height:110)
            }else if(collectionView == collectionVehicle){
                return CGSize(width: 130, height:150)
            }else if(collectionView == collectionHelper){
                return CGSize(width: 230, height:158)
            }else{
                return CGSize(width: 248, height:110)
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
                                self.viewStaticAddFrequentGuestMain.isHidden = true  // 2 number view

                                 self.viewStaticAddFrequentGuest.isHidden = false
                                 self.lblAddFrequentguest.isHidden = false
                                 self.collectionFrequentGuest.dataSource = self
                                 self.collectionFrequentGuest.delegate = self
                                 self.collectionFrequentGuest.reloadData()
                             }else{
                                self.viewStaticAddFrequentGuestMain.isHidden = false

                                 self.viewStaticAddFrequentGuest.isHidden = true
                                 self.lblAddFrequentguest.isHidden = true
                                 self.collectionFrequentGuest.isHidden = true
                             }
                             
                             
                             
                         }
                         
                         else if(JSON.response?.statusCode == 401)
                         {
                            
                            UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                            UserDefaults.standard.removeObject(forKey:USER_ID)
                            UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                            UserDefaults.standard.removeObject(forKey:USER_ROLE)
                            UserDefaults.standard.removeObject(forKey:USER_PHONE)
                            UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                            UserDefaults.standard.removeObject(forKey:USER_NAME)
                            UserDefaults.standard.removeObject(forKey:USER_SECRET)
                            UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                            
                                      let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                   let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                let navController = UINavigationController(rootViewController: aVC)
                                                                                navController.isNavigationBarHidden = true
                                                                   self.appDelegate.window!.rootViewController  = navController
                                                                   
                                
                             
                         }
                         
                     case .failure(let err):
                         
                         webservices().StopSpinner()
                         let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                         self.present(alert, animated: true, completion: nil)
                         print(err.asAFError)
                         
                         
                     }
                 }
            
             
         }
    
        @objc func DeleteFrequentEntry(sender:UIButton) {
            let strGuestId = arrFrequentGuestData[sender.tag].activity?.activityID

             //  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
               avc?.titleStr = "Delete Contact"
               avc?.subtitleStr = "Are you sure you want to delete this contact?"
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
                    else if(JSON.response?.statusCode == 401)
                    {
                       
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                              let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                          
                        
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"")
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    
                    if JSON.response?.statusCode == 401{
                       
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                        
                                  let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                           
                        return
                    }
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
            }
    }
    
        @objc func deletevehicle(sender:UIButton)
        {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                             let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                             avc?.titleStr = "Delete Vehicle"
                                             avc?.subtitleStr = "Are you sure you want to delete this vehicle?"
                                             avc?.yesAct = {
                                             
                                                self.ApiCallDeleteVehicle(id: self.arrVehicleList[sender.tag].id)

                                                 }
                                             avc?.noAct = {
                                               print("no delete")
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
    
     @objc func callFrequentGuestmember(sender:UIButton)
        {
                
                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                    avc?.titleStr = "Call"//GeneralConstants.kAppName // "Society Buddy"
                avc?.isfrom = 3

        avc?.subtitleStr = "Are you sure you want to call: \(arrFrequentGuestData[sender.tag].activity?.phone ?? "")"
                                    avc?.yesAct = {
                                        
                                        self.dialNumber(number:(self.arrFrequentGuestData[sender.tag].activity?.phone!)!)

                                                 }
                                    avc?.noAct = {
                                      
                                    }
                                    present(avc!, animated: true)
                    
        
                
            }
        
        

    
    @objc func deleteFamilyMember(sender:UIButton)
    {
            let id =  familymeberary[sender.tag].guid
        
        print("guid :- ",id!)
        //let strId = "\(id)"
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = "Delete Contact"  // "Communei"
            avc?.subtitleStr = "Are you sure you want to delete this contact?"
                // "Are you sure you want to delete this family member?"
            avc?.yesAct = {
                    
                self.apicallDeleteFamilyMember(strId: id!)
                
            }
            avc?.noAct = {
                      
            }
            present(avc!, animated: true)
                    
            
    }
    
    func apicallDeleteFamilyMember(strId:String) {
               if !NetworkState().isInternetAvailable {
                               ShowNoInternetAlert()
                               return
                           }
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
               let param : Parameters = [
                   "guid" : strId
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
    
    @objc func callmember(sender:UIButton)
    {
            
                let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
                avc?.isfrom = 3

        avc?.subtitleStr = "Are you sure you want to call: \(familymeberary[sender.tag].phone ?? "")"
                                avc?.yesAct = {

                                    self.dialNumber(number:self.familymeberary[sender.tag].phone!)

                                             }
                                avc?.noAct = {
                                  
                                }
                                present(avc!, animated: true)
                
    
            
        }
    
    
    
    @objc func editmember(sender:UIButton) {
           
           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
           
           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFamilyMemberVC") as! AddFamilyMemberVC
           nextViewController.isfrom = 1
           nextViewController.member = familymeberary[sender.tag]
           navigationController?.pushViewController(nextViewController, animated: true)
           
    }
    
    // DeleteVehicle
    
    func ApiCallDeleteVehicle(id:Int)
    {
        
        
              if !NetworkState().isInternetAvailable {
                                      ShowNoInternetAlert()
                                      return
                                  }
        
        webservices().StartSpinner()

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        let param : Parameters = [
            "VehicleID" : id
         ]
        
        Apicallhandler.sharedInstance.ApiCallDeleteVehicle(Vehicleid:id, token: token as! String,param: param) { JSON in
                             
                             let statusCode = JSON.response?.statusCode
                             
                             switch JSON.result{
                             case .success(let resp):
                                
                                print(resp)

                                 webservices().StopSpinner()
                                 
                                 if statusCode == 200{
                                  
                                  self.apicallGetVehicleList()
                                  
                                   
                                 }
                                 
                             case .failure(let err):
                                 webservices().StopSpinner()
                                 if statusCode == 401{
                                     
                                    UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                                    UserDefaults.standard.removeObject(forKey:USER_ID)
                                    UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                                    UserDefaults.standard.removeObject(forKey:USER_ROLE)
                                    UserDefaults.standard.removeObject(forKey:USER_PHONE)
                                    UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                                    UserDefaults.standard.removeObject(forKey:USER_NAME)
                                    UserDefaults.standard.removeObject(forKey:USER_SECRET)
                                    UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                                    
                                              let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                                        let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                        let navController = UINavigationController(rootViewController: aVC)
                                                                                        navController.isNavigationBarHidden = true
                                                                           self.appDelegate.window!.rootViewController  = navController
                                                                           
                                     
                                     return
                                 }
                                 
                                 let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                                 self.present(alert, animated: true, completion: nil)
                                 print(err.asAFError as Any)
                                 
                             }
                         }
              
        
        
    }
    
    
    func apicallDeleteMyDailyHelper(DailyHelpPropertyID:Int,VendorServiceTypeID:Int) {
               if !NetworkState().isInternetAvailable {
                    ShowNoInternetAlert()
                    return
                }
        
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
               let param : Parameters = [
                   "DailyHelpPropertyID" : DailyHelpPropertyID,
                    "VendorServiceTypeID" : VendorServiceTypeID
                ]
               
               webservices().StartSpinner()
               Apicallhandler.sharedInstance.ApiCallDeleteHelperList(token: token as! String, param: param) { JSON in
                      
                      let statusCode = JSON.response?.statusCode
                      
                      switch JSON.result{
                      case .success(let resp):
                          //webservices().StopSpinner()
                          self.refreshControl.endRefreshing()
                          if statusCode == 200{
                            self.apicallGetMyHelperList()
                          }
                      case .failure(let err):
                          
                          webservices().StopSpinner()
                          let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                          self.present(alert, animated: true, completion: nil)
                          print(err.asAFError!)
                          
                          
                      }
                  }
                  
          
              
    }
    
    
    @objc func deleteMyDailyHelper(sender:UIButton)
    {
        
         dailyHelpPropertyID = arrHelperList[sender.tag].dailyHelpPropertyID!
        
         vendorServiceTypeID = arrHelperList[sender.tag].vendorServiceTypeID!

            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = "Communei"
            avc?.subtitleStr = "Are you sure you want to unassign this helper?"
                // "Are you sure you want to delete this family member?"
        
            avc?.yesAct = {
                
                self.apicallDeleteMyDailyHelper(DailyHelpPropertyID: self.dailyHelpPropertyID! , VendorServiceTypeID: self.vendorServiceTypeID!)
                
            }
            avc?.noAct = {
                      
            }
            present(avc!, animated: true)
                    
    }
    
    @objc func notifyToggleMyDailyHelper(sender:UIButton)
    {
        dailyHelpPropertyID = arrHelperList[sender.tag].dailyHelpPropertyID!
        
        if ((arrHelperList[sender.tag].dailyHelperCard?.shouldNotifyOnEntry) == 0) {
            if indexNotifyOnEntry == 1 {
                indexNotifyOnEntry = 1
            }else{
                indexNotifyOnEntry = 0
            }
        }
        self.apicallnotifyToggleMyDailyHelper(DailyHelpPropertyID: self.dailyHelpPropertyID! , ShouldNotifyOnEntry: self.indexNotifyOnEntry!)
    }
    
    
    @objc func servicesToggleMyDailyHelper(sender:UIButton)
    {
        dailyHelpPropertyID = arrHelperList[sender.tag].dailyHelpPropertyID!

        if ((arrHelperList[sender.tag].dailyHelperCard?.holdService) == 0) {
            if indexService == 1 {
                indexService = 1
            }else{
                indexService = 0
            }
        }
        self.apicallServicesToggleMyDailyHelper(DailyHelpPropertyID: self.dailyHelpPropertyID! , HoldService: self.indexService!)
    }
    
    func apicallServicesToggleMyDailyHelper(DailyHelpPropertyID:Int,HoldService:Int) {
        if !NetworkState().isInternetAvailable {
             ShowNoInternetAlert()
             return
         }
 
         let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        let param : Parameters = [
            "DailyHelpPropertyID" : DailyHelpPropertyID,
            "HoldService" : indexService!
         ]
        
        print("Service Toggle param", param)

        webservices().StartSpinner()
        Apicallhandler.sharedInstance.ApiCallServiceToggleHelperList(token: token as! String, param: param) { JSON in
               
               let statusCode = JSON.response?.statusCode
               
               switch JSON.result{
               case .success(let resp):
                
                print("resp Services ",resp)
                   //webservices().StopSpinner()
                   self.refreshControl.endRefreshing()
                   if statusCode == 200{
                     self.apicallGetMyHelperList()
                   }
                   else if(statusCode == 401)
                   {
                      
                    UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                    UserDefaults.standard.removeObject(forKey:USER_ID)
                    UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                    UserDefaults.standard.removeObject(forKey:USER_ROLE)
                    UserDefaults.standard.removeObject(forKey:USER_PHONE)
                    UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                    UserDefaults.standard.removeObject(forKey:USER_NAME)
                    UserDefaults.standard.removeObject(forKey:USER_SECRET)
                    UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                    
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                          let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                          let navController = UINavigationController(rootViewController: aVC)
                                                                          navController.isNavigationBarHidden = true
                                                             self.appDelegate.window!.rootViewController  = navController
                                                             
                        
                       
                   }
                
               case .failure(let err):
                   
                   webservices().StopSpinner()
                   let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   self.present(alert, animated: true, completion: nil)
                   print(err.asAFError!)
                   
                   
               }
           }
           
   
       
    }
    
    
    func apicallnotifyToggleMyDailyHelper(DailyHelpPropertyID:Int,ShouldNotifyOnEntry:Int) {
        if !NetworkState().isInternetAvailable {
             ShowNoInternetAlert()
             return
         }
 
         let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        let param : Parameters = [
            "DailyHelpPropertyID" : DailyHelpPropertyID,
            "ShouldNotifyOnEntry" : indexNotifyOnEntry!
         ]
        
        print("Notify Toggle param", param)
        
        webservices().StartSpinner()
        Apicallhandler.sharedInstance.ApiCallNotifyToggleHelperList(token: token as! String, param: param) { JSON in
               
               let statusCode = JSON.response?.statusCode
               
               switch JSON.result{
               case .success(let resp):
                
                print("resp Notify ",resp)

                   //webservices().StopSpinner()
                   self.refreshControl.endRefreshing()
                   if statusCode == 200{
                     self.apicallGetMyHelperList()
                   }
                
                   else if(statusCode == 401)
                   {
                       
                    UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                    UserDefaults.standard.removeObject(forKey:USER_ID)
                    UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                    UserDefaults.standard.removeObject(forKey:USER_ROLE)
                    UserDefaults.standard.removeObject(forKey:USER_PHONE)
                    UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                    UserDefaults.standard.removeObject(forKey:USER_NAME)
                    UserDefaults.standard.removeObject(forKey:USER_SECRET)
                    UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                    
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                          let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                          let navController = UINavigationController(rootViewController: aVC)
                                                                          navController.isNavigationBarHidden = true
                                                             self.appDelegate.window!.rootViewController  = navController
                                                             
                        
                       
                       
                   }
               case .failure(let err):
                   
                   webservices().StopSpinner()
                   let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   self.present(alert, animated: true, completion: nil)
                   print(err.asAFError!)
                   
                   
               }
           }
           
   
       
    }
    
    @objc func calenderAttendanceMaid(sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DomesticHelperAttendanceVC") as! DomesticHelperAttendanceVC
        
        let dailyHelperID = (arrHelperList[sender.tag].dailyHelperCard?.dailyHelperID)!
        nextViewController.dailyHelperID = (dailyHelperID as NSString).integerValue
        nextViewController.strlbl = (arrHelperList[sender.tag].dailyHelperCard?.name)!
        nextViewController.strAddedCalendarDate = (arrHelperList[sender.tag].dailyHelperCard?.addedOn?.components(separatedBy: " ")[0])!
        
        print("nextViewController.strAddedCalendarDate : ",nextViewController.strAddedCalendarDate)

       // nextViewController.isfrom = 0
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func callMaid(sender:UIButton)
      {
                
                    let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                    avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
                    avc?.isfrom = 3

        avc?.subtitleStr = "Are you sure you want to call: \(arrHelperList[sender.tag].dailyHelperCard?.phone ?? "")"
        
                                    avc?.yesAct = {
                                        
                                        self.dialNumber(number:(self.arrHelperList[sender.tag].dailyHelperCard?.phone!)!)

                                            }
        
                                    avc?.noAct = {
                                      
                                    }
                                    present(avc!, animated: true)
                    
        
            }
        
        
    
}
