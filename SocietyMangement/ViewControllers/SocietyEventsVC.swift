//
//  SocietyEventsVC.swift
//  SocietyMangement
//
//  Created by MacMini on 30/05/1941 Saka.
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
class SocietyEventsVC: BaseVC  , UITableViewDelegate , UITableViewDataSource{

    @IBOutlet weak var vwbtnadd: UIView!

    @IBOutlet weak var btnadd: UIButton!
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet var viewnoresult: UIView!
    
    @IBOutlet weak var lblTitel: UILabel!
    @IBOutlet weak var lblstartdate: UILabel!
    @IBOutlet weak var lblenddate: UILabel!
    @IBOutlet weak var lblDiscription: UILabel!
    
    @IBOutlet weak var txtvwDiscription: UITextView!


    @IBOutlet weak var vwReadMore: UIView!

    @IBOutlet weak var toptblConstraint: NSLayoutConstraint!
    
    var isfrom = 0
    var eventary = [Event]()
    
    var arrReadMore = NSMutableArray()
    var refreshControl = UIRefreshControl()

    @IBAction func backaction(_ sender: Any) {
        if(isfrom == 0)
        {
             self.navigationController?.popViewController(animated: true)
        }
        else{
           // revealViewController()?.revealToggle(self)
                      let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                      let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                      navigationController?.pushViewController(nextViewController, animated: true)
            
        }
    }
    

    var lblnoproperty = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
        vwReadMore.isHidden = true

        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
             refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
             tblview.addSubview(refreshControl)
        
        
        
        if(isfrom == 0) // from menu
        {
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }
        else{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }
        
      
        viewnoresult.center = self.view.center
        self.view.addSubview(viewnoresult)
        viewnoresult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewnoresult.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        viewnoresult.heightAnchor.constraint(equalToConstant: 198).isActive = true
        
        viewnoresult.isHidden  = true
        
//        if(revealViewController() != nil)
//        {
//            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
//        }
        
        
        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
           // if(str.contains("Chairman")  || str.contains("Secretory"))
            if(str.contains("society_admin"))
            {
                self.toptblConstraint.constant = 0

                btnadd.isHidden = false
                vwbtnadd.isHidden = false

            }
            else{
                
                btnadd.isHidden = true
                vwbtnadd.isHidden = true


            }
        }
        
        // 12/9/20.
        // temparary
        
        //Update notification count
        APPDELEGATE.apicallUpdateNotificationCount(strType: "1")
        
    }
  
    //Mark: Pull to refresh action

    @objc func refresh(sender:AnyObject) {
          apicallGetEvents()
       }
       
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apicallGetEvents()
        
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    
    @objc func sendNotification(sender:UIButton){
        
        let id = "\(eventary[sender.tag].id!)"
        
        //let stri
        APPDELEGATE.apicallReminder(strType: "2", id: id)
        
        
        
        
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
      return eventary.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SocietyEventcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocietyEventcell
        
        cell.lblname.text = eventary[indexPath.row].title
        cell.lblstartdate.text = "From: \(changeDateFormate(strDate: eventary[indexPath.row].eventStartDate!)) \(eventary[indexPath.row].eventStartTime!)"
        cell.lblenddate.text = "To: \(changeDateFormate(strDate: eventary[indexPath.row].eventEndDate!)) \(eventary[indexPath.row].eventEndTime!)"
        //cell.lbldes.text = eventary[indexPath.row].datumDescription
        //webservices.sharedInstance.setShadow(view:cell.innerview)
        cell.btnEditNew.tag = indexPath.row
        cell.btnDeleteNew.tag = indexPath.row
        cell.btnreadmore.tag = indexPath.row
        cell.btnNotification.tag = indexPath.row
        cell.btnDownloadEvent.tag = indexPath.row
        

        
               
        let hight = getLabelHeight(text: eventary[indexPath.row].datumDescription!, width:cell.bounds.width - 32 , font: UIFont(name:"Lato-Regular", size: 14)!)
               
                  if hight >  38{
                      cell.btnreadmore.isHidden = false
                  }else{
                      cell.btnreadmore.isHidden = true
                  }

        
               
               if arrReadMore.contains(eventary[indexPath.row].id){
                cell.lbldes.numberOfLines = 0
                cell.lbldes.lineBreakMode = .byWordWrapping
                cell.lbldes.text = eventary[indexPath.row].datumDescription
                cell.btnreadmore.setTitle("Read Less <", for:.normal)

                   
               }else{
                cell.lbldes.numberOfLines = 3
                cell.lbldes.lineBreakMode = .byTruncatingTail
                cell.lbldes.text = eventary[indexPath.row].datumDescription
                cell.btnreadmore.setTitle("Read More >", for:.normal)

               }
      
        cell.btnEditNew.addTarget(self, action:#selector(editevent), for: .touchUpInside)
        cell.btnDeleteNew.addTarget(self, action:#selector(deletevent), for: .touchUpInside)
        cell.btnreadmore.addTarget(self, action:#selector(readmore(sender:)), for: .touchUpInside)
        cell.btnNotification.addTarget(self, action: #selector(sendNotification(sender:)), for: .touchUpInside)
         cell.btnDownloadEvent.addTarget(self, action: #selector(downloadaction(sender:)), for: .touchUpInside)
        
        
        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            // if(str.contains("Chairman") || str.contains("Secretory"))
            if(str.contains("society_admin"))
            {
                self.toptblConstraint.constant = 0

                cell.btnEditNew.isHidden = false
                cell.btnDeleteNew.isHidden = false
                cell.btnNotification.isHidden = false
                
            }
            else{
                
                self.toptblConstraint.constant = -60

                cell.btnEditNew.isHidden = true
                cell.btnDeleteNew.isHidden = true
                cell.btnNotification.isHidden = true
                
            }
        }
        
        
        
        return cell

    }
    @objc func deletevent(sender:UIButton)
    {
        
        
               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                                avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
                                                avc?.subtitleStr = "Are you sure you want to delete \(self.eventary[sender.tag].title!)?"
                                                avc?.yesAct = {
                                                
                                               self.apicallDeleteEvent(id: (self.eventary[sender.tag].id! as NSNumber).stringValue)

                                                    }
                                                avc?.noAct = {
                                                  
                                                }
                                                present(avc!, animated: true)
                  
        
        
        
//
//    let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to delete \(self.eventary[sender.tag].title!)?", preferredStyle: UIAlertControllerStyle.alert)
//
//    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//        self.apicallDeleteEvent(id: (self.eventary[sender.tag].id! as NSNumber).stringValue)
//
//    print("Handle Ok logic here")
//    }))
//
//    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//    print("Handle Cancel Logic here")
//    }))
//
//
 //   present(refreshAlert, animated: true, completion: nil)
    }
    
    @objc func downloadaction(sender:UIButton)
       {
           let pdffile = eventary[sender.tag].eventAttachment
           
         guard let url = URL(string:webservices().imgurl + pdffile!) else {
               return //be safe
           }
        
//            let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//            let downloadTask = urlSession.downloadTask(with: url)
//            downloadTask.resume()
//
        
           
           if #available(iOS 10.0, *) {
               UIApplication.shared.open(url, options: [:], completionHandler: nil)
           } else {
               UIApplication.shared.openURL(url)
           }
           
       }
    
    
    @objc func editevent(sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddEventVC") as! AddEventVC
        
        nextViewController.dic = eventary[sender.tag]
        nextViewController.isfrom = 1
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    @objc func readmore(sender:UIButton)
    {
        if arrReadMore.contains(eventary[sender.tag].id) {
            arrReadMore.remove(eventary[sender.tag].id)
        }else{
            arrReadMore.add(eventary[sender.tag].id)
        }
        
        vwReadMore.isHidden = false
               
        lblTitel.text = eventary[sender.tag].title
        
        lblstartdate.text = "From: \(changeDateFormate(strDate: eventary[sender.tag].eventStartDate!)) \(eventary[sender.tag].eventStartTime!)"
        lblenddate.text = "To: \(changeDateFormate(strDate: eventary[sender.tag].eventEndDate!)) \(eventary[sender.tag].eventEndTime!)"

       // lblDate.text = strChangeDateFormate(strDateeee: eventary[sender.tag].createdAt!)
        txtvwDiscription.text = eventary[sender.tag].datumDescription
    
      //  tblview.reloadData()
        
    }
    
    
    
    func changeDateFormate(strDate:String) -> String {
        //"2019/10/11"
        
        let formate = DateFormatter()
        formate.dateFormat = "yyyy/MM/dd"
        let strDates = formate.date(from: strDate)
        formate.dateFormat = "dd/MM/yyyy"
        let str = formate.string(from: strDates!)
        
        return str
    }
    
    @IBAction func btnclosePressed(_ sender: Any) {
           vwReadMore.isHidden = true
       }
    
    // MARK: - get Events
    
    func apicallGetEvents()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
           let strToken = UserDefaults.standard.value(forKey: USER_TOKEN)! as! String
            
            webservices().StartSpinner()
            Apicallhandler().GetAllEvents(URL: webservices().baseurl + API_GET_EVENT, societyid:"", BuildingID: "", token: strToken) { JSON in
                switch JSON.result{
                case .success(let resp):
                    self.refreshControl.endRefreshing()
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.eventary = resp.data
                        self.tblview.reloadData()
                        if(resp.data.count == 0)
                        {
                            self.tblview.isHidden = true
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
                            self.tblview.isHidden = false
                            self.viewnoresult.isHidden = true
                            
                        }
                        
                    }
                    else
                    {
                        if(resp.data.count == 0)
                        {
                            self.tblview.isHidden = true
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
                            self.tblview.isHidden = false
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
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                   
                    
                }
                
            }
            
       
    }
    
    // MARK: - Delete Notices
    
    func apicallDeleteEvent(id:String)
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
             let strToken = UserDefaults.standard.value(forKey: USER_TOKEN)! as! String
            
            webservices().StartSpinner()
            Apicallhandler().DeleteEvent(URL: webservices().baseurl + API_DELETE_EVENT, id:id, token: strToken) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.apicallGetEvents()
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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


@available(iOS 13.0, *)
extension SocietyEventsVC : URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("File Downloaded Location- ",  location)
        
        guard let url = downloadTask.originalRequest?.url else {
            return
        }
        let docsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationPath = docsPath.appendingPathComponent(url.lastPathComponent)
        
        try? FileManager.default.removeItem(at: destinationPath)
        
        do{
            try FileManager.default.copyItem(at: location, to: destinationPath)
           // self.pdfUrl = destinationPath
           // print("File Downloaded Location- ",  self.pdfUrl ?? "NOT")
        }catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}
