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
class ActivityTabVC: BaseVC {
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet weak var menuaction: UIButton!

    @IBOutlet weak var filtrview: UIView!

    @IBOutlet weak var collectionActivity: UICollectionView!

    var arrSelectionCheck = NSMutableArray()

    var arrActivity = [UserActivityType]()
    //NSMutableArray()
    
  // var activityGroupAry = [UserActivityType]()
    // ["Visitor","Delivery","Cab","Service Provider","Daily Helper","On Demand Help","Parcel Collection"]

    var arrGuestList = [UserActivityAll]()
    //[guestData]()
    
    @IBOutlet weak var message: UILabel!

   // var message = UILabel()
    var refreshControl = UIRefreshControl()
    
    // MARK: - get Events
    
    func apicallGetActivitytypes()
    {
        
        // 6/11/20 temp comment
        
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
                            
                        }
                        else
                        {
                            self.collectionActivity.reloadData()

                            self.collectionActivity.isHidden = false
                            self.filtrview.isHidden = false
                            
                        }
                        
                    }
                    else
                    {
                        if(resp.data!.count == 0)
                        {
                            self.collectionActivity.isHidden = true
                            self.filtrview.isHidden = true
                        }
                        else
                        {
                            self.collectionActivity.reloadData()

                            self.collectionActivity.isHidden = false
                            self.filtrview.isHidden = false
                            
                        }
                        
                    }
                    
                    print(resp)
                case .failure(let err):

                     webservices().StopSpinner()
                //    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                 //   self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                   
                    
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
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tblview.addSubview(refreshControl)
        
        tblview.estimatedRowHeight = 150
        tblview.rowHeight = UITableViewAutomaticDimension
        
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

        apicallUserMe()
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
    
    @objc func refresh(sender:AnyObject) {
        apicallGuestList()
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
    
    @IBAction func btnApplyfilteraction(_ sender: Any) {
        filtrview.isHidden = true
    }
    
    @IBAction func btnResetaction(_ sender: Any) {
        arrSelectionCheck.removeAllObjects()
        filtrview.isHidden = true
    }
    
    @IBAction func btnDateOpenView(_ sender: Any) {
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
                        self.tblview.dataSource = self
                        self.tblview.delegate = self
                        self.tblview.reloadData()
                        
                        self.message.isHidden = true
                        
                        self.tblview.isHidden = false
                    }else{
                        self.message.isHidden = false
                        self.tblview.isHidden = true
                        
                    }
                    
                }
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
                    
                }
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
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError as Any)
                    
                    
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
        if(arrSelectionCheck.contains(arrActivity[indexPath.row].activityName!))

            {
                cell.bgViw.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 1/255, alpha: 1.0)

            }else{
                cell.bgViw.backgroundColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1.0)
            }
            
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
        let contentNSString = arrActivity[indexPath.row].activityName
        let expectedLabelSize = contentNSString!.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15.0)], context: nil)
        
        print("\(expectedLabelSize)")
        return CGSize(width:expectedLabelSize.size.width + 35, height: expectedLabelSize.size.height + 12) //31
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
          //  arrSelectionCheck.removeAllObjects()
           // collectionProfession.reloadData()
            
        
        if arrSelectionCheck.contains(arrActivity[indexPath.row].activityName!){
            arrSelectionCheck.remove(arrActivity[indexPath.row].activityName!)
        }else{
            arrSelectionCheck.add(arrActivity[indexPath.row].activityName!)
        }
      /*  if (arrActivity[indexPath.row].activityName as! String).value(forKey: "is_selected") as? String == "0"{
                
                let dict = arrActivity[indexPath.row] as! NSMutableDictionary
                dict.setValue("1", forKey: "is_selected")
                arrActivity.replaceObject(at: indexPath.row, with: dict)
                
            }else{
                
                let dict = arrActivity[indexPath.row] as! NSMutableDictionary
                dict.setValue("0", forKey: "is_selected")
                arrActivity.replaceObject(at: indexPath.row, with: dict)
                
            } */
            
            //selectedbloodgrop = bloodgroupary[indexPath.row]
            collectionActivity.reloadData()
        
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
    
}


@available(iOS 13.0, *)
extension ActivityTabVC:UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrGuestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
        
        if arrGuestList[indexPath.row].activity?.name != nil {
            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
        }
        
        if arrGuestList[indexPath.row].activity?.profilePic != nil {
            cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic)!), placeholderImage: UIImage(named: "vendor-1"))
        }
        
        if arrGuestList[indexPath.row].activity?.companyLogoURL != nil {
            cell.imgviewCompanyLogo.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.companyLogoURL)!), placeholderImage: UIImage(named: ""))
            cell.imgviewCompanyLogo.isHidden = false
        }else{
            cell.imgviewCompanyLogo.isHidden = true
        }
        
        if arrGuestList[indexPath.row].activity?.phone != nil {
            cell.btncall.isHidden = false
        }else{
            cell.btncall.isHidden = true
        }
        
        cell.btncall.tag = indexPath.item
        
        cell.btncall.addTarget(self, action:#selector(callmember), for: .touchUpInside)

        
         if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Visitor Entry" {
            
            cell.lblname.text = arrGuestList[indexPath.row].activity?.name

            cell.lblguest.text = "Visitor"
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
                
              /*  cell.btnWrong_Entry.isHidden = false
                cell.btnCancel.isHidden = true
                cell.btnEdit.isHidden = true
                cell.btnRenew.isHidden = true
                cell.btnClose.isHidden = true
                cell.btnWrong_Entry.isHidden = true
                cell.btnNote_Guard.isHidden = true
                cell.btnOut.isHidden = true */
                
            }else if cell.lblStatus.text == "CANCELLED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "NOT RESPONDED" || cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }

            if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                cell.lblapprovedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                cell.lblapprovedby.isHidden = false
                cell.imgview4.isHidden = false   // approvedby
            }else{
                cell.lblapprovedby.isHidden = true
                cell.imgview4.isHidden = true   // approvedby
            }
            
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.activityIn
                cell.lblintime.isHidden = false
                cell.imgview2.isHidden = false   // intime
            }else{
                cell.lblintime.isHidden = false
                cell.imgview2.isHidden = true   // intime
            }
            
            if arrGuestList[indexPath.row].activity?.out != nil {
                cell.lblouttime.text =  arrGuestList[indexPath.row].activity?.out
                cell.lblouttime.isHidden = false
                cell.imgview3.isHidden = false   // outtime
            }else{
                cell.lblouttime.isHidden = true
                cell.imgview3.isHidden = true   // outtime

            }
            
            cell.imgview1.isHidden = true   // time
           // cell.imgview2.isHidden = true   // intime
           // cell.imgview3.isHidden = true   // outtime
           // cell.imgview4.isHidden = true   // approvedby
            cell.imgview5.isHidden = false   // addedby
            cell.imgview6.isHidden = true   // parcel collection time
            cell.imgview7.isHidden = true   // leave at gate
            cell.imgview8.isHidden = true   // cancel by you
            cell.imgview9.isHidden = true   // denied by you
            cell.imgview10.isHidden = true  // No response
            

        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Visitor Pre-Approval"{
            cell.lblname.text = arrGuestList[indexPath.row].activity?.name

            cell.lblguest.text = "Visitor"
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
            }else if cell.lblStatus.text == "CANCELLED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "NOT RESPONDED" || cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }
            
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.activityIn
                cell.lblintime.isHidden = false
            }else{
                cell.lblintime.isHidden = true
            }
            
            if arrGuestList[indexPath.row].activity?.out != nil {
                cell.lblouttime.text =  arrGuestList[indexPath.row].activity?.out
                cell.lblouttime.isHidden = false
            }else{
                cell.lblouttime.isHidden = true
            }
            
            cell.imgview1.isHidden = true   // time
           // cell.imgview2.isHidden = true   // intime
           // cell.imgview3.isHidden = true   // outtime
           // cell.imgview4.isHidden = true   // approvedby
            cell.imgview5.isHidden = false   // addedby
          /*  cell.imgview6.isHidden = true   // parcel collection time
            cell.imgview7.isHidden = true   // leave at gate
            cell.imgview8.isHidden = true   // cancel by you
            cell.imgview9.isHidden = true   // denied by you
            cell.imgview10.isHidden = true  // No response */
            
            
        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Delivery Entry"{
            cell.lblname.text = "Delivery"
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName

            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
            }else if cell.lblStatus.text == "CANCELLED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "NOT RESPONDED" || cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                cell.lblapprovedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                cell.lblapprovedby.isHidden = false
            }else{
                cell.lblapprovedby.isHidden = true
            }
            
            
        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Delivery Pre-Approval"{
            cell.lblname.text = "Delivery"
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.vendor
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
            }else if cell.lblStatus.text == "CANCELLED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "NOT RESPONDED" || cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }

            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.activityIn
                cell.lblintime.isHidden = false
            }else{
                cell.lblintime.isHidden = true
            }
            
            if arrGuestList[indexPath.row].activity?.out != nil {
                cell.lblouttime.text =  arrGuestList[indexPath.row].activity?.out
                cell.lblouttime.isHidden = false

            }else{
                cell.lblouttime.isHidden = true
            }
            
        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Cab Entry"{
            cell.lblname.text = "Cab"
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
            }else if cell.lblStatus.text == "CANCELLED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "NOT RESPONDED" || cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.activityIn
            }else{
                cell.lblintime.isHidden = true
            }
            
        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Cab Pre-Approval"{
            
            cell.lblname.text = "Cab"
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.vendor
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
            }else if cell.lblStatus.text == "CANCELLED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "NOT RESPONDED" || cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            
        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Daily Helper Entry"{
            
            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            
            cell.lblguest.text = "Daily Helper"
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
             if cell.lblStatus.text == "WAITING" || cell.lblStatus.text == "CHECKED IN" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }
            
            cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!

            if arrGuestList[indexPath.row].activity?.approvedBy != nil {
                cell.lblapprovedby.text = "Approved by " + (arrGuestList[indexPath.row].activity?.approvedBy)!
                cell.lblapprovedby.isHidden = false
            }else{
                cell.lblapprovedby.isHidden = true
            }
            
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.activityIn
                cell.lblintime.isHidden = false

            }else{
                cell.lblintime.isHidden = true
            }
            
        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Daily Helper"{
            
            cell.lblname.text = arrGuestList[indexPath.row].activity?.name
            
            cell.lblguest.text = "Daily Helper"
            
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.activityIn
                cell.lblintime.isHidden = false

            }else{
                cell.lblintime.isHidden = true
            }
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
             if cell.lblStatus.text == "WAITING" || cell.lblStatus.text == "CHECKED IN" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }
            
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            }
            
            if arrGuestList[indexPath.row].activity?.removedBy != nil {
                cell.lbladdedby.text = "Removed by " + (arrGuestList[indexPath.row].activity?.removedBy)!
            }
            
        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Service Provider Entry"{
            
            cell.lblname.text = "Service Entry"
            
            cell.lblguest.text = arrGuestList[indexPath.row].activity?.companyName
            
            cell.lblStatus.text = arrGuestList[indexPath.row].activity?.status
            
            if cell.lblStatus.text == "DENIED" {
                cell.lblStatus.backgroundColor = AppColor.deniedColor
            }else if cell.lblStatus.text == "CANCELLED" || cell.lblStatus.text == "EXPIRED" || cell.lblStatus.text == "VISITED" || cell.lblStatus.text == "NOT RESPONDED" || cell.lblStatus.text == "DELIVERED" || cell.lblStatus.text == "ATTENDED"{
                cell.lblStatus.backgroundColor = AppColor.cancelColor
            }else{
                cell.lblStatus.backgroundColor = AppColor.pollborderSelect
            }
            
            if arrGuestList[indexPath.row].activity?.addedBy != nil {
                cell.lbladdedby.text = "Added by " + (arrGuestList[indexPath.row].activity?.addedBy)!
            }
            
            if arrGuestList[indexPath.row].activity?.activityIn != nil {
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.activityIn
                cell.lblintime.isHidden = false

            }else{
                cell.lblintime.isHidden = true
            }

        }else if arrGuestList[indexPath.row].activity?.activityType != nil  && arrGuestList[indexPath.row].activity?.activityType  == "Vehicle Added"{
            
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
                cell.lblintime.text =  arrGuestList[indexPath.row].activity?.creationDate
            }

        }else{
            if arrGuestList[indexPath.row].activity?.activityType != nil {
                print("Activity ActivityType :- ",(arrGuestList[indexPath.row].activity?.activityType)!)
            }else{
                print("ActivityType :- ")
            }
        }

        

        
      //  cell.imgview.sd_setImage(with: URL(string: (arrGuestList[indexPath.row].activity?.profilePic!)!), placeholderImage: UIImage(named: "vendor-1"))
        
      /* let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatterGet.date(from: (arrGuestList[indexPath.row].activity?.activityIn!)!)
        dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
        cell.lblintime.text = dateFormatterGet.string(from: date!) */

      //  cell.lblapprovedby.text = "INVITED by \(String.getString(UsermeResponse?.data?.name!))"
        
        
        return cell
        
    }
    
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
