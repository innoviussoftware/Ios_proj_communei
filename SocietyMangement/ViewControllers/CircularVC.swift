//
//  CircularVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class CircularVC: BaseVC ,UITableViewDelegate , UITableViewDataSource {
    
    var selectedindexary = NSMutableArray()
    
    var isfrom = 1
    
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var vwbtnadd: UIView!

    @IBOutlet weak var btnadd: UIButton!
    @IBOutlet weak var tblcircular: UITableView!
    
    
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var txtvwDiscription: UITextView!

    @IBOutlet weak var vwReadMore: UIView!

    @IBOutlet weak var toptblConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var viewnoresult: UIView!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    var lblnoproperty = UILabel()
    var Circularary = [Circular]()
    
    var noticeRead = ""
    
    var arrReadMore = NSMutableArray()
    
    var refreshControl = UIRefreshControl()

    @IBAction func backaction(_ sender: Any) {
        if(isfrom == 1)
        {
            //revealViewController()?.revealToggle(self)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                           navigationController?.pushViewController(nextViewController, animated: true)
            
        }
        else{
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
                 refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
                 tblcircular.addSubview(refreshControl)
            
        
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        vwReadMore.isHidden = true

        tblcircular.register(UINib(nibName: "CircularNewCell", bundle: nil), forCellReuseIdentifier: "CircularNewCell")
        
        if isfrom == 1{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
           // btnMenu.setImage(UIImage(named: "ic_backbutton"), for: .normal)
            
        }else{
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
                self.toptblConstraint.constant = 0

                btnadd.isHidden = false
                vwbtnadd.isHidden = false

            }
            else{
              //  self.toptblConstraint.constant = -60

                vwbtnadd.isHidden = true
                btnadd.isHidden = true //Manish
                
            }
        }
        
       
        
//        if(revealViewController() != nil)
//        {
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//        }
        
        
         APPDELEGATE.apicallUpdateNotificationCount(strType: "3")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        apicallGetCirculars()
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    
    //Mark: Pull to refresh action

       @objc func refresh(sender:AnyObject) {
             apicallGetCirculars()
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
            
        }
        
    }
    
    @objc  func sendNotification(sender:UIButton) {
        
        let id = String.getString(Circularary[sender.tag].noticeID)
        
        let noticeReminder = "user/notice/" + "3/" + id + "/reminder"
         
         print("noticeReminder :- ",noticeReminder)
         
         APPDELEGATE.apicallNoticeReminder(strType: noticeReminder)
        
       // APPDELEGATE.apicallReminder(strType: "3", id: strId)
        
    }
    
    @IBAction func actionNotification(_ sender: Any) {
           let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
            vc.isfrom = 0
         }
        
        @IBAction func btnOpenQRCodePressed(_ sender: Any) {
            let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
            vc.isfrom = 0
        }
    
    // MARK: - Tableview delegate and data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.Circularary.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // let cell: SocietyEventcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocietyEventcell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CircularNewCell", for: indexPath) as! CircularNewCell
        
        
        cell.btnReadMore.tag = indexPath.row
        cell.btnNotification.tag = indexPath.row
        
        cell.lblTitel.text = Circularary[indexPath.row].title
        cell.lblDate.text = strChangeDateFormate(strDateeee: Circularary[indexPath.row].creationDate!)
        

        
        // 4/9/20.
      //  let str = Circularary[indexPath.row].name
      //  print("4/9/20. str :- ",str as Any)
     
        let hight = getLabelHeight(text: Circularary[indexPath.row].datumDescription!, width:cell.bounds.width - 32 , font: UIFont(name:"Lato-Regular", size: 14)!)
        
         //  if hight >  34{
              cell.btnReadMore.isHidden = false
         //  }else{
         //      cell.btnReadMore.isHidden = true
         //  }

        
       /* if arrReadMore.contains(Circularary[indexPath.row].id){
            cell.lblDiscription.numberOfLines = 0
            cell.lblDiscription.lineBreakMode = .byWordWrapping
            cell.lblDiscription.text = Circularary[indexPath.row].datumDescription
            cell.btnReadMore.setTitle("Read Less <", for:.normal)
            
        }else{ */
            cell.lblDiscription.numberOfLines = 4
            cell.lblDiscription.lineBreakMode = .byTruncatingTail
            cell.lblDiscription.text = Circularary[indexPath.row].datumDescription
            cell.btnReadMore.setTitle("Read More >", for:.normal)

       // }
        
        
      /*  if(Circularary[indexPath.row].attachments?[0] != nil || Circularary[indexPath.row].attachments![0] == "")
        {
            cell.btnDownload.isHidden = false
        }
        else
        {
            cell.btnDownload.isHidden = true
        } */
        
        cell.btnDownload.isHidden = false

        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        cell.btnEdit.addTarget(self, action:#selector(editcircular), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action:#selector(deletecircular), for: .touchUpInside)
        cell.btnReadMore.addTarget(self, action:#selector(readmore(sender:)), for: .touchUpInside)
        
        cell.btnNotification.addTarget(self, action:#selector(sendNotification(sender:)), for: .touchUpInside)
        
        
        cell.btnDownload.tag = indexPath.row
        cell.btnDownload.addTarget(self, action:#selector(downloadaction), for: .touchUpInside)
        
        if (Circularary[indexPath.row].readAt) != nil {
            cell.lblcolor.backgroundColor = UIColor(red: 242/255, green: 97/255, blue: 1/255, alpha: 1.0)  // F26101 orange
        }else{
            cell.lblcolor.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0) // #DDDDDD
        }
        
        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            if(str.contains("society_admin"))
            {
                self.toptblConstraint.constant = 0

                cell.btnEdit.isHidden = false
                cell.btnDelete.isHidden = false
                cell.btnNotification.isHidden = false
                
            }
            else{
                
                self.toptblConstraint.constant = -60

                cell.btnEdit.isHidden = true
                cell.btnDelete.isHidden = true
                cell.btnNotification.isHidden = true
                
            }
        }
        
        
        
        
        
        //        cell.lblname.text = Circularary[indexPath.row].title
        //        cell.lbldes.text = Circularary[indexPath.row].datumDescription
        //
        //
        //        if(Circularary[indexPath.row].pdffile != nil)
        //        {
        //
        //            cell.btndownload.isHidden = false
        //
        //        }
        //        else
        //        {
        //            cell.btndownload.isHidden = true
        //
        //        }
        //        cell.btnedit.tag = indexPath.row
        //        cell.btndelete.tag = indexPath.row
        //
        //        cell.btnedit.addTarget(self, action:#selector(editcircular), for: .touchUpInside)
        //        cell.btndelete.addTarget(self, action:#selector(deletecircular), for: .touchUpInside)
        //        if(Circularary[indexPath.row].pdffile == "")
        //        {
        //
        //            cell.btndownload.isHidden = true
        //        }
        //        else
        //        {
        //            cell.btndownload.isHidden = false
        //
        //        }
        //        cell.btndownload.tag = indexPath.row
        //        cell.btndownload.addTarget(self, action:#selector(downloadaction), for: .touchUpInside)
        //        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        //        {
        //            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
        //
        //            if(str.contains("Chairman") || str.contains("Secretory"))
        //            {
        //                cell.btnedit.isHidden = false
        //                cell.btndelete.isHidden = false
        //
        //            }
        //            else{
        //
        //                cell.btnedit.isHidden = true
        //                cell.btndelete.isHidden = true
        //
        //            }
        //        }
        
        
        return cell
        
    }
    @objc func downloadaction(sender:UIButton)
    {
        let pdffile = Circularary[sender.tag].attachments![0]
        
        guard let url = URL(string: pdffile) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
    @objc func editcircular(sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddCircularVC") as! AddCircularVC
        
        nextViewController.dic = Circularary[sender.tag]
        nextViewController.isfrom = 1
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    @objc func deletecircular(sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                      let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                                      avc?.titleStr = "Communei"
                                                      avc?.subtitleStr = "Are you sure you want to delete \(self.Circularary[sender.tag].title!)?"
                                                      avc?.yesAct = {
                                                            
                                                       self.apicallDeleteCirculars(id: self.Circularary[sender.tag].noticeID!)
                                                          }
                                                      avc?.noAct = {
                                                        
                                                      }
                                                      present(avc!, animated: true)
                        
              
        
        
        
//        let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to delete \(self.Circularary[sender.tag].title!)?", preferredStyle: UIAlertControllerStyle.alert)
//
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//            self.apicallDeleteCirculars(id: (self.Circularary[sender.tag].id! as NSNumber).stringValue)
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
        if arrReadMore.contains(Circularary[sender.tag].noticeID) {
            
            arrReadMore.remove(Circularary[sender.tag].noticeID)
        }else{
            arrReadMore.add(Circularary[sender.tag].noticeID)
        }
        
        vwReadMore.isHidden = false
        
        lblTitel.text = Circularary[sender.tag].title
        lblDate.text = strChangeDateFormate(strDateeee: Circularary[sender.tag].creationDate!)

        txtvwDiscription.text = Circularary[sender.tag].datumDescription
        
        let id = String.getString(Circularary[sender.tag].noticeID)

        noticeRead = "user/notice/" + "2/" + id + "/read"
        
        print("circularRead :- ",noticeRead)
        
        apiCallNoticeRead()
        
       // tblcircular.reloadData()
      
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
    
    
    @IBAction func btnclosePressed(_ sender: Any) {
             vwReadMore.isHidden = true
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
    
    
    
    
    
    
    // MARK: - get circulars
    
    func apicallGetCirculars()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN) as! String
            webservices().StartSpinner()
        
        Apicallhandler().GetAllCirculars(URL: webservices().baseurl + API_USER_GET_CIRCULAR, token: token) { JSON in

                switch JSON.result{
                case .success(let resp):
                    self.refreshControl.endRefreshing()
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.Circularary = resp.data!
                        
//                        for i in 0 ..< self.Circularary.count{
//                            self.arrReadMore.add("0")
//                        }
                        
                        self.tblcircular.reloadData()
                        
                        if(resp.data!.count == 0)
                        {
                            self.tblcircular.isHidden = true
                            self.viewnoresult.isHidden = false
                            
                            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                                                                  
                            if(str.contains("society_admin"))
                                                                  {
                                                                    self.lblNoDataFound.isHidden = false
                                                                  }else{
                                                                    self.lblNoDataFound.isHidden = false
                            }
                            
                            
                            
                        }
                        else
                        {
                            self.tblcircular.isHidden = false
                            self.viewnoresult.isHidden = true
                            
                        }
                        
                    }
                    else
                    {
                        if(resp.data!.count == 0)
                        {
                            self.tblcircular.isHidden = true
                            self.viewnoresult.isHidden = false
                            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                                                                                             
                            if(str.contains("society_admin"))
                                           {
                                                                                               self.lblNoDataFound.isHidden = false
                                                                                             }else{
                                                                                               self.lblNoDataFound.isHidden = false
                                                       }
                        }
                        else
                        {
                            self.tblcircular.isHidden = false
                            self.viewnoresult.isHidden = true
                            
                        }
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    self.refreshControl.endRefreshing()

                    webservices().StopSpinner()
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
                   // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                  //  self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                    
                }
                
            }
      
    }
    
    // MARK: - Delete circulars
    
    func apicallDeleteCirculars(id:Int)
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN) as! String
            
            webservices().StartSpinner()
            Apicallhandler().DeleteCircular(URL: webservices().baseurl + API_DELETE_CIRCULAR, id:id, token: token) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.apicallGetCirculars()
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
                    
                    
                }
                
            }
      
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

}
