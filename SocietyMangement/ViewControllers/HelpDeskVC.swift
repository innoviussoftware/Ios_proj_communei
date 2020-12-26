//
//  HelpDeskVC.swift
//  SocietyMangement
//
//  Created by MacMini on 14/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire
import SWRevealViewController

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class HelpDeskVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblHelpDesk: UITableView!
    
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    var arrDictDataHelpDesk = [GetHelpDeskData]()
    
    var isfrom = 1


    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        if isfrom == 1{
                btnMenu.setImage(UIImage(named:"ic_back-1"), for: .normal)
        }else{
                btnMenu.setImage(UIImage(named:"menu"), for: .normal)
        }
        
        if isfrom == 0 {
            if(revealViewController() != nil)
            {
                btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
        }
        
        tblHelpDesk.register(UINib(nibName: "EmergencyNumberCell", bundle: nil), forCellReuseIdentifier: "EmergencyNumberCell")
        
        tblHelpDesk.separatorStyle = .none


       // tblHelpDesk.estimatedRowHeight = 100
        
      //  tblHelpDesk.rowHeight = UITableViewAutomaticDimension
        
       apicallGethelpDesk()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

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
    
    @IBAction func backaction(_ sender: Any) {

         if isfrom == 1{
             self.navigationController?.popViewController(animated: true)
         }else{
         }
         
     }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func actionQrCode(_ sender: Any) {
          if #available(iOS 13.0, *) {
                     let vc = self.storyboard?.instantiateViewController(identifier: "QRCodeVC") as! QRCodeVC
            self.navigationController?.pushViewController(vc, animated: true)

                 } else {
                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "QRCodeVC") as! QRCodeVC
                    self.navigationController?.pushViewController(vc, animated: true)

                 }
                 
      }
    
        
        @objc func actionCall(sender:UIButton) {

        
          //   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
           //  avc?.subtitleStr = "Are you sure you want to call?"
     
        avc?.isfrom = 3

            avc?.subtitleStr = "Are you sure you want to call:\(self.arrDictDataHelpDesk[sender.tag].number!)"

                            avc?.yesAct = {

                                    self.dialNumber(number:self.arrDictDataHelpDesk[sender.tag].number!)
                                         
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
    
    func apicallGethelpDesk()
       {
         if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
                           
            
            webservices().StartSpinner()
        
        //         Apicallhandler.sharedInstance.ApiCallGetHelpDesk(URL: webservices().baseurl + API_GET_HELP_DESK) { JSON in

        let token = UserDefaults.standard.value(forKey: USER_TOKEN)

        Apicallhandler().ApiCallGetHelpDesk(URL: webservices().baseurl + API_GET_HELP_DESK, token: token as! String) { JSON in
            
            //   let statusCode = JSON.response?.statusCode

            switch JSON.result{
            case .success(let resp):

                webservices().StopSpinner()
                if(resp.status == 1) {
                      
                    self.arrDictDataHelpDesk = resp.data!
                        
                        if(self.arrDictDataHelpDesk.count > 0)
                        {
                            self.tblHelpDesk.isHidden = false
                            self.lblNoDataFound.isHidden = true
                            self.tblHelpDesk.delegate = self
                            self.tblHelpDesk.dataSource = self
                            self.tblHelpDesk.reloadData()
                        }else{
                            self.lblNoDataFound.isHidden = false
                            self.tblHelpDesk.isHidden = true
                        }
                        
                           
                       }
                   case .failure(let err):
                       
                       webservices().StopSpinner()
                       let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       self.present(alert, animated: true, completion: nil)
                       print(err.asAFError!)
                       
                       
                   }
               }
      
           
       }
       
    
    //MARK:- tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDictDataHelpDesk.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmergencyNumberCell") as! EmergencyNumberCell
            
            if arrDictDataHelpDesk[indexPath.row].icon!.count > 0{
                    cell.imgview.sd_setImage(with: URL(string: (arrDictDataHelpDesk[indexPath.row].icon)!), placeholderImage: UIImage(named: ""))
                }
            
                    
        cell.lblName.text = arrDictDataHelpDesk[indexPath.row].name
            
        cell.lblType.text = arrDictDataHelpDesk[indexPath.row].type
        
        cell.lblCallNumbber.text = arrDictDataHelpDesk[indexPath.row].number
        
        cell.selectionStyle = .none
        
        cell.btnCall.tag = indexPath.row

        cell.btnCall.addTarget(self, action: #selector(actionCall(sender:)), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // UITableViewAutomaticDimension
    }
    

}
