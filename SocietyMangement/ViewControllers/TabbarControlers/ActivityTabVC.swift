//
//  ActivityTabVC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 16/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

import SWRevealViewController

var UsermeResponse:UserMeResponse?

var BuidigResponse:BuidingResponse?


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ActivityTabVC: BaseVC , addSingleDate , addMultiDate , addDeliveryMultiDate, addLeaveNoteGuard  {
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var menuaction: UIButton!

    @IBOutlet weak var filtrview: UIView!

    @IBOutlet weak var collectionActivity: UICollectionView!

    var arrSelectionCheck = NSMutableArray()
    
  //  var selectedindex = Int()
    var selectedindex:Int?

    var userActIndex:Int?
    
    var selectedColorNo:Int?



    var arrActivity = [UserActivityType]()
    //NSMutableArray()
    
  // var activityGroupAry = [UserActivityType]()
    // ["Visitor","Delivery","Cab","Service Provider","Daily Helper","On Demand Help","Parcel Collection"]

    var arrGuestList = [UserActivityAll]()
    //[guestData]()
    
    @IBOutlet weak var message: UILabel!

   // var message = UILabel()
    var refreshControl = UIRefreshControl()
    
    // MARK: - get Activity Types
    
    func apicallGetActivitytypes()
    {
        
        
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                    }
        
           let strToken = UserDefaults.standard.value(forKey: USER_TOKEN)! as! String
            
            webservices().StartSpinner()
        
        Apicallhandler().GetAllActivitytypes(URL: webservices().baseurl + API_USER_ACTIVITYTYPES, token:strToken) { JSON in
        
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    
                    {
                        self.arrActivity = resp.data!

                        if(resp.data!.count == 0)
                        {
                            self.filtrview.isHidden = true
                            self.collectionActivity.isHidden = true

                            
                        }
                        else
                        {
                            self.collectionActivity.dataSource = self
                            self.collectionActivity.delegate = self
                            self.collectionActivity.reloadData()

                            self.collectionActivity.isHidden = false
                            self.filtrview.isHidden = false
                            
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
                          //  self.filtrview.isHidden = true
                    }
                    
                    print(resp)
                case .failure(let err):

                    if err.asAFError == nil {
                        webservices().StopSpinner()
                    }else {
                        webservices().StopSpinner()
                //    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                 //   self.present(alert, animated: true, completion: nil)
                        print(err.asAFError!)
                   
                    }
                }
                
            }
            
       
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
   //  tabBarItem = UITabBarItem(title: "Activity", image: UIImage(named: "ic_activity_selected"), selectedImage: UIImage(named: "ic_activity_unselected"))
        
        if(revealViewController() != nil) {
            menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                   
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
                   
            print("revealViewController auto")

        }
        
       // self.tblview.isHidden = true

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tblview.addSubview(refreshControl)
                
        tblview.estimatedRowHeight = 110.0
        tblview.rowHeight = UITableViewAutomaticDimension
        
        selectedColorNo = 0

        filtrview.isHidden = true
        
      //  setUpFilterActivityView()
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left, verticalAlignment: .center)
               
        collectionActivity.collectionViewLayout = alignedFlowLayout
        
        /*
        message.text = "No Data Found"
        message.translatesAutoresizingMaskIntoConstraints = false
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.textAlignment = .center
        message.textColor = UIColor(named:"Orange")
        message.font = UIFont(name: "Gotham-Black", size: 18)
        self.view.addSubview(message)
        
        message.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        message.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        message.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true */
        
        message.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filtrview.isHidden = true
      //  DispatchQueue.main.async {
            self.apicallUserMe()
            self.apicallGuestList()
      //  }
      
    }
    
    @objc func refresh(sender:AnyObject) {
        apicallGuestList()
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
    
   
    
    /*
     func setUpFilterActivityView() {
        
        let dict = NSMutableDictionary()
        dict.setValue("Visitor", forKey: "activity_grp")
        dict.setValue("0", forKey: "is_selected")
        arrActivity.add(dict)
        
        let dict1 = NSMutableDictionary()
        dict1.setValue("Delivery", forKey: "activity_grp")
        dict1.setValue("0", forKey: "is_selected")
        arrActivity.add(dict1)
        
        let dict2 = NSMutableDictionary()
        dict2.setValue("Cab", forKey: "activity_grp")
        dict2.setValue("0", forKey: "is_selected")
        arrActivity.add(dict2)
        
        
        let dict3 = NSMutableDictionary()
        dict3.setValue("Service Provider", forKey: "activity_grp")
        dict3.setValue("0", forKey: "is_selected")
        arrActivity.add(dict3)
        
        let dict4 = NSMutableDictionary()
        dict4.setValue("Daily Helper", forKey: "activity_grp")
        dict4.setValue("0", forKey: "is_selected")
        arrActivity.add(dict4)
        
        let dict5 = NSMutableDictionary()
        dict5.setValue("On Demand Help", forKey: "activity_grp")
        dict5.setValue("0", forKey: "is_selected")
        arrActivity.add(dict5)
        
        let dict6 = NSMutableDictionary()
        dict6.setValue("Parcel Collection", forKey: "activity_grp")
        dict6.setValue("0", forKey: "is_selected")
        arrActivity.add(dict6)
        
    } */
    
    @IBAction func btnFilterOpenView(_ sender: Any) {
        apicallGetActivitytypes()

        filtrview.isHidden = false

    }
    
    @IBAction func btnClosefilter(_ sender: UIButton) {
        filtrview.isHidden = true
    }
    
    @IBAction func btnApplyfilteraction(_ sender: UIButton) {
        
        selectedColorNo = 0
        
        if userActIndex != nil {
            let userAct = String(format: "%d", userActIndex!)
            apicallUseractivityFilter(userActInd: userAct)
        }
        
        filtrview.isHidden = true
    }
    
    @IBAction func btnResetaction(_ sender: UIButton) {
       // arrSelectionCheck.removeAllObjects()
        
        selectedColorNo = 1
        
        apicallGuestList()

        collectionActivity.reloadData()
        filtrview.isHidden = true
    }
    
    @IBAction func btnDateOpenView(_ sender: UIButton) {
        filtrview.isHidden = true
    }
           
    func apicallGuestList()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        webservices().StartSpinner()
        
        Apicallhandler.sharedInstance.ApiCallUserActivityList(token: token as! String) { JSON in
            
            let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200{
                    
                    self.arrGuestList = resp.data!
                    if self.arrGuestList.count > 0{
                                                
                        self.tblview.isHidden = false

                        self.tblview.dataSource = self
                        self.tblview.delegate = self
                        self.tblview.reloadData()
                        
                        self.message.isHidden = true
                        
                    }else{
                        self.message.isHidden = false
                        self.tblview.isHidden = true
                        
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
                            
                     
                   // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                    
                }
                    if err.asAFError == nil {
                        webservices().StopSpinner()
                    }else {
                        webservices().StopSpinner()
                        print(err.asAFError!)
                    }
            }
            
            
            
        }
    }
    
    @objc func aceeptRequest(sender:UIButton) {
        let strGuestId = arrGuestList[sender.tag].userActivityID
        ApiCallAccepGuest(type: 1, guestId: strGuestId!)
    }
    
    @objc func DeclineRequest(sender:UIButton) {
        let strGuestId = arrGuestList[sender.tag].userActivityID
        
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  GeneralConstants.kAppName   // "Society Buddy"
        avc?.subtitleStr = "Are you sure you want to decline entry request?"
        avc?.yesAct = {
            
            self.ApiCallAccepGuest(type: 2, guestId: strGuestId!)
            
            
        }
        avc?.noAct = {
            
        }
        present(avc!, animated: true)
        
        
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
                print(err.asAFError!)
                webservices().StopSpinner()
                
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
    
    func strChangeDateFormate(strDateeee: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "dd MMM"
            return  dateFormatter.string(from: date!)

        }
    
    func strChangeTimeFormate(strDateeee: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "hh:mm a"
            return  dateFormatter.string(from: date!)

        }
    
   /* func strChangeDateFormate(strDateeee:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM"
        let strDate = formatter.date(from: strDateeee)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "dd-MMM"
            str = formatter.string(from: strDate!)
        }else{
            str = strDateeee
        }
        
        return str
     
    } */
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        view.setNeedsLayout() // loop creation
//        tblview.setNeedsLayout()
//    }
    
    
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
                    UserDefaults.standard.set(resp.data!.society?.societyID, forKey: USER_SOCIETY_ID)
                    UserDefaults.standard.set(resp.data!.guid, forKey: USER_ID)
                    UserDefaults.standard.set(resp.data!.role, forKey: USER_ROLE)
                   // UserDefaults.standard.set(resp.data!.buildingID, forKey: USER_BUILDING_ID)
                    UserDefaults.standard.synchronize()
                    UsermeResponse = resp
                    self.lblname.text = "Welcome, \(resp.data!.name ?? "")"
                    
                  //  self.lblname.text = resp.data!.name
                    
                    // 22/10/20. temp comment
                    
                  //  self.lblname.text = String(format: "%@-%@", UsermeResponse!.data!.society!,UsermeResponse!.data!.society?.property!)
                    
                    self.lblname.text = "\(resp.data!.society?.parentProperty ?? "")-\(resp.data!.society?.property ?? "")"

                    if(UsermeResponse?.data!.profilePhotoPath != nil)
                    {
                        
                    }
                    //self.lblflatno.text = "Flat no: \(UsermeResponse!.data.flatNo!)"
                    
                    
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
                    webservices().StopSpinner()

                   // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                }
                
               
                
            }
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
    
    
    @objc func OutguestByMember(sender:UIButton) {
        
       /* let strType = arrGuestList[sender.tag].type!
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
        avc?.titleStr = GeneralConstants.kAppName   // "Society Buddy"
        avc?.subtitleStr = "Are you sure you want to OUT this guest?"
        avc?.yesAct = {
            
            self.apicallOutMember(strGaurdID: strGurdId, strRequestId: strId, outTime: outTime, userTye: strType, strbuildingID: strBuildingId, strflatID: strFlatId, strType: "")
        }
        avc?.noAct = {
            
        }
        present(avc!, animated: true) */
        
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
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated
//    }
}

@available(iOS 13.0, *)
extension ActivityTabVC: UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrActivity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell:UserCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! UserCell
            
         
          //  cell.lblname.text = (arrActivity[indexPath.row] as! NSMutableDictionary).value(forKey: "activity_grp") as? String

        cell.lblname.text = arrActivity[indexPath.row].activityName
            
          //  if((arrActivity[indexPath.row] as! NSMutableDictionary).value(forKey: "is_selected") as? String == "1")
       // if(arrSelectionCheck.contains(arrActivity[indexPath.row].activityName!))
        
        if selectedColorNo == 1 {
            cell.bgViw.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
        }
        else if(selectedindex == indexPath.row){
                cell.bgViw.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 1/255, alpha: 1.0)

                userActIndex = arrActivity[indexPath.row].userActivityTypeID
            }else{
                cell.bgViw.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
              //  userActIndex = 0
            }
        
       // print("userActIndex :- ",userActIndex!)
            
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
        let contentNSString = arrActivity[indexPath.row].activityName
        let expectedLabelSize = contentNSString!.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15.0)], context: nil)
        
        print("\(expectedLabelSize)")
        return CGSize(width:expectedLabelSize.size.width + 45, height: expectedLabelSize.size.height + 12) //31
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
          //  arrSelectionCheck.removeAllObjects()
           // collectionProfession.reloadData()
            
        
       /* if arrSelectionCheck.contains(arrActivity[indexPath.row].activityName!){
            arrSelectionCheck.remove(arrActivity[indexPath.row].activityName!)
        }else{
            arrSelectionCheck.add(arrActivity[indexPath.row].activityName!)
        } */
        
      /*  if (arrActivity[indexPath.row].activityName as! String).value(forKey: "is_selected") as? String == "0"{
                
                let dict = arrActivity[indexPath.row] as! NSMutableDictionary
                dict.setValue("1", forKey: "is_selected")
                arrActivity.replaceObject(at: indexPath.row, with: dict)
                
            }else{
                
                let dict = arrActivity[indexPath.row] as! NSMutableDictionary
                dict.setValue("0", forKey: "is_selected")
                arrActivity.replaceObject(at: indexPath.row, with: dict)
                
            } */
        
        selectedColorNo = 0
        
        selectedindex = indexPath.row

            
            //selectedbloodgrop = bloodgroupary[indexPath.row]
            collectionActivity.reloadData()
        
    }
    
  //  user/activity/4
    
    // MARK: - User activity Filter
    
//    func apicallUseractivityFilter(userActInd:Int) {
//
//        // userActIndex
//    }
    
    func apicallUseractivityFilter(userActInd:String) {
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        webservices().StartSpinner()
            
        Apicallhandler.sharedInstance.ApiCallUserActivityListFilter(UserActivityTypeID: userActInd, token: token as! String) { JSON in
                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    self.refreshControl.endRefreshing()
                    if statusCode == 200{
                        
                        self.arrGuestList = resp.data!
                        if self.arrGuestList.count > 0{
                            self.tblview.isHidden = false
                            
                            self.tblview.dataSource = self
                            self.tblview.delegate = self
                            self.tblview.reloadData()
                            
                            self.message.isHidden = true
                            
                        }else{
                            self.message.isHidden = false
                            self.tblview.isHidden = true
                            
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
                    
                    if JSON.response?.statusCode == 401{
                        
                        webservices().StopSpinner()
                       
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
                                
                            
                           
                       // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                      //  self.present(alert, animated: true, completion: nil)
                        print(err.asAFError!)
                        
                    }
                    
                    if err.asAFError == nil {
                        webservices().StopSpinner()
                    }else {
                        webservices().StopSpinner()
                        print(err.asAFError!)
                    }
                }
                
                
                
            }
            
       
    }

    
    @objc func callmember(sender:UIButton)
    {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
        avc?.subtitleStr = "Are you sure you want to call: \((arrGuestList[sender.tag].activity?.phone )!)"
        avc?.isfrom = 3

                                   avc?.yesAct = {
                                    self.dialNumber(number:  (self.arrGuestList[sender.tag].activity?.phone)!)

                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
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
    
    // MARK: - Api Edit delegate
    
    func addedSingleDate() {
        apicallGuestList()
    }
    
    func addedMultiDate() {
        apicallGuestList()
    }
    
    func addedDeliveryMultiDate()  {
        apicallGuestList()
    }
    
    
    // MARK: - Api Close
    
    func ApiCallCloseList(UserActivityID:Int ,VisitFlatPreApprovalID : Int)
    {
              
        filtrview.isHidden = true

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "UserActivityID" : UserActivityID,
            "VisitFlatPreApprovalID" : VisitFlatPreApprovalID
        ]
        
        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + API_ACTIVITY_CLOSE ,token: token as! String, param: param) { JSON in
                    
        let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                //webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200
                {
                    self.apicallGuestList()
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(resp as AnyObject).message ?? "")
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
                
                
               // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
              //  self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                webservices().StopSpinner()
                
            }
            
        }
        
    }
    
    @objc func ApiCallClose(sender:UIButton)
    {
        self.ApiCallCloseList(UserActivityID: self.arrGuestList[sender.tag].userActivityID!, VisitFlatPreApprovalID: (self.arrGuestList[sender.tag].activity?.visitorPreApprovalID!)!)
    }
    
    func addedLeaveNoteGuard() {
        apicallGuestList()
    }
    
    @objc func ApiCallNote_to_Guard(sender:UIButton)
    {
        filtrview.isHidden = true

        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "LeaveNoteGuardVC") as! LeaveNoteGuardVC
        
        popOverConfirmVC.delegate = self
        
        popOverConfirmVC.userActivityID = self.arrGuestList[sender.tag].userActivityID!
        popOverConfirmVC.visitingFlatID = self.arrGuestList[sender.tag].visitingFlatID!

        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)
    
        
    }
    
    // MARK: - Api AlertInfo

    @objc func ApiCallAlertInfo(sender:UIButton) {
        
        filtrview.isHidden = true
        
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AlertInfoVC") as! AlertInfoVC
         
        popOverConfirmVC.strName = (arrGuestList[sender.tag].activity?.messageBy!)!
        
        if arrGuestList[sender.tag].activity?.ActivityType  == "Emergency Alert " {
            popOverConfirmVC.strTitle = (arrGuestList[sender.tag].activity?.propertyFullName!)!

        }else if arrGuestList[sender.tag].activity?.ActivityType  == "Complaint to Guard" {
            popOverConfirmVC.strTitle = (arrGuestList[sender.tag].activity?.propertyFullName!)!
        }else{ // Message to Guard
            popOverConfirmVC.strTitle = (arrGuestList[sender.tag].activity?.propertyFullName!)!
        }
        
       // popOverConfirmVC.strTitle = (arrGuestList[sender.tag].activity?.propertyFullName!)!
        
       // popOverConfirmVC.strTime = (arrGuestList[sender.tag].inTime!)
        
        let lblDate = arrGuestList[sender.tag].inTime?.components(separatedBy: " ")[0]
        let strDate = strChangeDateFormate(strDateeee: lblDate!)
        
        let lblTime = arrGuestList[sender.tag].inTime?.components(separatedBy: " ")[1]
        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

        popOverConfirmVC.strTime =  strTime + " , " + strDate


        if arrGuestList[sender.tag].activity?.ActivityType  == "Emergency Alert " {
            popOverConfirmVC.strMessage = (arrGuestList[sender.tag].activity?.emergencyAlertType!)!
        }else if arrGuestList[sender.tag].activity?.ActivityType  == "Complaint to Guard" {
            popOverConfirmVC.strMessage = (arrGuestList[sender.tag].activity?.complaintType!)!
        }else{
            popOverConfirmVC.strMessage = "Message"
        }
        
        popOverConfirmVC.strtxtview = (arrGuestList[sender.tag].activity?.message!)!

        if (arrGuestList[sender.tag].activity?.messageAttachment!) != nil {
            let str = (arrGuestList[sender.tag].activity?.messageAttachment)!
            let array = str.components(separatedBy: ",")
            popOverConfirmVC.getImage = array[0]
        }
        
        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)
        
    }
    
    // MARK: - Api Edit
    

        
    @objc func ApiCallEdit(sender:UIButton)
    {
        
       filtrview.isHidden = true

      /*  if self.arrGuestList[sender.tag].activity?.ActivityType! == "Visitor Entry" {
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 1
                
               if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    let strDate = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                
                    popOverConfirmVC.strStartDate = strDate!
                }
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    
                    let lblTime = arrGuestList[sender.tag].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     popOverConfirmVC.StrTime = strTime
                 }
                 
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
            
        }else if self.arrGuestList[sender.tag].activity?.ActivityType! == "Visitor Pre-Approval" {
            if arrGuestList[sender.tag].activity?.isMulti == "0" { // single
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
                
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 1
                
               if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    let strDate = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                
                 // let strTime = arrGuestList[sender.tag].activity?.activityIn?.components(separatedBy: " ")[1]
                  // let strDate = strChangeDateFormate(strDateeee: lblDate!)
                
                    popOverConfirmVC.strStartDate = strDate!
                   // popOverConfirmVC.StrTime = strTime!

                }
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    // let strTime = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[1]
                    
                    let lblTime = arrGuestList[sender.tag].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     popOverConfirmVC.StrTime = strTime
                 }
                 
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
                
            }else if arrGuestList[sender.tag].activity?.isMulti == "1" { // Multi
                          
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "MultiEditDateVC") as! MultiEditDateVC
                popOverConfirmVC.delegate = self
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    
                //  let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                    
                    let lblin = arrGuestList[sender.tag].activity?.activityIn?.components(separatedBy: " ")[0]
                   
                    let strIn = strChangeDateFormate(strDateeee: lblin!)
                    
                    popOverConfirmVC.strStartDate = strIn
                }
                
                if (arrGuestList[sender.tag].activity?.out) != nil {
                 // let out = arrGuestList[sender.tag].activity?.out!.components(separatedBy:" ")[0]
                    
                    let lblout = arrGuestList[sender.tag].activity?.out?.components(separatedBy: " ")[0]
                    
                    let strOut = strChangeDateFormate(strDateeee: lblout!)
                    popOverConfirmVC.StrEndDate = strOut
                }
               
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID!
                
                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)

            }
        }else if self.arrGuestList[sender.tag].activity?.ActivityType! == "Delivery Pre-Approval" {
            if arrGuestList[sender.tag].activity?.isMulti == "0" { // single
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 2
                
               if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                     let activityInTime = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[1]

                     popOverConfirmVC.StrTime = activityInTime!
                 }
                 
                popOverConfirmVC.singleDeliveryCheckGate = (arrGuestList[sender.tag].activity?.leaveAtGate)!
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
                
            }else if arrGuestList[sender.tag].activity?.isMulti == "1" { // Multi
                          
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryMultiEditDateVC") as! DeliveryMultiEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 2

                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                  let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.out) != nil {
                  let out = arrGuestList[sender.tag].activity?.out!.components(separatedBy:" ")[0]
                    popOverConfirmVC.StrEndDate = out!
                }
                
                if (arrGuestList[sender.tag].activity?.allowedInTime) != nil {
                  let activityIn = arrGuestList[sender.tag].activity?.allowedInTime!
                    popOverConfirmVC.strStartTime = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.allowedOutTime) != nil {
                  let out = arrGuestList[sender.tag].activity?.allowedOutTime!
                    popOverConfirmVC.strEndTime = out!
                }
               
                popOverConfirmVC.multiDeliveryCheckGate = (arrGuestList[sender.tag].activity?.leaveAtGate)!
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID!
                
                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)

            }
        }else if self.arrGuestList[sender.tag].activity?.ActivityType! == "Delivery Entry" {
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 2
                
               if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                     let activityInTime = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[1]

                     popOverConfirmVC.StrTime = activityInTime!
                 }
                 
                popOverConfirmVC.singleDeliveryCheckGate = (arrGuestList[sender.tag].activity?.leaveAtGate)!
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
                
        }else if self.arrGuestList[sender.tag].activity?.ActivityType! == "Cab Entry" {
            
            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
            popOverConfirmVC.delegate = self
            
            popOverConfirmVC.isfrom = 3
            
           if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
            
                popOverConfirmVC.strStartDate = activityIn!
            }
            
            if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                 let activityInTime = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[1]

                 popOverConfirmVC.StrTime = activityInTime!
             }
             
            popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
            popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
            popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

            self.addChildViewController(popOverConfirmVC)
            popOverConfirmVC.view.frame = self.view.frame
            self.view.center = popOverConfirmVC.view.center
            self.view.addSubview(popOverConfirmVC.view)
            popOverConfirmVC.didMove(toParentViewController: self)
            
        }else if self.arrGuestList[sender.tag].activity?.ActivityType! == "Cab Pre-Approval" {
            if arrGuestList[sender.tag].activity?.isMulti == "0" { // single
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 3
                
               if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                     let activityInTime = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[1]

                     popOverConfirmVC.StrTime = activityInTime!
                 }
                 
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
                
            }else if arrGuestList[sender.tag].activity?.isMulti == "1" { // Multi
                          
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryMultiEditDateVC") as! DeliveryMultiEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 3
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                  let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.out) != nil {
                  let out = arrGuestList[sender.tag].activity?.out!.components(separatedBy:" ")[0]
                    popOverConfirmVC.StrEndDate = out!
                }
                
                if (arrGuestList[sender.tag].activity?.allowedInTime) != nil {
                  let activityIn = arrGuestList[sender.tag].activity?.allowedInTime!
                    popOverConfirmVC.strStartTime = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.allowedOutTime) != nil {
                  let out = arrGuestList[sender.tag].activity?.allowedOutTime!
                    popOverConfirmVC.strEndTime = out!
                }
               
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID!
                
                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)

            }
        }else if self.arrGuestList[sender.tag].activity?.ActivityType! == "Service Provider Pre-Approval" {
         //  else if  ((arrGuestList[sender.tag].activity?.ActivityType!.contains("Service Provider")) != nil)

            if arrGuestList[sender.tag].activity?.isMulti == "0" { // single
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 3
                
               if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                     let activityInTime = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[1]

                     popOverConfirmVC.StrTime = activityInTime!
                 }
                 
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
                
            }else if arrGuestList[sender.tag].activity?.isMulti == "1" { // Multi
                          
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryMultiEditDateVC") as! DeliveryMultiEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 3
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                  let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.out) != nil {
                  let out = arrGuestList[sender.tag].activity?.out!.components(separatedBy:" ")[0]
                    popOverConfirmVC.StrEndDate = out!
                }
                
                if (arrGuestList[sender.tag].activity?.allowedInTime) != nil {
                  let activityIn = arrGuestList[sender.tag].activity?.allowedInTime!
                    popOverConfirmVC.strStartTime = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.allowedOutTime) != nil {
                  let out = arrGuestList[sender.tag].activity?.allowedOutTime!
                    popOverConfirmVC.strEndTime = out!
                }
               
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID!
                
                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)

            }else{
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
                popOverConfirmVC.delegate = self
                
                popOverConfirmVC.isfrom = 3
                
               if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                    let activityIn = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
                
                    popOverConfirmVC.strStartDate = activityIn!
                }
                
                if (arrGuestList[sender.tag].activity?.activityIn) != nil {
                     let activityInTime = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[1]

                     popOverConfirmVC.StrTime = activityInTime!
                 }
                 
                popOverConfirmVC.VisitFlatPreApprovalID = arrGuestList[sender.tag].activity?.visitorPreApprovalID!
                popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
                popOverConfirmVC.VisitorEntryTypeID = self.arrGuestList[sender.tag].visitorEntryTypeID! //1

                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
                
            }
        } */
        
    }
    
    
    @objc func ApiCallEdit_OnDemand(sender:UIButton)
    {
        filtrview.isHidden = true

        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleEditDateVC") as! SingleEditDateVC
        popOverConfirmVC.delegate = self
        
        popOverConfirmVC.isfrom = 4
        
       if (arrGuestList[sender.tag].activity?.activityIn) != nil {
            let strDate = arrGuestList[sender.tag].activity?.activityIn!.components(separatedBy:" ")[0]
        
            popOverConfirmVC.strStartDate = strDate!
        }
        
        if (arrGuestList[sender.tag].activity?.activityIn) != nil {
            
            let lblTime = arrGuestList[sender.tag].activity?.activityIn?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

             popOverConfirmVC.StrTime = strTime
         }
        
        let dailyHelpPropertyID = (self.arrGuestList[sender.tag].activity?.dailyHelpPropertyID!)
        
        let my_DailyHelpPropertyID = (dailyHelpPropertyID! as NSString).integerValue

        popOverConfirmVC.UserActivityID = self.arrGuestList[sender.tag].userActivityID!
        popOverConfirmVC.DailyHelpPropertyID = my_DailyHelpPropertyID

        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)
    
        
    }
    
    @objc func ApiCallIn_OnDemand(sender:UIButton)
    {
        
        filtrview.isHidden = true

        let dailyHelpPropertyID = (self.arrGuestList[sender.tag].activity?.dailyHelpPropertyID!)
        
        let my_DailyHelpPropertyID = (dailyHelpPropertyID! as NSString).integerValue
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "UserActivityID" : self.arrGuestList[sender.tag].userActivityID!,
            "DailyHelpPropertyID" : my_DailyHelpPropertyID
        ]

        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + API_ACTIVITY_EXIT_OUT ,token: token as! String, param: param) { JSON in
            
        let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                //webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200
                {
                    self.apicallGuestList()
                }
                else
                {
                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(resp as AnyObject).message ?? "")
                   // self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()

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
                
                
               // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
              //  self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
            }
            
        }
        
    }
    
    
    
    // MARK: - Api Cancel
    
    func ApiCallCancelList(UserActivityID:Int,VisitorEntryTypeID : Int,VisitFlatPreApprovalID : Int)
    {
                
        filtrview.isHidden = true

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "UserActivityID" : UserActivityID,
            "VisitorEntryTypeID" : VisitorEntryTypeID,
            "VisitFlatPreApprovalID" : VisitFlatPreApprovalID
        ]
        
        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + API_ACTIVITY_CANCEL ,token: token as! String, param: param) { JSON in
                    
        let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                //webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200
                {
                    self.apicallGuestList()
                }
                else
                {
                   // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(resp as AnyObject).message ?? "")
                 //   self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()

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
    
    @objc func ApiCallCancel(sender:UIButton)
    {
        
        filtrview.isHidden = true

        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Cancel"
        avc?.subtitleStr = "Are you sure you want to cancel this visitor enry?"

                                   avc?.yesAct = {
                                    
                                    if self.arrGuestList[sender.tag].activity?.visitorPreApprovalID != nil {
                                        self.ApiCallCancelList(UserActivityID: self.arrGuestList[sender.tag].userActivityID!, VisitorEntryTypeID: 1, VisitFlatPreApprovalID: (self.arrGuestList[sender.tag].activity?.visitorPreApprovalID!)!)
                                    }
                                    
                                   // self.dialNumber(number: <#T##String#>)
                                    
                                   // self.dialNumber(number:  (self.arrGuestList[sender.tag].activity?.phone)!)

                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
    }
    
    @objc func ApiCallCancel_OnDemand(sender:UIButton)
    {
        
        filtrview.isHidden = true

        let dailyHelpPropertyID = (self.arrGuestList[sender.tag].activity?.dailyHelpPropertyID!)
        
        let my_DailyHelpPropertyID = (dailyHelpPropertyID! as NSString).integerValue

        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Cancel"
        avc?.subtitleStr = "Are you sure you want to cancel this visitor enry?"

                                   avc?.yesAct = {
                                    
                                        self.ApiCallCancelList_OnDemand(UserActivityID: self.arrGuestList[sender.tag].userActivityID!, DailyHelpPropertyID: my_DailyHelpPropertyID)
                                    
                                   // self.dialNumber(number: <#T##String#>)
                                    
                                   // self.dialNumber(number:  (self.arrGuestList[sender.tag].activity?.phone)!)

                                        }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
        
    }
    
    func ApiCallCancelList_OnDemand(UserActivityID:Int,DailyHelpPropertyID : Int)
    {
         
        filtrview.isHidden = true

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "UserActivityID" : UserActivityID,
            "DailyHelpPropertyID" : DailyHelpPropertyID,
        ]
        
        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + API_ACTIVITY_CANCEL_ON_DEMAND ,token: token as! String, param: param) { JSON in
                    
        let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                //webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200
                {
                    self.apicallGuestList()
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(resp as AnyObject).message ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()

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
    
    
    // MARK: - Api Out/exit
    
    func ApiCallOutList(UserActivityID:Int,VisitorEntryTypeID : Int,VisitingFlatID : Int,GuardActivityID : Int)
    {
        
        filtrview.isHidden = true

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "UserActivityID" : UserActivityID,
            "VisitorEntryTypeID" : VisitorEntryTypeID,
            "VisitingFlatID" : VisitingFlatID,
            "GuardActivityID" : GuardActivityID
        ]

        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + API_ACTIVITY_EXIT_OUT ,token: token as! String, param: param) { JSON in
            
        let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                //webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200
                {
                    self.apicallGuestList()
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(resp as AnyObject).message ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()

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
                
                
               // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
              //  self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
            }
            
        }
        
    }
    
    @objc func ApiCallOut_Exit(sender:UIButton)
    {
        filtrview.isHidden = true

        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Out"
        avc?.subtitleStr = "Are you sure you want to out this visitor entry?"

                                   avc?.yesAct = {
                                    
                                    if self.arrGuestList[sender.tag].visitingFlatID != nil {
                                        self.ApiCallOutList(UserActivityID: self.arrGuestList[sender.tag].userActivityID!, VisitorEntryTypeID: 1, VisitingFlatID: (self.arrGuestList[sender.tag].visitingFlatID!), GuardActivityID: (self.arrGuestList[sender.tag].guardActivityID!))
                                    }
                                    
                                   // self.dialNumber(number: <#T##String#>)
                                    
                                   // self.dialNumber(number:  (self.arrGuestList[sender.tag].activity?.phone)!)

                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
    }
    
    // MARK: - Api Out/exit
    
    func ApiCallOutList_onDemand(UserActivityID:Int,DailyHelpPropertyID : Int)
    {
        filtrview.isHidden = true

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "UserActivityID" : UserActivityID,
            "DailyHelpPropertyID" : DailyHelpPropertyID,
        ]

        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + API_ACTIVITY_EXIT_OUT ,token: token as! String, param: param) { JSON in
            
        let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                //webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200
                {
                    self.apicallGuestList()
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(resp as AnyObject).message ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()

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
                
                
               // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
              //  self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
            }
            
        }
        
    }
    
    @objc func ApiCallOut_Exit_OnDemand(sender:UIButton)
    {
        filtrview.isHidden = true

        let dailyHelpPropertyID = (self.arrGuestList[sender.tag].activity?.dailyHelpPropertyID!)
        
        let my_DailyHelpPropertyID = (dailyHelpPropertyID! as NSString).integerValue
        
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Out"
        avc?.subtitleStr = "Are you sure you want to out this visitor entry?"

                                   avc?.yesAct = {
                                    
                                    if self.arrGuestList[sender.tag].visitingFlatID != nil {
                                        self.ApiCallOutList_onDemand(UserActivityID: self.arrGuestList[sender.tag].userActivityID!, DailyHelpPropertyID: my_DailyHelpPropertyID)
                                    }
                                    
                                   // self.dialNumber(number: <#T##String#>)
                                    
                                   // self.dialNumber(number:  (self.arrGuestList[sender.tag].activity?.phone)!)

                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
    }
    
    
    // MARK: - Api wrong-entry
    
    func ApiCallwrong_entryList(UserActivityID:Int)
    {
              
        filtrview.isHidden = true

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        webservices().StartSpinner()
        
        let param : Parameters = [
            "UserActivityID" : UserActivityID,
        ]

        Apicallhandler().ApiCallUserActivityListcancel(URL: webservices().baseurl + API_ACTIVITY_WRONG_ENTRY ,token: token as! String, param: param) { JSON in
            
        let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                //webservices().StopSpinner()
                self.refreshControl.endRefreshing()
                if statusCode == 200
                {
                    self.apicallGuestList()
                }
                else
                {
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(resp as AnyObject).message ?? "")
                    self.present(alert, animated: true, completion: nil)
                }
                
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()
                
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
                
                
               // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
              //  self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
            }
            
        }
        
    }
    
    @objc func ApiCallWrong_Entry(sender:UIButton)
    {
        
        filtrview.isHidden = true

        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Wrong_Entry"
        avc?.subtitleStr = "Are you sure you want to out this Wrong Entry?"

                                   avc?.yesAct = {
                                    
                                    if self.arrGuestList[sender.tag].userActivityID != nil {
                                        self.ApiCallwrong_entryList(UserActivityID: self.arrGuestList[sender.tag].userActivityID!)
                                    }
                                    
                                   // self.dialNumber(number: <#T##String#>)
                                    
                                   // self.dialNumber(number:  (self.arrGuestList[sender.tag].activity?.phone)!)

                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
    }
    
}


@available(iOS 13.0, *)
extension ActivityTabVC:UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrGuestList.count

    /*  if self.arrGuestList.count > 10 {
            return 10 // self.arrGuestList.count // 10 //
        }else{
            return self.arrGuestList.count
        } */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
        
       /* if arrGuestList[indexPath.row].activity?.name != nil {
            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
        } */
        
        if arrGuestList[indexPath.row].userActivityID != nil {
            
        }
        
        
//       if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
//            cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
//            cell.imgviewCompanyLogo.isHidden = false
//        }else{
//            cell.imgviewCompanyLogo.isHidden = true
//        }
        
        if arrGuestList[indexPath.row].activity?.phone != nil {
            cell.btncall.isHidden = false
        }else{
            cell.btncall.isHidden = true
        }
        
        if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Visitor Entry" {
           
            cell.lblguest.text = "Visitor"
            
            if arrGuestList[indexPath.row].activity?.name != nil {
                 cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            }else{
                cell.lblname.text = ""
            }

            cell.lblStatus.isHidden = false
            
            cell.imgviewCompanyLogo.isHidden = true

            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }else{
                cell.imgview.sd_setImage(with: URL(string: "vendor-1"), placeholderImage: UIImage(named: "vendor-1"))
            }
            
            
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lbldateintime.text =  strTime + " , " + strDate
                        cell.lbldateintime.isHidden = false
                }else{
                    cell.lbldateintime.isHidden = true
                }
            
            
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                cell.lbladdedby.isHidden = false
            }else {
                cell.lbladdedby.isHidden = true
            }
           
           cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
           
           if cell.lblStatus.text == "NOT RESPONDED" {
               cell.lblStatus.backgroundColor = AppColor.deniedColor
            
           /* if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    cell.lblintime.isHidden = false
            }else{
                cell.lblintime.isHidden = true
            } */
            
                
           
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            
                         
            cell.lblWrongEntry.text = "No Response"


                   // 13/1/20 temp comment
                   
                 /*  cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 0
                 cell.imgviewHight3.constant = 12
                   cell.imgviewHight4.constant = 0
                   cell.imgviewHight5.constant = 0
                   cell.imgviewHight6.constant = 0
                 cell.imgviewHight7.constant = 0
                 cell.imgviewHight8.constant = 0
                 cell.imgviewHightExtra.constant = 0
                    */
                
                   cell.imgview1.isHidden = true
                   cell.imgview2.isHidden = false
                   cell.imgview3.isHidden = true
                   cell.imgview4.isHidden = true
                   cell.imgview5.isHidden = true
                   cell.imgview6.isHidden = true
                   cell.imgview7.isHidden = true
                   cell.imgview8.isHidden = false
                   cell.imgviewExtra.isHidden = true
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = 81.5
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5

            
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = true
            
            cell.lblWrongEntry.isHidden = false
            cell.lblintime.isHidden = false
            
            cell.lbldateintime.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = true
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true

            cell.btnWrong_Entry.isHidden = false
            cell.btnWrong_Entry_Red.isHidden = true

               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "DENIED" {
            cell.lblStatus.backgroundColor = AppColor.deniedColor
         
           /* if arrGuestList[indexPath.row].activity?.activityIn != nil {
                 let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblintime.text =  strTime + " , " + strDate
                 cell.lblintime.isHidden = false
             }else{
                 cell.lblintime.isHidden = true
             } */
            

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            
                           
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lblWrongEntry.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            }else {
                cell.lblWrongEntry.text = "denied by "
            }

                // 13/1/20 temp comment
                
              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
              cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
              cell.imgviewHight7.constant = 0
              cell.imgviewHight8.constant = 0
              cell.imgviewHightExtra.constant = 0
                 */
             
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = 81.5
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5

         
         cell.constraintHightStackBtn.constant = 50
         cell.constraintHightStacklbl.constant = 0.5
         cell.lblHightStacklblMiddle.isHidden = true
         
         cell.lblWrongEntry.isHidden = false
         cell.lblintime.isHidden = false
         
         cell.lbldateintime.isHidden = true
         cell.lbldateintimeMulti.isHidden = true // Extra
         cell.lblouttime.isHidden = true
         cell.lbladdedby.isHidden = true
         cell.lblparceltime.isHidden = true
         cell.lblLeaveatGate.isHidden = true
         cell.lblcancelby.isHidden = true

         cell.btnWrong_Entry.isHidden = false
         cell.btnWrong_Entry_Red.isHidden = true

            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true

        }
           else if cell.lblStatus.text == "CANCELLED" {
                               
               cell.lblStatus.backgroundColor = AppColor.cancelColor
               
               cell.lblcancelby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                               
               
               // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 12
               cell.imgviewHight5.constant = 0 */
            
            cell.lblWrongEntry.isHidden = true
            cell.lblintime.isHidden = true
            
            cell.lbldateintime.isHidden = false
            cell.lbldateintimeMulti.isHidden = true // Extra
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = false
               
            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = false
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true
             
           
            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = 98.5
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 120.5

                               
               cell.constraintHightStackBtn.constant = 0
               cell.constraintHightStacklbl.constant = 0
               cell.lblHightStacklblMiddle.isHidden = true
               
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true

               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "EXPIRED" {
               cell.lblStatus.backgroundColor = AppColor.cancelColor
               
               
                cell.lbldateintime.isHidden = false
                cell.lbldateintimeMulti.isHidden = true // Extra
                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = true
                cell.lblWrongEntry.isHidden = true

               // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0
               cell.imgviewHight6.constant = 0 */

               cell.imgview1.isHidden = false
               cell.imgview2.isHidden = true
               cell.imgview3.isHidden = true
               cell.imgview4.isHidden = false
               cell.imgview5.isHidden = true
               cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = true
                 
            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
            
            
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = true
            

               cell.btnRenew.isHidden = false
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true
               
           }
           else if cell.lblStatus.text == "ADDED" {
               
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect

            
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = false
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra
              
            
            cell.imgview1.isHidden = true
            cell.imgview2.isHidden = false
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
             cell.imgview7.isHidden = true
             cell.imgview8.isHidden = true
             cell.imgviewExtra.isHidden = true
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                               
               cell.constraintHightStackBtn.constant = 50
               cell.constraintHightStacklbl.constant = 0.5
               cell.lblHightStacklblMiddle.isHidden = false
               
               
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnOut.isHidden = false

               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "VISITED" {
               cell.lblStatus.backgroundColor = AppColor.cancelColor
            
          
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                }

            if arrGuestList[indexPath.row].activity?.out != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                        
                      let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblouttime.text =  strDate + " , " + strTime
                }
             
               
               cell.constraintHightStackBtn.constant = 50

               cell.constraintHightStacklbl.constant = 0.5

               cell.lblHightStacklblMiddle.isHidden = true
               
               if arrGuestList[indexPath.row].isWrongEntry == 0 {
                   cell.lblWrongEntry.isHidden = true
                   cell.imgview8.isHidden = true
                   
                   cell.btnWrong_Entry.isHidden = false
                   cell.btnWrong_Entry_Red.isHidden = true
                
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
              //  cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true

                cell.imgviewTop1.constant = -12
                cell.imgviewTop2.constant = 64.5
                cell.imgviewTop3.constant = 81.5
                cell.imgviewTop4.constant = 98.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = -12
                cell.imgviewTop8.constant = -12
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 120.5
                     

               }else{
                   cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                   cell.lblWrongEntry.isHidden = false
                   cell.imgview8.isHidden = false
                   
                   cell.btnWrong_Entry_Red.isHidden = false
                   cell.btnWrong_Entry.isHidden = true
                
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
              //  cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true

                cell.imgviewTop1.constant = -12
                cell.imgviewTop2.constant = 64.5
                cell.imgviewTop3.constant = 81.5
                cell.imgviewTop4.constant = 98.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = -12
                cell.imgviewTop8.constant = 115.5
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 137.5
                                 

               }
               
               // 13/1/20 temp comment
               
              /* cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0 */

            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = false
            cell.lblouttime.isHidden = false
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
          //  cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


          
                cell.btnDeliveryInfo.isHidden = true
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "APPROVED" {
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
            if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                cell.lbladdedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
            }else {
                cell.lbladdedby.text = "Approved by "
            }
               
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = false
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


             // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0
               cell.imgviewHight6.constant = 0 */

               cell.imgview1.isHidden = true
               cell.imgview2.isHidden = false
               cell.imgview3.isHidden = true
               cell.imgview4.isHidden = false
               cell.imgview5.isHidden = true
               cell.imgview6.isHidden = true
               cell.imgview7.isHidden = true
               cell.imgview8.isHidden = true
               cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                 
            
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = false
         
             
               cell.btnClose.isHidden = true
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry.isHidden = false
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = false
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
             
               // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0
               cell.imgviewHight6.constant = 0 */
            
            cell.lbldateintime.isHidden = false
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                 
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = false
            

               cell.btnCancel.isHidden = false
               cell.btnEdit.isHidden = false
               
               cell.btnWrong_Entry.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "DELIVERED" {
               
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                   
               
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = true
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = true
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
            cell.constraintHightStackBtn.constant = 0
            
            cell.constraintHightStacklbl.constant = 0

            cell.lblHightStacklblMiddle.isHidden = true

            
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnWrong_Entry.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "LEFT" {
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
               cell.constraintHightStackBtn.constant = 0
               
               cell.constraintHightStacklbl.constant = 0

               cell.lblHightStacklblMiddle.isHidden = true
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = true
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = true
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

              
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "CHECKED IN" {
               
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             
            
             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = true
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


             cell.imgview1.isHidden = true
             cell.imgview2.isHidden = true
             cell.imgview3.isHidden = true
             cell.imgview4.isHidden = true
             cell.imgview5.isHidden = true
             cell.imgview6.isHidden = true
             cell.imgview7.isHidden = true
             cell.imgview8.isHidden = true
             cell.imgviewExtra.isHidden = true

            cell.constraintHightStackBtn.constant = 0
            
            cell.constraintHightStacklbl.constant = 0

            cell.lblHightStacklblMiddle.isHidden = true
         
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
           
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            cell.btnWrong_Entry.isHidden = true
            cell.btnWrong_Entry_Red.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true


           }
           else{
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
                
                 cell.lbldateintime.isHidden = true
                 cell.lblintime.isHidden = true
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = true
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = true
                 cell.imgview3.isHidden = true
                 cell.imgview4.isHidden = true
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true

            cell.constraintHightStackBtn.constant = 0
            
            cell.constraintHightStacklbl.constant = 0

            cell.lblHightStacklblMiddle.isHidden = true
         
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
            
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

           }
          
           cell.btnIn_OnDemand.isHidden = true
           cell.btnCancel_OnDemand.isHidden = true
           cell.btnOut_OnDemand.isHidden = true
           cell.btnEdit_OnDemand.isHidden = true

           
        /*   cell.imgview1.isHidden = true   // time
          // cell.imgview2.isHidden = true   // intime
          // cell.imgview3.isHidden = true   // outtime
          // cell.imgview4.isHidden = true   // approvedby
           cell.imgview5.isHidden = false   // addedby
           cell.imgview6.isHidden = true   // parcel collection time
           cell.imgview7.isHidden = true   // leave at gate
           cell.imgview8.isHidden = true   // cancel by you
           cell.imgview9.isHidden = true   // denied by you
           cell.imgview10.isHidden = true  // No response */
           
        }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  &&  arrGuestList[indexPath.row].activity?.ActivityType  == "Visitor Pre-Approval" {
            
            cell.lblguest.text = "Visitor"
            
            if arrGuestList[indexPath.row].activity?.name != nil {
                 cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            }else{
                cell.lblname.text = ""
            }

            cell.lblStatus.isHidden = false
            
            cell.imgviewCompanyLogo.isHidden = true

            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }else{
                cell.imgview.sd_setImage(with: URL(string: "vendor-1"), placeholderImage: UIImage(named: "vendor-1"))
            }
            
            
            if arrGuestList[indexPath.row].activity?.isMulti == "0" {

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lbldateintime.text =  strTime + " , " + strDate
                }else{
                    cell.lbldateintime.isHidden = true
                }
                
            }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                    let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                    
                        cell.lbldateintime.text =  strDate + " - " + strDate1
                        cell.lbldateintime.isHidden = false
                }else{
                    cell.lbldateintime.isHidden = true
                }
            }
            
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                cell.lbladdedby.isHidden = false
            }else {
                cell.lbladdedby.isHidden = true
            }
           
           cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
           
           if cell.lblStatus.text == "NOT RESPONDED" {
               cell.lblStatus.backgroundColor = AppColor.deniedColor
            
           /* if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    cell.lblintime.isHidden = false
            }else{
                cell.lblintime.isHidden = true
            } */
            
                
            if arrGuestList[indexPath.row].activity?.isMulti == "0" {

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                    let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                    
                        cell.lblintime.text =  strDate + " - " + strDate1
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            }
                         
            cell.lblWrongEntry.text = "No Response"


                   // 13/1/20 temp comment
                   
                 /*  cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 0
                 cell.imgviewHight3.constant = 12
                   cell.imgviewHight4.constant = 0
                   cell.imgviewHight5.constant = 0
                   cell.imgviewHight6.constant = 0
                 cell.imgviewHight7.constant = 0
                 cell.imgviewHight8.constant = 0
                 cell.imgviewHightExtra.constant = 0
                    */
                
                   cell.imgview1.isHidden = true
                   cell.imgview2.isHidden = false
                   cell.imgview3.isHidden = true
                   cell.imgview4.isHidden = true
                   cell.imgview5.isHidden = true
                   cell.imgview6.isHidden = true
                   cell.imgview7.isHidden = true
                   cell.imgview8.isHidden = false
                   cell.imgviewExtra.isHidden = true
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = 81.5
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5

            
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = true
            
            cell.lblWrongEntry.isHidden = false
            cell.lblintime.isHidden = false
            
            cell.lbldateintime.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = true
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true

            cell.btnWrong_Entry.isHidden = false
            cell.btnWrong_Entry_Red.isHidden = true

               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "DENIED" {
            cell.lblStatus.backgroundColor = AppColor.deniedColor
         
           /* if arrGuestList[indexPath.row].activity?.activityIn != nil {
                 let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblintime.text =  strTime + " , " + strDate
                 cell.lblintime.isHidden = false
             }else{
                 cell.lblintime.isHidden = true
             } */
            
            if arrGuestList[indexPath.row].activity?.isMulti == "0" {

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                    let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                    
                        cell.lblintime.text =  strDate + " - " + strDate1
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            }
                           
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lblWrongEntry.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            }else {
                cell.lblWrongEntry.text = "denied by "
            }

                // 13/1/20 temp comment
                
              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
              cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
              cell.imgviewHight7.constant = 0
              cell.imgviewHight8.constant = 0
              cell.imgviewHightExtra.constant = 0
                 */
             
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = 81.5
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5

         
         cell.constraintHightStackBtn.constant = 50
         cell.constraintHightStacklbl.constant = 0.5
         cell.lblHightStacklblMiddle.isHidden = true
         
         cell.lblWrongEntry.isHidden = false
         cell.lblintime.isHidden = false
         
         cell.lbldateintime.isHidden = true
         cell.lbldateintimeMulti.isHidden = true // Extra
         cell.lblouttime.isHidden = true
         cell.lbladdedby.isHidden = true
         cell.lblparceltime.isHidden = true
         cell.lblLeaveatGate.isHidden = true
         cell.lblcancelby.isHidden = true

         cell.btnWrong_Entry.isHidden = false
         cell.btnWrong_Entry_Red.isHidden = true

            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true

        }
           else if cell.lblStatus.text == "CANCELLED" {
                               
               cell.lblStatus.backgroundColor = AppColor.cancelColor
               
               cell.lblcancelby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                               
               
               // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 12
               cell.imgviewHight5.constant = 0 */
            
            cell.lblWrongEntry.isHidden = true
            cell.lblintime.isHidden = true
            
            cell.lbldateintime.isHidden = false
            cell.lbldateintimeMulti.isHidden = true // Extra
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = false
               
            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = false
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true
             
           
            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = 98.5
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 120.5

                               
               cell.constraintHightStackBtn.constant = 0
               cell.constraintHightStacklbl.constant = 0
               cell.lblHightStacklblMiddle.isHidden = true
               
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true

               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "EXPIRED" {
               cell.lblStatus.backgroundColor = AppColor.cancelColor
               
               
                cell.lbldateintime.isHidden = false
                cell.lbldateintimeMulti.isHidden = true // Extra
                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = true
                cell.lblWrongEntry.isHidden = true

               // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0
               cell.imgviewHight6.constant = 0 */

               cell.imgview1.isHidden = false
               cell.imgview2.isHidden = true
               cell.imgview3.isHidden = true
               cell.imgview4.isHidden = false
               cell.imgview5.isHidden = true
               cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = true
                 
            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
            
            
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = true
            

               cell.btnRenew.isHidden = false
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true
               
           }
           else if cell.lblStatus.text == "ADDED" {
               
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect

            
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = false
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra
              
            
            cell.imgview1.isHidden = true
            cell.imgview2.isHidden = false
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
             cell.imgview7.isHidden = true
             cell.imgview8.isHidden = true
             cell.imgviewExtra.isHidden = true
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                               
               cell.constraintHightStackBtn.constant = 50
               cell.constraintHightStacklbl.constant = 0.5
               cell.lblHightStacklblMiddle.isHidden = false
               
               
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnOut.isHidden = false

               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "VISITED" {
            cell.lblStatus.backgroundColor = AppColor.cancelColor
         
       
             if arrGuestList[indexPath.row].activity?.activityIn != nil {
                     let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lblintime.text =  strTime + " , " + strDate
             }

         if arrGuestList[indexPath.row].activity?.out != nil {
                     let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                     
                   let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lblouttime.text =  strDate + " , " + strTime
             }
          
            
            cell.constraintHightStackBtn.constant = 50

            cell.constraintHightStacklbl.constant = 0.5

            cell.lblHightStacklblMiddle.isHidden = true
            
            if arrGuestList[indexPath.row].isWrongEntry == 0 {
                cell.lblWrongEntry.isHidden = true
                cell.imgview8.isHidden = true
                
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true
             
             cell.imgview1.isHidden = true
             cell.imgview2.isHidden = false
             cell.imgview3.isHidden = false
             cell.imgview4.isHidden = false
             cell.imgview5.isHidden = true
             cell.imgview6.isHidden = true
              cell.imgview7.isHidden = true
           //  cell.imgview8.isHidden = true
              cell.imgviewExtra.isHidden = true

             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = 81.5
             cell.imgviewTop4.constant = 98.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 120.5
                  

            }else{
                cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                cell.lblWrongEntry.isHidden = false
                cell.imgview8.isHidden = false
                
                cell.btnWrong_Entry_Red.isHidden = false
                cell.btnWrong_Entry.isHidden = true
             
             cell.imgview1.isHidden = true
             cell.imgview2.isHidden = false
             cell.imgview3.isHidden = false
             cell.imgview4.isHidden = false
             cell.imgview5.isHidden = true
             cell.imgview6.isHidden = true
              cell.imgview7.isHidden = true
           //  cell.imgview8.isHidden = true
              cell.imgviewExtra.isHidden = true

             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = 81.5
             cell.imgviewTop4.constant = 98.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = 115.5
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 137.5
                              

            }
            
            // 13/1/20 temp comment
            
           /* cell.imgviewHight1.constant = 12
            cell.imgviewHight2.constant = 0
            cell.imgviewHight3.constant = 12
            cell.imgviewHight4.constant = 0
            cell.imgviewHight5.constant = 0 */

         cell.lbldateintime.isHidden = true
         cell.lblintime.isHidden = false
         cell.lblouttime.isHidden = false
         cell.lbladdedby.isHidden = false
         cell.lblparceltime.isHidden = true
         cell.lblLeaveatGate.isHidden = true
         cell.lblcancelby.isHidden = true
       //  cell.lblWrongEntry.isHidden = true
         cell.lbldateintimeMulti.isHidden = true // Extra


       
             cell.btnDeliveryInfo.isHidden = true
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnAlertInfo.isHidden = true

        }
           else if cell.lblStatus.text == "APPROVED" {
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
            if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                cell.lbladdedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
            }else {
                cell.lbladdedby.text = "Approved by "
            }
               
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = false
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


             // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0
               cell.imgviewHight6.constant = 0 */

               cell.imgview1.isHidden = true
               cell.imgview2.isHidden = false
               cell.imgview3.isHidden = true
               cell.imgview4.isHidden = false
               cell.imgview5.isHidden = true
               cell.imgview6.isHidden = true
               cell.imgview7.isHidden = true
               cell.imgview8.isHidden = true
               cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = 64.5
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                 
            
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = false
         
             
               cell.btnClose.isHidden = true
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry.isHidden = false
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = false
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
             
               // 13/1/20 temp comment

             /*  cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight3.constant = 12
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0
               cell.imgviewHight6.constant = 0 */
            
            cell.lbldateintime.isHidden = false
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                 
            cell.constraintHightStackBtn.constant = 50
            cell.constraintHightStacklbl.constant = 0.5
            cell.lblHightStacklblMiddle.isHidden = false
            

               cell.btnCancel.isHidden = false
               cell.btnEdit.isHidden = false
               
               cell.btnWrong_Entry.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "DELIVERED" {
               
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                   
               
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = true
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = true
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
            cell.constraintHightStackBtn.constant = 0
            
            cell.constraintHightStacklbl.constant = 0

            cell.lblHightStacklblMiddle.isHidden = true

            
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnWrong_Entry.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "LEFT" {
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
               cell.constraintHightStackBtn.constant = 0
               
               cell.constraintHightStacklbl.constant = 0

               cell.lblHightStacklblMiddle.isHidden = true
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
            cell.lbldateintime.isHidden = true
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = true
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = true
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

              
               cell.btnCancel.isHidden = true
               cell.btnEdit.isHidden = true
               cell.btnWrong_Entry.isHidden = true
               cell.btnWrong_Entry_Red.isHidden = true
               cell.btnRenew.isHidden = true
               cell.btnClose.isHidden = true
               cell.btnNote_Guard.isHidden = true
               cell.btnOut.isHidden = true
               cell.btnDeliveryInfo.isHidden = true
               cell.btnAlertInfo.isHidden = true

           }
           else if cell.lblStatus.text == "CHECKED IN" {
               
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             
            
             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = true
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


             cell.imgview1.isHidden = true
             cell.imgview2.isHidden = true
             cell.imgview3.isHidden = true
             cell.imgview4.isHidden = true
             cell.imgview5.isHidden = true
             cell.imgview6.isHidden = true
             cell.imgview7.isHidden = true
             cell.imgview8.isHidden = true
             cell.imgviewExtra.isHidden = true

            cell.constraintHightStackBtn.constant = 0
            
            cell.constraintHightStacklbl.constant = 0

            cell.lblHightStacklblMiddle.isHidden = true
         
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
           
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            cell.btnWrong_Entry.isHidden = true
            cell.btnWrong_Entry_Red.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true


           }
           else{
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
               
                
                 cell.lbldateintime.isHidden = true
                 cell.lblintime.isHidden = true
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = true
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = true
                 cell.imgview3.isHidden = true
                 cell.imgview4.isHidden = true
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true

            cell.constraintHightStackBtn.constant = 0
            
            cell.constraintHightStacklbl.constant = 0

            cell.lblHightStacklblMiddle.isHidden = true
         
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
            
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

           }
          
           cell.btnIn_OnDemand.isHidden = true
           cell.btnCancel_OnDemand.isHidden = true
           cell.btnOut_OnDemand.isHidden = true
           cell.btnEdit_OnDemand.isHidden = true

           
        /*   cell.imgview1.isHidden = true   // time
          // cell.imgview2.isHidden = true   // intime
          // cell.imgview3.isHidden = true   // outtime
          // cell.imgview4.isHidden = true   // approvedby
           cell.imgview5.isHidden = false   // addedby
           cell.imgview6.isHidden = true   // parcel collection time
           cell.imgview7.isHidden = true   // leave at gate
           cell.imgview8.isHidden = true   // cancel by you
           cell.imgview9.isHidden = true   // denied by you
           cell.imgview10.isHidden = true  // No response */
           
        }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Cab Entry"  {
                            
                cell.lblname.text = "Cab"
                
                cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName

                cell.imgview.sd_setImage(with: URL(string: "cab"), placeholderImage: UIImage(named: "cab"))
                
                if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                     cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: "cab"))
                     cell.imgviewCompanyLogo.isHidden = false
                 }else{
                     cell.imgviewCompanyLogo.isHidden = true
                 }
            
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lbldateintime.text =  strTime + " , " + strDate
            }

                cell.lblStatus.isHidden = false

                cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
                

              //  cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            if cell.lblStatus.text == "NOT RESPONDED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
             
                 if arrGuestList[indexPath.row].activity?.activityIn != nil {
                         let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lblintime.text =  strTime + " , " + strDate
                         cell.lblintime.isHidden = false
                 }else{
                     cell.lblintime.isHidden = true
                 }
                      
                cell.lblWrongEntry.text = "No Response"

                    // 13/1/20 temp comment
                    
                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                  cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0
                  cell.imgviewHight7.constant = 0
                  cell.imgviewHight8.constant = 0
                  cell.imgviewHightExtra.constant = 0
                     */
                 
                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = true
                    cell.imgview8.isHidden = false
                    cell.imgviewExtra.isHidden = true
             
             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = -12
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = 81.5
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             
             cell.lblWrongEntry.isHidden = false
             cell.lblintime.isHidden = false
             
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true

             cell.btnWrong_Entry.isHidden = false
             cell.btnWrong_Entry_Red.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
             
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                     let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lblintime.text =  strTime + " , " + strDate
                     cell.lblintime.isHidden = false
             }else{
                 cell.lblintime.isHidden = true
             }
                if arrGuestList[indexPath.row].activity?.addedBy != nil {
                    cell.lblWrongEntry.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                }else {
                    cell.lblWrongEntry.text = "denied by "
                }

                    // 13/1/20 temp comment
                    
                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                  cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0
                  cell.imgviewHight7.constant = 0
                  cell.imgviewHight8.constant = 0
                  cell.imgviewHightExtra.constant = 0
                     */
                 
                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = true
                    cell.imgview8.isHidden = false
                    cell.imgviewExtra.isHidden = true

                cell.imgviewTop1.constant = -12
                cell.imgviewTop2.constant = 64.5
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = -12
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = -12
                cell.imgviewTop8.constant = 81.5
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 103.5

             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             
             cell.lblWrongEntry.isHidden = false
             cell.lblintime.isHidden = false
             
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true

             cell.btnWrong_Entry.isHidden = false
             cell.btnWrong_Entry_Red.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "CANCELLED" {
                    
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                    
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                    cell.lblcancelby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                                    
                    
                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 12
                    cell.imgviewHight5.constant = 0 */
                 
                 cell.lblWrongEntry.isHidden = true
                 cell.lblintime.isHidden = true
                 
                 cell.lbldateintime.isHidden = false
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = false
                    
                 cell.imgview1.isHidden = false
                 cell.imgview2.isHidden = true
                 cell.imgview3.isHidden = true
                 cell.imgview4.isHidden = true
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = false
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true
                  
                
                 cell.imgviewTop1.constant = 64.5
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = -12
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = 81.5
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 103.5

                                    
                    cell.constraintHightStackBtn.constant = 0
                    cell.constraintHightStacklbl.constant = 0
                    cell.lblHightStacklblMiddle.isHidden = true
                    
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true

                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                else if cell.lblStatus.text == "EXPIRED" {
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                    
                    
                 cell.lbldateintime.isHidden = false
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblintime.isHidden = true
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */

                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                     cell.imgview7.isHidden = true
                     cell.imgview8.isHidden = true
                     cell.imgviewExtra.isHidden = true
                      
                 cell.imgviewTop1.constant = 64.5
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = 81.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 103.5
                 
                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = true
                 

                    cell.btnRenew.isHidden = false
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                }
                else if cell.lblStatus.text == "VISITED" {
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                 
                 if arrGuestList[indexPath.row].activity?.out != nil {
                     
                     let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lblouttime.text =  strTime + " , " + strDate
                     
                     cell.lblouttime.isHidden = false

                 }else{
                     cell.lblouttime.isHidden = true
                 }
                    
                    cell.constraintHightStackBtn.constant = 50

                    cell.constraintHightStacklbl.constant = 0.5

                    cell.lblHightStacklblMiddle.isHidden = true
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgview8.isHidden = true
                        
                        cell.btnWrong_Entry.isHidden = false
                        cell.btnWrong_Entry_Red.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = -12
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 120.5
                          

                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgview8.isHidden = false
                        
                        cell.btnWrong_Entry_Red.isHidden = false
                        cell.btnWrong_Entry.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = 115.5
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 137.5
                                      

                    }
                    
                    // 13/1/20 temp comment
                    
                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0 */

                 cell.lbldateintime.isHidden = true
                 cell.lblintime.isHidden = false
                // cell.lblouttime.isHidden = false
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
               //  cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


               
                     cell.btnDeliveryInfo.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
            else if cell.lblStatus.text == "APPROVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
             if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                 cell.lbladdedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
             }else {
                 cell.lbladdedby.text = "Approved by "
             }
                
             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = false
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


              // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = true

             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = 81.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
                  
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
          
              
                cell.btnClose.isHidden = false
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
                else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                  
                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */
                 
                 cell.lbldateintime.isHidden = false
                 cell.lblintime.isHidden = true
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


                 cell.imgview1.isHidden = false
                 cell.imgview2.isHidden = true
                 cell.imgview3.isHidden = true
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = 64.5
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = 81.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 103.5
                      
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = false
                 

                    cell.btnCancel.isHidden = false
                    cell.btnEdit.isHidden = false
                    
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                else if cell.lblStatus.text == "LEFT" {
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                 
                 if arrGuestList[indexPath.row].activity?.out != nil {
                     
                     let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lblouttime.text =  strTime + " , " + strDate
                     
                     cell.lblouttime.isHidden = false

                 }else{
                     cell.lblouttime.isHidden = true
                 }
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                    cell.constraintHightStackBtn.constant = 0

                    cell.constraintHightStacklbl.constant = 0

                    cell.lblHightStacklblMiddle.isHidden = true
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgview8.isHidden = true
                        
                        cell.btnWrong_Entry.isHidden = false
                        cell.btnWrong_Entry_Red.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = -12
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 120.5
                          

                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgview8.isHidden = false
                        
                        cell.btnWrong_Entry_Red.isHidden = false
                        cell.btnWrong_Entry.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = 115.5
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 137.5
                                      

                    }
                    
                    // 13/1/20 temp comment
                    
                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0 */

                 cell.lbldateintime.isHidden = true
                 cell.lblintime.isHidden = false
                // cell.lblouttime.isHidden = false
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
               //  cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


               
                     cell.btnDeliveryInfo.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                else if cell.lblStatus.text == "CHECKED IN" {
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                            let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                            let strDate = strChangeDateFormate(strDateeee: lblDate!)
                            
                            let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                            cell.lblintime.text =  strTime + " , " + strDate
                            cell.lblintime.isHidden = false
                    }else{
                        cell.lblintime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                 cell.lbldateintime.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblintime.isHidden = false
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */

                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                     cell.imgview7.isHidden = true
                     cell.imgview8.isHidden = true
                     cell.imgviewExtra.isHidden = true
                      
                 cell.imgviewTop1.constant = 64.5
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = 81.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 103.5
                 
                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = true
                 

                    cell.btnRenew.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = false
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                }
                else if cell.lblStatus.text == "CHECKED OUT" {
                    
                    cell.lblStatus.backgroundColor = UIColor.systemRed

                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        
                        cell.lblintime.isHidden = false

                    }else{
                        cell.lblintime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.out != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblouttime.text =  strTime + " , " + strDate
                        
                        cell.lblouttime.isHidden = false

                    }else{
                        cell.lblouttime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                 cell.lbldateintime.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblintime.isHidden = false
                 cell.lblouttime.isHidden = false
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */

                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                     cell.imgview7.isHidden = true
                     cell.imgview8.isHidden = true
                     cell.imgviewExtra.isHidden = true
                      
                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 120.5
                 
                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = true
                 

                    cell.btnRenew.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = false
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                                 
                }
                else{
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                     
                      cell.lbldateintime.isHidden = true
                      cell.lblintime.isHidden = true
                      cell.lblouttime.isHidden = true
                      cell.lbladdedby.isHidden = true
                      cell.lblparceltime.isHidden = true
                      cell.lblLeaveatGate.isHidden = true
                      cell.lblcancelby.isHidden = true
                      cell.lblWrongEntry.isHidden = true
                      cell.lbldateintimeMulti.isHidden = true // Extra


                      cell.imgview1.isHidden = true
                      cell.imgview2.isHidden = true
                      cell.imgview3.isHidden = true
                      cell.imgview4.isHidden = true
                      cell.imgview5.isHidden = true
                      cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                      cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                 cell.constraintHightStackBtn.constant = 0
                 
                 cell.constraintHightStacklbl.constant = 0

                 cell.lblHightStacklblMiddle.isHidden = true
              
                 
                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = -12
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 69.5
                   
                 
                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                }
                
                cell.btnIn_OnDemand.isHidden = true
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true
                
        }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Cab Pre-Approval" {
            
            cell.lblname.text = "Cab"
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName

            cell.imgview.sd_setImage(with: URL(string: "cab"), placeholderImage: UIImage(named: "cab"))
            
            if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                 cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: "cab"))
                 cell.imgviewCompanyLogo.isHidden = false
             }else{
                 cell.imgviewCompanyLogo.isHidden = true
             }
        
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lbldateintime.text =  strTime + " , " + strDate
            }

            cell.lblStatus.isHidden = false

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status

          //  cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

        if cell.lblStatus.text == "NOT RESPONDED" {
            cell.lblStatus.backgroundColor = AppColor.deniedColor
         
                 if arrGuestList[indexPath.row].activity?.activityIn != nil {
                         let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lblintime.text =  strTime + " , " + strDate
                         cell.lblintime.isHidden = false
                 }else{
                     cell.lblintime.isHidden = true
                 }
                      
                cell.lblWrongEntry.text = "No Response"

                // 13/1/20 temp comment
                
              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
              cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
              cell.imgviewHight7.constant = 0
              cell.imgviewHight8.constant = 0
              cell.imgviewHightExtra.constant = 0
                 */
             
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true
         
             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = -12
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = 81.5
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             
             cell.lblWrongEntry.isHidden = false
             cell.lblintime.isHidden = false
             
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true

             cell.btnWrong_Entry.isHidden = false
             cell.btnWrong_Entry_Red.isHidden = true

            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true

        }
        else if cell.lblStatus.text == "DENIED" {
            cell.lblStatus.backgroundColor = AppColor.deniedColor
         
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                 let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblintime.text =  strTime + " , " + strDate
                 cell.lblintime.isHidden = false
         }else{
             cell.lblintime.isHidden = true
         }
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lblWrongEntry.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            }else {
                cell.lblWrongEntry.text = "denied by "
            }

                // 13/1/20 temp comment
                
              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
              cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
              cell.imgviewHight7.constant = 0
              cell.imgviewHight8.constant = 0
              cell.imgviewHightExtra.constant = 0
                 */
             
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true

                cell.imgviewTop1.constant = -12
                cell.imgviewTop2.constant = 64.5
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = -12
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = -12
                cell.imgviewTop8.constant = 81.5
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 103.5

             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             
             cell.lblWrongEntry.isHidden = false
             cell.lblintime.isHidden = false
             
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true

             cell.btnWrong_Entry.isHidden = false
             cell.btnWrong_Entry_Red.isHidden = true

            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true

        }
        else if cell.lblStatus.text == "CANCELLED" {
                
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            cell.lblcancelby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
            
            if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                cell.lbldateintime.isHidden = false

                cell.lblWrongEntry.isHidden = true
                cell.lblintime.isHidden = true
                
                cell.lbldateintimeMulti.isHidden = true // Extra
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = false
                   
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = false
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = true
                 
               
                cell.imgviewTop1.constant = 64.5
                cell.imgviewTop2.constant = -12
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = 81.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = 98.5
                cell.imgviewTop8.constant = -12
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 120.5
                                
            }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                        
                    cell.lbldateintime.text =  strDate + " - " + strDate1

                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                    
                    let lblTime1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                    let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                        cell.lbldateintimeMulti.text =  strTime + " - " + strTime1
                }
                
                cell.lblWrongEntry.isHidden = true
                cell.lblintime.isHidden = true
                
                cell.lbldateintime.isHidden = false
                cell.lbldateintimeMulti.isHidden = false // Extra
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = false
                   
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = false
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = false
                 
               
                cell.imgviewTop1.constant = 64.5
                cell.imgviewTop2.constant = -12
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = 98.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = 115.5
                cell.imgviewTop8.constant = -12
                cell.imgviewTopExtra.constant = 81.5

                cell.stackviewStatus.constant = 137.5

                                
            }
             
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                 cell.btnWrong_Entry.isHidden = false
                 cell.btnWrong_Entry_Red.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "EXPIRED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    cell.lbldateintime.isHidden = false

                    cell.lblWrongEntry.isHidden = true
                    cell.lblintime.isHidden = true
                    
                    cell.lbldateintimeMulti.isHidden = true // Extra
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = false
                       
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = true
                    cell.imgview8.isHidden = true
                    cell.imgviewExtra.isHidden = true
                     
                   
                    cell.imgviewTop1.constant = 64.5
                    cell.imgviewTop2.constant = -12
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 103.5
                                    
                }else{
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                            let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                            let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                        let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                            
                        cell.lbldateintime.text =  strDate + " - " + strDate1

                            let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                            let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                        
                        let lblTime1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                        let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                            cell.lbldateintimeMulti.text =  strTime + " - " + strTime1
                    }
                    
                    cell.lblWrongEntry.isHidden = true
                    cell.lblintime.isHidden = true
                    
                    cell.lbldateintime.isHidden = false
                    cell.lbldateintimeMulti.isHidden = false // Extra
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = false
                       
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = true
                    cell.imgview8.isHidden = true
                    cell.imgviewExtra.isHidden = false
                     
                   
                    cell.imgviewTop1.constant = 64.5
                    cell.imgviewTop2.constant = -12
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 98.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = 81.5

                    cell.stackviewStatus.constant = 120.5

                                    
                }

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */
            
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             

                cell.btnRenew.isHidden = false
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }
            else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
             
             if arrGuestList[indexPath.row].activity?.out != nil {
                 
                 let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblouttime.text =  strTime + " , " + strDate
                 
                 cell.lblouttime.isHidden = false

             }else{
                 cell.lblouttime.isHidden = true
             }
                
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgview8.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 120.5
                      

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgview8.isHidden = false
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = 115.5
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 137.5
                                  

                }
                
                // 13/1/20 temp comment
                
               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = false
            // cell.lblouttime.isHidden = false
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
           //  cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


           
                 cell.btnDeliveryInfo.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "APPROVED" {
                
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                     if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                         cell.lbladdedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                     }else {
                         cell.lbladdedby.text = "Approved by "
                     }
                        
                    cell.lbldateintime.isHidden = true
                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = true
                    cell.lblWrongEntry.isHidden = true
                    cell.lbldateintimeMulti.isHidden = true // Extra


                     // 13/1/20 temp comment

                     /*  cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight3.constant = 12
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0 */

                       cell.imgview1.isHidden = true
                       cell.imgview2.isHidden = false
                       cell.imgview3.isHidden = true
                       cell.imgview4.isHidden = false
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true
                       cell.imgview7.isHidden = true
                       cell.imgview8.isHidden = true
                       cell.imgviewExtra.isHidden = true

                    cell.imgviewTop1.constant = -12
                    cell.imgviewTop2.constant = 64.5
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 103.5
                         
                
                     cell.constraintHightStackBtn.constant = 50
                     cell.constraintHightStacklbl.constant = 0.5
                     cell.lblHightStacklblMiddle.isHidden = true
                  
              
                cell.btnClose.isHidden = false
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */
             
             cell.lbldateintime.isHidden = false
             cell.lblintime.isHidden = true
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


             cell.imgview1.isHidden = false
             cell.imgview2.isHidden = true
             cell.imgview3.isHidden = true
             cell.imgview4.isHidden = false
             cell.imgview5.isHidden = true
             cell.imgview6.isHidden = true
             cell.imgview7.isHidden = true
             cell.imgview8.isHidden = true
             cell.imgviewExtra.isHidden = true

             cell.imgviewTop1.constant = 64.5
             cell.imgviewTop2.constant = -12
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = 81.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
                  
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = false
             

                cell.btnCancel.isHidden = false
                cell.btnEdit.isHidden = false
                
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "LEFT" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
             
             if arrGuestList[indexPath.row].activity?.out != nil {
                 
                 let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblouttime.text =  strTime + " , " + strDate
                 
                 cell.lblouttime.isHidden = false

             }else{
                 cell.lblouttime.isHidden = true
             }
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                
                cell.constraintHightStackBtn.constant = 0

                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgview8.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 120.5
                      

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgview8.isHidden = false
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = 115.5
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 137.5
                                  

                }
                
                // 13/1/20 temp comment
                
               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = false
            // cell.lblouttime.isHidden = false
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
           //  cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


           
                 cell.btnDeliveryInfo.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "CHECKED IN" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblintime.isHidden = false
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true
                  
             cell.imgviewTop1.constant = 64.5
             cell.imgviewTop2.constant = -12
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = 81.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
             
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             

                cell.btnRenew.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }
            else if cell.lblStatus.text == "CHECKED OUT" {
                
                cell.lblStatus.backgroundColor = UIColor.systemRed

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.out != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblouttime.text =  strTime + " , " + strDate
                    
                    cell.lblouttime.isHidden = false

                }else{
                    cell.lblouttime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblintime.isHidden = false
             cell.lblouttime.isHidden = false
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true
                  
             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = 81.5
             cell.imgviewTop4.constant = 98.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 120.5
             
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             

                cell.btnRenew.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
                             
            }
            else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                 
                  cell.lbldateintime.isHidden = true
                  cell.lblintime.isHidden = true
                  cell.lblouttime.isHidden = true
                  cell.lbladdedby.isHidden = true
                  cell.lblparceltime.isHidden = true
                  cell.lblLeaveatGate.isHidden = true
                  cell.lblcancelby.isHidden = true
                  cell.lblWrongEntry.isHidden = true
                  cell.lbldateintimeMulti.isHidden = true // Extra


                  cell.imgview1.isHidden = true
                  cell.imgview2.isHidden = true
                  cell.imgview3.isHidden = true
                  cell.imgview4.isHidden = true
                  cell.imgview5.isHidden = true
                  cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
                  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

             cell.constraintHightStackBtn.constant = 0
             
             cell.constraintHightStacklbl.constant = 0

             cell.lblHightStacklblMiddle.isHidden = true
          
             
             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = -12
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = -12
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 80.5 // 69.5
               
             
                 cell.btnCancel.isHidden = true
                 cell.btnEdit.isHidden = true
                 cell.btnWrong_Entry.isHidden = true
                 cell.btnWrong_Entry_Red.isHidden = true
                 cell.btnRenew.isHidden = true
                 cell.btnClose.isHidden = true
                 cell.btnNote_Guard.isHidden = true
                 cell.btnOut.isHidden = true
                 cell.btnDeliveryInfo.isHidden = true
                 cell.btnAlertInfo.isHidden = true

            }
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
            
        }
       /* else if (arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "Daily Helper") || (arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "Daily Helper Entry") {
            
             cell.btnIn_OnDemand.isHidden = true
             cell.btnCancel_OnDemand.isHidden = true
             cell.btnOut_OnDemand.isHidden = true
             cell.btnEdit_OnDemand.isHidden = true
            
            cell.lblStatus.isHidden = false
            
          //  cell.btncall.isHidden = true
            
            cell.imgviewCompanyLogo.isHidden = true
            
            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }else{
                cell.imgview.sd_setImage(with: URL(string: "vendor-1"), placeholderImage: UIImage(named: "vendor-1"))
            }

            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            
            if arrGuestList[indexPath.row].activity?.vendorServiceTypeName != nil {
                cell.lblguest.text = arrGuestList[indexPath.row].activity?.vendorServiceTypeName
                //  "" // comment
            }else{
                cell.lblguest.text = ""
            }
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "CHECKED IN" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        
                        cell.lblintime.isHidden = false

                    }else{
                        cell.lblintime.isHidden = true
                    }
                                      
                      if arrGuestList[indexPath.row].isWrongEntry == 0 {
                          
                        cell.lbladdedby.isHidden = true
                          cell.lblouttime.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = true
                          

                       // 13/1/20 temp comment

                         /* cell.imgviewHight1.constant = 12
                          cell.imgviewHight2.constant = 0
                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          cell.imgviewHight6.constant = 0
                          cell.imgviewHight3.constant = 12 */


                          cell.lblouttime.isHidden = true
                          
                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          cell.imgview6.isHidden = true

                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = false
                          cell.btnWrong_Entry_Red.isHidden = true

                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = false
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true
                          
                      }else{
                        cell.lbladdedby.isHidden = true
                          cell.lblouttime.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = false
                          
                        
                       // 13/1/20 temp comment

                        /*  cell.imgviewHight1.constant = 12
                          cell.imgviewHight3.constant = 12
                          cell.imgviewHight2.constant = 0
                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                          
                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          
                          cell.imgview6.isHidden = false
                          cell.imgview1.isHidden = false
                          cell.imgview3.isHidden = false

                          
                          cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                          
                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = true
                          cell.btnWrong_Entry_Red.isHidden = false
                          
                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = false
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true

                      }
                   
                   cell.constraintHightStackBtn.constant = 50
                   
                   cell.constraintHightStacklbl.constant = 0.5

                   cell.lblHightStacklblMiddle.isHidden = false

            }else if cell.lblStatus.text == "CHECKED OUT" {
                
                cell.lblStatus.backgroundColor = UIColor.systemRed

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.out != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblouttime.text =  strTime + " , " + strDate
                    
                    cell.lblouttime.isHidden = false

                }else{
                    cell.lblouttime.isHidden = true
                }
                
                        if arrGuestList[indexPath.row].isWrongEntry == 0 {
                             
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = true
                             

                           // 13/1/20 temp comment

                            /* cell.imgviewHight1.constant = 12
                             cell.imgviewHight2.constant = 12
                             cell.imgviewHight4.constant = 0
                             cell.imgviewHight5.constant = 0
                             cell.imgviewHight6.constant = 0
                             cell.imgviewHight3.constant = 12 */


                             cell.lblouttime.isHidden = false
                             
                             cell.imgview2.isHidden = false
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             cell.imgview6.isHidden = true

                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = false
                             cell.btnWrong_Entry_Red.isHidden = true

                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = false
                             cell.btnOut.isHidden = false
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true
                             
                         }else{
                             
                             cell.lblouttime.isHidden = false
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = false
                             
                            
                           // 13/1/20 temp comment

                           /*  cell.imgviewHight1.constant = 12

                             cell.imgviewHight3.constant = 12

                             cell.imgviewHight2.constant = 12
                             cell.imgviewHight4.constant = 0
                             cell.imgviewHight5.constant = 0
                             
                             cell.imgviewHight6.constant = 0 */

                             
                             cell.imgview2.isHidden = false
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             
                             cell.imgview6.isHidden = false
                             cell.imgview1.isHidden = false
                             cell.imgview3.isHidden = false

                             
                             cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                             
                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = true
                             cell.btnWrong_Entry_Red.isHidden = false
                             
                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = false
                             cell.btnOut.isHidden = false
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true

                         }

                
            }
        else if cell.lblStatus.text == "DENIED" {
            
                   cell.lblStatus.backgroundColor = UIColor.systemRed
                  
                         if arrGuestList[indexPath.row].isWrongEntry == 0 {
                             
                             cell.constraintHightStackBtn.constant = 50
                             
                             cell.constraintHightStacklbl.constant = 0.5

                             cell.lblHightStacklblMiddle.isHidden = true
                             
                             cell.lblouttime.isHidden = true
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = false
                          
                             cell.lblWrongEntry.text = "Denied by "// + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                             
                        
                           // 13/1/20 temp comment

                        /*  cell.imgviewHight1.constant = 12
                          cell.imgviewHight2.constant = 0

                          cell.imgviewHight3.constant = 0

                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          
                          cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                          
                          cell.imgview1.isHidden = false
                          cell.imgview3.isHidden = false

                             cell.imgview2.isHidden = true
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             cell.imgview6.isHidden = true

                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = false
                             cell.btnWrong_Entry_Red.isHidden = true

                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = true
                             cell.btnOut.isHidden = true
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true
                             
                         }else{
                             
                             cell.constraintHightStackBtn.constant = 50
                             
                             cell.constraintHightStacklbl.constant = 0.5

                             cell.lblHightStacklblMiddle.isHidden = true
                             
                             cell.lblouttime.isHidden = true
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = false
                             
                            
                           // 13/1/20 temp comment

                            /* cell.imgviewHight1.constant = 12
                             cell.imgviewHight2.constant = 0
                             cell.imgviewHight3.constant = 0
                             cell.imgviewHight4.constant = 0
                             cell.imgviewHight5.constant = 0
                             cell.imgviewHight6.constant = 12 */

                             cell.lblouttime.isHidden = true
                             
                             cell.imgview2.isHidden = true
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             
                             cell.imgview6.isHidden = false
                             cell.imgview1.isHidden = false
                             cell.imgview3.isHidden = true
                            
                            cell.lblWrongEntry.text = "Denied by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!

                             
                           //  cell.lblWrongEntry.text = "No Response" //"Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                             
                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = true
                             
                             cell.btnWrong_Entry_Red.isHidden = false
                             
                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = true
                             cell.btnOut.isHidden = true
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true
                   
                }
                
            }else if cell.lblStatus.text == "NOT RESPONDED"{
                
                cell.lblStatus.backgroundColor = AppColor.ratingBorderColor

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                
                      if arrGuestList[indexPath.row].isWrongEntry == 0 {
                          
                          cell.constraintHightStackBtn.constant = 50
                          
                          cell.constraintHightStacklbl.constant = 0.5

                          cell.lblHightStacklblMiddle.isHidden = true
                          
                          cell.lblouttime.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = false
                       
                          cell.lblWrongEntry.text = "No Response" //"Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                          
                     
                       // 13/1/20 temp comment

                      /* cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0

                       cell.imgviewHight3.constant = 0

                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       
                       cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                       
                       cell.imgview1.isHidden = false
                       cell.imgview3.isHidden = false

                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          cell.imgview6.isHidden = true

                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = false
                          cell.btnWrong_Entry_Red.isHidden = true

                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = true
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true
                          
                      }else{
                          
                          cell.constraintHightStackBtn.constant = 50
                          
                          cell.constraintHightStacklbl.constant = 0.5

                          cell.lblHightStacklblMiddle.isHidden = true
                          
                          cell.lblouttime.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = false
                          
                        
                       // 13/1/20 temp comment

                        /*  cell.imgviewHight1.constant = 12
                          cell.imgviewHight2.constant = 0

                          cell.imgviewHight3.constant = 0

                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          
                          cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                          
                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          
                          cell.imgview6.isHidden = false
                          cell.imgview1.isHidden = false
                          cell.imgview3.isHidden = true
                          
                          cell.lblWrongEntry.text = "No Response" //"Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                          
                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = true
                          
                          cell.btnWrong_Entry_Red.isHidden = false
                          
                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = true
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true

                      }
                   
            }else if cell.lblStatus.text == "ADDED"{
                
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                   
                   if arrGuestList[indexPath.row].isWrongEntry == 0 {
                       
                       cell.lblouttime.isHidden = true
                       cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = false
                       
                       cell.lblWrongEntry.isHidden = true
                       
                      

                       // 13/1/20 temp comment

                      /* cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0
                       cell.imgviewHight3.constant = 12 */


                       cell.lblouttime.isHidden = true
                       
                       cell.imgview2.isHidden = true
                       cell.imgview4.isHidden = true
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true

                       cell.btnCancel.isHidden = true
                       cell.btnEdit.isHidden = true
                       
                       cell.btnWrong_Entry.isHidden = false
                       cell.btnWrong_Entry_Red.isHidden = true

                       cell.btnRenew.isHidden = true
                       cell.btnClose.isHidden = true
                       cell.btnNote_Guard.isHidden = true
                       cell.btnOut.isHidden = true
                       cell.btnDeliveryInfo.isHidden = true
                       cell.btnAlertInfo.isHidden = true
                       
                   }else{
                       
                       cell.lblouttime.isHidden = true
                       cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = false

                       cell.lblWrongEntry.isHidden = false
                       
                      
                       // 13/1/20 temp comment

                    /*   cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0

                       cell.imgviewHight3.constant = 12

                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       
                       cell.imgviewHight6.constant = 12 */

                       cell.lblouttime.isHidden = true
                       
                       cell.imgview2.isHidden = true
                       cell.imgview4.isHidden = true
                       cell.imgview5.isHidden = true
                       
                       cell.imgview6.isHidden = false
                       cell.imgview1.isHidden = false
                       cell.imgview3.isHidden = false

                       
                       cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                       
                       cell.btnCancel.isHidden = true
                       cell.btnEdit.isHidden = true
                       
                       cell.btnWrong_Entry.isHidden = true
                       
                       cell.btnWrong_Entry_Red.isHidden = false
                       
                       cell.btnRenew.isHidden = true
                       cell.btnClose.isHidden = true
                       cell.btnNote_Guard.isHidden = true
                       cell.btnOut.isHidden = true
                       cell.btnDeliveryInfo.isHidden = true
                       cell.btnAlertInfo.isHidden = true

                   }
                   
                   cell.constraintHightStackBtn.constant = 50
                   
                   cell.constraintHightStacklbl.constant = 0.5

                   cell.lblHightStacklblMiddle.isHidden = true
               
            }else if cell.lblStatus.text == "REMOVED" {
               cell.lblStatus.backgroundColor = UIColor.systemRed
                
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                cell.lbladdedby.isHidden = true
                cell.lblouttime.isHidden = true
                
            cell.lblLeaveatGate.isHidden = true
            cell.lblWrongEntry.isHidden = true
            
          
            
            // 13/1/20 temp comment

        /*  cell.imgviewHight1.constant = 12
            cell.imgviewHight2.constant = 0
            cell.imgviewHight3.constant = 12
            cell.imgviewHight4.constant = 0
            cell.imgviewHight5.constant = 0 */
            
            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = false

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                
            }
            
            else{
            }

            
            //  //  ///  // / // / // /  / //  // ./.....// / / / /
            
                /*    if arrGuestList[indexPath.row].activity?.addedOn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                    }else{
                        cell.lblintime.isHidden = true
                    }
             
                        
              if cell.lblStatus.text == "SERVING" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

                if arrGuestList[indexPath.row].isWrongEntry == 0 {

                    cell.lblouttime.isHidden = true
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    
                    cell.lblWrongEntry.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12

                    cell.imgviewHight2.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0

                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = false
                    
                    cell.imgview2.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true

                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = false
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                }
             else{
                    
                    cell.lblouttime.isHidden = true
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    
                    cell.lblWrongEntry.isHidden = false
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5

                    cell.imgviewStackTop6.constant = 10

                // 13/1/20 temp comment

                 /*   cell.imgviewHight1.constant = 12

                    cell.imgviewHight3.constant = 12

                    cell.imgviewHight2.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    
                    cell.imgviewHight6.constant = 0 */

                    cell.lblouttime.isHidden = false
                
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    
                    cell.imgview6.isHidden = false
                    cell.imgview3.isHidden = false

                    
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = false
                    
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = false
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
             } */
             
            
            /* if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            } */
            
           /* if arrGuestList[indexPath.row].activity?.removedBy != nil {
                cell.lblWrongEntry.text = "Removed by " + (arrGuestList[indexPath.row].activity?.removedBy)!
            
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
               // cell.imgviewBottom6.constant = 15

                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = true
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = false
                
                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 0
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 12 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
               
                cell.imgviewTop3_1.constant = 0
                cell.imgviewTop6_3.constant = 0
                cell.imgviewTop6_1.constant = 5

                cell.imgviewStackTop6.constant = 10  // hello
                cell.imgviewStackTop3.constant = 27

                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }else {
                
            } */
                
        } */
       /* else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType! == "Service Provider Pre-Approval" {
            
            cell.lblname.text = "Service Provider"
            
            if arrGuestList[indexPath.row].activity?.companyName != nil {
                cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
            }else{
               cell.lblguest.text = ""
            }
            
            cell.imgview.sd_setImage(with: URL(string: "ic_service"), placeholderImage: UIImage(named: "ic_service"))
            
          
            if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                 cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: "ic_service"))
                 cell.imgviewCompanyLogo.isHidden = false
             }else{
                 cell.imgviewCompanyLogo.isHidden = true
             }
        
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lbldateintime.text =  strTime + " , " + strDate
            }

            cell.lblStatus.isHidden = false

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status

          //  cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

        if cell.lblStatus.text == "NOT RESPONDED" {
            cell.lblStatus.backgroundColor = AppColor.deniedColor
         
                 if arrGuestList[indexPath.row].activity?.activityIn != nil {
                         let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lblintime.text =  strTime + " , " + strDate
                         cell.lblintime.isHidden = false
                 }else{
                     cell.lblintime.isHidden = true
                 }
                      
                cell.lblWrongEntry.text = "No Response"

                // 13/1/20 temp comment
                
              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
              cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
              cell.imgviewHight7.constant = 0
              cell.imgviewHight8.constant = 0
              cell.imgviewHightExtra.constant = 0
                 */
             
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true
         
             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = -12
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = 81.5
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             
             cell.lblWrongEntry.isHidden = false
             cell.lblintime.isHidden = false
             
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true

             cell.btnWrong_Entry.isHidden = false
             cell.btnWrong_Entry_Red.isHidden = true

            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true

        }
        else if cell.lblStatus.text == "DENIED" {
            cell.lblStatus.backgroundColor = AppColor.deniedColor
         
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                 let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblintime.text =  strTime + " , " + strDate
                 cell.lblintime.isHidden = false
         }else{
             cell.lblintime.isHidden = true
         }
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lblWrongEntry.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            }else {
                cell.lblWrongEntry.text = "denied by "
            }

                // 13/1/20 temp comment
                
              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
              cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
              cell.imgviewHight7.constant = 0
              cell.imgviewHight8.constant = 0
              cell.imgviewHightExtra.constant = 0
                 */
             
                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true

                cell.imgviewTop1.constant = -12
                cell.imgviewTop2.constant = 64.5
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = -12
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = -12
                cell.imgviewTop8.constant = 81.5
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 103.5

             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             
             cell.lblWrongEntry.isHidden = false
             cell.lblintime.isHidden = false
             
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true

             cell.btnWrong_Entry.isHidden = false
             cell.btnWrong_Entry_Red.isHidden = true

            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true

        }
        else if cell.lblStatus.text == "CANCELLED" {
                
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            cell.lblcancelby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
            
            if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                cell.lbldateintime.isHidden = false

                cell.lblWrongEntry.isHidden = true
                cell.lblintime.isHidden = true
                
                cell.lbldateintimeMulti.isHidden = true // Extra
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = false
                   
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = false
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = true
                 
               
                cell.imgviewTop1.constant = 64.5
                cell.imgviewTop2.constant = -12
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = 81.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = 98.5
                cell.imgviewTop8.constant = -12
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 120.5
                                
            }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                        
                    cell.lbldateintime.text =  strDate + " - " + strDate1

                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                    
                    let lblTime1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                    let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                        cell.lbldateintimeMulti.text =  strTime + " - " + strTime1
                }
                
                cell.lblWrongEntry.isHidden = true
                cell.lblintime.isHidden = true
                
                cell.lbldateintime.isHidden = false
                cell.lbldateintimeMulti.isHidden = false // Extra
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = false
                   
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = false
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = false
                 
               
                cell.imgviewTop1.constant = 64.5
                cell.imgviewTop2.constant = -12
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = 98.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = 115.5
                cell.imgviewTop8.constant = -12
                cell.imgviewTopExtra.constant = 81.5

                cell.stackviewStatus.constant = 137.5

                                
            }
             
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                 cell.btnWrong_Entry.isHidden = false
                 cell.btnWrong_Entry_Red.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "EXPIRED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    cell.lbldateintime.isHidden = false

                    cell.lblWrongEntry.isHidden = true
                    cell.lblintime.isHidden = true
                    
                    cell.lbldateintimeMulti.isHidden = true // Extra
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = false
                       
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = true
                    cell.imgview8.isHidden = true
                    cell.imgviewExtra.isHidden = true
                     
                   
                    cell.imgviewTop1.constant = 64.5
                    cell.imgviewTop2.constant = -12
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 103.5
                                    
                }else{
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                            let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                            let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                        let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                            
                        cell.lbldateintime.text =  strDate + " - " + strDate1

                            let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                            let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                        
                        let lblTime1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                        let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                            cell.lbldateintimeMulti.text =  strTime + " - " + strTime1
                    }
                    
                    cell.lblWrongEntry.isHidden = true
                    cell.lblintime.isHidden = true
                    
                    cell.lbldateintime.isHidden = false
                    cell.lbldateintimeMulti.isHidden = false // Extra
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = false
                       
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = true
                    cell.imgview8.isHidden = true
                    cell.imgviewExtra.isHidden = false
                     
                   
                    cell.imgviewTop1.constant = 64.5
                    cell.imgviewTop2.constant = -12
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 98.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = 81.5

                    cell.stackviewStatus.constant = 120.5

                                    
                }

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */
            
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             

                cell.btnRenew.isHidden = false
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }
            else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
             
             if arrGuestList[indexPath.row].activity?.out != nil {
                 
                 let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblouttime.text =  strTime + " , " + strDate
                 
                 cell.lblouttime.isHidden = false

             }else{
                 cell.lblouttime.isHidden = true
             }
                
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgview8.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 120.5
                      

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgview8.isHidden = false
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = 115.5
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 137.5
                                  

                }
                
                // 13/1/20 temp comment
                
               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = false
            // cell.lblouttime.isHidden = false
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
           //  cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


           
                 cell.btnDeliveryInfo.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "APPROVED" {
                
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                     if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                         cell.lbladdedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                     }else {
                         cell.lbladdedby.text = "Approved by "
                     }
                        
                    cell.lbldateintime.isHidden = true
                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = true
                    cell.lblWrongEntry.isHidden = true
                    cell.lbldateintimeMulti.isHidden = true // Extra


                     // 13/1/20 temp comment

                     /*  cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight3.constant = 12
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0 */

                       cell.imgview1.isHidden = true
                       cell.imgview2.isHidden = false
                       cell.imgview3.isHidden = true
                       cell.imgview4.isHidden = false
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true
                       cell.imgview7.isHidden = true
                       cell.imgview8.isHidden = true
                       cell.imgviewExtra.isHidden = true

                    cell.imgviewTop1.constant = -12
                    cell.imgviewTop2.constant = 64.5
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 103.5
                         
                
                     cell.constraintHightStackBtn.constant = 50
                     cell.constraintHightStacklbl.constant = 0.5
                     cell.lblHightStacklblMiddle.isHidden = true
                  
              
                cell.btnClose.isHidden = false
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */
             
             cell.lbldateintime.isHidden = false
             cell.lblintime.isHidden = true
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


             cell.imgview1.isHidden = false
             cell.imgview2.isHidden = true
             cell.imgview3.isHidden = true
             cell.imgview4.isHidden = false
             cell.imgview5.isHidden = true
             cell.imgview6.isHidden = true
             cell.imgview7.isHidden = true
             cell.imgview8.isHidden = true
             cell.imgviewExtra.isHidden = true

             cell.imgviewTop1.constant = 64.5
             cell.imgviewTop2.constant = -12
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = 81.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
                  
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = false
             

                cell.btnCancel.isHidden = false
                cell.btnEdit.isHidden = false
                
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "LEFT" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
             
             if arrGuestList[indexPath.row].activity?.out != nil {
                 
                 let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                 let strDate = strChangeDateFormate(strDateeee: lblDate!)
                 
                 let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                 let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                 cell.lblouttime.text =  strTime + " , " + strDate
                 
                 cell.lblouttime.isHidden = false

             }else{
                 cell.lblouttime.isHidden = true
             }
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                
                cell.constraintHightStackBtn.constant = 0

                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgview8.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 120.5
                      

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgview8.isHidden = false
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                 
                 cell.imgview1.isHidden = true
                 cell.imgview2.isHidden = false
                 cell.imgview3.isHidden = false
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
               //  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = 115.5
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 137.5
                                  

                }
                
                // 13/1/20 temp comment
                
               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = false
            // cell.lblouttime.isHidden = false
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
           //  cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra


           
                 cell.btnDeliveryInfo.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "CHECKED IN" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblintime.isHidden = false
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true
                  
             cell.imgviewTop1.constant = 64.5
             cell.imgviewTop2.constant = -12
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = 81.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

             cell.stackviewStatus.constant = 103.5
             
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             

                cell.btnRenew.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }
            else if cell.lblStatus.text == "CHECKED OUT" {
                
                cell.lblStatus.backgroundColor = UIColor.systemRed

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.out != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblouttime.text =  strTime + " , " + strDate
                    
                    cell.lblouttime.isHidden = false

                }else{
                    cell.lblouttime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                    cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                }else {
                    cell.lbladdedby.text = "Pre Approved by "
                }
                
             cell.lbldateintime.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra
             cell.lblintime.isHidden = false
             cell.lblouttime.isHidden = false
             cell.lbladdedby.isHidden = false
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = true
                cell.imgview2.isHidden = false
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true
                  
             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = 64.5
             cell.imgviewTop3.constant = 81.5
             cell.imgviewTop4.constant = 98.5
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 120.5
             
             
             cell.constraintHightStackBtn.constant = 50
             cell.constraintHightStacklbl.constant = 0.5
             cell.lblHightStacklblMiddle.isHidden = true
             

                cell.btnRenew.isHidden = true
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
                             
            }
            else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                 
                  cell.lbldateintime.isHidden = true
                  cell.lblintime.isHidden = true
                  cell.lblouttime.isHidden = true
                  cell.lbladdedby.isHidden = true
                  cell.lblparceltime.isHidden = true
                  cell.lblLeaveatGate.isHidden = true
                  cell.lblcancelby.isHidden = true
                  cell.lblWrongEntry.isHidden = true
                  cell.lbldateintimeMulti.isHidden = true // Extra


                  cell.imgview1.isHidden = true
                  cell.imgview2.isHidden = true
                  cell.imgview3.isHidden = true
                  cell.imgview4.isHidden = true
                  cell.imgview5.isHidden = true
                  cell.imgview6.isHidden = true
                  cell.imgview7.isHidden = true
                  cell.imgview8.isHidden = true
                  cell.imgviewExtra.isHidden = true

             cell.constraintHightStackBtn.constant = 0
             
             cell.constraintHightStacklbl.constant = 0

             cell.lblHightStacklblMiddle.isHidden = true
          
             
             cell.imgviewTop1.constant = -12
             cell.imgviewTop2.constant = -12
             cell.imgviewTop3.constant = -12
             cell.imgviewTop4.constant = -12
             cell.imgviewTop5.constant = -12
             cell.imgviewTop6.constant = -12
             cell.imgviewTop7.constant = -12
             cell.imgviewTop8.constant = -12
             cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 80.5 // 69.5
               
             
                 cell.btnCancel.isHidden = true
                 cell.btnEdit.isHidden = true
                 cell.btnWrong_Entry.isHidden = true
                 cell.btnWrong_Entry_Red.isHidden = true
                 cell.btnRenew.isHidden = true
                 cell.btnClose.isHidden = true
                 cell.btnNote_Guard.isHidden = true
                 cell.btnOut.isHidden = true
                 cell.btnDeliveryInfo.isHidden = true
                 cell.btnAlertInfo.isHidden = true

            }
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
            
        } */
      /* else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType! == "Service Provider Pre-Approval" {

            cell.lblname.text = "Service Provider"
            
            if arrGuestList[indexPath.row].activity?.companyName != nil {
                cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
            }else{
               cell.lblguest.text = ""
            }
            
            cell.imgview.sd_setImage(with: URL(string: "ic_service"), placeholderImage: UIImage(named: "ic_service"))
            
           if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                 cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: "ic_service"))
                 cell.imgviewCompanyLogo.isHidden = false
             }else{
                 cell.imgviewCompanyLogo.isHidden = true
             }

          /*  if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lbldateintime.text =  strTime + " , " + strDate
            } */

             
                cell.lblStatus.isHidden = false

                cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status

              //  cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                
            if cell.lblStatus.text == "NOT RESPONDED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
             
                     if arrGuestList[indexPath.row].activity?.activityIn != nil {
                             let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                             let strDate = strChangeDateFormate(strDateeee: lblDate!)
                             
                             let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                             let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                             cell.lblintime.text =  strTime + " , " + strDate
                     }
                          
                    cell.lblWrongEntry.text = "No Response"

                    // 13/1/20 temp comment
                    
                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                  cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0
                  cell.imgviewHight7.constant = 0
                  cell.imgviewHight8.constant = 0
                  cell.imgviewHightExtra.constant = 0
                     */
                 
                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = true
                    cell.imgview8.isHidden = false
                    cell.imgviewExtra.isHidden = true
             
                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = -12
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = 81.5
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 103.5
                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = true
                 
                 cell.lblWrongEntry.isHidden = false
                 cell.lblintime.isHidden = false

                 cell.lbldateintime.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = true
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true

                 cell.btnWrong_Entry.isHidden = false
                 cell.btnWrong_Entry_Red.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
             else if cell.lblStatus.text == "DENIED" {
                    cell.lblStatus.backgroundColor = AppColor.deniedColor
                 
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                         let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lblintime.text =  strTime + " , " + strDate
                         cell.lblintime.isHidden = false
                 }
                
                    if arrGuestList[indexPath.row].activity?.addedBy != nil {
                        cell.lblWrongEntry.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                    }else {
                        cell.lblWrongEntry.text = "denied by "
                    }

                        // 13/1/20 temp comment
                        
                      /*  cell.imgviewHight1.constant = 12
                        cell.imgviewHight2.constant = 0
                      cell.imgviewHight3.constant = 12
                        cell.imgviewHight4.constant = 0
                        cell.imgviewHight5.constant = 0
                        cell.imgviewHight6.constant = 0
                      cell.imgviewHight7.constant = 0
                      cell.imgviewHight8.constant = 0
                      cell.imgviewHightExtra.constant = 0
                         */
                     
                        cell.imgview1.isHidden = true
                        cell.imgview2.isHidden = false
                        cell.imgview3.isHidden = true
                        cell.imgview4.isHidden = true
                        cell.imgview5.isHidden = true
                        cell.imgview6.isHidden = true
                        cell.imgview7.isHidden = true
                        cell.imgview8.isHidden = false
                        cell.imgviewExtra.isHidden = true

                    cell.imgviewTop1.constant = -12
                    cell.imgviewTop2.constant = 64.5
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = -12
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = 81.5
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 103.5

                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = true
                 
                 cell.lblWrongEntry.isHidden = false
                 cell.lblintime.isHidden = false
                 
                 cell.lbldateintime.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = true
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true

                 cell.btnWrong_Entry.isHidden = false
                 cell.btnWrong_Entry_Red.isHidden = true

                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                else if cell.lblStatus.text == "CANCELLED" {
                    
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                    
                    cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                cell.lblcancelby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 12
                    cell.imgviewHight5.constant = 0 */
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                              let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                              cell.lbldateintime.text =  strTime + " , " + strDate
                      }
                    
                    cell.lbldateintime.isHidden = false

                    cell.lblWrongEntry.isHidden = true
                    cell.lblintime.isHidden = true
                    
                    cell.lbldateintimeMulti.isHidden = true // Extra
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = false
                       
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = false
                    cell.imgview8.isHidden = true
                    cell.imgviewExtra.isHidden = true
                     
                   
                    cell.imgviewTop1.constant = 64.5
                    cell.imgviewTop2.constant = -12
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = 98.5
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 120.5
                                    
                }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                            let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                            let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                        let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                            
                        cell.lbldateintime.text =  strDate + " - " + strDate1

                            let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                            let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                        
                        let lblTime1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                        let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                            cell.lbldateintimeMulti.text =  strTime + " - " + strTime1
                    }
                    
                    cell.lblWrongEntry.isHidden = true
                    cell.lblintime.isHidden = true
                    
                    cell.lbldateintime.isHidden = false
                    cell.lbldateintimeMulti.isHidden = false // Extra
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = false
                       
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = false
                    cell.imgview8.isHidden = true
                    cell.imgviewExtra.isHidden = false
                     
                   
                    cell.imgviewTop1.constant = 64.5
                    cell.imgviewTop2.constant = -12
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 98.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = 115.5
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = 81.5

                    cell.stackviewStatus.constant = 137.5

                                    
                }else {
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                              let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                              cell.lbldateintime.text =  strTime + " , " + strDate
                      }
                    
                    cell.lbldateintime.isHidden = false

                    cell.lblWrongEntry.isHidden = true
                    cell.lblintime.isHidden = true
                    
                    cell.lbldateintimeMulti.isHidden = true // Extra
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = false
                       
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    cell.imgview7.isHidden = false
                    cell.imgview8.isHidden = true
                    cell.imgviewExtra.isHidden = true
                     
                   
                    cell.imgviewTop1.constant = 64.5
                    cell.imgviewTop2.constant = -12
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = 98.5
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 120.5
                                    
                }
                 
                   
                    cell.constraintHightStackBtn.constant = 50
                    cell.constraintHightStacklbl.constant = 0.5
                    cell.lblHightStacklblMiddle.isHidden = true
                    
                     cell.btnWrong_Entry.isHidden = false
                     cell.btnWrong_Entry_Red.isHidden = true

                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                
                // 25/1/21 temp comment
                
                else if cell.lblStatus.text == "EXPIRED" {
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                    
                    cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                    
                   if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                        
                        if arrGuestList[indexPath.row].activity?.activityIn != nil {
                                  let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                                  let strDate = strChangeDateFormate(strDateeee: lblDate!)
                                  
                                  let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                                  let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                                  cell.lbldateintime.text =  strTime + " , " + strDate
                          }
                        
                        cell.lbldateintime.isHidden = false

                        cell.lblWrongEntry.isHidden = true
                        cell.lblintime.isHidden = true
                        
                        cell.lbldateintimeMulti.isHidden = true // Extra
                        cell.lblouttime.isHidden = true
                        cell.lbladdedby.isHidden = false
                        cell.lblparceltime.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.lblcancelby.isHidden = false
                           
                        cell.imgview1.isHidden = false
                        cell.imgview2.isHidden = true
                        cell.imgview3.isHidden = true
                        cell.imgview4.isHidden = false
                        cell.imgview5.isHidden = true
                        cell.imgview6.isHidden = true
                        cell.imgview7.isHidden = true
                        cell.imgview8.isHidden = true
                        cell.imgviewExtra.isHidden = true
                         
                       
                        cell.imgviewTop1.constant = 64.5
                        cell.imgviewTop2.constant = -12
                        cell.imgviewTop3.constant = -12
                        cell.imgviewTop4.constant = 81.5
                        cell.imgviewTop5.constant = -12
                        cell.imgviewTop6.constant = -12
                        cell.imgviewTop7.constant = -12
                        cell.imgviewTop8.constant = -12
                        cell.imgviewTopExtra.constant = -12

                        cell.stackviewStatus.constant = 103.5
                                        
                    }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                        
                        if arrGuestList[indexPath.row].activity?.activityIn != nil {
                                let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                                let strDate = strChangeDateFormate(strDateeee: lblDate!)
                            
                            let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                            let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                                
                            cell.lbldateintime.text =  strDate + " - " + strDate1

                                let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                                let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                            
                            let lblTime1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                            let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                                cell.lbldateintimeMulti.text =  strTime + " - " + strTime1
                        }
                        
                        cell.lblWrongEntry.isHidden = true
                        cell.lblintime.isHidden = true
                        
                        cell.lbldateintime.isHidden = false
                        cell.lbldateintimeMulti.isHidden = false // Extra
                        cell.lblouttime.isHidden = true
                        cell.lbladdedby.isHidden = false
                        cell.lblparceltime.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.lblcancelby.isHidden = false
                           
                        cell.imgview1.isHidden = false
                        cell.imgview2.isHidden = true
                        cell.imgview3.isHidden = true
                        cell.imgview4.isHidden = false
                        cell.imgview5.isHidden = true
                        cell.imgview6.isHidden = true
                        cell.imgview7.isHidden = true
                        cell.imgview8.isHidden = true
                        cell.imgviewExtra.isHidden = false
                         
                       
                        cell.imgviewTop1.constant = 64.5
                        cell.imgviewTop2.constant = -12
                        cell.imgviewTop3.constant = -12
                        cell.imgviewTop4.constant = 98.5
                        cell.imgviewTop5.constant = -12
                        cell.imgviewTop6.constant = -12
                        cell.imgviewTop7.constant = -12
                        cell.imgviewTop8.constant = -12
                        cell.imgviewTopExtra.constant = 81.5

                        cell.stackviewStatus.constant = 120.5

                                        
                    }else{
                        if arrGuestList[indexPath.row].activity?.activityIn != nil {
                                  let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                                  let strDate = strChangeDateFormate(strDateeee: lblDate!)
                                  
                                  let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                                  let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                                  cell.lbldateintime.text =  strTime + " , " + strDate
                          }
                        
                        cell.lbldateintime.isHidden = false

                        cell.lblWrongEntry.isHidden = true
                        cell.lblintime.isHidden = true
                        
                        cell.lbldateintimeMulti.isHidden = true // Extra
                        cell.lblouttime.isHidden = true
                        cell.lbladdedby.isHidden = false
                        cell.lblparceltime.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.lblcancelby.isHidden = false
                           
                        cell.imgview1.isHidden = false
                        cell.imgview2.isHidden = true
                        cell.imgview3.isHidden = true
                        cell.imgview4.isHidden = false
                        cell.imgview5.isHidden = true
                        cell.imgview6.isHidden = true
                        cell.imgview7.isHidden = true
                        cell.imgview8.isHidden = true
                        cell.imgviewExtra.isHidden = true
                         
                       
                        cell.imgviewTop1.constant = 64.5
                        cell.imgviewTop2.constant = -12
                        cell.imgviewTop3.constant = -12
                        cell.imgviewTop4.constant = 81.5
                        cell.imgviewTop5.constant = -12
                        cell.imgviewTop6.constant = -12
                        cell.imgviewTop7.constant = -12
                        cell.imgviewTop8.constant = -12
                        cell.imgviewTopExtra.constant = -12

                        cell.stackviewStatus.constant = 103.5
                        
                    }

                    // 13/1/20 temp comment

                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = true
                 

                    cell.btnRenew.isHidden = false
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                }
               /* else if cell.lblStatus.text == "VISITED" {
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                 
                 if arrGuestList[indexPath.row].activity?.out != nil {
                     
                     let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lblouttime.text =  strTime + " , " + strDate
                     
                     cell.lblouttime.isHidden = false

                 }else{
                     cell.lblouttime.isHidden = true
                 }
                    
                    
                    cell.constraintHightStackBtn.constant = 50

                    cell.constraintHightStacklbl.constant = 0.5

                    cell.lblHightStacklblMiddle.isHidden = true
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgview8.isHidden = true
                        
                        cell.btnWrong_Entry.isHidden = false
                        cell.btnWrong_Entry_Red.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = -12
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 120.5
                          

                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgview8.isHidden = false
                        
                        cell.btnWrong_Entry_Red.isHidden = false
                        cell.btnWrong_Entry.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = 115.5
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 137.5
                                      

                    }
                    
                    // 13/1/20 temp comment
                    
                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0 */

                 cell.lbldateintime.isHidden = true
                 cell.lblintime.isHidden = false
                // cell.lblouttime.isHidden = false
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
               //  cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


               
                     cell.btnDeliveryInfo.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                } */
                else if cell.lblStatus.text == "APPROVED" {
                    
                        cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                         if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                             cell.lbladdedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                         }else {
                             cell.lbladdedby.text = "Approved by "
                         }
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                              let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                              cell.lblintime.text =  strTime + " , " + strDate
                      }
                    
                    cell.lbldateintime.isHidden = true
                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = true
                    cell.lblWrongEntry.isHidden = true
                    cell.lbldateintimeMulti.isHidden = true // Extra


                     // 13/1/20 temp comment

                     /*  cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight3.constant = 12
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0 */

                       cell.imgview1.isHidden = true
                       cell.imgview2.isHidden = false
                       cell.imgview3.isHidden = true
                       cell.imgview4.isHidden = false
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true
                       cell.imgview7.isHidden = true
                       cell.imgview8.isHidden = true
                       cell.imgviewExtra.isHidden = true

                    cell.imgviewTop1.constant = -12
                    cell.imgviewTop2.constant = 64.5
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 103.5
                       
                }
                else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                              let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                              cell.lblintime.text =  strTime + " , " + strDate
                      }
                    
                    if arrGuestList[indexPath.row].activity?.out != nil {
                              let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                              cell.lbldateintimeMulti.text =  strTime + " , " + strDate
                      }
                    
                    cell.lbldateintime.isHidden = true
                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = true
                    cell.lblWrongEntry.isHidden = true
                    cell.lbldateintimeMulti.isHidden = false // Extra


                     // 13/1/20 temp comment

                     /*  cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight3.constant = 12
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0 */

                       cell.imgview1.isHidden = true
                       cell.imgview2.isHidden = false
                       cell.imgview3.isHidden = true
                       cell.imgview4.isHidden = false
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true
                       cell.imgview7.isHidden = true
                       cell.imgview8.isHidden = true
                       cell.imgviewExtra.isHidden = false

                    cell.imgviewTop1.constant = -12
                    cell.imgviewTop2.constant = 64.5
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = 98.5

                    cell.stackviewStatus.constant = 120.5
                       
                }
                else{
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                              let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                              let strDate = strChangeDateFormate(strDateeee: lblDate!)
                              
                              let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                              let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                              cell.lblintime.text =  strTime + " , " + strDate
                      }
                    
                    cell.lbldateintime.isHidden = true
                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblparceltime.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblcancelby.isHidden = true
                    cell.lblWrongEntry.isHidden = true
                    cell.lbldateintimeMulti.isHidden = true // Extra


                     // 13/1/20 temp comment

                     /*  cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight3.constant = 12
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0 */

                       cell.imgview1.isHidden = true
                       cell.imgview2.isHidden = false
                       cell.imgview3.isHidden = true
                       cell.imgview4.isHidden = false
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true
                       cell.imgview7.isHidden = true
                       cell.imgview8.isHidden = true
                       cell.imgviewExtra.isHidden = true

                    cell.imgviewTop1.constant = -12
                    cell.imgviewTop2.constant = 64.5
                    cell.imgviewTop3.constant = -12
                    cell.imgviewTop4.constant = 81.5
                    cell.imgviewTop5.constant = -12
                    cell.imgviewTop6.constant = -12
                    cell.imgviewTop7.constant = -12
                    cell.imgviewTop8.constant = -12
                    cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 103.5
                       
                }

                    
                         cell.constraintHightStackBtn.constant = 50
                         cell.constraintHightStacklbl.constant = 0.5
                         cell.lblHightStacklblMiddle.isHidden = true
                      
                  
                    cell.btnClose.isHidden = false
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                    if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                        
                        if arrGuestList[indexPath.row].activity?.activityIn != nil {
                                  let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                                  let strDate = strChangeDateFormate(strDateeee: lblDate!)
                                  
                                  let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                                  let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                                  cell.lbldateintime.text =  strTime + " , " + strDate
                          }
                        
                        cell.lbldateintime.isHidden = false
                        cell.lblintime.isHidden = true
                        cell.lblouttime.isHidden = true
                        cell.lbladdedby.isHidden = false
                        cell.lblparceltime.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.lblcancelby.isHidden = true
                        cell.lblWrongEntry.isHidden = true
                        cell.lbldateintimeMulti.isHidden = true // Extra


                        cell.imgview1.isHidden = false
                        cell.imgview2.isHidden = true
                        cell.imgview3.isHidden = true
                        cell.imgview4.isHidden = false
                        cell.imgview5.isHidden = true
                        cell.imgview6.isHidden = true
                        cell.imgview7.isHidden = true
                        cell.imgview8.isHidden = true
                        cell.imgviewExtra.isHidden = true

                        cell.imgviewTop1.constant = 64.5
                        cell.imgviewTop2.constant = -12
                        cell.imgviewTop3.constant = -12
                        cell.imgviewTop4.constant = 81.5
                        cell.imgviewTop5.constant = -12
                        cell.imgviewTop6.constant = -12
                        cell.imgviewTop7.constant = -12
                        cell.imgviewTop8.constant = -12
                        cell.imgviewTopExtra.constant = -12

                        cell.stackviewStatus.constant = 103.5
                             
                    }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                        
                        if arrGuestList[indexPath.row].activity?.activityIn != nil {
                                let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                                let strDate = strChangeDateFormate(strDateeee: lblDate!)
                            
                            let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                            let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)
                                
                            cell.lbldateintime.text =  strDate + " - " + strDate1

                                let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                                let strTime = strChangeTimeFormate(strDateeee: lblTime!)
                            
                            let lblTime1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                            let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)

                                cell.lbldateintimeMulti.text =  strTime + " - " + strTime1
                        }
                        
                        cell.lbldateintime.isHidden = false
                        cell.lblintime.isHidden = true
                        cell.lblouttime.isHidden = true
                        cell.lbladdedby.isHidden = false
                        cell.lblparceltime.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.lblcancelby.isHidden = true
                        cell.lblWrongEntry.isHidden = true
                        cell.lbldateintimeMulti.isHidden = false // Extra


                        cell.imgview1.isHidden = false
                        cell.imgview2.isHidden = true
                        cell.imgview3.isHidden = true
                        cell.imgview4.isHidden = false
                        cell.imgview5.isHidden = true
                        cell.imgview6.isHidden = true
                        cell.imgview7.isHidden = true
                        cell.imgview8.isHidden = true
                        cell.imgviewExtra.isHidden = false

                        cell.imgviewTop1.constant = 64.5
                        cell.imgviewTop2.constant = -12
                        cell.imgviewTop3.constant = -12
                        cell.imgviewTop4.constant = 98.5
                        cell.imgviewTop5.constant = -12
                        cell.imgviewTop6.constant = -12
                        cell.imgviewTop7.constant = -12
                        cell.imgviewTop8.constant = -12
                        cell.imgviewTopExtra.constant = 81.5

                        cell.stackviewStatus.constant = 120.5
                             
                        
                    }else{
                        
                        if arrGuestList[indexPath.row].activity?.activityIn != nil {
                                  let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                                  let strDate = strChangeDateFormate(strDateeee: lblDate!)
                                  
                                  let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                                  let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                                  cell.lbldateintime.text =  strTime + " , " + strDate
                          }
                        
                        cell.lbldateintime.isHidden = false
                        cell.lblintime.isHidden = true
                        cell.lblouttime.isHidden = true
                        cell.lbladdedby.isHidden = false
                        cell.lblparceltime.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.lblcancelby.isHidden = true
                        cell.lblWrongEntry.isHidden = true
                        cell.lbldateintimeMulti.isHidden = true // Extra


                        cell.imgview1.isHidden = false
                        cell.imgview2.isHidden = true
                        cell.imgview3.isHidden = true
                        cell.imgview4.isHidden = false
                        cell.imgview5.isHidden = true
                        cell.imgview6.isHidden = true
                        cell.imgview7.isHidden = true
                        cell.imgview8.isHidden = true
                        cell.imgviewExtra.isHidden = true

                        cell.imgviewTop1.constant = 64.5
                        cell.imgviewTop2.constant = -12
                        cell.imgviewTop3.constant = -12
                        cell.imgviewTop4.constant = 81.5
                        cell.imgviewTop5.constant = -12
                        cell.imgviewTop6.constant = -12
                        cell.imgviewTop7.constant = -12
                        cell.imgviewTop8.constant = -12
                        cell.imgviewTopExtra.constant = -12

                        cell.stackviewStatus.constant = 103.5
                             
                    }
                        
                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */
                 
               /*  cell.lbldateintime.isHidden = false
                 cell.lblintime.isHidden = true
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


                 cell.imgview1.isHidden = false
                 cell.imgview2.isHidden = true
                 cell.imgview3.isHidden = true
                 cell.imgview4.isHidden = false
                 cell.imgview5.isHidden = true
                 cell.imgview6.isHidden = true
                 cell.imgview7.isHidden = true
                 cell.imgview8.isHidden = true
                 cell.imgviewExtra.isHidden = true

                 cell.imgviewTop1.constant = 64.5
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = 81.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 103.5 */
                      
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = false
                 

                    cell.btnCancel.isHidden = false
                    cell.btnEdit.isHidden = false
                    
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                else if cell.lblStatus.text == "LEFT" {
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                 
                 if arrGuestList[indexPath.row].activity?.out != nil {
                     
                     let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lblouttime.text =  strTime + " , " + strDate
                     
                     cell.lblouttime.isHidden = false

                 }else{
                     cell.lblouttime.isHidden = true
                 }
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                    cell.constraintHightStackBtn.constant = 0

                    cell.constraintHightStacklbl.constant = 0

                    cell.lblHightStacklblMiddle.isHidden = true
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgview8.isHidden = true
                        
                        cell.btnWrong_Entry.isHidden = false
                        cell.btnWrong_Entry_Red.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = -12
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 120.5
                          

                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgview8.isHidden = false
                        
                        cell.btnWrong_Entry_Red.isHidden = false
                        cell.btnWrong_Entry.isHidden = true
                     
                     cell.imgview1.isHidden = true
                     cell.imgview2.isHidden = false
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                   //  cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                     cell.imgviewTop1.constant = -12
                     cell.imgviewTop2.constant = 64.5
                     cell.imgviewTop3.constant = 81.5
                     cell.imgviewTop4.constant = 98.5
                     cell.imgviewTop5.constant = -12
                     cell.imgviewTop6.constant = -12
                     cell.imgviewTop7.constant = -12
                     cell.imgviewTop8.constant = 115.5
                     cell.imgviewTopExtra.constant = -12

                     cell.stackviewStatus.constant = 137.5
                                      

                    }
                    
                    // 13/1/20 temp comment
                    
                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0 */

                 cell.lbldateintime.isHidden = true
                 cell.lblintime.isHidden = false
                // cell.lblouttime.isHidden = false
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
               //  cell.lblWrongEntry.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra


               
                     cell.btnDeliveryInfo.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                else if cell.lblStatus.text == "CHECKED IN" {
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                            let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                            let strDate = strChangeDateFormate(strDateeee: lblDate!)
                            
                            let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                            cell.lblintime.text =  strTime + " , " + strDate
                            cell.lblintime.isHidden = false
                    }else{
                        cell.lblintime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                 cell.lbldateintime.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblintime.isHidden = false
                 cell.lblouttime.isHidden = true
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */

                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                     cell.imgview7.isHidden = true
                     cell.imgview8.isHidden = true
                     cell.imgviewExtra.isHidden = true
                      
                 cell.imgviewTop1.constant = 64.5
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = 81.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                 cell.stackviewStatus.constant = 103.5
                 
                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = true
                 

                    cell.btnRenew.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = false
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                }
                else if cell.lblStatus.text == "CHECKED OUT" {
                    
                    cell.lblStatus.backgroundColor = UIColor.systemRed

                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        
                        cell.lblintime.isHidden = false

                    }else{
                        cell.lblintime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.out != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblouttime.text =  strTime + " , " + strDate
                        
                        cell.lblouttime.isHidden = false

                    }else{
                        cell.lblouttime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                 cell.lbldateintime.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblintime.isHidden = false
                 cell.lblouttime.isHidden = false
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */

                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                     cell.imgview7.isHidden = true
                     cell.imgview8.isHidden = true
                     cell.imgviewExtra.isHidden = true
                      
                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 120.5
                 
                 
                 cell.constraintHightStackBtn.constant = 50
                 cell.constraintHightStacklbl.constant = 0.5
                 cell.lblHightStacklblMiddle.isHidden = false
                 

                    cell.btnRenew.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = false
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                                 
                }
              /*  else if cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED" {
                    
                    cell.lblStatus.backgroundColor = AppColor.cancelColor
                    
                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        
                        cell.lblintime.isHidden = false

                    }else{
                        cell.lblintime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.out != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblouttime.text =  strTime + " , " + strDate
                        
                        cell.lblouttime.isHidden = false

                    }else{
                        cell.lblouttime.isHidden = true
                    }
                    
                    if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                        cell.lbladdedby.text = "Pre Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                    }else {
                        cell.lbladdedby.text = "Pre Approved by "
                    }
                    
                 cell.lbldateintime.isHidden = true
                 cell.lbldateintimeMulti.isHidden = true // Extra
                 cell.lblintime.isHidden = false
                 cell.lblouttime.isHidden = false
                 cell.lbladdedby.isHidden = false
                 cell.lblparceltime.isHidden = true
                 cell.lblLeaveatGate.isHidden = true
                 cell.lblcancelby.isHidden = true
                 cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */

                    cell.imgview1.isHidden = true
                    cell.imgview2.isHidden = false
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                     cell.imgview7.isHidden = true
                     cell.imgview8.isHidden = true
                     cell.imgviewExtra.isHidden = true
                      
                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = 64.5
                 cell.imgviewTop3.constant = 81.5
                 cell.imgviewTop4.constant = 98.5
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 120.5
                 
                 
                 cell.constraintHightStackBtn.constant = 0
                 cell.constraintHightStacklbl.constant = 0
                 cell.lblHightStacklblMiddle.isHidden = true
                 

                    cell.btnRenew.isHidden = true
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                } */
                else{
                    cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                     
                      cell.lbldateintime.isHidden = true
                      cell.lblintime.isHidden = true
                      cell.lblouttime.isHidden = true
                      cell.lbladdedby.isHidden = true
                      cell.lblparceltime.isHidden = true
                      cell.lblLeaveatGate.isHidden = true
                      cell.lblcancelby.isHidden = true
                      cell.lblWrongEntry.isHidden = true
                      cell.lbldateintimeMulti.isHidden = true // Extra


                      cell.imgview1.isHidden = true
                      cell.imgview2.isHidden = true
                      cell.imgview3.isHidden = true
                      cell.imgview4.isHidden = true
                      cell.imgview5.isHidden = true
                      cell.imgview6.isHidden = true
                      cell.imgview7.isHidden = true
                      cell.imgview8.isHidden = true
                      cell.imgviewExtra.isHidden = true

                 cell.constraintHightStackBtn.constant = 0
                 
                 cell.constraintHightStacklbl.constant = 0

                 cell.lblHightStacklblMiddle.isHidden = true
              
                 
                 cell.imgviewTop1.constant = -12
                 cell.imgviewTop2.constant = -12
                 cell.imgviewTop3.constant = -12
                 cell.imgviewTop4.constant = -12
                 cell.imgviewTop5.constant = -12
                 cell.imgviewTop6.constant = -12
                 cell.imgviewTop7.constant = -12
                 cell.imgviewTop8.constant = -12
                 cell.imgviewTopExtra.constant = -12

                    cell.stackviewStatus.constant = 80.5 // 69.5
                   
                 
                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                }
                
              
               cell.btnIn_OnDemand.isHidden = true
               cell.btnCancel_OnDemand.isHidden = true
               cell.btnOut_OnDemand.isHidden = true
               cell.btnEdit_OnDemand.isHidden = true
                 
                print("Service : Provider : Pre-Approval")

        } */
        
        
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "Emergency Alert " {
        
            cell.lblname.text = "Emergency"
            
            cell.lblguest.text = "Alert"
          
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "Group 16679"))
            
            cell.imgviewCompanyLogo.isHidden = true
            
            cell.lblStatus.isHidden = false

            
            let lblDate = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[0]
            let strDate = strChangeDateFormate(strDateeee: lblDate!)
            
            let lblTime = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

            cell.lbldateintime.text =  strTime + " , " + strDate

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.messageStatus
            
            // 13/1/20 temp comment

           /* cell.imgviewHight1.constant = 12
            cell.imgviewHight2.constant = 0
            cell.imgviewHight4.constant = 0
            cell.imgviewHight5.constant = 0
            cell.imgviewHight6.constant = 0
            cell.imgviewHight3.constant = 12 */
           

            cell.lblHightStacklblMiddle.isHidden = true
            
            cell.constraintHightStackBtn.constant = 50
            
            cell.constraintHightStacklbl.constant = 0.5

            cell.lbladdedby.text =  "Alert from " + (arrGuestList[indexPath.row].activity?.messageBy)!
            
             if cell.lblStatus.text == "RESOLVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if cell.lblStatus.text == "SENT" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if cell.lblStatus.text == "IN PROGRESS" {
                cell.lblStatus.backgroundColor = UIColor.systemRed
             }
             else{
                cell.lblStatus.backgroundColor = UIColor.systemRed
             }
            
            cell.lbldateintime.isHidden = false
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                 
            
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnWrong_Entry.isHidden = true
            cell.btnWrong_Entry_Red.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = false
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true

        }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Complaint to Guard" {
               
               cell.lblStatus.isHidden = false

               cell.lblname.text = "Complaint"
             
               cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_complaint"))

               cell.lblguest.text = "Alert"
               
               cell.imgviewCompanyLogo.isHidden = true
               

              // cell.lblintime.text = arrGuestList[indexPath.row].inTime!
               
               let lblDate = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[0]
               let strDate = strChangeDateFormate(strDateeee: lblDate!)
               
               let lblTime = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[1]
               let strTime = strChangeTimeFormate(strDateeee: lblTime!)

               cell.lbldateintime.text =  strTime + " , " + strDate

               cell.lblStatus.text = arrGuestList[indexPath.row].activity?.messageStatus
               
              
               // 13/1/20 temp comment

              /* cell.imgviewHight1.constant = 12
               cell.imgviewHight2.constant = 0
               cell.imgviewHight4.constant = 0
               cell.imgviewHight5.constant = 0
               cell.imgviewHight3.constant = 12 */

              
               cell.lblHightStacklblMiddle.isHidden = true
               
               cell.constraintHightStackBtn.constant = 50
               
               cell.constraintHightStacklbl.constant = 0.5

               cell.lbladdedby.text =  "Alert from " + (arrGuestList[indexPath.row].activity?.messageBy)!
               
                if cell.lblStatus.text == "RESOLVED" {
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                }else if cell.lblStatus.text == "SENT" {
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                }else if cell.lblStatus.text == "IN PROGRESS" {
                    cell.lblStatus.backgroundColor = UIColor.systemRed
                }else{
                   cell.lblStatus.backgroundColor = UIColor.systemRed
                }
               
            cell.lbldateintime.isHidden = false
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

            cell.imgviewTop1.constant = 64.5
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 103.5
                 
            
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnWrong_Entry.isHidden = true
            cell.btnWrong_Entry_Red.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = false
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true


           }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Message to Guard" {
            
            cell.lblStatus.isHidden = false

            cell.lblname.text = "Message to Guard"
          
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_message"))

            cell.lblguest.text = "Alert"
            
            cell.imgviewCompanyLogo.isHidden = true
            

           // cell.lblintime.text = arrGuestList[indexPath.row].inTime!
            
            let lblDate = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[0]
            let strDate = strChangeDateFormate(strDateeee: lblDate!)
            
            let lblTime = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

            cell.lbldateintime.text =  strTime + " , " + strDate

            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.messageStatus
            
            cell.lblHightStacklblMiddle.isHidden = false

            cell.constraintHightStackBtn.constant = 50
            
            cell.constraintHightStacklbl.constant = 0.5

            cell.lbladdedby.text =  "Alert from " + (arrGuestList[indexPath.row].activity?.messageBy)!
            
             if cell.lblStatus.text == "RESOLVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if cell.lblStatus.text == "SENT" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else{
                cell.lblStatus.backgroundColor = UIColor.systemRed
             }
            
            if arrGuestList[indexPath.row].isWrongEntry == 0 {
                

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12

                cell.imgviewHight2.constant = 0
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
                cell.imgviewHight3.constant = 12 */


                cell.lbldateintime.isHidden = false
                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = true
                cell.lblWrongEntry.isHidden = true
                cell.lbldateintimeMulti.isHidden = true // Extra


                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = true

                cell.imgviewTop1.constant = 64.5
                cell.imgviewTop2.constant = -12
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = 81.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = -12
                cell.imgviewTop8.constant = -12
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 103.5
                     
               

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true

                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = false
                
            }else{
                
                cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight3.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 12 */
               
                cell.lbldateintime.isHidden = false
                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = true
                cell.lblWrongEntry.isHidden = false
                cell.lbldateintimeMulti.isHidden = true // Extra

                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true

                cell.imgviewTop1.constant = 64.5
                cell.imgviewTop2.constant = -12
                cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = 81.5
                cell.imgviewTop5.constant = -12
                cell.imgviewTop6.constant = -12
                cell.imgviewTop7.constant = -12
                cell.imgviewTop8.constant = 98.5
                cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 120.5
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                
                cell.btnWrong_Entry_Red.isHidden = false
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = false
            }
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true

        }

        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Vehicle Added"{
             
             cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "scooter"))

             cell.lblStatus.isHidden = true

             if arrGuestList[indexPath.row].activity?.vehicleTypeID != nil {
                 cell.lblname.text = arrGuestList[indexPath.row].activity?.vehicleTypeID
             }else{
                 cell.lblname.text = ""
             }
            
            cell.imgviewCompanyLogo.isHidden = true

             cell.lblguest.text = arrGuestList[indexPath.row].activity?.vehicleNumber

             if arrGuestList[indexPath.row].activity?.addedBy != nil {
                 cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
             }
         
                 if arrGuestList[indexPath.row].activity?.creationDate != nil {
                     
                     let lblDate = arrGuestList[indexPath.row].activity?.creationDate?.components(separatedBy: " ")[0]
                     let strDate = strChangeDateFormate(strDateeee: lblDate!)
                     
                     let lblTime = arrGuestList[indexPath.row].activity?.creationDate?.components(separatedBy: " ")[1]
                     let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                     cell.lbldateintime.text =  strTime + " , " + strDate
                     
                 }
                 
           // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                 cell.imgviewHight3.constant = 12
                 cell.imgviewHight2.constant = 12
                 cell.imgviewHight4.constant = 0
                 cell.imgviewHight5.constant = 0
                 cell.imgviewHight6.constant = 0 */
                 
            cell.lbldateintime.isHidden = false
            cell.lblintime.isHidden = true
            cell.lblouttime.isHidden = true
            cell.lbladdedby.isHidden = false
            cell.lblparceltime.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblcancelby.isHidden = true
            cell.lblWrongEntry.isHidden = true
            cell.lbldateintimeMulti.isHidden = true // Extra


            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = false
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true
            cell.imgview7.isHidden = true
            cell.imgview8.isHidden = true
            cell.imgviewExtra.isHidden = true

      
            cell.imgviewTop1.constant = 64.5
       cell.imgviewTop2.constant = -12
       cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = 81.5
       cell.imgviewTop5.constant = -12
       cell.imgviewTop6.constant = -12
       cell.imgviewTop7.constant = -12
       cell.imgviewTop8.constant = -12
       cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 95 // 69.5
         
                     
                 cell.constraintHightStackBtn.constant = 0
                 
                 cell.constraintHightStacklbl.constant = 0

                 cell.lblHightStacklblMiddle.isHidden = true
                 
                 cell.btnCancel.isHidden = true
                 cell.btnEdit.isHidden = true
                 cell.btnWrong_Entry.isHidden = true
                 cell.btnWrong_Entry_Red.isHidden = true
                 cell.btnRenew.isHidden = true
                 cell.btnClose.isHidden = true
                 cell.btnNote_Guard.isHidden = true
                 cell.btnOut.isHidden = true
                 cell.btnDeliveryInfo.isHidden = true
                 cell.btnAlertInfo.isHidden = true
     
                 cell.btnIn_OnDemand.isHidden = true
                 cell.btnCancel_OnDemand.isHidden = true
                 cell.btnOut_OnDemand.isHidden = true
                 cell.btnEdit_OnDemand.isHidden = true
             
          }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Add Family Member"{
            
            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }else{
                cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "vendor-1"))
            }

                 cell.lblStatus.isHidden = true

                 if arrGuestList[indexPath.row].activity?.name != nil {
                     cell.lblname.text = arrGuestList[indexPath.row].activity?.name
                 }else{
                     cell.lblname.text = ""
                 }
                
                cell.imgviewCompanyLogo.isHidden = true

            if arrGuestList[indexPath.row].activity?.relation != nil {
                cell.lblguest.text = arrGuestList[indexPath.row].activity?.relation
            }else{
                cell.lblguest.text = "Family Member"
            }

                 if arrGuestList[indexPath.row].activity?.addedBy != nil {
                     cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                 }else{
                    cell.lbladdedby.text = "Added by "
                 }
             
                     if arrGuestList[indexPath.row].activity?.addedOn != nil {
                         
                         let lblDate = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lbldateintime.text =  strTime + " , " + strDate
                         
                     }
                     
               // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight2.constant = 12
                     cell.imgviewHight4.constant = 0
                     cell.imgviewHight5.constant = 0
                     cell.imgviewHight6.constant = 0 */
                     
                cell.lbldateintime.isHidden = false
                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = true
                cell.lblWrongEntry.isHidden = true
                cell.lbldateintimeMulti.isHidden = true // Extra


                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = true
                cell.imgviewExtra.isHidden = true

          
                cell.imgviewTop1.constant = 64.5
           cell.imgviewTop2.constant = -12
           cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = 81.5
           cell.imgviewTop5.constant = -12
           cell.imgviewTop6.constant = -12
           cell.imgviewTop7.constant = -12
           cell.imgviewTop8.constant = -12
           cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 95 // 69.5
             
                         
                     cell.constraintHightStackBtn.constant = 0
                     
                     cell.constraintHightStacklbl.constant = 0

                     cell.lblHightStacklblMiddle.isHidden = true
                     
                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true
         
                     cell.btnIn_OnDemand.isHidden = true
                     cell.btnCancel_OnDemand.isHidden = true
                     cell.btnOut_OnDemand.isHidden = true
                     cell.btnEdit_OnDemand.isHidden = true
                 
         }
         
         else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Remove Family Member"{
            
            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }else{
                cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "vendor-1"))
            }

                 cell.lblStatus.isHidden = true

                 if arrGuestList[indexPath.row].activity?.name != nil {
                     cell.lblname.text = arrGuestList[indexPath.row].activity?.name
                 }else{
                     cell.lblname.text = ""
                 }
                
                cell.imgviewCompanyLogo.isHidden = true

            if arrGuestList[indexPath.row].activity?.relation != nil {
                cell.lblguest.text = arrGuestList[indexPath.row].activity?.relation
            }else{
                cell.lblguest.text = "Family Member"
            }

                 if arrGuestList[indexPath.row].activity?.wrongEntryBy != nil {
                     cell.lblWrongEntry.text = "Removed by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                 }else{
                    cell.lblWrongEntry.text = "Removed by "
                 }
             
                     if arrGuestList[indexPath.row].activity?.deletedOn != nil {
                         
                         let lblDate = arrGuestList[indexPath.row].activity?.deletedOn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.deletedOn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lbldateintime.text =  strTime + " , " + strDate
                         
                     }
                     
               // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight2.constant = 12
                     cell.imgviewHight4.constant = 0
                     cell.imgviewHight5.constant = 0
                     cell.imgviewHight6.constant = 0 */
                     
                cell.lbldateintime.isHidden = false
                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = true
                cell.lblparceltime.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblcancelby.isHidden = true
                cell.lblWrongEntry.isHidden = false
                cell.lbldateintimeMulti.isHidden = true // Extra


                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                cell.imgview7.isHidden = true
                cell.imgview8.isHidden = false
                cell.imgviewExtra.isHidden = true

          
                cell.imgviewTop1.constant = 64.5
           cell.imgviewTop2.constant = -12
           cell.imgviewTop3.constant = -12
                cell.imgviewTop4.constant = -12
           cell.imgviewTop5.constant = -12
           cell.imgviewTop6.constant = -12
           cell.imgviewTop7.constant = -12
           cell.imgviewTop8.constant = 81.5
           cell.imgviewTopExtra.constant = -12

                cell.stackviewStatus.constant = 95 // 69.5
             
                         
                     cell.constraintHightStackBtn.constant = 0
                     
                     cell.constraintHightStacklbl.constant = 0

                     cell.lblHightStacklblMiddle.isHidden = true
                     
                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true
         
                     cell.btnIn_OnDemand.isHidden = true
                     cell.btnCancel_OnDemand.isHidden = true
                     cell.btnOut_OnDemand.isHidden = true
                     cell.btnEdit_OnDemand.isHidden = true
                 
         }
        else{
            cell.lblname.text = ""
            cell.lblguest.text = ""
            
            
             cell.lbldateintime.isHidden = true
             cell.lblintime.isHidden = true
             cell.lblouttime.isHidden = true
             cell.lbladdedby.isHidden = true
             cell.lblparceltime.isHidden = true
             cell.lblLeaveatGate.isHidden = true
             cell.lblcancelby.isHidden = true
             cell.lblWrongEntry.isHidden = true
             cell.lbldateintimeMulti.isHidden = true // Extra

            cell.lblStatus.isHidden = true

             cell.imgview1.isHidden = true
             cell.imgview2.isHidden = true
             cell.imgview3.isHidden = true
             cell.imgview4.isHidden = true
             cell.imgview5.isHidden = true
             cell.imgview6.isHidden = true
             cell.imgview7.isHidden = true
             cell.imgview8.isHidden = true
             cell.imgviewExtra.isHidden = true
            
            cell.imgviewTop1.constant = -12
            cell.imgviewTop2.constant = -12
            cell.imgviewTop3.constant = -12
            cell.imgviewTop4.constant = -12
            cell.imgviewTop5.constant = -12
            cell.imgviewTop6.constant = -12
            cell.imgviewTop7.constant = -12
            cell.imgviewTop8.constant = -12
            cell.imgviewTopExtra.constant = -12

            cell.stackviewStatus.constant = 69.5
              
            cell.imgviewCompanyLogo.isHidden = true

            cell.constraintHightStackBtn.constant = 0
            
            cell.constraintHightStacklbl.constant = 0

            cell.lblHightStacklblMiddle.isHidden = true
         
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            cell.btnWrong_Entry.isHidden = true
            cell.btnWrong_Entry_Red.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = true

            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true


        }
        
             cell.btncall.tag = indexPath.item
            
            cell.btnCancel.tag = indexPath.item
            cell.btnEdit.tag = indexPath.item
            cell.btnWrong_Entry.tag = indexPath.item
            cell.btnRenew.tag = indexPath.item
            cell.btnClose.tag = indexPath.item
            cell.btnAlertInfo.tag = indexPath.item

            cell.btnNote_Guard.tag = indexPath.item
            cell.btnOut.tag = indexPath.item
            
            cell.btnCancel_OnDemand.tag = indexPath.item
            cell.btnEdit_OnDemand.tag = indexPath.item
            cell.btnIn_OnDemand.tag = indexPath.item
            cell.btnOut_OnDemand.tag = indexPath.item


            cell.btncall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
            
            cell.btnCancel.addTarget(self, action:#selector(ApiCallCancel), for: .touchUpInside)
            cell.btnOut.addTarget(self, action:#selector(ApiCallOut_Exit), for: .touchUpInside)
            cell.btnWrong_Entry.addTarget(self, action:#selector(ApiCallWrong_Entry), for: .touchUpInside)
            
            cell.btnEdit.addTarget(self, action:#selector(ApiCallEdit), for: .touchUpInside) // renew
            
            cell.btnAlertInfo.addTarget(self, action:#selector(ApiCallAlertInfo), for: .touchUpInside)
            
            cell.btnRenew.addTarget(self, action:#selector(ApiCallEdit), for: .touchUpInside)

            cell.btnClose.addTarget(self, action:#selector(ApiCallClose), for: .touchUpInside)
            
             cell.btnNote_Guard.addTarget(self, action:#selector(ApiCallNote_to_Guard), for: .touchUpInside)
            

            cell.btnCancel_OnDemand.addTarget(self, action:#selector(ApiCallCancel_OnDemand), for: .touchUpInside)
            cell.btnEdit_OnDemand.addTarget(self, action:#selector(ApiCallEdit_OnDemand), for: .touchUpInside) // renew
            cell.btnIn_OnDemand.addTarget(self, action:#selector(ApiCallIn_OnDemand), for: .touchUpInside)
            cell.btnOut_OnDemand.addTarget(self, action:#selector(ApiCallOut_Exit_OnDemand), for: .touchUpInside)
            
        
        return cell
        
    }
    
    // aa comment ma che code
    
   /* func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
        
        if arrGuestList[indexPath.row].activity?.name != nil {
            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
        }
        
        if arrGuestList[indexPath.row].userActivityID != nil {
            
        }
        
//        if arrGuestList[indexPath.row].activity?.profilePic != nil {
//            cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
//        }
        
//       if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
//            cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
//            cell.imgviewCompanyLogo.isHidden = false
//        }else{
//            cell.imgviewCompanyLogo.isHidden = true
//        }
        
        if arrGuestList[indexPath.row].activity?.phone != nil {
            cell.btncall.isHidden = false
        }else{
            cell.btncall.isHidden = true
        }
        
        
         cell.btncall.tag = indexPath.item
        
         if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Visitor Entry" {
            
            cell.lblStatus.isHidden = false
            
            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }
            
          //  cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            
            cell.imgviewCompanyLogo.isHidden = true

            cell.lblguest.text = "Visitor"
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            
            cell.lbladdedby.isHidden = false
                        
           // cell.lblLeaveatGate.isHidden = true
            
            cell.btnDeliveryInfo.isHidden = true
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lbladdedby.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment
                    
                  /*  cell.imgviewHight1.constant = 12

                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0

                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    
                }else{

                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblWrongEntry.isHidden = false
                    
                    cell.imgviewStackTop3.constant = 27
                    cell.imgviewStackTop6.constant = 10

                    cell.imgviewTop3_1.constant = 5
                    cell.imgviewTop6_3.constant = 5

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 12 */

                    
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = false
                   
                    
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                }
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "CANCELLED" {
                                
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = false
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "EXPIRED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                
                cell.imgviewTop3_1.constant = 5
                
                cell.imgviewStackTop3.constant = 10

                cell.btnRenew.isHidden = false

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnCancel.isHidden = false
                cell.btnEdit.isHidden = false
                
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "APPROVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnClose.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                   // cell.imgviewTop6_3.constant = 0

                    cell.imgviewStackTop3.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false

                }
                
                // 13/1/20 temp comment
                
               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "DELIVERED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgviewHight6.constant = 0
                        cell.imgview6.isHidden = true
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop3.constant = 27
                        
                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgviewHight6.constant = 12
                        cell.imgview6.isHidden = false
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop6.constant = 10
                        
                      
                    }
                   
                    cell.imgview2.isHidden = true
                    
                    cell.imgviewHight2.constant = 0

                    cell.imgview5.isHidden = true

                    cell.imgview4.isHidden = true

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true
                
                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "LEFT" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "ADDED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true


                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true

                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "CHECKED IN" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

              //  cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

               if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                
                    cell.btnWrong_Entry.isHidden = false
                
                    cell.btnWrong_Entry_Red.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = false
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                     cell.lblWrongEntry.isHidden = true
                     cell.imgviewHight6.constant = 0
                     cell.imgview6.isHidden = true
                     
                     cell.imgviewTop3_1.constant = 5
                     
                     cell.imgviewStackTop3.constant = 27
                 
                    
                 }else{
                     cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                     cell.lblWrongEntry.isHidden = false
                     cell.imgviewHight6.constant = 12
                     cell.imgview6.isHidden = false
                     
                     cell.imgviewTop3_1.constant = 5

                     cell.imgviewStackTop6.constant = 10
                     
                 }
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
           
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    cell.lblintime.isHidden = false
            }else{
                cell.lblintime.isHidden = true
            }
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true

            
         /*   cell.imgview1.isHidden = true   // time
           // cell.imgview2.isHidden = true   // intime
           // cell.imgview3.isHidden = true   // outtime
           // cell.imgview4.isHidden = true   // approvedby
            cell.imgview5.isHidden = false   // addedby
            cell.imgview6.isHidden = true   // parcel collection time
            cell.imgview7.isHidden = true   // leave at gate
            cell.imgview8.isHidden = true   // cancel by you
            cell.imgview9.isHidden = true   // denied by you
            cell.imgview10.isHidden = true  // No response */
            

        }
         else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Visitor Pre-Approval" {
            
            cell.lblStatus.isHidden = false
            
            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }
            
          //  cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            
            cell.imgviewCompanyLogo.isHidden = true

            cell.lblguest.text = "Visitor"
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            
            cell.lbladdedby.isHidden = false
                        
            cell.lblLeaveatGate.isHidden = true
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lbladdedby.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12

                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0

                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    
                }else{

                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblWrongEntry.isHidden = false
                    
                    cell.imgviewStackTop3.constant = 27
                    cell.imgviewStackTop6.constant = 10

                    cell.imgviewTop3_1.constant = 5
                    cell.imgviewTop6_3.constant = 5

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 12 */
                    
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = false
                   
                    
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                }
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "CANCELLED" {
                                
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 22  // 27

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 0
                cell.constraintHightStacklbl.constant = 0
                cell.lblHightStacklblMiddle.isHidden = true //
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "EXPIRED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                
                cell.imgviewTop3_1.constant = 5
                
                cell.imgviewStackTop3.constant = 10

                cell.btnRenew.isHidden = false

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
            }
            else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnCancel.isHidden = false
                cell.btnEdit.isHidden = false
                
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "APPROVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnClose.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                   // cell.imgviewTop6_3.constant = 0

                    cell.imgviewStackTop3.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false

                }
                
                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "ADDED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true


                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true

                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                 
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "DELIVERED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgviewHight6.constant = 0
                        cell.imgview6.isHidden = true
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop3.constant = 27
                        
                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgviewHight6.constant = 12
                        cell.imgview6.isHidden = false
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop6.constant = 10
                        
                      
                    }
                   
                    cell.imgview2.isHidden = true
                    
                    cell.imgviewHight2.constant = 0

                    cell.imgview5.isHidden = true

                    cell.imgview4.isHidden = true

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true
                
                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "LEFT" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "CHECKED IN" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

              // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true
                
              if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                
                cell.btnWrong_Entry.isHidden = false
                
                cell.btnWrong_Entry_Red.isHidden = true
                

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
 
                    cell.btnWrong_Entry.isHidden = true
 
                    cell.btnWrong_Entry_Red.isHidden = false
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
               
                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            
            if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblin = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let lblout = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strIn = strChangeDateFormate(strDateeee: lblin!)
                    let strOut = strChangeDateFormate(strDateeee: lblout!)
                    cell.lblintime.text = strIn + " - " + strOut
                    cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
                
            }
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
                                    
        }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Cab Entry" {
            
            cell.lblStatus.isHidden = false

            cell.lblname.text = "Cab"
            
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "cab"))
            
            if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                 cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
                 cell.imgviewCompanyLogo.isHidden = false
             }else{
                 cell.imgviewCompanyLogo.isHidden = true
             }

            cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            cell.btnAlertInfo.isHidden = true

            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            
            cell.lbladdedby.isHidden = false
                        
            cell.lblLeaveatGate.isHidden = true
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lbladdedby.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0

                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    
                }else{

                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblWrongEntry.isHidden = false
                    
                    cell.imgviewStackTop3.constant = 27
                    cell.imgviewStackTop6.constant = 10

                    cell.imgviewTop3_1.constant = 5
                    cell.imgviewTop6_3.constant = 5

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 12 */

                    
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = false
                   
                    
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                }
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "CANCELLED" {
                                
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 0
                cell.constraintHightStacklbl.constant = 0
                cell.lblHightStacklblMiddle.isHidden = true //
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "EXPIRED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                
                cell.imgviewTop3_1.constant = 5
                
                cell.imgviewStackTop3.constant = 10

                cell.btnRenew.isHidden = false

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
            }
            else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnCancel.isHidden = false
                cell.btnEdit.isHidden = false
                
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "APPROVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnClose.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                   // cell.imgviewTop6_3.constant = 0

                    cell.imgviewStackTop3.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false

                }
                
                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "ADDED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true


                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true

                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "DELIVERED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgviewHight6.constant = 0
                        cell.imgview6.isHidden = true
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop3.constant = 27
                        
                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgviewHight6.constant = 12
                        cell.imgview6.isHidden = false
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop6.constant = 10
                        
                      
                    }
                   
                    cell.imgview2.isHidden = true
                    
                    cell.imgviewHight2.constant = 0

                    cell.imgview5.isHidden = true

                    cell.imgview4.isHidden = true

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true
                
                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "LEFT" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }

            else if cell.lblStatus.text == "CHECKED IN" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    
                    cell.btnWrong_Entry_Red.isHidden = true
                    
                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                                        
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                /* cell.viewHight1.constant = 28.5
                cell.viewHight2.constant = 0
                cell.viewHight3.constant = 28.5
                cell.viewHight4.constant = 0
                cell.viewHight5.constant = 0 */

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            

            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
          
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
            
        }
        
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Cab Pre-Approval" {
            
            cell.lblStatus.isHidden = false

            cell.lblname.text = "Cab"
            
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "cab"))
            
            if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                 cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
                 cell.imgviewCompanyLogo.isHidden = false
             }else{
                 cell.imgviewCompanyLogo.isHidden = true
             }
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName //vendor
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            cell.btnAlertInfo.isHidden = true

            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            
            cell.lbladdedby.isHidden = false
                        
            cell.lblLeaveatGate.isHidden = true
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lbladdedby.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12

                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0

                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    
                }else{

                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.lblWrongEntry.isHidden = false
                    
                    cell.imgviewStackTop3.constant = 27
                    cell.imgviewStackTop6.constant = 10

                    cell.imgviewTop3_1.constant = 5
                    cell.imgviewTop6_3.constant = 5

                    // 13/1/20 temp comment

                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 12 */

                    
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = false
                   
                    
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                }
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "CANCELLED" {
                                
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 0
                cell.constraintHightStacklbl.constant = 0
                cell.lblHightStacklblMiddle.isHidden = true //
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "EXPIRED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                
                cell.imgviewTop3_1.constant = 5
                
                cell.imgviewStackTop3.constant = 10

                cell.btnRenew.isHidden = false

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
            }
            else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnCancel.isHidden = false
                cell.btnEdit.isHidden = false
                
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "APPROVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10

                cell.btnClose.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                   // cell.imgviewTop6_3.constant = 0

                    cell.imgviewStackTop3.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false

                }
                
               /* if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5

                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false

                } */
                
                // 13/1/20 temp comment

             /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }

            else if cell.lblStatus.text == "ADDED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true


                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true

                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "DELIVERED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgviewHight6.constant = 0
                        cell.imgview6.isHidden = true
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop3.constant = 27
                        
                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgviewHight6.constant = 12
                        cell.imgview6.isHidden = false
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop6.constant = 10
                        
                      
                    }
                   
                    cell.imgview2.isHidden = true
                    
                    cell.imgviewHight2.constant = 0

                    cell.imgview5.isHidden = true

                    cell.imgview4.isHidden = true

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true
                
                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "LEFT" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }

            else if cell.lblStatus.text == "CHECKED IN" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

               if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
 
                    cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true


                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
 
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true

                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                /* cell.viewHight1.constant = 28.5
                cell.viewHight2.constant = 0
                cell.viewHight3.constant = 28.5
                cell.viewHight4.constant = 0
                cell.viewHight5.constant = 0 */

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            
            if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
            }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    let lblin = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let lblout = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strIn = strChangeDateFormate(strDateeee: lblin!)
                    let strOut = strChangeDateFormate(strDateeee: lblout!)
                    cell.lblintime.text = strIn + " - " + strOut
                    cell.lblintime.isHidden = false
                }else{
                    cell.lblintime.isHidden = true
                }
                
            }

            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
            
        }
         else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "Delivery Entry" {
            
            cell.lblStatus.isHidden = false

            cell.lblname.text = "Delivery"
            
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_delivery_tab"))
            
            if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                 cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
                 cell.imgviewCompanyLogo.isHidden = false
             }else{
                 cell.imgviewCompanyLogo.isHidden = true
             }
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
               
               cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
               
               cell.lbladdedby.isHidden = false
                           
             //  cell.lblLeaveatGate.isHidden = true
               
               cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
               
               if cell.lblStatus.text == "DENIED" {
                   cell.lblStatus.backgroundColor = AppColor.deniedColor
                   
                   cell.constraintHightStackBtn.constant = 50
                   cell.constraintHightStacklbl.constant = 0.5
                   cell.lblHightStacklblMiddle.isHidden = true
                   
                   cell.lbladdedby.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                   if arrGuestList[indexPath.row].isWrongEntry == 0 {
                       cell.btnWrong_Entry.isHidden = false
                       cell.btnWrong_Entry_Red.isHidden = true
                       
                       cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                     /*  cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight3.constant = 12
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0 */


                       cell.imgviewTop3_1.constant = 5

                       cell.lblouttime.isHidden = true
                       
                       cell.imgview2.isHidden = true
                       cell.imgview4.isHidden = true
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true
                       
                       if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                           cell.lblLeaveatGate.text = "Leave at Gate"
                           cell.imgview5.isHidden = false
                           cell.lblLeaveatGate.isHidden = false
                           cell.imgviewHight5.constant = 12

                           cell.imgviewStackTop3.constant = 27
                           
                       }else{
                           cell.imgview5.isHidden = true
                           cell.lblLeaveatGate.isHidden = true
                           cell.imgviewHight5.constant = 0
                       }
                       
                   }else{

                       cell.lblintime.isHidden = false
                       cell.lblouttime.isHidden = true
                       cell.lbladdedby.isHidden = false
                       cell.lblapprovedby.isHidden = true
                      // cell.lblLeaveatGate.isHidden = true
                       cell.lblWrongEntry.isHidden = false
                       
                       cell.imgviewStackTop3.constant = 27
                       cell.imgviewStackTop6.constant = 10

                       cell.imgviewTop3_1.constant = 5
                       cell.imgviewTop6_3.constant = 5

                    // 13/1/20 temp comment

                     /*  cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight3.constant = 12
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 12 */

                       
                       cell.imgview1.isHidden = false
                       cell.imgview2.isHidden = true
                       cell.imgview3.isHidden = false
                       cell.imgview4.isHidden = true
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = false
                      
                       cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                       
                      
                       if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                           cell.lblLeaveatGate.text = "Leave at Gate"
                           cell.imgview5.isHidden = false
                           cell.lblLeaveatGate.isHidden = false
                           cell.imgviewHight5.constant = 12
                           
                           cell.imgviewStackTop3.constant = 27

                       }else{
                           cell.imgview5.isHidden = true
                           cell.lblLeaveatGate.isHidden = true
                           cell.imgviewHight5.constant = 0
                       }
                       
                       cell.btnWrong_Entry_Red.isHidden = false
                       cell.btnWrong_Entry.isHidden = true
                   }
                   
                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   
                   cell.btnRenew.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true

               }else if cell.lblStatus.text == "CANCELLED" {
                                   
                   cell.lblStatus.backgroundColor = AppColor.cancelColor
                   
                   cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                   
                   if arrGuestList[indexPath.row].isWrongEntry == 0 {
                       cell.lblWrongEntry.isHidden = true
                       cell.imgviewHight6.constant = 0
                       cell.imgview6.isHidden = true
                       
                       cell.imgviewTop3_1.constant = 5
                       
                       cell.imgviewStackTop3.constant = 27
                       
                       
                       if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                           cell.lblLeaveatGate.text = "Leave at Gate"
                           cell.imgview5.isHidden = false
                           cell.lblLeaveatGate.isHidden = false
                           cell.imgviewHight5.constant = 12
                           
                           cell.imgviewStackTop3.constant = 27

                       }else{
                           cell.imgview5.isHidden = true
                           cell.lblLeaveatGate.isHidden = true
                           cell.imgviewHight5.constant = 0
                       }

                   }else{
                       cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                       cell.lblWrongEntry.isHidden = false
                       cell.imgviewHight6.constant = 12
                       cell.imgview6.isHidden = false
                       
                       cell.imgviewTop3_1.constant = 5

                       cell.imgviewStackTop6.constant = 10
                       
                       
                       if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                           cell.lblLeaveatGate.text = "Leave at Gate"
                           cell.imgview5.isHidden = false
                           cell.lblLeaveatGate.isHidden = false
                           cell.imgviewHight5.constant = 12
                           
                           cell.imgviewStackTop3.constant = 27

                       }else{
                           cell.imgview5.isHidden = true
                           cell.lblLeaveatGate.isHidden = true
                           cell.imgviewHight5.constant = 0
                       }
                       
                   }
                                   
                   cell.lblintime.isHidden = false
                   cell.lblouttime.isHidden = true
                   cell.lbladdedby.isHidden = false
                   cell.lblapprovedby.isHidden = false
                  // cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

                  /* cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 0
                   cell.imgviewHight3.constant = 12
                   cell.imgviewHight4.constant = 12 */
                  // cell.imgviewHight5.constant = 0
                   
                   cell.imgview1.isHidden = false
                   cell.imgview2.isHidden = true
                   cell.imgview3.isHidden = false
                   cell.imgview4.isHidden = false
                  // cell.imgview5.isHidden = true
                                   
                   cell.constraintHightStackBtn.constant = 0
                   cell.constraintHightStacklbl.constant = 0
                   cell.lblHightStacklblMiddle.isHidden = true //
                   
                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   cell.btnWrong_Entry.isHidden = true
                   cell.btnWrong_Entry_Red.isHidden = true
                   cell.btnRenew.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true

               }else if cell.lblStatus.text == "EXPIRED" {
                   cell.lblStatus.backgroundColor = AppColor.cancelColor
                   
                   cell.constraintHightStackBtn.constant = 50
                   cell.constraintHightStacklbl.constant = 0.5
                   cell.lblHightStacklblMiddle.isHidden = true
                   
                   cell.lblintime.isHidden = false
                   cell.lblouttime.isHidden = true
                   cell.lbladdedby.isHidden = false
                   cell.lblapprovedby.isHidden = true
                 //  cell.lblLeaveatGate.isHidden = true
                   cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

                  /* cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 0
                   cell.imgviewHight3.constant = 12
                   cell.imgviewHight4.constant = 0
                   cell.imgviewHight5.constant = 0
                   cell.imgviewHight6.constant = 0 */

                   cell.imgview1.isHidden = false
                   cell.imgview2.isHidden = true
                   cell.imgview3.isHidden = false
                   cell.imgview4.isHidden = true
                   cell.imgview5.isHidden = true
                   cell.imgview6.isHidden = true
                   
                   cell.imgviewTop3_1.constant = 5
                   
                   cell.imgviewStackTop3.constant = 10
                   
                  
                   if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                       cell.lblLeaveatGate.text = "Leave at Gate"
                       cell.imgview5.isHidden = false
                       cell.lblLeaveatGate.isHidden = false
                       cell.imgviewHight5.constant = 12
                       
                       cell.imgviewStackTop3.constant = 27

                   }else{
                       cell.imgview5.isHidden = true
                       cell.lblLeaveatGate.isHidden = true
                       cell.imgviewHight5.constant = 0
                   }

                   cell.btnRenew.isHidden = false

                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   cell.btnWrong_Entry.isHidden = true
                   cell.btnWrong_Entry_Red.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true
               }
               else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                   
                   cell.constraintHightStackBtn.constant = 50
                   cell.constraintHightStacklbl.constant = 0.5
                   cell.lblHightStacklblMiddle.isHidden = false
                   
                   
                   cell.lblintime.isHidden = false
                   cell.lblouttime.isHidden = true
                   cell.lbladdedby.isHidden = false
                   cell.lblapprovedby.isHidden = true
                  // cell.lblLeaveatGate.isHidden = true
                   cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

                  /* cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 0
                   cell.imgviewHight3.constant = 12
                   cell.imgviewHight4.constant = 0
                   cell.imgviewHight5.constant = 0
                   cell.imgviewHight6.constant = 0 */

                   cell.imgview1.isHidden = false
                   cell.imgview2.isHidden = true
                   cell.imgview3.isHidden = false
                   cell.imgview4.isHidden = true
                   cell.imgview5.isHidden = true
                   cell.imgview6.isHidden = true

                   cell.imgviewTop3_1.constant = 5

                   cell.imgviewStackTop3.constant = 10
                   
                   if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                       cell.lblLeaveatGate.text = "Leave at Gate"
                       cell.imgview5.isHidden = false
                       cell.lblLeaveatGate.isHidden = false
                       cell.imgviewHight5.constant = 12
                       
                       cell.imgviewStackTop3.constant = 27

                   }else{
                       cell.imgview5.isHidden = true
                       cell.lblLeaveatGate.isHidden = true
                       cell.imgviewHight5.constant = 0
                   }

                   cell.btnCancel.isHidden = false
                   cell.btnEdit.isHidden = false
                   
                   cell.btnWrong_Entry.isHidden = true
                   cell.btnWrong_Entry_Red.isHidden = true
                   cell.btnRenew.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true

               }
               else if cell.lblStatus.text == "APPROVED" {
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                   
                   cell.constraintHightStackBtn.constant = 50
                   cell.constraintHightStacklbl.constant = 0.5
                   cell.lblHightStacklblMiddle.isHidden = false
                   
                   cell.lblintime.isHidden = false
                   cell.lblouttime.isHidden = true
                   cell.lbladdedby.isHidden = false
                   cell.lblapprovedby.isHidden = true
                   cell.lblLeaveatGate.isHidden = true
                   cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

                  /* cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 0
                   cell.imgviewHight3.constant = 12
                   cell.imgviewHight4.constant = 0
                   cell.imgviewHight5.constant = 0
                   cell.imgviewHight6.constant = 0 */

                   cell.imgview1.isHidden = false
                   cell.imgview2.isHidden = true
                   cell.imgview3.isHidden = false
                   cell.imgview4.isHidden = true
                   cell.imgview5.isHidden = true
                   cell.imgview6.isHidden = true

                   cell.imgviewTop3_1.constant = 5

                   cell.imgviewStackTop3.constant = 10

                   cell.btnClose.isHidden = false
                   
                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   cell.btnWrong_Entry.isHidden = true
                   cell.btnWrong_Entry_Red.isHidden = true
                   cell.btnRenew.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true

               }
               else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                   // cell.imgviewTop6_3.constant = 0

                    cell.imgviewStackTop3.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false

                }
                
                // 13/1/20 temp comment
                
               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
               else if cell.lblStatus.text == "ADDED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true


                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true

                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true
                
                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
               else if cell.lblStatus.text == "DELIVERED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgviewHight6.constant = 0
                        cell.imgview6.isHidden = true
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop3.constant = 27
                        
                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgviewHight6.constant = 12
                        cell.imgview6.isHidden = false
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop6.constant = 10
                        
                      
                    }
                   
                    cell.imgview2.isHidden = true
                    
                    cell.imgviewHight2.constant = 0

                    cell.imgview5.isHidden = true

                    cell.imgview4.isHidden = true

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true
                
                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
               else if cell.lblStatus.text == "LEFT" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
               else if cell.lblStatus.text == "CHECKED IN" {
                   
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect

                  // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                   
                   if arrGuestList[indexPath.row].isWrongEntry == 0 {
                       cell.lblWrongEntry.isHidden = true
                       cell.imgviewHight6.constant = 0
                       cell.imgview6.isHidden = true
                       
                       cell.imgviewTop3_1.constant = 5
                       
                       cell.imgviewStackTop3.constant = 27
                    
                      cell.btnWrong_Entry.isHidden = false
                
                      cell.btnWrong_Entry_Red.isHidden = true

                   }else{
                       cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                       cell.lblWrongEntry.isHidden = false
                       cell.imgviewHight6.constant = 12
                       cell.imgview6.isHidden = false
                       
                       cell.imgviewTop3_1.constant = 5

                       cell.imgviewStackTop6.constant = 10
                    
                        cell.btnWrong_Entry.isHidden = true
                
                        cell.btnWrong_Entry_Red.isHidden = false
                       
                   }
                                   
                   cell.lblintime.isHidden = false
                   cell.lblouttime.isHidden = true
                   cell.lbladdedby.isHidden = false
                   cell.lblapprovedby.isHidden = false
                   cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

                  /* cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 0
                   cell.imgviewHight3.constant = 12
                   cell.imgviewHight4.constant = 12
                   cell.imgviewHight5.constant = 0 */
                   
                   cell.imgview1.isHidden = false
                   cell.imgview2.isHidden = true
                   cell.imgview3.isHidden = false
                   cell.imgview4.isHidden = false
                   cell.imgview5.isHidden = true
                                   
                   cell.constraintHightStackBtn.constant = 50
                   cell.constraintHightStacklbl.constant = 0.5
                   cell.lblHightStacklblMiddle.isHidden = false
                   
                   
                   cell.btnOut.isHidden = false
                   
                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   cell.btnRenew.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true

               }
               else{
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                   
                   cell.constraintHightStackBtn.constant = 0
                   
                   cell.constraintHightStacklbl.constant = 0

                   cell.lblHightStacklblMiddle.isHidden = true
                   
                  
                   cell.imgview5.isHidden = true

                   cell.imgview4.isHidden = true

                   cell.lblapprovedby.isHidden = true
                   
                   if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                       cell.lblLeaveatGate.text = "Leave at Gate"
                       cell.imgview5.isHidden = false
                       cell.lblLeaveatGate.isHidden = false
                       cell.imgviewHight5.constant = 12
                       
                       cell.imgviewStackTop3.constant = 27

                   }else{
                       cell.imgview5.isHidden = true
                       cell.lblLeaveatGate.isHidden = true
                       cell.imgviewHight5.constant = 0
                   }

                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   cell.btnWrong_Entry.isHidden = true
                   cell.btnWrong_Entry_Red.isHidden = true
                   cell.btnRenew.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true

               }
               
               
         /*  if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
               cell.lblLeaveatGate.text = "Leave at Gate"
               cell.imgview5.isHidden = false
               cell.lblLeaveatGate.isHidden = false
               cell.imgviewHight5.constant = 12

           }else{
               cell.imgview5.isHidden = true
               cell.lblLeaveatGate.isHidden = true
               cell.imgviewHight5.constant = 0
           } */
               
               
                
                let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                let strDate = strChangeDateFormate(strDateeee: lblDate!)
                
                let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                cell.lblintime.text =  strTime + " , " + strDate
                cell.lblintime.isHidden = false

            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
            
        }
         else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Delivery Pre-Approval" {
            
            cell.lblStatus.isHidden = false

         cell.lblname.text = "Delivery"
         
         cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_delivery_tab"))
         
         if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
              cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
              cell.imgviewCompanyLogo.isHidden = false
          }else{
              cell.imgviewCompanyLogo.isHidden = true
          }
         
         cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            
            cell.lbladdedby.isHidden = false
                        
          //  cell.lblLeaveatGate.isHidden = true
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lbladdedby.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                    
                    if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    }else{
                        cell.lblouttime.isHidden = false
                        cell.imgviewHight2.constant = 12
                        cell.imgviewTop3_1.constant = 22
                    }
                    
                    if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                        cell.lblLeaveatGate.text = "Leave at Gate"
                        cell.imgview5.isHidden = false
                        cell.lblLeaveatGate.isHidden = false
                        cell.imgviewHight5.constant = 12

                        cell.imgviewStackTop3.constant = 27
                        
                    }else{
                        cell.imgview5.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.imgviewHight5.constant = 0
                    }
                    
                }else{

                    cell.lblintime.isHidden = false
                    cell.lblouttime.isHidden = true
                    cell.lbladdedby.isHidden = false
                    cell.lblapprovedby.isHidden = true
                   // cell.lblLeaveatGate.isHidden = true
                    cell.lblWrongEntry.isHidden = false
                    
                    cell.imgviewStackTop3.constant = 27
                    cell.imgviewStackTop6.constant = 10

                    cell.imgviewTop3_1.constant = 5
                    cell.imgviewTop6_3.constant = 5

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight3.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 12 */

                    
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = true
                    cell.imgview3.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = false
                   
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    }else{
                        cell.lblouttime.isHidden = false
                        cell.imgviewHight2.constant = 12
                        cell.imgviewTop3_1.constant = 22
                    }
                    
                    if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                        cell.lblLeaveatGate.text = "Leave at Gate"
                        cell.imgview5.isHidden = false
                        cell.lblLeaveatGate.isHidden = false
                        cell.imgviewHight5.constant = 12
                        
                        cell.imgviewStackTop3.constant = 27

                    }else{
                        cell.imgview5.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.imgviewHight5.constant = 0
                    }
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                }
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "CANCELLED" {
                                
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    }else{
                        cell.lblouttime.isHidden = false
                        cell.imgviewHight2.constant = 12
                        cell.imgviewTop3_1.constant = 22
                    }
                    
                    if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                        cell.lblLeaveatGate.text = "Leave at Gate"
                        cell.imgview5.isHidden = false
                        cell.lblLeaveatGate.isHidden = false
                        cell.imgviewHight5.constant = 12
                        
                        cell.imgviewStackTop3.constant = 27

                    }else{
                        cell.imgview5.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.imgviewHight5.constant = 0
                    }

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                    }else{
                        cell.lblouttime.isHidden = false
                        cell.imgviewHight2.constant = 12
                    }
                    
                    if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                        cell.lblLeaveatGate.text = "Leave at Gate"
                        cell.imgview5.isHidden = false
                        cell.lblLeaveatGate.isHidden = false
                        cell.imgviewHight5.constant = 12
                        
                        cell.imgviewStackTop3.constant = 27

                    }else{
                        cell.imgview5.isHidden = true
                        cell.lblLeaveatGate.isHidden = true
                        cell.imgviewHight5.constant = 0
                    }
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
               // cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12 */
               // cell.imgviewHight5.constant = 0
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
               // cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 0
                cell.constraintHightStacklbl.constant = 0
                cell.lblHightStacklblMiddle.isHidden = true //
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }else if cell.lblStatus.text == "EXPIRED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
              //  cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
                
                cell.imgviewTop3_1.constant = 5
                
                cell.imgviewStackTop3.constant = 10
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                }else{
                    cell.lblouttime.isHidden = false
                    cell.imgviewHight2.constant = 12
                    cell.imgviewTop3_1.constant = 22
                }
                
                if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                    cell.lblLeaveatGate.text = "Leave at Gate"
                    cell.imgview5.isHidden = false
                    cell.lblLeaveatGate.isHidden = false
                    cell.imgviewHight5.constant = 12
                    
                    cell.imgviewStackTop3.constant = 27

                }else{
                    cell.imgview5.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.imgviewHight5.constant = 0
                }

                cell.btnRenew.isHidden = false

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
            }
            else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
               // cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                }else{
                    cell.lblouttime.isHidden = false
                    cell.imgviewHight2.constant = 12
                    cell.imgviewTop3_1.constant = 22
                }
                
                if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                    cell.lblLeaveatGate.text = "Leave at Gate"
                    cell.imgview5.isHidden = false
                    cell.lblLeaveatGate.isHidden = false
                    cell.imgviewHight5.constant = 12
                    
                    cell.imgviewStackTop3.constant = 27

                }else{
                    cell.imgview5.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.imgviewHight5.constant = 0
                }

                cell.btnCancel.isHidden = false
                cell.btnEdit.isHidden = false
                
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "APPROVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = true

                // 13/1/20 temp comment

             /*   cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.imgviewTop3_1.constant = 5

                cell.imgviewStackTop3.constant = 10
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                }else{
                    cell.lblouttime.isHidden = false
                    cell.imgviewHight2.constant = 12
                    cell.imgviewTop3_1.constant = 22
                }
                
                if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                    cell.lblLeaveatGate.text = "Leave at Gate"
                    cell.imgview5.isHidden = false
                    cell.lblLeaveatGate.isHidden = false
                    cell.imgviewHight5.constant = 12
                    
                    cell.imgviewStackTop3.constant = 27

                }else{
                    cell.imgview5.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.imgviewHight5.constant = 0
                }
                

                cell.btnClose.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "VISITED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.constraintHightStackBtn.constant = 50

                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                   // cell.imgviewTop6_3.constant = 0

                    cell.imgviewStackTop3.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false

                }
                
                // 13/1/20 temp comment
                
               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0 */

                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                }else{
                    cell.lblouttime.isHidden = false
                    cell.imgviewHight2.constant = 12
                    cell.imgviewTop3_1.constant = 22
                }
                
                if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                    cell.lblLeaveatGate.text = "Leave at Gate"
                    cell.imgview5.isHidden = false
                    cell.lblLeaveatGate.isHidden = false
                    cell.imgviewHight5.constant = 12
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 1 {
                        cell.imgviewStackTop6.constant = 10
                    }

                }else{
                    cell.imgview5.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.imgviewHight5.constant = 0
                }
                

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "ADDED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

               // cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true


                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    cell.btnWrong_Entry.isHidden = true

                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                }else{
                    cell.lblouttime.isHidden = false
                    cell.imgviewHight2.constant = 12
                    cell.imgviewTop3_1.constant = 22
                }
                
                if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                    cell.lblLeaveatGate.text = "Leave at Gate"
                    cell.imgview5.isHidden = false
                    cell.lblLeaveatGate.isHidden = false
                    cell.imgviewHight5.constant = 12
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 1 {
                        cell.imgviewStackTop6.constant = 10
                    }

                }else{
                    cell.imgview5.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.imgviewHight5.constant = 0
                }
                
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "DELIVERED" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 0 {
                        cell.lblWrongEntry.isHidden = true
                        cell.imgviewHight6.constant = 0
                        cell.imgview6.isHidden = true
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop3.constant = 27
                        
                    }else{
                        cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                        cell.lblWrongEntry.isHidden = false
                        cell.imgviewHight6.constant = 12
                        cell.imgview6.isHidden = false
                        
                        cell.imgviewTop3_1.constant = 5
                        
                        cell.imgviewTop6_3.constant = 5

                        cell.imgviewStackTop6.constant = 10
                        
                      
                    }
                   
                    cell.imgview2.isHidden = true
                    
                    cell.imgviewHight2.constant = 0

                    cell.imgview5.isHidden = true

                    cell.imgview4.isHidden = true

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true
                
                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                }else{
                    cell.lblouttime.isHidden = false
                    cell.imgviewHight2.constant = 12
                    cell.imgviewTop3_1.constant = 22
                }
                
                if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                    cell.lblLeaveatGate.text = "Leave at Gate"
                    cell.imgview5.isHidden = false
                    cell.lblLeaveatGate.isHidden = false
                    cell.imgviewHight5.constant = 12
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    if arrGuestList[indexPath.row].isWrongEntry == 1 {
                        cell.imgviewStackTop6.constant = 10
                    }

                }else{
                    cell.imgview5.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.imgviewHight5.constant = 0
                }
                

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else if cell.lblStatus.text == "LEFT" {  // right
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true

                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }

            else if cell.lblStatus.text == "CHECKED IN" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

              //  cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                
                cell.lblapprovedby.isHidden = true

                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    cell.lblWrongEntry.isHidden = true
                    cell.imgviewHight6.constant = 0
                    cell.imgview6.isHidden = true
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.btnWrong_Entry.isHidden = false
              
                    cell.btnWrong_Entry_Red.isHidden = true

                }else{
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    cell.lblWrongEntry.isHidden = false
                    cell.imgviewHight6.constant = 12
                    cell.imgview6.isHidden = false
                    
                    cell.imgviewTop3_1.constant = 5

                    cell.imgviewStackTop6.constant = 10
                    
                    cell.btnWrong_Entry.isHidden = true
              
                    cell.btnWrong_Entry_Red.isHidden = false
                    
                }
                                
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = false
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 12
                cell.imgviewHight4.constant = 12
                cell.imgviewHight5.constant = 0 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = false
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                                
                cell.constraintHightStackBtn.constant = 50
                cell.constraintHightStacklbl.constant = 0.5
                cell.lblHightStacklblMiddle.isHidden = false
                
                
                cell.btnOut.isHidden = false
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
               
                cell.imgview5.isHidden = true

                cell.imgview4.isHidden = true

                cell.lblapprovedby.isHidden = true
                
                if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                }else{
                    cell.lblouttime.isHidden = false
                    cell.imgviewHight2.constant = 12
                    cell.imgviewTop3_1.constant = 22
                }
                
                if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
                    cell.lblLeaveatGate.text = "Leave at Gate"
                    cell.imgview5.isHidden = false
                    cell.lblLeaveatGate.isHidden = false
                    cell.imgviewHight5.constant = 12
                    
                    cell.imgviewStackTop3.constant = 27

                }else{
                    cell.imgview5.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    cell.imgviewHight5.constant = 0
                }

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            
            
      /*  if arrGuestList[indexPath.row].activity?.leaveAtGate == "1" {
            cell.lblLeaveatGate.text = "Leave at Gate"
            cell.imgview5.isHidden = false
            cell.lblLeaveatGate.isHidden = false
            cell.imgviewHight5.constant = 12

        }else{
            cell.imgview5.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.imgviewHight5.constant = 0
        } */
            
            
            
         if arrGuestList[indexPath.row].activity?.isMulti == "0" {
             
             let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
             let strDate = strChangeDateFormate(strDateeee: lblDate!)
             
             let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
             let strTime = strChangeTimeFormate(strDateeee: lblTime!)

             cell.lblintime.text =  strTime + " , " + strDate
             cell.lblintime.isHidden = false

         }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
             
             let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
             let strDate = strChangeDateFormate(strDateeee: lblDate!)
             
             let lblDate1 = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
             let strDate1 = strChangeDateFormate(strDateeee: lblDate1!)

             cell.lblintime.text =  strDate + " - " + strDate1
             cell.lblintime.isHidden = false
         
             let lblTime = arrGuestList[indexPath.row].activity?.allowedInTime!
             let strTime = strChangeTimeFormate(strDateeee: lblTime!)
             
             let lblTime1 = arrGuestList[indexPath.row].activity?.allowedOutTime!
             let strTime1 = strChangeTimeFormate(strDateeee: lblTime1!)
             
             cell.lblouttime.text =  strTime + " - " + strTime1

            // cell.viewHight2.constant = 28.5
             cell.lblouttime.isHidden = false

         }
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
         
        }
        
         else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType! == "Service Provider Pre-Approval" {

             cell.lblStatus.isHidden = false

             cell.lblname.text = "Service Provider"
             
             cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_service"))
             
            if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
                  cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
                  cell.imgviewCompanyLogo.isHidden = false
              }else{
                  cell.imgviewCompanyLogo.isHidden = true
              }

             if arrGuestList[indexPath.row].activity?.companyName != nil {
                 cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
             }else{
                cell.lblguest.text = ""

             }
             
           //  cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
                
              
              //  cell.lblLeaveatGate.isHidden = true
            
                 cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
                 
                 cell.btnAlertInfo.isHidden = true

                 cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
                 
                 cell.lbladdedby.isHidden = false
                             
                 cell.lblLeaveatGate.isHidden = true
                 
                 cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
                 
                 if cell.lblStatus.text == "DENIED" {
                     cell.lblStatus.backgroundColor = AppColor.deniedColor
                     
                     cell.constraintHightStackBtn.constant = 50
                     
                     cell.constraintHightStacklbl.constant = 0.5

                     cell.lblHightStacklblMiddle.isHidden = true
                     
                     cell.lbladdedby.text = "denied by " + (arrGuestList[indexPath.row].activity?.addedBy)!

                     if arrGuestList[indexPath.row].isWrongEntry == 0 {
                         cell.btnWrong_Entry.isHidden = false
                         cell.btnWrong_Entry_Red.isHidden = true
                         
                         cell.imgviewStackTop3.constant = 10

                        // 13/1/20 temp comment

                       /*  cell.imgviewHight1.constant = 12
                         cell.imgviewHight2.constant = 0
                         cell.imgviewHight4.constant = 0
                         cell.imgviewHight5.constant = 0
                         cell.imgviewHight6.constant = 0

                         cell.imgviewHight3.constant = 12 */

                         cell.imgviewTop3_1.constant = 5

                         cell.lblouttime.isHidden = true
                         
                         cell.imgview2.isHidden = true
                         cell.imgview4.isHidden = true
                         cell.imgview5.isHidden = true
                         cell.imgview6.isHidden = true
                         
                     }else{

                         cell.lblintime.isHidden = false
                         cell.lblouttime.isHidden = true
                         cell.lbladdedby.isHidden = false
                         cell.lblapprovedby.isHidden = true
                         cell.lblLeaveatGate.isHidden = true
                         cell.lblWrongEntry.isHidden = false
                         
                         cell.imgviewStackTop3.constant = 27
                         cell.imgviewStackTop6.constant = 10

                         cell.imgviewTop3_1.constant = 5
                         cell.imgviewTop6_3.constant = 5

                        // 13/1/20 temp comment

                        /* cell.imgviewHight1.constant = 12
                         cell.imgviewHight2.constant = 0
                         cell.imgviewHight3.constant = 12
                         cell.imgviewHight4.constant = 0
                         cell.imgviewHight5.constant = 0
                         cell.imgviewHight6.constant = 12 */

                         
                         cell.imgview1.isHidden = false
                         cell.imgview2.isHidden = true
                         cell.imgview3.isHidden = false
                         cell.imgview4.isHidden = true
                         cell.imgview5.isHidden = true
                         cell.imgview6.isHidden = false
                        
                         
                         cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                         
                         cell.btnWrong_Entry_Red.isHidden = false
                         cell.btnWrong_Entry.isHidden = true
                     }
                     
                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                 }else if cell.lblStatus.text == "CANCELLED" {
                                     
                     cell.lblStatus.backgroundColor = AppColor.cancelColor
                     
                     cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!
                     
                     if arrGuestList[indexPath.row].isWrongEntry == 0 {
                         cell.lblWrongEntry.isHidden = true
                         cell.imgviewHight6.constant = 0
                         cell.imgview6.isHidden = true
                         
                         cell.imgviewTop3_1.constant = 5
                         
                         cell.imgviewStackTop3.constant = 27

                     }else{
                         cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                         cell.lblWrongEntry.isHidden = false
                         cell.imgviewHight6.constant = 12
                         cell.imgview6.isHidden = false
                         
                         cell.imgviewTop3_1.constant = 5

                         cell.imgviewStackTop6.constant = 10
                         
                     }
                                     
                     cell.lblintime.isHidden = false
                     cell.lblouttime.isHidden = true
                     cell.lbladdedby.isHidden = false
                     cell.lblapprovedby.isHidden = false
                     cell.lblLeaveatGate.isHidden = true

                    // 13/1/20 temp comment

                   /*  cell.imgviewHight1.constant = 12
                     cell.imgviewHight2.constant = 0
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight4.constant = 12
                     cell.imgviewHight5.constant = 0 */
                     
                     cell.imgview1.isHidden = false
                     cell.imgview2.isHidden = true
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = false
                     cell.imgview5.isHidden = true
                     
                                     
                     cell.constraintHightStackBtn.constant = 0
                     cell.constraintHightStacklbl.constant = 0
                     cell.lblHightStacklblMiddle.isHidden = true //
                     
                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                 }else if cell.lblStatus.text == "EXPIRED" {
                     cell.lblStatus.backgroundColor = AppColor.cancelColor
                     
                     cell.constraintHightStackBtn.constant = 50
                     cell.constraintHightStacklbl.constant = 0.5
                     cell.lblHightStacklblMiddle.isHidden = true
                     
                     cell.lblintime.isHidden = false
                     cell.lblouttime.isHidden = true
                     cell.lbladdedby.isHidden = false
                     cell.lblapprovedby.isHidden = true
                     cell.lblLeaveatGate.isHidden = true
                     cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                    /* cell.imgviewHight1.constant = 12
                     cell.imgviewHight2.constant = 0
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight4.constant = 0
                     cell.imgviewHight5.constant = 0
                     cell.imgviewHight6.constant = 0 */

                     cell.imgview1.isHidden = false
                     cell.imgview2.isHidden = true
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = true
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true
                     
                     cell.imgviewTop3_1.constant = 5
                     
                     cell.imgviewStackTop3.constant = 10

                     cell.btnRenew.isHidden = false

                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true
                 }
                 else if cell.lblStatus.text == "PRE-APPROVAL" || cell.lblStatus.text == "PRE-APPROVED" {  // right
                     cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                     
                     cell.constraintHightStackBtn.constant = 50
                     cell.constraintHightStacklbl.constant = 0.5
                     cell.lblHightStacklblMiddle.isHidden = false
                     
                     
                     cell.lblintime.isHidden = false
                     cell.lblouttime.isHidden = true
                     cell.lbladdedby.isHidden = false
                     cell.lblapprovedby.isHidden = true
                     cell.lblLeaveatGate.isHidden = true
                     cell.lblWrongEntry.isHidden = true

                    // 13/1/20 temp comment

                    /* cell.imgviewHight1.constant = 12
                     cell.imgviewHight2.constant = 0
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight4.constant = 0
                     cell.imgviewHight5.constant = 0
                     cell.imgviewHight6.constant = 0 */

                     cell.imgview1.isHidden = false
                     cell.imgview2.isHidden = true
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = true
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true

                     cell.imgviewTop3_1.constant = 5

                     cell.imgviewStackTop3.constant = 10

                     cell.btnCancel.isHidden = false
                     cell.btnEdit.isHidden = false
                     
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                 }
                 else if cell.lblStatus.text == "APPROVED" {
                     cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                     

                     cell.constraintHightStackBtn.constant = 50
                     cell.constraintHightStacklbl.constant = 0.5
                     cell.lblHightStacklblMiddle.isHidden = false
                     
                     cell.lblintime.isHidden = false
                     cell.lblouttime.isHidden = true
                     cell.lbladdedby.isHidden = false
                     cell.lblapprovedby.isHidden = true
                     cell.lblLeaveatGate.isHidden = true
                     cell.lblWrongEntry.isHidden = true
                    
                    // 13/1/20 temp comment

                  /*   cell.imgviewHight1.constant = 12
                     cell.imgviewHight2.constant = 0
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight4.constant = 0
                     cell.imgviewHight5.constant = 0
                     cell.imgviewHight6.constant = 0 */

                     cell.imgview1.isHidden = false
                     cell.imgview2.isHidden = true
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = true
                     cell.imgview5.isHidden = true
                     cell.imgview6.isHidden = true

                     cell.imgviewTop3_1.constant = 5

                     cell.imgviewStackTop3.constant = 10

                     cell.btnClose.isHidden = false
                     
                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                 }
                 else if cell.lblStatus.text == "VISITED" {
                     cell.lblStatus.backgroundColor = AppColor.cancelColor
                     
                     cell.constraintHightStackBtn.constant = 50

                     cell.constraintHightStacklbl.constant = 0.5

                     cell.lblHightStacklblMiddle.isHidden = true
                     
                     cell.lblapprovedby.isHidden = true
                     
                     if arrGuestList[indexPath.row].isWrongEntry == 0 {
                         cell.lblWrongEntry.isHidden = true
                         cell.imgviewHight6.constant = 0
                         cell.imgview6.isHidden = true
                         
                         cell.imgviewTop3_1.constant = 5
                         
                        // cell.imgviewTop6_3.constant = 0

                         cell.imgviewStackTop3.constant = 10
                         
                         cell.btnWrong_Entry.isHidden = false
                         cell.btnWrong_Entry_Red.isHidden = true

                         cell.imgviewHight6.constant = 0
                         cell.imgview6.isHidden = true

                     }else{
                         cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                         cell.lblWrongEntry.isHidden = false
                         cell.imgviewHight6.constant = 12
                         cell.imgview6.isHidden = false
                         
                         cell.imgviewTop3_1.constant = 5
                         
                         cell.imgviewTop6_3.constant = 5
                         
                         cell.imgviewStackTop3.constant = 27

                         cell.imgviewStackTop6.constant = 10
                         
                         cell.btnWrong_Entry_Red.isHidden = false
                         cell.btnWrong_Entry.isHidden = true
                         
                         cell.imgviewHight6.constant = 12
                         cell.imgview6.isHidden = false

                     }
                     
                    // 13/1/20 temp comment

                    /* cell.imgviewHight1.constant = 12
                     cell.imgviewHight2.constant = 0
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight4.constant = 0
                     cell.imgviewHight5.constant = 0 */

                     cell.imgview1.isHidden = false
                     cell.imgview2.isHidden = true
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = true
                     cell.imgview5.isHidden = true

                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                 }
                 else if cell.lblStatus.text == "CHECKED OUT" {
                     cell.lblStatus.backgroundColor = AppColor.cancelColor
                     
                     cell.constraintHightStackBtn.constant = 50

                     cell.constraintHightStacklbl.constant = 0.5

                     cell.lblHightStacklblMiddle.isHidden = true
                     
                     cell.lblapprovedby.isHidden = true
                     
                     if arrGuestList[indexPath.row].isWrongEntry == 0 {
                         cell.lblWrongEntry.isHidden = true
                         cell.imgviewHight6.constant = 0
                         cell.imgview6.isHidden = true
                         
                         cell.imgviewTop3_1.constant = 5
                         
                        // cell.imgviewTop6_3.constant = 0

                         cell.imgviewStackTop3.constant = 10
                         
                         cell.btnWrong_Entry.isHidden = false
                         cell.btnWrong_Entry_Red.isHidden = true

                         cell.imgviewHight6.constant = 0
                         cell.imgview6.isHidden = true

                     }else{
                         cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                         cell.lblWrongEntry.isHidden = false
                         cell.imgviewHight6.constant = 12
                         cell.imgview6.isHidden = false
                         
                         cell.imgviewTop3_1.constant = 5
                         
                         cell.imgviewTop6_3.constant = 5
                         
                         cell.imgviewStackTop3.constant = 27

                         cell.imgviewStackTop6.constant = 10
                         
                         cell.btnWrong_Entry_Red.isHidden = false
                         cell.btnWrong_Entry.isHidden = true
                         
                         cell.imgviewHight6.constant = 12
                         cell.imgview6.isHidden = false

                     }
                     
                    // 13/1/20 temp comment

                    /* cell.imgviewHight1.constant = 12
                     cell.imgviewHight2.constant = 0
                     cell.imgviewHight3.constant = 12
                     cell.imgviewHight4.constant = 0
                     cell.imgviewHight5.constant = 0 */

                     cell.imgview1.isHidden = false
                     cell.imgview2.isHidden = true
                     cell.imgview3.isHidden = false
                     cell.imgview4.isHidden = true
                     cell.imgview5.isHidden = true

                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = false
                     cell.btnOut.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                 }
                 else{
                     cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                     
                     cell.constraintHightStackBtn.constant = 0
                     
                     cell.constraintHightStacklbl.constant = 0

                     cell.lblHightStacklblMiddle.isHidden = true
                     
                     /* cell.viewHight1.constant = 28.5
                     cell.viewHight2.constant = 0
                     cell.viewHight3.constant = 28.5
                     cell.viewHight4.constant = 0
                     cell.viewHight5.constant = 0 */

                     cell.imgview5.isHidden = true

                     cell.imgview4.isHidden = true

                     cell.lblapprovedby.isHidden = true

                     cell.btnCancel.isHidden = true
                     cell.btnEdit.isHidden = true
                     cell.btnWrong_Entry.isHidden = true
                     cell.btnWrong_Entry_Red.isHidden = true
                     cell.btnRenew.isHidden = true
                     cell.btnClose.isHidden = true
                     cell.btnNote_Guard.isHidden = true
                     cell.btnOut.isHidden = true
                     cell.btnDeliveryInfo.isHidden = true
                     cell.btnAlertInfo.isHidden = true

                 }
                 
                 if arrGuestList[indexPath.row].activity?.isMulti == "0" {
                     if arrGuestList[indexPath.row].activity?.activityIn != nil {
                         let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lblintime.text =  strTime + " , " + strDate
                         cell.lblintime.isHidden = false
                     }else{
                         cell.lblintime.isHidden = true
                     }
                 }else if arrGuestList[indexPath.row].activity?.isMulti == "1" {
                     if arrGuestList[indexPath.row].activity?.activityIn != nil {
                         let lblin = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                         let lblout = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                         let strIn = strChangeDateFormate(strDateeee: lblin!)
                         let strOut = strChangeDateFormate(strDateeee: lblout!)
                         cell.lblintime.text = strIn + " - " + strOut
                         cell.lblintime.isHidden = false
                     }else{
                         cell.lblintime.isHidden = true
                     }
                     
                 }else{
                     if arrGuestList[indexPath.row].activity?.activityIn != nil {
                         let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                         let strDate = strChangeDateFormate(strDateeee: lblDate!)
                         
                         let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                         let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                         cell.lblintime.text =  strTime + " , " + strDate
                         cell.lblintime.isHidden = false
                     }else{
                         cell.lblintime.isHidden = true
                     }
                 }
                
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true
              
             print("Service : Provider : Pre-Approval")

         }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "Emergency Alert " {
        
            cell.lblStatus.isHidden = false
            
            cell.lblname.text = "Emergency"
          
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "Group 16679"))
            
            cell.imgviewCompanyLogo.isHidden = true

            cell.lblguest.text = "Alert"
            
           // cell.lblintime.text = arrGuestList[indexPath.row].inTime!
            
            let lblDate = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[0]
            let strDate = strChangeDateFormate(strDateeee: lblDate!)
            
            let lblTime = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

            cell.lblintime.text =  strTime + " , " + strDate
            cell.lblintime.isHidden = false

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.messageStatus
            
            cell.lblouttime.isHidden = true
            cell.lblapprovedby.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            cell.lblWrongEntry.isHidden = true

           // cell.imgviewStackTop1.constant = 27
            
            cell.imgviewStackTop3.constant = 10
            
          //  cell.imgviewStackTop4.constant = 0
            
          //  cell.imgviewStackTop5.constant = 0

            // 13/1/20 temp comment

           /* cell.imgviewHight1.constant = 12
            cell.imgviewHight2.constant = 0
            cell.imgviewHight4.constant = 0
            cell.imgviewHight5.constant = 0
            cell.imgviewHight6.constant = 0
            cell.imgviewHight3.constant = 12 */

            cell.imgviewTop3_1.constant = 5

            cell.lblouttime.isHidden = true
            
            cell.imgview2.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true

            cell.lblHightStacklblMiddle.isHidden = true
            
            cell.constraintHightStackBtn.constant = 50
            
            cell.constraintHightStacklbl.constant = 0.5

            cell.lbladdedby.text =  "Alert from " + (arrGuestList[indexPath.row].activity?.messageBy)!
            
             if cell.lblStatus.text == "RESOLVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if cell.lblStatus.text == "SENT" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if cell.lblStatus.text == "IN PROGRESS" {
                cell.lblStatus.backgroundColor = UIColor.systemRed
             }
             else{
                cell.lblStatus.backgroundColor = UIColor.systemRed
             }
            
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnWrong_Entry.isHidden = true
            cell.btnWrong_Entry_Red.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = false
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true

        }
     else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Complaint to Guard" {
            
            cell.lblStatus.isHidden = false

            
            cell.lblname.text = "Complaint"
          
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_complaint"))

            cell.lblguest.text = "Alert"
            
            cell.imgviewCompanyLogo.isHidden = true
            
            cell.lblLeaveatGate.isHidden = true

           // cell.lblintime.text = arrGuestList[indexPath.row].inTime!
            
            let lblDate = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[0]
            let strDate = strChangeDateFormate(strDateeee: lblDate!)
            
            let lblTime = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

            cell.lblintime.text =  strTime + " , " + strDate
            cell.lblintime.isHidden = false

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.messageStatus
            
            cell.lblouttime.isHidden = true
            cell.lblapprovedby.isHidden = true
            cell.lblLeaveatGate.isHidden = true
            
           // cell.imgviewStackTop1.constant = 27
            
            cell.imgviewStackTop3.constant = 10
            
          //  cell.imgviewStackTop4.constant = 0
            
          //  cell.imgviewStackTop5.constant = 0

            // 13/1/20 temp comment

           /* cell.imgviewHight1.constant = 12

            cell.imgviewHight2.constant = 0
            cell.imgviewHight4.constant = 0
            cell.imgviewHight5.constant = 0

            cell.imgviewHight3.constant = 12 */

            cell.imgviewTop3_1.constant = 5

            cell.lblouttime.isHidden = true
            
            cell.imgview2.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true

            cell.lblWrongEntry.isHidden = true

            cell.lblHightStacklblMiddle.isHidden = true
            
            cell.constraintHightStackBtn.constant = 50
            
            cell.constraintHightStacklbl.constant = 0.5

            cell.lbladdedby.text =  "Alert from " + (arrGuestList[indexPath.row].activity?.messageBy)!
            
             if cell.lblStatus.text == "RESOLVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if cell.lblStatus.text == "SENT" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else{
                cell.lblStatus.backgroundColor = UIColor.systemRed
             }
            
            cell.btnCancel.isHidden = true
            cell.btnEdit.isHidden = true
            
            cell.btnWrong_Entry.isHidden = true
            cell.btnWrong_Entry_Red.isHidden = true
            cell.btnRenew.isHidden = true
            cell.btnClose.isHidden = true
            cell.btnNote_Guard.isHidden = true
            cell.btnOut.isHidden = true
            cell.btnDeliveryInfo.isHidden = true
            cell.btnAlertInfo.isHidden = false
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true

        }
        else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Message to Guard" {
            
            cell.lblStatus.isHidden = false

            cell.lblname.text = "Message to Guard"
          
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_message"))

            cell.lblguest.text = "Alert"
            
            cell.imgviewCompanyLogo.isHidden = true
            
            cell.lblLeaveatGate.isHidden = true

           // cell.lblintime.text = arrGuestList[indexPath.row].inTime!
            
            let lblDate = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[0]
            let strDate = strChangeDateFormate(strDateeee: lblDate!)
            
            let lblTime = arrGuestList[indexPath.row].inTime?.components(separatedBy: " ")[1]
            let strTime = strChangeTimeFormate(strDateeee: lblTime!)

            cell.lblintime.text =  strTime + " , " + strDate
            cell.lblintime.isHidden = false

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.messageStatus
            
            cell.lblHightStacklblMiddle.isHidden = false

            cell.constraintHightStackBtn.constant = 50
            
            cell.constraintHightStacklbl.constant = 0.5

            cell.lbladdedby.text =  "Alert from " + (arrGuestList[indexPath.row].activity?.messageBy)!
            
             if cell.lblStatus.text == "RESOLVED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else if cell.lblStatus.text == "SENT" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
             }else{
                cell.lblStatus.backgroundColor = UIColor.systemRed
             }
            
            if arrGuestList[indexPath.row].isWrongEntry == 0 {
                
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                
                cell.lblWrongEntry.isHidden = true
                
                cell.imgviewStackTop3.constant = 10

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12

                cell.imgviewHight2.constant = 0
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0

                cell.imgviewHight3.constant = 12 */

                cell.imgviewTop3_1.constant = 5

                cell.lblouttime.isHidden = true
                
                cell.imgview2.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true

                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = false
                
            }else{
                
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                
                cell.lblWrongEntry.isHidden = false
                
                cell.imgviewStackTop3.constant = 27
                
                cell.imgviewTop3_1.constant = 5
                
                cell.imgviewTop6_3.constant = 5

                cell.imgviewStackTop6.constant = 10

                // 13/1/20 temp comment

              /*  cell.imgviewHight1.constant = 12

                cell.imgviewHight3.constant = 12

                cell.imgviewHight2.constant = 0
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                
                cell.imgviewHight6.constant = 12 */

                cell.lblouttime.isHidden = true
                
                cell.imgview2.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                
                cell.imgview6.isHidden = false
                cell.imgview1.isHidden = false
                cell.imgview3.isHidden = false

                
                cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnWrong_Entry.isHidden = true
                
                cell.btnWrong_Entry_Red.isHidden = false
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = false
            }
            
            cell.btnIn_OnDemand.isHidden = true
            cell.btnCancel_OnDemand.isHidden = true
            cell.btnOut_OnDemand.isHidden = true
            cell.btnEdit_OnDemand.isHidden = true

        }

        // 18/1/20 temp comment

        else if (arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "Daily Helper") || (arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "Daily Helper Entry") {
            
             cell.btnIn_OnDemand.isHidden = true
             cell.btnCancel_OnDemand.isHidden = true
             cell.btnOut_OnDemand.isHidden = true
             cell.btnEdit_OnDemand.isHidden = true
            
            cell.lblStatus.isHidden = false
            
          //  cell.btncall.isHidden = true
            
            cell.imgviewCompanyLogo.isHidden = true
            
            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }else{
                cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "vendor-1"))
            }

            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            
            if arrGuestList[indexPath.row].activity?.vendorServiceTypeName != nil {
                cell.lblguest.text = arrGuestList[indexPath.row].activity?.vendorServiceTypeName
                //  "" // comment
            }else{
                cell.lblguest.text = ""
            }
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "CHECKED IN" {
                
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

                    if arrGuestList[indexPath.row].activity?.activityIn != nil {
                        
                        let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        
                        cell.lblintime.isHidden = false

                    }else{
                        cell.lblintime.isHidden = true
                    }
                                      
                      if arrGuestList[indexPath.row].isWrongEntry == 0 {
                          
                        cell.lbladdedby.isHidden = true
                          cell.lblouttime.isHidden = true
                          cell.lblapprovedby.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = true
                          
                          cell.imgviewStackTop3.constant = 10

                       // 13/1/20 temp comment

                         /* cell.imgviewHight1.constant = 12
                          cell.imgviewHight2.constant = 0
                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          cell.imgviewHight6.constant = 0
                          cell.imgviewHight3.constant = 12 */

                          cell.imgviewTop3_1.constant = 5

                          cell.lblouttime.isHidden = true
                          
                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          cell.imgview6.isHidden = true

                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = false
                          cell.btnWrong_Entry_Red.isHidden = true

                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = false
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true
                          
                      }else{
                        cell.lbladdedby.isHidden = true
                          cell.lblouttime.isHidden = true
                          cell.lblapprovedby.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = false
                          
                          cell.imgviewStackTop3.constant = 27
                          
                          cell.imgviewTop3_1.constant = 5
                          
                          cell.imgviewTop6_3.constant = 5

                          cell.imgviewStackTop6.constant = 10

                       // 13/1/20 temp comment

                        /*  cell.imgviewHight1.constant = 12
                          cell.imgviewHight3.constant = 12
                          cell.imgviewHight2.constant = 0
                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                          
                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          
                          cell.imgview6.isHidden = false
                          cell.imgview1.isHidden = false
                          cell.imgview3.isHidden = false

                          
                          cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                          
                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = true
                          cell.btnWrong_Entry_Red.isHidden = false
                          
                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = false
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true

                      }
                   
                   cell.constraintHightStackBtn.constant = 50
                   
                   cell.constraintHightStacklbl.constant = 0.5

                   cell.lblHightStacklblMiddle.isHidden = false

            }else if cell.lblStatus.text == "CHECKED OUT" {
                
                cell.lblStatus.backgroundColor = UIColor.systemRed

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                if arrGuestList[indexPath.row].activity?.out != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.out?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblouttime.text =  strTime + " , " + strDate
                    
                    cell.lblouttime.isHidden = false

                }else{
                    cell.lblouttime.isHidden = true
                }
                
                        if arrGuestList[indexPath.row].isWrongEntry == 0 {
                             
                             cell.lblapprovedby.isHidden = true
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = true
                             
                             cell.imgviewStackTop3.constant = 10

                           // 13/1/20 temp comment

                            /* cell.imgviewHight1.constant = 12
                             cell.imgviewHight2.constant = 12
                             cell.imgviewHight4.constant = 0
                             cell.imgviewHight5.constant = 0
                             cell.imgviewHight6.constant = 0
                             cell.imgviewHight3.constant = 12 */

                             cell.imgviewTop3_1.constant = 22

                             cell.lblouttime.isHidden = false
                             
                             cell.imgview2.isHidden = false
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             cell.imgview6.isHidden = true

                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = false
                             cell.btnWrong_Entry_Red.isHidden = true

                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = false
                             cell.btnOut.isHidden = false
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true
                             
                         }else{
                             
                             cell.lblouttime.isHidden = false
                             cell.lblapprovedby.isHidden = true
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = false
                             
                             cell.imgviewStackTop3.constant = 27
                             
                             cell.imgviewTop3_1.constant = 5
                             
                             cell.imgviewTop6_3.constant = 5

                             cell.imgviewStackTop6.constant = 10

                           // 13/1/20 temp comment

                           /*  cell.imgviewHight1.constant = 12

                             cell.imgviewHight3.constant = 12

                             cell.imgviewHight2.constant = 12
                             cell.imgviewHight4.constant = 0
                             cell.imgviewHight5.constant = 0
                             
                             cell.imgviewHight6.constant = 0 */

                             
                             cell.imgview2.isHidden = false
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             
                             cell.imgview6.isHidden = false
                             cell.imgview1.isHidden = false
                             cell.imgview3.isHidden = false

                             
                             cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                             
                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = true
                             cell.btnWrong_Entry_Red.isHidden = false
                             
                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = false
                             cell.btnOut.isHidden = false
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true

                         }

                
            }
        else if cell.lblStatus.text == "DENIED" {
            
                   cell.lblStatus.backgroundColor = UIColor.systemRed
                  
                         if arrGuestList[indexPath.row].isWrongEntry == 0 {
                             
                             cell.constraintHightStackBtn.constant = 50
                             
                             cell.constraintHightStacklbl.constant = 0.5

                             cell.lblHightStacklblMiddle.isHidden = true
                             
                             cell.lblouttime.isHidden = true
                             cell.lblapprovedby.isHidden = true
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = false
                          
                             cell.lblWrongEntry.text = "Denied by "// + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                             
                          cell.imgviewStackTop3.constant = 27
                          
                         // cell.imgviewTop3_1.constant = 5
                          
                          cell.imgviewTop6_1.constant = 5

                          cell.imgviewStackTop6.constant = 10

                           // 13/1/20 temp comment

                        /*  cell.imgviewHight1.constant = 12
                          cell.imgviewHight2.constant = 0

                          cell.imgviewHight3.constant = 0

                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          
                          cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                          
                          cell.imgview1.isHidden = false
                          cell.imgview3.isHidden = false

                             cell.imgview2.isHidden = true
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             cell.imgview6.isHidden = true

                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = false
                             cell.btnWrong_Entry_Red.isHidden = true

                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = true
                             cell.btnOut.isHidden = true
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true
                             
                         }else{
                             
                             cell.constraintHightStackBtn.constant = 50
                             
                             cell.constraintHightStacklbl.constant = 0.5

                             cell.lblHightStacklblMiddle.isHidden = true
                             
                             cell.lblouttime.isHidden = true
                             cell.lblapprovedby.isHidden = true
                             cell.lblLeaveatGate.isHidden = true
                             
                             cell.lblWrongEntry.isHidden = false
                             
                             cell.imgviewStackTop3.constant = 27
                             
                            // cell.imgviewTop3_1.constant = 5
                             
                            // cell.imgviewTop6_3.constant = 5
                          
                               cell.imgviewTop6_1.constant = 5

                             cell.imgviewStackTop6.constant = 10

                           // 13/1/20 temp comment

                            /* cell.imgviewHight1.constant = 12
                             cell.imgviewHight2.constant = 0
                             cell.imgviewHight3.constant = 0
                             cell.imgviewHight4.constant = 0
                             cell.imgviewHight5.constant = 0
                             cell.imgviewHight6.constant = 12 */

                             cell.lblouttime.isHidden = true
                             
                             cell.imgview2.isHidden = true
                             cell.imgview4.isHidden = true
                             cell.imgview5.isHidden = true
                             
                             cell.imgview6.isHidden = false
                             cell.imgview1.isHidden = false
                             cell.imgview3.isHidden = true
                            
                            cell.lblWrongEntry.text = "Denied by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!

                             
                           //  cell.lblWrongEntry.text = "No Response" //"Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                             
                             cell.btnCancel.isHidden = true
                             cell.btnEdit.isHidden = true
                             
                             cell.btnWrong_Entry.isHidden = true
                             
                             cell.btnWrong_Entry_Red.isHidden = false
                             
                             cell.btnRenew.isHidden = true
                             cell.btnClose.isHidden = true
                             cell.btnNote_Guard.isHidden = true
                             cell.btnOut.isHidden = true
                             cell.btnDeliveryInfo.isHidden = true
                             cell.btnAlertInfo.isHidden = true
                   
                }
                
            }else if cell.lblStatus.text == "NOT RESPONDED"{
                
                cell.lblStatus.backgroundColor = AppColor.ratingBorderColor

                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                
                      if arrGuestList[indexPath.row].isWrongEntry == 0 {
                          
                          cell.constraintHightStackBtn.constant = 50
                          
                          cell.constraintHightStacklbl.constant = 0.5

                          cell.lblHightStacklblMiddle.isHidden = true
                          
                          cell.lblouttime.isHidden = true
                          cell.lblapprovedby.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = false
                       
                          cell.lblWrongEntry.text = "No Response" //"Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                          
                       cell.imgviewStackTop3.constant = 27
                       
                      // cell.imgviewTop3_1.constant = 5
                       
                       cell.imgviewTop6_1.constant = 5

                       cell.imgviewStackTop6.constant = 10

                       // 13/1/20 temp comment

                      /* cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0

                       cell.imgviewHight3.constant = 0

                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       
                       cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                       
                       cell.imgview1.isHidden = false
                       cell.imgview3.isHidden = false

                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          cell.imgview6.isHidden = true

                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = false
                          cell.btnWrong_Entry_Red.isHidden = true

                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = true
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true
                          
                      }else{
                          
                          cell.constraintHightStackBtn.constant = 50
                          
                          cell.constraintHightStacklbl.constant = 0.5

                          cell.lblHightStacklblMiddle.isHidden = true
                          
                          cell.lblouttime.isHidden = true
                          cell.lblapprovedby.isHidden = true
                          cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = true
                          
                          cell.lblWrongEntry.isHidden = false
                          
                          cell.imgviewStackTop3.constant = 27
                          
                         // cell.imgviewTop3_1.constant = 5
                          
                         // cell.imgviewTop6_3.constant = 5
                       
                            cell.imgviewTop6_1.constant = 5

                          cell.imgviewStackTop6.constant = 10

                       // 13/1/20 temp comment

                        /*  cell.imgviewHight1.constant = 12
                          cell.imgviewHight2.constant = 0

                          cell.imgviewHight3.constant = 0

                          cell.imgviewHight4.constant = 0
                          cell.imgviewHight5.constant = 0
                          
                          cell.imgviewHight6.constant = 12 */

                          cell.lblouttime.isHidden = true
                          
                          cell.imgview2.isHidden = true
                          cell.imgview4.isHidden = true
                          cell.imgview5.isHidden = true
                          
                          cell.imgview6.isHidden = false
                          cell.imgview1.isHidden = false
                          cell.imgview3.isHidden = true
                          
                          cell.lblWrongEntry.text = "No Response" //"Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                          
                          cell.btnCancel.isHidden = true
                          cell.btnEdit.isHidden = true
                          
                          cell.btnWrong_Entry.isHidden = true
                          
                          cell.btnWrong_Entry_Red.isHidden = false
                          
                          cell.btnRenew.isHidden = true
                          cell.btnClose.isHidden = true
                          cell.btnNote_Guard.isHidden = true
                          cell.btnOut.isHidden = true
                          cell.btnDeliveryInfo.isHidden = true
                          cell.btnAlertInfo.isHidden = true

                      }
                   
            }else if cell.lblStatus.text == "ADDED"{
                
                   cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                   
                   if arrGuestList[indexPath.row].isWrongEntry == 0 {
                       
                       cell.lblouttime.isHidden = true
                       cell.lblapprovedby.isHidden = true
                       cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = false
                       
                       cell.lblWrongEntry.isHidden = true
                       
                       cell.imgviewStackTop3.constant = 10

                       // 13/1/20 temp comment

                      /* cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0
                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       cell.imgviewHight6.constant = 0
                       cell.imgviewHight3.constant = 12 */

                       cell.imgviewTop3_1.constant = 5

                       cell.lblouttime.isHidden = true
                       
                       cell.imgview2.isHidden = true
                       cell.imgview4.isHidden = true
                       cell.imgview5.isHidden = true
                       cell.imgview6.isHidden = true

                       cell.btnCancel.isHidden = true
                       cell.btnEdit.isHidden = true
                       
                       cell.btnWrong_Entry.isHidden = false
                       cell.btnWrong_Entry_Red.isHidden = true

                       cell.btnRenew.isHidden = true
                       cell.btnClose.isHidden = true
                       cell.btnNote_Guard.isHidden = true
                       cell.btnOut.isHidden = true
                       cell.btnDeliveryInfo.isHidden = true
                       cell.btnAlertInfo.isHidden = true
                       
                   }else{
                       
                       cell.lblouttime.isHidden = true
                       cell.lblapprovedby.isHidden = true
                       cell.lblLeaveatGate.isHidden = true
                       
                       cell.lbladdedby.isHidden = false

                       cell.lblWrongEntry.isHidden = false
                       
                       cell.imgviewStackTop3.constant = 27
                       
                       cell.imgviewTop3_1.constant = 5
                       
                       cell.imgviewTop6_3.constant = 5

                       cell.imgviewStackTop6.constant = 10

                       // 13/1/20 temp comment

                    /*   cell.imgviewHight1.constant = 12
                       cell.imgviewHight2.constant = 0

                       cell.imgviewHight3.constant = 12

                       cell.imgviewHight4.constant = 0
                       cell.imgviewHight5.constant = 0
                       
                       cell.imgviewHight6.constant = 12 */

                       cell.lblouttime.isHidden = true
                       
                       cell.imgview2.isHidden = true
                       cell.imgview4.isHidden = true
                       cell.imgview5.isHidden = true
                       
                       cell.imgview6.isHidden = false
                       cell.imgview1.isHidden = false
                       cell.imgview3.isHidden = false

                       
                       cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                       
                       cell.btnCancel.isHidden = true
                       cell.btnEdit.isHidden = true
                       
                       cell.btnWrong_Entry.isHidden = true
                       
                       cell.btnWrong_Entry_Red.isHidden = false
                       
                       cell.btnRenew.isHidden = true
                       cell.btnClose.isHidden = true
                       cell.btnNote_Guard.isHidden = true
                       cell.btnOut.isHidden = true
                       cell.btnDeliveryInfo.isHidden = true
                       cell.btnAlertInfo.isHidden = true

                   }
                   
                   cell.constraintHightStackBtn.constant = 50
                   
                   cell.constraintHightStacklbl.constant = 0.5

                   cell.lblHightStacklblMiddle.isHidden = true
               
            }else if cell.lblStatus.text == "REMOVED" {
               cell.lblStatus.backgroundColor = UIColor.systemRed
                
                if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
                
                cell.lbladdedby.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = true
                
            cell.lblLeaveatGate.isHidden = true
            cell.lblWrongEntry.isHidden = true
            
            cell.imgviewHight6.constant = 12
            
            cell.imgviewTop6_3.constant = 0

            cell.imgviewStackTop3.constant = 10
             
            
            // 13/1/20 temp comment

        /*  cell.imgviewHight1.constant = 12
            cell.imgviewHight2.constant = 0
            cell.imgviewHight3.constant = 12
            cell.imgviewHight4.constant = 0
            cell.imgviewHight5.constant = 0 */
            
            cell.imgview1.isHidden = false
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = false

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                
            }
            
            else{
            }

            
            //  //  ///  // / // / // /  / //  // ./.....// / / / /
            
                /*    if arrGuestList[indexPath.row].activity?.addedOn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                    }else{
                        cell.lblintime.isHidden = true
                    }
             
                        
              if cell.lblStatus.text == "SERVING" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect

                if arrGuestList[indexPath.row].isWrongEntry == 0 {

                    cell.lblouttime.isHidden = true
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    
                    cell.lblWrongEntry.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12

                    cell.imgviewHight2.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0

                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = false
                    
                    cell.imgview2.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true

                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = false
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                }
             else{
                    
                    cell.lblouttime.isHidden = true
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    
                    cell.lblWrongEntry.isHidden = false
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5

                    cell.imgviewStackTop6.constant = 10

                // 13/1/20 temp comment

                 /*   cell.imgviewHight1.constant = 12

                    cell.imgviewHight3.constant = 12

                    cell.imgviewHight2.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    
                    cell.imgviewHight6.constant = 0 */

                    cell.lblouttime.isHidden = false
                
                    cell.imgview1.isHidden = false
                    cell.imgview2.isHidden = false
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    
                    cell.imgview6.isHidden = false
                    cell.imgview3.isHidden = false

                    
                    cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = false
                    
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = false
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
             } */
             
            
            /* if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            } */
            
           /* if arrGuestList[indexPath.row].activity?.removedBy != nil {
                cell.lblWrongEntry.text = "Removed by " + (arrGuestList[indexPath.row].activity?.removedBy)!
            
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
               // cell.imgviewBottom6.constant = 15

                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.lbladdedby.isHidden = true
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lblWrongEntry.isHidden = false
                
                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight3.constant = 0
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 12 */
                
                cell.imgview1.isHidden = false
                cell.imgview2.isHidden = true
                cell.imgview3.isHidden = true
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true
               
                cell.imgviewTop3_1.constant = 0
                cell.imgviewTop6_3.constant = 0
                cell.imgviewTop6_1.constant = 5

                cell.imgviewStackTop6.constant = 10  // hello
                cell.imgviewStackTop3.constant = 27

                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }else {
                
            } */
                        
        }
        
    
         // 18/1/20 temp comment
        
        else if (arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "OnDemand Helper")  || (arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType == "OnDemand Entry") {
        
             // "OnDemand" "Helper or Entry"
            
            cell.imgviewCompanyLogo.isHidden = true
            
            if arrGuestList[indexPath.row].activity?.profilePic != nil {
                cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
            }else{
                cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "vendor-1"))
            }

            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.vendorServiceTypeName


            cell.lblStatus.isHidden = false
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
           /* if cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "ATTENDED"{
               cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = UIColor.systemRed
            } */
       
           if cell.lblStatus.text == "CANCELLED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
                cell.lblapprovedby.text = "Cancelled by " + (arrGuestList[indexPath.row].activity?.cancelledBy)!

              /*  if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                } */
                
                if arrGuestList[indexPath.row].isWrongEntry == 0 {
                    
                    cell.lblouttime.isHidden = true
                    cell.lblapprovedby.isHidden = false
                    cell.lblLeaveatGate.isHidden = true
                    
                    cell.lbladdedby.isHidden = false
                    
                    cell.lblWrongEntry.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                    // 13/1/20 temp comment

                   /* cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0
                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true

                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = false
                    cell.btnWrong_Entry_Red.isHidden = true

                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                    
                }else{
                    
                    cell.lblouttime.isHidden = true
                    cell.lblapprovedby.isHidden = false
                    cell.lblLeaveatGate.isHidden = true
                    
                    cell.lbladdedby.isHidden = false

                    cell.lblWrongEntry.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 27
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5

                    cell.imgviewStackTop6.constant = 10

                    // 13/1/20 temp comment

                 /*   cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 0

                    cell.imgviewHight3.constant = 12

                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    
                    cell.imgviewHight6.constant = 12 */

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = false
                    cell.imgview5.isHidden = true
                
                    cell.imgview6.isHidden = false
                    cell.imgview1.isHidden = false
                    cell.imgview3.isHidden = false

                   
                   // cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                    
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    
                    cell.btnWrong_Entry.isHidden = true
                    
                    cell.btnWrong_Entry_Red.isHidden = false
                    
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true

                }
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5

                cell.lblHightStacklblMiddle.isHidden = true
            
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true
                cell.btnIn_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = true
                
         }
             else if cell.lblStatus.text == "COMPLETED" {
                cell.lblStatus.backgroundColor = AppColor.cancelColor
                
               /* if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                } */
                
            if arrGuestList[indexPath.row].isWrongEntry == 0 {
                
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true
                
                cell.lbladdedby.isHidden = false
                
                cell.lblWrongEntry.isHidden = true
                
                cell.imgviewStackTop3.constant = 10

                // 13/1/20 temp comment

               /* cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0
                cell.imgviewHight3.constant = 12 */

                cell.imgviewTop3_1.constant = 5

                cell.lblouttime.isHidden = true
                
                cell.imgview2.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
                cell.imgview6.isHidden = true

                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnWrong_Entry.isHidden = false
                cell.btnWrong_Entry_Red.isHidden = true

                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
            }else{
                
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = false
                cell.lblLeaveatGate.isHidden = true
                
                cell.lbladdedby.isHidden = false

                cell.lblWrongEntry.isHidden = true
                
                cell.imgviewStackTop3.constant = 27
                
                cell.imgviewTop3_1.constant = 5
                
                cell.imgviewTop6_3.constant = 5

                cell.imgviewStackTop6.constant = 10

                // 13/1/20 temp comment

             /*   cell.imgviewHight1.constant = 12
                cell.imgviewHight2.constant = 0

                cell.imgviewHight3.constant = 12

                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                
                cell.imgviewHight6.constant = 12 */

                cell.lblouttime.isHidden = true
                
                cell.imgview2.isHidden = true
                cell.imgview4.isHidden = false
                cell.imgview5.isHidden = true
            
                cell.imgview6.isHidden = false
                cell.imgview1.isHidden = false
                cell.imgview3.isHidden = false

                
               // cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                
                cell.btnWrong_Entry.isHidden = true
                
                cell.btnWrong_Entry_Red.isHidden = false
                
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = false
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true

            }
            
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5
                
                cell.lblHightStacklblMiddle.isHidden = false
            
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true
                cell.btnIn_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = true
                
            
             }
            else if cell.lblStatus.text == "SERVING" {
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
               /*  if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                } */
                
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

               if arrGuestList[indexPath.row].isWrongEntry == 0 {

                   cell.lblouttime.isHidden = true
                   cell.lblapprovedby.isHidden = true
                   cell.lblLeaveatGate.isHidden = true
                  cell.lbladdedby.isHidden = false

                   cell.lblWrongEntry.isHidden = true
                   
                   cell.imgviewStackTop3.constant = 10

                cell.imgviewStackTop6.constant = 10
                
                // 13/1/20 temp comment
                
                 /*  cell.imgviewHight1.constant = 12
                   cell.imgviewHight2.constant = 12
                   cell.imgviewHight4.constant = 0
                   cell.imgviewHight5.constant = 0
                   cell.imgviewHight6.constant = 0
                   cell.imgviewHight3.constant = 12 */

                   cell.imgviewTop3_1.constant = 5

                   cell.lblouttime.isHidden = true
                   
                   cell.imgview2.isHidden = true
                   cell.imgview4.isHidden = true
                   cell.imgview5.isHidden = true
                   cell.imgview6.isHidden = true

                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   
                   cell.btnWrong_Entry.isHidden = false
                   cell.btnWrong_Entry_Red.isHidden = true

                   cell.btnRenew.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true
                
               }
            else{
                   
                    cell.lbladdedby.isHidden = false
                   cell.lblouttime.isHidden = true
                   cell.lblapprovedby.isHidden = true
                   cell.lblLeaveatGate.isHidden = true
                   
                   cell.lblWrongEntry.isHidden = false
                   
                   cell.imgviewStackTop3.constant = 27
                   
                   cell.imgviewTop3_1.constant = 5
                   
                   cell.imgviewTop6_3.constant = 5

                   cell.imgviewStackTop6.constant = 10

                // 13/1/20 temp comment
                
                 /*  cell.imgviewHight1.constant = 12
                   cell.imgviewHight3.constant = 12
                   cell.imgviewHight2.constant = 12
                   cell.imgviewHight4.constant = 0
                   cell.imgviewHight5.constant = 0
                   cell.imgviewHight6.constant = 0 */

                   cell.lblouttime.isHidden = true
                   
                   cell.imgview2.isHidden = true
                   cell.imgview4.isHidden = true
                   cell.imgview5.isHidden = true
                   
                   cell.imgview6.isHidden = false
                   cell.imgview1.isHidden = false
                   cell.imgview3.isHidden = false
                   
                  cell.lblWrongEntry.isHidden = true

                 //  cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                   
                   cell.btnCancel.isHidden = true
                   cell.btnEdit.isHidden = true
                   
                   cell.btnWrong_Entry.isHidden = true
                   cell.btnWrong_Entry_Red.isHidden = false
                   
                   cell.btnRenew.isHidden = true
                   cell.btnClose.isHidden = true
                   cell.btnNote_Guard.isHidden = true
                   cell.btnOut.isHidden = true
                   cell.btnDeliveryInfo.isHidden = true
                   cell.btnAlertInfo.isHidden = true
                
                }
                
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true
                cell.btnIn_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = false
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5
                
                cell.lblHightStacklblMiddle.isHidden = true
            }
            else if cell.lblStatus.text == "REQUESTED" {
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                
               /*  if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                } */
                
                    cell.lblouttime.isHidden = true
                    cell.lblapprovedby.isHidden = true
                    cell.lblLeaveatGate.isHidden = true
                    
                    cell.lblWrongEntry.isHidden = true
                    
                    cell.imgviewStackTop3.constant = 10

                 cell.imgviewStackTop6.constant = 10
                 
                 // 13/1/20 temp comment
                 
                  /*  cell.imgviewHight1.constant = 12
                    cell.imgviewHight2.constant = 12
                    cell.imgviewHight4.constant = 0
                    cell.imgviewHight5.constant = 0
                    cell.imgviewHight6.constant = 0
                    cell.imgviewHight3.constant = 12 */

                    cell.imgviewTop3_1.constant = 5

                    cell.lblouttime.isHidden = true
                    
                    cell.imgview2.isHidden = true
                    cell.imgview4.isHidden = true
                    cell.imgview5.isHidden = true
                    cell.imgview6.isHidden = true
                   
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5
                
                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
                
                cell.btnCancel_OnDemand.isHidden = false
                cell.btnEdit_OnDemand.isHidden = false
                cell.btnIn_OnDemand.isHidden = false
                cell.btnOut_OnDemand.isHidden = true
                
            }
            else if cell.lblStatus.text == "ADDED"{
               cell.lblStatus.backgroundColor = AppColor.pollborderSelect
                                
                /*  if arrGuestList[indexPath.row].activity?.activityIn != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.activityIn?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                } */
                
                
                  if arrGuestList[indexPath.row].isWrongEntry == 0 {

                      cell.lblouttime.isHidden = true
                      cell.lblapprovedby.isHidden = true
                      cell.lblLeaveatGate.isHidden = true
                      
                    cell.lbladdedby.isHidden = false
                    
                      cell.lblWrongEntry.isHidden = true
                      
                      cell.imgviewStackTop3.constant = 10
                    
                    cell.imgviewTop3_1.constant = 5
                    
                    cell.imgviewTop6_3.constant = 5

                    cell.imgviewStackTop6.constant = 10

                    // 13/1/20 temp comment

                     /* cell.imgviewHight1.constant = 12
                      cell.imgviewHight2.constant = 12
                      cell.imgviewHight4.constant = 0
                      cell.imgviewHight5.constant = 0
                      cell.imgviewHight6.constant = 0
                      cell.imgviewHight3.constant = 12 */

                      cell.imgviewTop3_1.constant = 5

                      cell.lblouttime.isHidden = false
                      
                      cell.imgview2.isHidden = false
                      cell.imgview4.isHidden = true
                      cell.imgview5.isHidden = true
                      cell.imgview6.isHidden = true

                      cell.btnCancel.isHidden = true
                      cell.btnEdit.isHidden = true
                      
                      cell.btnWrong_Entry.isHidden = false
                      cell.btnWrong_Entry_Red.isHidden = true

                      cell.btnRenew.isHidden = true
                      cell.btnClose.isHidden = true
                      cell.btnNote_Guard.isHidden = true
                      cell.btnOut.isHidden = true
                      cell.btnDeliveryInfo.isHidden = true
                      cell.btnAlertInfo.isHidden = true
                      
                  }
               else{
                      
                      cell.lblouttime.isHidden = true
                      cell.lblapprovedby.isHidden = true
                      cell.lblLeaveatGate.isHidden = true
                      
                    cell.lbladdedby.isHidden = false

                      cell.lblWrongEntry.isHidden = false
                      
                      cell.imgviewStackTop3.constant = 27
                      
                      cell.imgviewTop3_1.constant = 5
                      
                      cell.imgviewTop6_3.constant = 5

                      cell.imgviewStackTop6.constant = 10

                // 13/1/20 temp comment

                    /* cell.imgviewHight1.constant = 12
                      cell.imgviewHight3.constant = 12
                      cell.imgviewHight2.constant = 12
                      cell.imgviewHight4.constant = 0
                      cell.imgviewHight5.constant = 0
                      cell.imgviewHight6.constant = 0 */

                     // cell.lblouttime.isHidden = false
                      
                      cell.imgview2.isHidden = false
                      cell.imgview4.isHidden = true
                      cell.imgview5.isHidden = true
                      
                      cell.imgview6.isHidden = false
                      cell.imgview1.isHidden = false
                      cell.imgview3.isHidden = false
                      
                      cell.lblWrongEntry.text = "Wrong Entry Reported by " + (arrGuestList[indexPath.row].activity?.wrongEntryBy)!
                
                //  cell.lblWrongEntry.text = ""

                      
                      cell.btnCancel.isHidden = true
                      cell.btnEdit.isHidden = true
                      
                      cell.btnWrong_Entry.isHidden = true
                      cell.btnWrong_Entry_Red.isHidden = false
                      
                      cell.btnRenew.isHidden = true
                      cell.btnClose.isHidden = true
                      cell.btnNote_Guard.isHidden = true
                      cell.btnOut.isHidden = true
                      cell.btnDeliveryInfo.isHidden = true
                      cell.btnAlertInfo.isHidden = true

                  }
                
                cell.constraintHightStackBtn.constant = 50
                
                cell.constraintHightStacklbl.constant = 0.5
                
                cell.lblHightStacklblMiddle.isHidden = false
               
                cell.btnIn_OnDemand.isHidden = true
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true
                
            }
            else{
                cell.lblStatus.backgroundColor = AppColor.cancelColor

                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                cell.lbladdedby.isHidden = true
                cell.lblWrongEntry.isHidden = true
                
                     cell.imgview2.isHidden = true
                     cell.imgview4.isHidden = true
                     cell.imgview5.isHidden = true
                     
                     cell.imgview6.isHidden = true
                     cell.imgview1.isHidden = true
                     cell.imgview3.isHidden = true
                
                    cell.constraintHightStackBtn.constant = 0
                    
                    cell.constraintHightStacklbl.constant = 0

                    cell.lblHightStacklblMiddle.isHidden = true
                    
                    cell.btnCancel.isHidden = true
                    cell.btnEdit.isHidden = true
                    cell.btnWrong_Entry.isHidden = true
                    cell.btnWrong_Entry_Red.isHidden = true
                    cell.btnRenew.isHidden = true
                    cell.btnClose.isHidden = true
                    cell.btnNote_Guard.isHidden = true
                    cell.btnOut.isHidden = true
                    cell.btnDeliveryInfo.isHidden = true
                    cell.btnAlertInfo.isHidden = true
                
                cell.btnIn_OnDemand.isHidden = true
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true

            }
        
            print("OnDemand : Helper / Entry ")
            
        }
        
       else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Vehicle Added"{
            
            cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "scooter"))

            cell.lblStatus.isHidden = false
        
             cell.lblStatus.text = ""

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status

            if arrGuestList[indexPath.row].activity?.vehicleTypeID != nil {
                cell.lblname.text = arrGuestList[indexPath.row].activity?.vehicleTypeID
            }else{
                cell.lblname.text = ""
            }
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.vehicleNumber

            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            }
        
                if arrGuestList[indexPath.row].activity?.creationDate != nil {
                    
                    let lblDate = arrGuestList[indexPath.row].activity?.creationDate?.components(separatedBy: " ")[0]
                    let strDate = strChangeDateFormate(strDateeee: lblDate!)
                    
                    let lblTime = arrGuestList[indexPath.row].activity?.creationDate?.components(separatedBy: " ")[1]
                    let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                    cell.lblintime.text =  strTime + " , " + strDate
                    
                    cell.lblintime.isHidden = false

                }else{
                    cell.lblintime.isHidden = true
                }
        
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = true
                cell.lblLeaveatGate.isHidden = true
                
              cell.lbladdedby.isHidden = false

                cell.lblWrongEntry.isHidden = true
                
                cell.imgviewStackTop3.constant = 10
                
                cell.imgviewTop3_1.constant = 5
                
               // cell.imgviewTop6_3.constant = 5

               // cell.imgviewStackTop6.constant = 10

          // 13/1/20 temp comment

              /* cell.imgviewHight1.constant = 12
                cell.imgviewHight3.constant = 12
                cell.imgviewHight2.constant = 12
                cell.imgviewHight4.constant = 0
                cell.imgviewHight5.constant = 0
                cell.imgviewHight6.constant = 0 */
                
                cell.imgview2.isHidden = false
                cell.imgview4.isHidden = true
                cell.imgview5.isHidden = true
                
                cell.imgview6.isHidden = true
                cell.imgview1.isHidden = false
                cell.imgview3.isHidden = true
                        
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnAlertInfo.isHidden = true
    
                cell.btnIn_OnDemand.isHidden = true
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true
            
         }
         
      /*else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Add Family Member"{
       }
       
       else if arrGuestList[indexPath.row].activity?.ActivityType != nil  && arrGuestList[indexPath.row].activity?.ActivityType  == "Remove Family Member"{
       } */
       else{
        if arrGuestList[indexPath.row].activity?.ActivityType != nil {

                   // cell.lblStatus.isHidden = true
        
               if arrGuestList[indexPath.row].activity?.name != nil {
                    cell.lblname.text = arrGuestList[indexPath.row].activity?.name
                }else{
                    cell.lblname.text = ""
                }
          
                    cell.imgview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "vendor-1"))
                    
                    cell.imgviewCompanyLogo.isHidden = true
                
                    
               cell.lblguest.text = ""
            
                       
                      cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
                        
                 
                 /*   if arrGuestList[indexPath.row].activity?.addedOn != nil {
                        let lblDate = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[0]
                        let strDate = strChangeDateFormate(strDateeee: lblDate!)
                        
                        let lblTime = arrGuestList[indexPath.row].activity?.addedOn?.components(separatedBy: " ")[1]
                        let strTime = strChangeTimeFormate(strDateeee: lblTime!)

                        cell.lblintime.text =  strTime + " , " + strDate
                        cell.lblintime.isHidden = false
                    }else{
                        cell.lblintime.isHidden = true
                    } */
                
                cell.lblintime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.lblapprovedby.isHidden = true
                
            cell.lblLeaveatGate.isHidden = true
            cell.lblWrongEntry.isHidden = true
            
            cell.imgviewHight6.constant = 0
            
            cell.imgviewTop6_3.constant = 0

            cell.imgviewStackTop3.constant = 10 
             
            
            // 13/1/20 temp comment

        /*  cell.imgviewHight1.constant = 12
            cell.imgviewHight2.constant = 0
            cell.imgviewHight3.constant = 12
            cell.imgviewHight4.constant = 0
            cell.imgviewHight5.constant = 0 */
            
            cell.imgview1.isHidden = true
            cell.imgview2.isHidden = true
            cell.imgview3.isHidden = true
            cell.imgview4.isHidden = true
            cell.imgview5.isHidden = true
            cell.imgview6.isHidden = true

                
                cell.constraintHightStackBtn.constant = 0
                
                cell.constraintHightStacklbl.constant = 0

                cell.lblHightStacklblMiddle.isHidden = true
                
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true
                cell.btnAlertInfo.isHidden = true
                cell.btnDeliveryInfo.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnWrong_Entry_Red.isHidden = true

                cell.btnIn_OnDemand.isHidden = true
                cell.btnCancel_OnDemand.isHidden = true
                cell.btnOut_OnDemand.isHidden = true
                cell.btnEdit_OnDemand.isHidden = true

                print("Activity ActivityType :- ",(arrGuestList[indexPath.row].activity?.ActivityType)!)
            }else{
                print("ActivityType :- ")
            }
           
        }
        
           cell.imgview2.isHidden = true
           cell.imgview3.isHidden = true
           cell.btnDeliveryInfo.isHidden = true

        
      //  cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic!)!), placeholderImage: UIImage(named: "vendor-1"))
        
      /* let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatterGet.date(from: (arrGuestList[indexPath.row].activity?.activityIn!)!)
        dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
        cell.lblintime.text = dateFormatterGet.string(from: date!) */

      //  cell.lblapprovedby.text = "INVITED by \(String.getString(UsermeResponse?.data?.name!))"
        
        
        cell.btnCancel.tag = indexPath.item
        cell.btnEdit.tag = indexPath.item
        cell.btnWrong_Entry.tag = indexPath.item
        cell.btnRenew.tag = indexPath.item
        cell.btnClose.tag = indexPath.item
        cell.btnAlertInfo.tag = indexPath.item

        cell.btnNote_Guard.tag = indexPath.item
        cell.btnOut.tag = indexPath.item
        
        cell.btnCancel_OnDemand.tag = indexPath.item
        cell.btnEdit_OnDemand.tag = indexPath.item
        cell.btnIn_OnDemand.tag = indexPath.item
        cell.btnOut_OnDemand.tag = indexPath.item


        cell.btncall.addTarget(self, action:#selector(callmember), for: .touchUpInside)
        
        cell.btnCancel.addTarget(self, action:#selector(ApiCallCancel), for: .touchUpInside)
        cell.btnOut.addTarget(self, action:#selector(ApiCallOut_Exit), for: .touchUpInside)
        cell.btnWrong_Entry.addTarget(self, action:#selector(ApiCallWrong_Entry), for: .touchUpInside)
        
        cell.btnEdit.addTarget(self, action:#selector(ApiCallEdit), for: .touchUpInside) // renew
        
        cell.btnAlertInfo.addTarget(self, action:#selector(ApiCallAlertInfo), for: .touchUpInside)
        
        cell.btnRenew.addTarget(self, action:#selector(ApiCallEdit), for: .touchUpInside)

        cell.btnClose.addTarget(self, action:#selector(ApiCallClose), for: .touchUpInside)
        
         cell.btnNote_Guard.addTarget(self, action:#selector(ApiCallNote_to_Guard), for: .touchUpInside)
        

        cell.btnCancel_OnDemand.addTarget(self, action:#selector(ApiCallCancel_OnDemand), for: .touchUpInside)
        cell.btnEdit_OnDemand.addTarget(self, action:#selector(ApiCallEdit_OnDemand), for: .touchUpInside) // renew
        cell.btnIn_OnDemand.addTarget(self, action:#selector(ApiCallIn_OnDemand), for: .touchUpInside)
        cell.btnOut_OnDemand.addTarget(self, action:#selector(ApiCallOut_Exit_OnDemand), for: .touchUpInside)
        
        
        return cell
        
    } */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didSelectRowAt")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension  // 345
//    }
    
    /* func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrGuestList[indexPath.row].type == "1"{
            if arrGuestList[indexPath.row].inOutFlag == 0{
                let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
                cell.lblname.text = arrGuestList[indexPath.row].name
                
                cell.imgview.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "vendor-1"))
                cell.lblouttime.isHidden = true
               // cell.lblouttime.isHidden = true
                cell.imgout.isHidden = true
                cell.hightlblout.constant = 0
                cell.lblouttime.isHidden = true
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
                dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
                cell.lblintime.text = dateFormatterGet.string(from: date!)
                cell.lblouttime.isHidden = true
                cell.btnapproved.setTitle("INVITED", for: .normal)
                cell.btnapproved.backgroundColor = UIColor(red: 0.27, green: 0.75, blue: 0.33, alpha: 1.00)
                cell.imgaprroved.image = UIImage(named:"ic_right-1")
                cell.lblapprovedby.text = "INVITED by \(String.getString(UsermeResponse?.data?.name!))"
                var attributedString1 = NSMutableAttributedString()
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                    let formater = DateFormatter()
                    formater.dateFormat = "hh:mm a"
                    let strIN = formater.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                    let format = DateFormatter()
                    format.dateFormat = "hh:mm a"
                    let strIN = format.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                }else{
                    dateFormatterGet.dateFormat = "dd-MMM-yy HH:mm a"
                    let strIN = dateFormatterGet.string(from: date!)
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                }
                cell.imgout.isHidden = true
                return cell
            }else if arrGuestList[indexPath.row].inOutFlag == 1{ //in
                
                let cell:OUTUserCell = tableView.dequeueReusableCell(withIdentifier:"cellout", for: indexPath) as! OUTUserCell
                
                cell.lblname.text = arrGuestList[indexPath.row].name
                
                cell.imgview.sd_setImage(with: URL(string: arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                cell.btnout.isHidden = false
                cell.btnout.isHidden = false
                cell.btnout.tag = indexPath.row
                cell.btnapproved.setTitle("INVITED", for: .normal)
                cell.lblguest.text = "Frequent Visitor"
                cell.btnout.addTarget(self, action: #selector(OutguestByMember(sender:)), for: .touchUpInside)
                
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                
                var attributedString1 = NSMutableAttributedString()
                cell.lblapprovedby.text = "Approved by \(String.getString(UsermeResponse?.data?.name!))"
                
                if arrGuestList[indexPath.row].intime != nil ||  arrGuestList[indexPath.row].intime != ""{
                    cell.lblintime.isHidden = false
                    let dateFormaINOUT = DateFormatter()
                    dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                    //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                    let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                    //let timeInterval = date!.timeIntervalSinceNow
                    //print("=========>\(dayDifference(from: timeInterval))")
                    cell.lblapprovedby.text = "Approved by \(String.getString(UsermeResponse?.data?.name!))"
                    
                    if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                        let formater = DateFormatter()
                        formater.dateFormat = "hh:mm a"
                        let strIN = formater.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                    }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                        let format = DateFormatter()
                        format.dateFormat = "hh:mm a"
                        let strIN = format.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                    }else{
                        dateFormaINOUT.dateFormat = "dd-MMM-yy HH:mm a"
                        let strIN = dateFormaINOUT.string(from: date!)
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                    }
                    
                }else{
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    //cell.lblINTIme.isHidden = true
                }
                
                
                
                return cell
                
            }else{ //in and OUT both
                let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
                
                cell.lblapprovedby.text = "Approved by \(String.getString(UsermeResponse?.data?.name!))"
                cell.lblname.text = arrGuestList[indexPath.row].name
                
                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                
                var attributedString1 = NSMutableAttributedString()
                cell.imgout.isHidden = false
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = false
                cell.hightlblout.constant = 12
                cell.btnapproved.setTitle("INVITED", for: .normal)
                cell.lblguest.text = "Frequent Visitor"
                if arrGuestList[indexPath.row].intime != nil || arrGuestList[indexPath.row].intime != "" {
                    cell.lblintime.isHidden = false
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
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                    }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                        let format = DateFormatter()
                        format.dateFormat = "hh:mm a"
                        let strIN = format.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                    }else{
                        dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                        let strIN = dateFormaINOUT.string(from: date!)
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                    }
                    
                }else{
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                }
                
                
                
                if arrGuestList[indexPath.row].outtime != nil || arrGuestList[indexPath.row].outtime != "" {
                    cell.lblouttime.isHidden = false
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
                            cell.lblouttime.attributedText = attributedString1
                            
                            //cell.lblOutTime.text = String(format: "OUT: %@ Today", strOut)
                        }else if dayDifference(from: 0000, date: dates! as NSDate) == "Yesterday"{
                            let formateees = DateFormatter()
                            formateees.dateFormat = "hh:mm a"
                            let strOut = formateees.string(from: dates!)
                            
                            attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                            let attributedString3 = NSMutableAttributedString(string:String(format: "Yesterday  %@ ", strOut), attributes:attrs2)
                            attributedString1.append(attributedString3)
                            cell.lblouttime.attributedText = attributedString1
                            
                            //cell.lblOutTime.text = String(format: "OUT: %@ Yesterday", strOut)
                        }else{
                            dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                            let strOut = dateFormaINOUT.string(from: dates!)
                            
                            attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                            let attributedString3 = NSMutableAttributedString(string:String(format: "%@", strOut), attributes:attrs2)
                            attributedString1.append(attributedString3)
                            cell.lblouttime.attributedText = attributedString1
                            //cell.lblOutTime.text = String(format: "OUt: %@", strOut)
                        }
                        
                    }
                    
                }else{
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblouttime.attributedText = attributedString1
                    //cell.lblOutTime.text = "00:00 PM"
                    cell.lblouttime.isHidden = true
                }
                
                return cell
                
            }
            
            
        }
            
        else
        {
            if arrGuestList[indexPath.row].flag == 0 && arrGuestList[indexPath.row].inOutFlag == 0{
                
                let cell:AcceptRejectCell = tableView.dequeueReusableCell(withIdentifier:"cellacceptreject", for: indexPath) as! AcceptRejectCell
                
                cell.lblname.text = arrGuestList[indexPath.row].name
                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
                dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
                cell.lbldate.text = dateFormatterGet.string(from: date!)
                cell.btnaccept.tag = indexPath.row
                cell.btnreject.tag = indexPath.row
                cell.btnaccept.addTarget(self, action: #selector(aceeptRequest(sender:)), for: .touchUpInside)
                cell.btnreject.addTarget(self, action: #selector(DeclineRequest(sender:)), for: .touchUpInside)
                return cell
                
            }
            else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 0{ //approve but not IN
                let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
                cell.lblname.text = arrGuestList[indexPath.row].name
                
                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                cell.lblouttime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.imgout.isHidden = true
                cell.hightlblout.constant = 0
                cell.lblouttime.isHidden = true
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
                dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
                cell.lblintime.text = dateFormatterGet.string(from: date!)
                cell.lblouttime.isHidden = true
                cell.btnapproved.setTitle("APPROVED", for: .normal)
                cell.btnapproved.backgroundColor = UIColor(red: 0.27, green: 0.75, blue: 0.33, alpha: 1.00)
                cell.imgaprroved.image = UIImage(named:"ic_right-1")
                cell.lblapprovedby.text = "Approved by \(String.getString(UsermeResponse?.data?.name!))"
                var attributedString1 = NSMutableAttributedString()
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                    let formater = DateFormatter()
                    formater.dateFormat = "hh:mm a"
                    let strIN = formater.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                    let format = DateFormatter()
                    format.dateFormat = "hh:mm a"
                    let strIN = format.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                }else{
                    dateFormatterGet.dateFormat = "dd-MMM-yy HH:mm a"
                    let strIN = dateFormatterGet.string(from: date!)
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                }
                cell.imgout.isHidden = true
                return cell
                
            }
            else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 1{ //approve and IN
                
                let cell:OUTUserCell = tableView.dequeueReusableCell(withIdentifier:"cellout", for: indexPath) as! OUTUserCell
                
                cell.lblname.text = arrGuestList[indexPath.row].name
                
                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                cell.btnout.isHidden = false
                cell.btnout.isHidden = false
                cell.btnout.tag = indexPath.row
                
                cell.btnout.addTarget(self, action: #selector(OutguestByMember(sender:)), for: .touchUpInside)
                cell.btnapproved.setTitle("APPROVED", for: .normal)
                cell.lblguest.text = "Guest"
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                
                var attributedString1 = NSMutableAttributedString()
                cell.lblapprovedby.text = "Approved by \(String.getString(UsermeResponse?.data?.name!))"
                
                if arrGuestList[indexPath.row].intime != nil ||  arrGuestList[indexPath.row].intime != ""{
                    cell.lblintime.isHidden = false
                    let dateFormaINOUT = DateFormatter()
                    dateFormaINOUT.dateFormat = "dd-MM-yyyy hh:mm a"
                    //dateFormaINOUT.timeZone = NSTimeZone(name: "UTC") as TimeZone!
                    let date = dateFormaINOUT.date(from: arrGuestList[indexPath.row].intime!)
                    //let timeInterval = date!.timeIntervalSinceNow
                    //print("=========>\(dayDifference(from: timeInterval))")
                    cell.lblapprovedby.text = "Approved by \(String.getString(UsermeResponse?.data?.name!))"
                    
                    if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                        let formater = DateFormatter()
                        formater.dateFormat = "hh:mm a"
                        let strIN = formater.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                    }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                        let format = DateFormatter()
                        format.dateFormat = "hh:mm a"
                        let strIN = format.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                    }else{
                        dateFormaINOUT.dateFormat = "dd-MMM-yy HH:mm a"
                        let strIN = dateFormaINOUT.string(from: date!)
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                    }
                    
                }else{
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    //cell.lblINTIme.isHidden = true
                }
                
                
                
                return cell
                
                
            }
            else if arrGuestList[indexPath.row].flag == 1 && arrGuestList[indexPath.row].inOutFlag == 2 { //approve and OUT
                
                let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
                
                cell.lblapprovedby.text = "Approved by \(String.getString(UsermeResponse?.data?.name!))"
                cell.lblname.text = arrGuestList[indexPath.row].name
                cell.btnapproved.setTitle("APPROVED", for: .normal)
                cell.lblguest.text = "Guest"

                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                
                var attributedString1 = NSMutableAttributedString()
                cell.imgout.isHidden = false
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = false
                cell.hightlblout.constant = 12
                
                if arrGuestList[indexPath.row].intime != nil || arrGuestList[indexPath.row].intime != "" {
                    cell.lblintime.isHidden = false
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
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                    }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                        let format = DateFormatter()
                        format.dateFormat = "hh:mm a"
                        let strIN = format.string(from: date!)
                        
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                    }else{
                        dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                        let strIN = dateFormaINOUT.string(from: date!)
                        attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                        let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                        attributedString1.append(attributedString2)
                        cell.lblintime.attributedText = attributedString1
                        
                        //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                    }
                    
                }else{
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                }
                
                
                
                if arrGuestList[indexPath.row].outtime != nil || arrGuestList[indexPath.row].outtime != "" {
                    cell.lblouttime.isHidden = false
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
                            cell.lblouttime.attributedText = attributedString1
                            
                            //cell.lblOutTime.text = String(format: "OUT: %@ Today", strOut)
                        }else if dayDifference(from: 0000, date: dates! as NSDate) == "Yesterday"{
                            let formateees = DateFormatter()
                            formateees.dateFormat = "hh:mm a"
                            let strOut = formateees.string(from: dates!)
                            
                            attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                            let attributedString3 = NSMutableAttributedString(string:String(format: "Yesterday  %@ ", strOut), attributes:attrs2)
                            attributedString1.append(attributedString3)
                            cell.lblouttime.attributedText = attributedString1
                            
                            //cell.lblOutTime.text = String(format: "OUT: %@ Yesterday", strOut)
                        }else{
                            dateFormaINOUT.dateFormat = "dd-MMM-yy hh:mm a"
                            let strOut = dateFormaINOUT.string(from: dates!)
                            
                            attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                            let attributedString3 = NSMutableAttributedString(string:String(format: "%@", strOut), attributes:attrs2)
                            attributedString1.append(attributedString3)
                            cell.lblouttime.attributedText = attributedString1
                            //cell.lblOutTime.text = String(format: "OUt: %@", strOut)
                        }
                        
                    }
                    
                }else{
                    attributedString1 = NSMutableAttributedString(string:"OUT: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:"00:00", attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblouttime.attributedText = attributedString1
                    //cell.lblOutTime.text = "00:00 PM"
                    cell.lblouttime.isHidden = true
                }
                
                return cell
                
                
            }
            else if arrGuestList[indexPath.row].flag == 2{ //Declined
                
                let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
                
                cell.lblname.text = arrGuestList[indexPath.row].name
                cell.btnapproved.setTitle("APPROVED", for: .normal)
                cell.lblguest.text = "Guest"

                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
                cell.lblouttime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.imgout.isHidden = true
                cell.hightlblout.constant = 0
                cell.lblouttime.isHidden = true
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
                dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
                cell.lblintime.text = dateFormatterGet.string(from: date!)
                cell.lblintime.isHidden = false
                cell.lblintime.isHidden = false
                cell.lblouttime.isHidden = true
                cell.btnapproved.setTitle("DENIED", for: .normal)
                cell.btnapproved.backgroundColor = UIColor(red: 0.96, green: 0.04, blue: 0.13, alpha: 1.00)
                cell.imgaprroved.image = UIImage(named:"ic_denied")
                cell.imgout.isHidden = true
                
                cell.lblapprovedby.text = "Denied by \(String.getString(UsermeResponse?.data?.name!))"
                var attributedString1 = NSMutableAttributedString()
                let attrs1 = [NSAttributedStringKey.foregroundColor : AppColor.appcolor]
                let attrs2 = [NSAttributedStringKey.foregroundColor : UIColor.black]
                if dayDifference(from: 0000, date: date! as NSDate) == "Today"{
                    let formater = DateFormatter()
                    formater.dateFormat = "hh:mm a"
                    let strIN = formater.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Today  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Today", strIN)
                }else if dayDifference(from: 0000, date: date! as NSDate) == "Yesterday"{
                    let format = DateFormatter()
                    format.dateFormat = "hh:mm a"
                    let strIN = format.string(from: date!)
                    
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "Yesterday  %@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    // cell.lblINTIme.text = String(format: "IN: %@ Yesterday", strIN)
                }else{
                    dateFormatterGet.dateFormat = "dd-MMM-yy HH:mm a"
                    let strIN = dateFormatterGet.string(from: date!)
                    attributedString1 = NSMutableAttributedString(string:"IN: ", attributes:attrs1)
                    let attributedString2 = NSMutableAttributedString(string:String(format: "%@", strIN), attributes:attrs2)
                    attributedString1.append(attributedString2)
                    cell.lblintime.attributedText = attributedString1
                    
                    //cell.lblINTIme.text = String(format: "IN: %@", strIN)
                }
                
                return cell
                
            }
            else
            {
                let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
                
                return cell
                
                
            }
        }
    } */
    
    
    
 }
