//
//  PollVC.swift
//  SocietyMangement
//
//  Created by MacMini on 22/09/1941 Saka.
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
class PollVC: BaseVC {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var btnMenu: UIButton!

    @IBOutlet weak var lblNoDataFound: UILabel!
    var refreshControl = UIRefreshControl()
    
    var arrPollList = [PollListResponseData]()



    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                                     // Always adopt a light interface style.
                          overrideUserInterfaceStyle = .light
                        }
        
        self.lblNoDataFound.isHidden = true
        tblView.tableFooterView = UIView()
        tblView.separatorStyle = .none
        
        tblView.register(UINib(nibName: "PollListCell", bundle: nil), forCellReuseIdentifier: "PollListCell")
        apicallGetPollList()
       
        
        if(revealViewController() != nil)
               {
                   btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                   
                   self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                   self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
               }
               
               
               refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
               refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
               tblView.addSubview(refreshControl)
               
    }
    
    
    @objc func refresh(sender:AnyObject) {
        self.refreshControl.endRefreshing()
           apicallGetPollList()
       }
    
    @IBAction func actionNotification(_ sender: Any) {
        let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
                  vc.isfrom = 0
    }
    
    @IBAction func actionQRCode(_ sender: Any) {
        let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
        vc.isfrom = 0
    }
    func dateFormateChange(str:String)->String {
        //2019-12-06 12:15:02"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatterGet.date(from: str)
        dateFormatterGet.dateFormat = "dd/MM/yyyy HH:mm a"
        let strDate = dateFormatterGet.string(from: date!)
        
        return strDate
        
    }
    
    
    func dateFormateChangeNEW(str:String)->String {
        //2019-12-06 12:15:02"
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatterGet.date(from: str)
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        let strDate = dateFormatterGet.string(from: date!)
        
        return strDate
        
    }
    
    
    
    // MARK: - get Notices

      func apicallGetPollList()
      {
           if !NetworkState().isInternetAvailable {
                           ShowNoInternetAlert()
                           return
            }
              webservices().StartSpinner()
              Apicallhandler().GetPollList(URL: webservices().baseurl + API_GET_POLL_LIST, token:UserDefaults.standard.value(forKey: USER_TOKEN)! as! String) { JSON in
                  switch JSON.result{
                  case .success(let resp):

                      webservices().StopSpinner()
                      self.refreshControl.endRefreshing()
                      if(resp.status == 1)
                      {
                        self.arrPollList = resp.data!
                        
                        if self.arrPollList.count > 0{
                            self.lblNoDataFound.isHidden = true
                            self.tblView.isHidden = false
                            self.tblView.dataSource = self
                            self.tblView.delegate = self
                            self.tblView.reloadData()
                            
                        }else{
                            self.tblView.isHidden = true
                            self.lblNoDataFound.isHidden = false
                        }

                      }
                      else
                      {

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


}


@available(iOS 13.0, *)
extension PollVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPollList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PollListCell") as! PollListCell
        
        cell.lblQuestion.text = arrPollList[indexPath.row].question
        //cell.lblDate.text = "Create On: \(dateFormateChange(str: arrPollList[indexPath.row].createdAt!))"
        
        
        if arrPollList[indexPath.row].createdAt != nil{
            cell.lblDate.isHidden = false
            let date = NSDate()
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd/MM/yyyy"
            let strCurrentdate = dateFormatterGet.string(from: date as Date)
            
            let strOURDate = dateFormateChangeNEW(str: arrPollList[indexPath.row].createdAt!)
            
            if strCurrentdate == strOURDate{
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let TodayDate = dateFormatterGet.date(from: arrPollList[indexPath.row].createdAt!)
                 dateFormatterGet.dateFormat = "HH:mm a"
                let strDtae = dateFormatterGet.string(from: TodayDate!)
                
                cell.lblDate.text = "Create On: Today \(strDtae)"
            }else{
                 cell.lblDate.text = "Create On: \(dateFormateChange(str: arrPollList[indexPath.row].createdAt!))"
            }
            
        }else{
            cell.lblDate.isHidden = true
        }
        
        
        //for expire
        
        if arrPollList[indexPath.row].expiresOn != nil{
            cell.lblExpireDate.isHidden = false
            let date = NSDate()
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd/MM/yyyy"
            let strCurrentdate = dateFormatterGet.string(from: date as Date)
            
            let strOURDate = dateFormateChangeNEW(str: arrPollList[indexPath.row].expiresOn!)
            
            if strCurrentdate == strOURDate{
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let TodayDate = dateFormatterGet.date(from: arrPollList[indexPath.row].expiresOn!)
                 dateFormatterGet.dateFormat = "HH:mm a"
                let strDtae = dateFormatterGet.string(from: TodayDate!)
                
                cell.lblExpireDate.text = "Expire On: Today \(strDtae)"
            }else{
                 cell.lblExpireDate.text = "Expire On: \(dateFormateChange(str: arrPollList[indexPath.row].expiresOn!))"
            }
            
        }else{
            cell.lblExpireDate.isHidden = true
        }
       
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        if #available(iOS 13.0, *) {
            let vc = self.storyboard?.instantiateViewController(identifier: "PollDetailsVC") as! PollDetailsVC
            vc.arrPollData = arrPollList[indexPath.row]
            //vc.lblTitel.text = arrPollList[indexPath.row].question
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PollDetailsVC") as! PollDetailsVC
             vc.arrPollData = arrPollList[indexPath.row]
            //vc.lblTitel.text = arrPollList[indexPath.row].question
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    
}
