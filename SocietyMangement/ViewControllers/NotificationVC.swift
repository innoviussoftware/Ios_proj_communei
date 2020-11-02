//
//  NotificationVC.swift
//  SocietyMangement
//
//  Created by MacMini on 15/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire

@available(iOS 13.0, *)
class NotificationVC: UIViewController {
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lbltotalSelected: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var btnMenu: UIButton!

    @IBOutlet weak var viewDelete: UIView!
    @IBOutlet weak var lblNoDataFound: UILabel!
    var arrNotiData = [NotificationListData]()
    var arrReadMore = NSMutableArray()
    var arrNotificationId = NSMutableArray()
    
    var isAllSelected : Bool!
    
    var isfrom = 1


    @IBOutlet weak var btnSelectAll: UIButton!
    @IBOutlet weak var constraintHightDeleteview: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbltotalSelected.isHidden = true
//        constraintHightDeleteview.constant = 0
//        viewDelete.isHidden = true
        
        btnSelectAll.layer.cornerRadius = 8
        btnSelectAll.clipsToBounds = true
        
        isAllSelected = false
        
        if isfrom == 0 {
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }else{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }
        
        tblView.separatorStyle = .none
        tblView.tableFooterView = UIView()
        
        tblView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")


        apicallGetNotifications()

    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
           
       }
    @IBAction func actionSelectAll(_ sender: Any) {
        
        if isAllSelected == false{
            isAllSelected = true
            arrNotificationId.removeAllObjects()
                   for value in arrNotiData {
                       arrNotificationId.add(value.id!)
                   }
            
             lbltotalSelected.isHidden = false
            lbltotalSelected.text = "\(arrNotificationId.count) selected"
            btnSelectAll.setTitle("Deselect All", for: .normal)
            
        }else{
            arrNotificationId.removeAllObjects()
            isAllSelected = false
            btnSelectAll.setTitle("Select All", for: .normal)
            lbltotalSelected.isHidden = true
        }
        
        
       
        tblView.reloadData()
        
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
    
    
    @IBAction func actionDelete(_ sender: Any) {
        
        if arrNotificationId.count == 0{
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select at least one notification to delete")
            self.present(alert, animated: true, completion: nil)
            
        }else{
            apicallDeleteNotification()
        }
        
        
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


    // MARK: - get Notices

      func apicallGetNotifications()
      {
           if !NetworkState().isInternetAvailable {
                           ShowNoInternetAlert()
                           return
                       }
              webservices().StartSpinner()
              Apicallhandler().GetNotificationList(URL: webservices().baseurl + API_NOTIFICATION_LIST, token:UserDefaults.standard.value(forKey: USER_TOKEN)! as! String) { JSON in
                  switch JSON.result{
                  case .success(let resp):

                      webservices().StopSpinner()
                      if(resp.status == 1)
                      {
                        self.arrNotiData = resp.data!.reversed()

                        if self.arrNotiData.count > 0{
                            self.lblNoDataFound.isHidden = true
                            self.tblView.dataSource = self
                            self.tblView.delegate = self
                            self.tblView.reloadData()

                        }else{
                            self.tblView.isHidden = true
                            self.lblNoDataFound.isHidden = false
                            self.btnSelectAll.setTitle("Select All", for: .normal)
                            self.lbltotalSelected.isHidden = true
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
    
    
    @objc func checkUnCheck(sender:UIButton)
    {

            if arrNotificationId.contains(arrNotiData[sender.tag].id!){
                               //arrDummy.add("1")
                                arrNotificationId.remove(arrNotiData[sender.tag].id!)

                           }else{
                                //arrDummy.add("0")
                                 arrNotificationId.add(arrNotiData[sender.tag].id!)
                           }
            if arrNotificationId.count > 0{
                 lbltotalSelected.text = String(format: "%d selected", arrNotificationId.count)
                //viewDelete.heightAnchor.constraint(equalToConstant: 60).isActive = true
    //            constraintHightDeleteview.constant = 0
    //            viewDelete.isHidden = false
                lbltotalSelected.isHidden = false
                
            }else{
                lbltotalSelected.isHidden = true
                btnSelectAll.setTitle("Select All", for: .normal)
    //             constraintHightDeleteview.constant = 0
    //            viewDelete.isHidden = true
            }
                           tblView.reloadData()

        }


    @objc func readmore(sender:UIButton)
    {
        if arrReadMore.contains(arrNotiData[sender.tag].id!) {
            arrReadMore.remove(arrNotiData[sender.tag].id!)
        }else{
            arrReadMore.add(arrNotiData[sender.tag].id!)
        }
        tblView.reloadData()

    }
    
    
    
    func apicallDeleteNotification()
          {
               if !NetworkState().isInternetAvailable {
                               ShowNoInternetAlert()
                               return
                           }
                  let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            
               let strId = arrNotificationId.componentsJoined(by: ",")
            
               let param : Parameters = [
                   "notification_id" : strId,
                ]
               
               webservices().StartSpinner()
               Apicallhandler.sharedInstance.ApiCallDeleteNotification(token: token as! String, param: param) { JSON in
                      
                      let statusCode = JSON.response?.statusCode
                      
                      switch JSON.result{
                      case .success(let resp):
                          //webservices().StopSpinner()
                          if statusCode == 200{
                           self.apicallGetNotifications()
                            self.lbltotalSelected.isHidden = true
                            self.arrNotificationId.removeAllObjects()
                          }
                      case .failure(let err):
                          
                          webservices().StopSpinner()
                          let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                          self.present(alert, animated: true, completion: nil)
                          print(err.asAFError)
                          
                          
                      }
                  }
                  
          
              
          }
    
    
    @IBAction func actionNotification(_ sender: Any) {
              viewDidLoad()
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
  

}



@available(iOS 13.0, *)
extension NotificationVC : UITableViewDelegate , UITableViewDataSource{


    // MARK: - Tableview delegate and data source methods

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrNotiData.count
       }
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let  cell   = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
           //(0-Inout 1-Events 2-Notices 3-Circulrs)

          cell.selectionStyle = .none
        
           cell.btnCheckUnCheck.tag = indexPath.row
           cell.btnReadMore.tag = indexPath.row

        if arrNotiData[indexPath.row].type == 0{ // INOUT
            cell.lblTitel.text = ""
        }
        if arrNotiData[indexPath.row].type == 1{ // Event
            cell.lblTitel.text = "Event"
        }
        
        if arrNotiData[indexPath.row].type == 2{//Notices
            cell.lblTitel.text = "Notice"
        }
        
        if arrNotiData[indexPath.row].type == 3{//Circulars
            cell.lblTitel.text = "Circulars"
        }
          cell.btnReadMore.isHidden = true
        
           cell.lblDiscription.text = arrNotiData[indexPath.row].text
        
        cell.lblDate.isHidden = true


        let hight = getLabelHeight(text: arrNotiData[indexPath.row].text!, width:cell.bounds.width - 32 , font: UIFont(name:"Lato-Regular", size: 14)!)
        
           if hight >  34{
               cell.btnReadMore.isHidden = false
           }else{
               cell.btnReadMore.isHidden = true
           }

           if arrReadMore.contains(arrNotiData[indexPath.row].id!){
               cell.lblDiscription.numberOfLines = 0
               cell.lblDiscription.lineBreakMode = .byWordWrapping
               cell.lblDiscription.text = arrNotiData[indexPath.row].text
               cell.btnReadMore.setTitle("Read Less <", for: .normal)

           }else{
               cell.lblDiscription.numberOfLines = 3
               cell.lblDiscription.lineBreakMode = .byTruncatingTail
               cell.lblDiscription.text = arrNotiData[indexPath.row].text
               cell.btnReadMore.setTitle("Read More >", for: .normal)

           }
        
        cell.lblDiscription.text = arrNotiData[indexPath.row].text

        if arrNotificationId.contains(arrNotiData[indexPath.row].id!){
            cell.btnCheckUnCheck.setImage(UIImage(named: "ic_checked"), for: .normal)

        }else{
            cell.btnCheckUnCheck.setImage(UIImage(named: "ic_unchecked"), for: .normal)
        }
        
        cell.btnCheckUnCheck.addTarget(self, action:#selector(checkUnCheck(sender:)), for: .touchUpInside)

           cell.btnReadMore.addTarget(self, action:#selector(readmore(sender:)), for: .touchUpInside)

           return cell

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
    
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if arrNotificationId.contains(arrNotiData[indexPath.row].id!){
                           //arrDummy.add("1")
                            arrNotificationId.remove(arrNotiData[indexPath.row].id!)

                       }else{
                            //arrDummy.add("0")
                             arrNotificationId.add(arrNotiData[indexPath.row].id!)
                       }
        if arrNotificationId.count > 0{
             lbltotalSelected.text = String(format: "%d selected", arrNotificationId.count)
            //viewDelete.heightAnchor.constraint(equalToConstant: 60).isActive = true
//            constraintHightDeleteview.constant = 0
//            viewDelete.isHidden = false
            lbltotalSelected.isHidden = false
            
        }else{
            lbltotalSelected.isHidden = true
            btnSelectAll.setTitle("Select All", for: .normal)
//             constraintHightDeleteview.constant = 0
//            viewDelete.isHidden = true
        }
                       tblView.reloadData()

    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }



}
