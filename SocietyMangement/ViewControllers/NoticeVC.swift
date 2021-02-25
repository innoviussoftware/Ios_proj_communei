//
//  NoticeVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController



class NoticeVC: BaseVC  , UITableViewDataSource , UITableViewDelegate ,UITextFieldDelegate{
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var txttype: UITextField!
    
    @IBOutlet weak var vwbtnadd: UIView!

    @IBOutlet weak var btnadd: UIButton!
    
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var txtvwDiscription: UITextView!


    @IBOutlet weak var vwReadMore: UIView!

    @IBOutlet weak var toptblConstraint: NSLayoutConstraint!
    
    var noticeary = [Notice]()  // Notice? // // 3/11/20. temp comment
    var announcementary = [Announcement]()
    var eventary = [Event]()
    var circularary = [Circular]()
    
    var noticeRead = ""
    
//  var noticeary = [Notice]()  // 3/11/20. temp comment
//  var noticearytype = NSMutableArray()
    
    @IBOutlet var viewnoresult: UIView!
    
    var isFrormDashboard = 0
    var arrReadMore = NSMutableArray()
    
    @IBOutlet weak var tblview: UITableView!
    var dataary = ["Notice","Circular","Events","Announcements"]
    
    var refreshControl = UIRefreshControl()

    var lblnoproperty = UILabel()
    @IBAction func addaction(_ sender: Any) {
                
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddNoticeVC") as! AddNoticeVC
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    
    @IBAction func backaction(_ sender: Any) {
        
        if isFrormDashboard == 0{
            //revealViewController()?.revealToggle(self)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            navigationController?.pushViewController(nextViewController, animated: true)
            
            
        }else{
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vwReadMore.isHidden = true
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
             refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
             tblview.addSubview(refreshControl)
        
        
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        
        tblview.register(UINib(nibName: "CircularNewCell", bundle: nil), forCellReuseIdentifier: "CircularNewCell")
        
        if isFrormDashboard == 0{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
          //  btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }else{
          //  btnMenu.setImage(UIImage(named: "menu"), for: .normal)
           btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }
        
        viewnoresult.center = self.view.center
        self.view.addSubview(viewnoresult)
        viewnoresult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewnoresult.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        viewnoresult.heightAnchor.constraint(equalToConstant: 198).isActive = true
        
        viewnoresult.isHidden  = true
        
        
        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            if(str.contains("society_admin"))
            {
                btnadd.isHidden = false
                vwbtnadd.isHidden = false
                
                self.toptblConstraint.constant = 0

            }
            else{ // resident
                
              //  self.toptblConstraint.constant = -44
                
                vwbtnadd.isHidden = true

                btnadd.isHidden = true
                
            }
        }
        
        
        //        if(revealViewController() != nil)
        //        {
        //            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        //        }
        // Do any additional setup after loading the view.
        
        // 12/9/20.
        // temparary
        
        APPDELEGATE.apicallUpdateNotificationCount(strType: "2")
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    //Mark: Pull to refresh action

    @objc func refresh(sender:AnyObject) {
            
        apicallGetNotices()
    }
           
    @IBAction func actionNotification(_ sender: Any) {
         let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
          vc.isfrom = 0
       }
      
      @IBAction func btnOpenQRCodePressed(_ sender: Any) {
          let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
          vc.isfrom = 0
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
              else if object.value(forKey: "notification_type") as! String == "Notice"{
                                  
                                             
                                         let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                              
                                              let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                                              nextViewController.isFrormDashboard = 0

                                         navigationController?.pushViewController(nextViewController, animated: true)

                                  
                                  
                              }else if object.value(forKey: "notification_type") as! String == "Circular"{
                                  
                                           
                                  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                       
                                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                       nextViewController.isfrom = 2

                                  navigationController?.pushViewController(nextViewController, animated: true)

                                  
                                  
                              }else if object.value(forKey: "notification_type") as! String == "Event"{

                          
                          
                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                               
                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                               nextViewController.isfrom = 1

                          navigationController?.pushViewController(nextViewController, animated: true)
                                  
                              }
            
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        apicallGetNotices()
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
        
    }
    
    
    @objc  func cancelPressed() {
        view.endEditing(true) // or do something
    }
    
    @objc  func sendNotification(sender:UIButton) {
        let strId = "\(noticeary[sender.tag].noticeID)"
        
       let noticeReminder = "user/notice/" + "1/" + strId + "/reminder"
        
        print("noticeReminder :- ",noticeReminder)
        
        APPDELEGATE.apicallNoticeReminder(strType: noticeReminder)
        
        // /user/notice/1/134/reminder
        
    }
    
    func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
                 let lbl = UILabel(frame: .zero)
                 lbl.frame.size.width = width
                 lbl.font = font
                 lbl.numberOfLines = 0
                 lbl.text = text
                 lbl.sizeToFit()

                 return lbl.frame.size.height
             }
    // MARK: - Tableview delegate and data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noticeary.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //        let cell: SocietyEventcell?
        //
        //        cell   = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SocietyEventcell
        
        let  cell   = tableView.dequeueReusableCell(withIdentifier: "CircularNewCell", for: indexPath) as? CircularNewCell
        
        cell?.btnEdit.tag = indexPath.row
        cell?.btnDelete.tag = indexPath.row
        cell!.btnReadMore.tag = indexPath.row
        
         cell!.btnNotification.tag = indexPath.row
        
        if (noticeary[indexPath.row].readAt) != nil {
            cell?.lblcolor.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 1/255, alpha: 1.0)  // F26101 orange
        }else{
            cell?.lblcolor.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0) // #DDDDDD
        }
        
        cell?.lblTitel.text = noticeary[indexPath.row].title
        cell?.lblDate.text = strChangeDateFormate(strDateeee: noticeary[indexPath.row].visibleTill)
        cell?.btnDownload.isHidden = true
       
      //  let hight = getLabelHeight(text: noticeary[indexPath.row].datumDescription, width:(cell?.bounds.width)! - 32 , font: UIFont(name:"Gotham-Light", size: 14)!)
        
// 28/10/20.
//           if hight >  34{
//            cell?.btnReadMore.isHidden = false
//           }else{
//               cell?.btnReadMore.isHidden = true
//           }

        
//        if arrReadMore.contains(noticeary[indexPath.row].noticeID){
//            cell?.lblDiscription.numberOfLines = 0
//            cell!.lblDiscription.lineBreakMode = .byWordWrapping
//            cell!.lblDiscription.text = noticeary[indexPath.row].datumDescription
//
//            cell?.btnReadMore.setTitle("Read Less <", for:.normal)
//
//        }else{
        
            cell!.lblDiscription.numberOfLines = 4
            cell!.lblDiscription.lineBreakMode = .byTruncatingTail
            cell!.lblDiscription.text = noticeary[indexPath.row].datumDescription

            cell?.btnReadMore.setTitle("Read More >", for:.normal)

      //  }
        
        
        
        //        cell?.btnedit.tag = indexPath.row
        //        cell?.btndelete.tag = indexPath.row
        //        cell?.lblname.text = noticeary[indexPath.row].title
        //
        //        let formate = DateFormatter()
        //        formate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //        let strDate = formate.date(from: noticeary[indexPath.row].createdAt!)
        //        formate.dateFormat = "dd/MM/yyyy"
        //        let str = formate.string(from: strDate!)
        //
        //        cell?.lblstartdate.text = str //noticeary[indexPath.row].createdAt
        //        cell?.lbldes.text = noticeary[indexPath.row].datumDescription
        //        cell?.btndelete.addTarget(self, action:#selector(deletebuilding), for: .touchUpInside)
        //        cell?.btnedit.addTarget(self, action:#selector(editbuilding), for: .touchUpInside)
        //
        
        cell?.btnDelete.addTarget(self, action:#selector(deletebuilding), for: .touchUpInside)
        cell?.btnEdit.addTarget(self, action:#selector(editbuilding), for: .touchUpInside)
        cell!.btnReadMore.addTarget(self, action:#selector(readmore(sender:)), for: .touchUpInside)
        
        cell!.btnNotification.addTarget(self, action:#selector(sendNotification(sender:)), for: .touchUpInside)
        
        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            // if(str.contains("Chairman") || str.contains("Secretory"))
            if(str.contains("society_admin"))
            {
                self.toptblConstraint.constant = 0

                cell?.btnEdit.isHidden = false
                cell?.btnDelete.isHidden = false
                cell!.btnNotification.isHidden = false
            }
            else{
                
                self.toptblConstraint.constant = -44

                cell?.btnEdit.isHidden = true
                cell?.btnDelete.isHidden = true
                cell!.btnNotification.isHidden = true
                
            }
        }
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    @objc func editbuilding(sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddNoticeVC") as! AddNoticeVC
        nextViewController.isfrom = 1
        nextViewController.dic = noticeary[sender.tag]
        
        navigationController?.pushViewController(nextViewController, animated: true)
        
        
        
    }
    @objc func deletebuilding(sender:UIButton)
    {
        
      //  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
        avc?.subtitleStr = "Are you sure you want to delete \(self.noticeary[sender.tag].title)?"

            avc?.yesAct = {
                  
                self.apicallDeleteNotice(id: String(format: "%d",  self.noticeary[sender.tag].noticeID))

                }
            avc?.noAct = {
              
            }
            present(avc!, animated: true)
        
        
//
//        let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to delete \(self.noticeary[sender.tag].title!)?", preferredStyle: UIAlertControllerStyle.alert)
//
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//            self.apicallDeleteNotice(id: String(format: "%d",  self.noticeary[sender.tag].id!))
//
//            print("Handle Ok logic here")
//        }))
//
//        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("Handle Cancel Logic here")
//        }))
//
//        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    @objc func readmore(sender:UIButton)
    {
        if arrReadMore.contains(noticeary[sender.tag].noticeID) {
            arrReadMore.remove(noticeary[sender.tag].noticeID)
        }else{
            arrReadMore.add(noticeary[sender.tag].noticeID)
        }
        
        vwReadMore.isHidden = false
        
        lblTitel.text = noticeary[sender.tag].title
        lblDate.text = strChangeDateFormate(strDateeee: noticeary[sender.tag].creationDate)
        txtvwDiscription.text = noticeary[sender.tag].datumDescription
        
        let id = String(format: "%d",noticeary[sender.tag].noticeID)
         
        noticeRead = "user/notice/" + "1/" + id + "/read"
        
        print("noticeRead :- ",noticeRead)
        
        apiCallNoticeRead()
        
        /*
         // user/notice/1/157/read
         
         //todo:: update read count
            /*Todo::: type 1=notice 2=Circulars  3=Events  4=poll*/
            @GET("user/notice/{type}/{id}/read")
         */

       // tblview.reloadData()
        
    }
    
    func apiCallNoticeRead() {
        
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
     
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)

            webservices().StartSpinner()
         
             
         Apicallhandler.sharedInstance.apiCallNoticeRead(URL: webservices().baseurl + noticeRead, token: token as! String) { JSON in
        
         
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if statusCode == 200{
                      print("read")
                    }
                    
                case .failure(let err):
                    
                    webservices().StopSpinner()
                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                 //   self.present(alert, animated: true, completion: nil)
                 print(err.asAFError!)
                    
                    
                }
            }
        
    }
    
    func strChangeDateFormate(strDateeee:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let strDate = formatter.date(from: strDateeee)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "dd-MM-yyyy hh:mm a"
            str = formatter.string(from: strDate!)
        }else{
            str = strDateeee
        }
        
        
        return str
    }
    
    @IBAction func btnclosePressed(_ sender: Any) {
        vwReadMore.isHidden = true
    }

    
    // MARK: - get Notices
    
    func apicallGetNotices()
    {
         if !NetworkState().isInternetAvailable {
                             ShowNoInternetAlert()
                             return
                         }
        let strToken = UserDefaults.standard.value(forKey: USER_TOKEN)! as! String

            webservices().StartSpinner()
            Apicallhandler().GetAllNotice(URL: webservices().baseurl + API_GET_NOTICE, token:strToken) { JSON in
                
                let statusCode = JSON.response?.statusCode

                switch JSON.result{
                case .success(let resp):
                    self.refreshControl.endRefreshing()
                    webservices().StopSpinner()
                   // if(resp.status == 1)
                    
                   // if(resp.status == true)
                    if statusCode == 200
                    {
                        self.noticeary = resp.data!
                        
                        self.lblnoproperty.isHidden = true
                        self.tblview.isHidden = false
                        self.tblview.reloadData()
                      //  if(resp.data == nil)
                        
                        if(resp.data!.count == 0)

                                              {
                                                  self.tblview.isHidden = true
                                                  self.viewnoresult.isHidden = false
                                              }
                                              else
                                              {
                                                  self.tblview.isHidden = false
                                                  self.viewnoresult.isHidden = true
                                                  
                                              }
                                              
                    }
                    else
                    {
                        //if(resp.data == nil)
                        
                        if(resp.data!.count == 0)

                        {
                            self.tblview.isHidden = true
                            self.viewnoresult.isHidden = false
                        }
                        else
                        {
                            self.tblview.isHidden = false
                            self.viewnoresult.isHidden = true
                            
                        }
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    self.refreshControl.endRefreshing()

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
                    // 28/10/20. temp comment
                  //  let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                 //   self.present(alert, animated: true, completion: nil)
                   
                    print(err.asAFError!)
                    
                }
                
            }
            
    
        
    }
    
    // MARK: - get all announcement
    
    func apicallGetAnnouncement()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().GetAllAnnouncement(URL: webservices().baseurl + "getAnnouncement", societyid:UserDefaults.standard.value(forKey:"societyid")! as! String) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.errorCode == 0)
                    {
                        self.announcementary = resp.data
                        self.lblnoproperty.isHidden = true
                        self.tblview.isHidden = false
                        self.tblview.reloadData()
                        
                    }
                    else
                    {
                        if(resp.data.count == 0)
                        {
                            self.tblview.isHidden = true
                            self.lblnoproperty.isHidden = false
                            
                        }
                        else
                        {
                            self.tblview.isHidden = false
                            self.lblnoproperty.isHidden = true
                        }
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
    }
    
    
    
    // MARK: - Delete Notices
    
    func apicallDeleteNotice(id:String)
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let strToken = UserDefaults.standard.value(forKey: USER_TOKEN)! as! String
            
            webservices().StartSpinner()
            Apicallhandler().DeleteNotice(URL: webservices().baseurl + API_DELETE_NOTICE, id:id, token: strToken) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.apicallGetNotices()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                }
                
            }
            
      
    }
    // MARK: - Delete Notices
    
    func apicallDeleteAnnoucement(id:String)
    {
       if !NetworkState().isInternetAvailable {
                        ShowNoInternetAlert()
                        return
                    }
            webservices().StartSpinner()
            Apicallhandler().DeleteAnnoucement(URL: webservices().baseurl + "deleteAnnouncement", id:id) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        
                        self.apicallGetAnnouncement()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                }
                
            }
            
      
        
    }
    
    
}
