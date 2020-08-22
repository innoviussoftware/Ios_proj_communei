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
var UsermeResponse:UserMeResponse?

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ActivityTabVC: UIViewController {
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var tblview: UITableView!
    
    var arrGuestList = [guestData]()
    var message = UILabel()
    var refreshControl = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        
     tabBarItem = UITabBarItem(title: "Activityssss", image: UIImage(named: "ic_activity_selected"), selectedImage: UIImage(named: "ic_activity_unselected"))
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        tblview.addSubview(refreshControl)
        
        
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
        message.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        message.isHidden = false
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        apicallUserMe()
        apicallGuestList()
        
    }
    @objc func refresh(sender:AnyObject) {
        apicallGuestList()
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
        let strGuestId = arrGuestList[sender.tag].id
        ApiCallAccepGuest(type: 1, guestId: strGuestId!)
        
    }
    
    @objc func DeclineRequest(sender:UIButton) {
        let strGuestId = arrGuestList[sender.tag].id
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
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
        Apicallhandler.sharedInstance.ApiCallUserMe(token: token as! String) { JSON in
            
            let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
                
                if statusCode == 200{
                    UserDefaults.standard.set(resp.data!.societyID, forKey: USER_SOCIETY_ID)
                    UserDefaults.standard.set(resp.data!.id, forKey: USER_ID)
                    UserDefaults.standard.set(resp.data!.role, forKey: USER_ROLE)
                    UserDefaults.standard.set(resp.data!.buildingID, forKey: USER_BUILDING_ID)
                    UserDefaults.standard.synchronize()
                    UsermeResponse = resp
                    self.lblname.text = "Welcome, \(resp.data!.name!)"
                    
                    self.lblname.text = resp.data!.name
                    
                    self.lblname.text = String(format: "%@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)

                    if(UsermeResponse?.data!.image != nil)
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
        avc?.titleStr = GeneralConstants.kAppName   // "Society Buddy"
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
extension ActivityTabVC:UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrGuestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrGuestList[indexPath.row].type == "1"{
            if arrGuestList[indexPath.row].inOutFlag == 0{
                let cell:AcceptedRequestCell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! AcceptedRequestCell
                cell.lblname.text = arrGuestList[indexPath.row].name
                
                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "vendor-1"))
                cell.lblouttime.isHidden = true
                cell.lblouttime.isHidden = true
                cell.imgout.isHidden = true
                cell.hightlblout.constant = 0
                cell.lblouttime.isHidden = true
                var dateFormatterGet = DateFormatter()
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
                
                cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "ic_profile"))
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
                var dateFormatterGet = DateFormatter()
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
                var dateFormatterGet = DateFormatter()
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
    }
    
    
    
}
