//
//  EditGuestVC.swift
//  SocietyMangement
//
//  Created by MacMini on 02/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire
import SWRevealViewController

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class EditGuestVC: BaseVC , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    var arrInvitedmember = NSMutableArray()
    
    @IBOutlet weak var lblTodayFrequentDataShow: UILabel!
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        // 17/8/20.
        
        var strDateee = ""
        var endDate = ""
            
            if frequencyType == "once"{
                strDateee = strChangeDateFormate(strDateeee: date)
            }else{
                strDateee = strChangeDateFormate(strDateeee: startdate)
                endDate = strChangeDateFormate(strDateeee: enddate)
            }
        
        if frequencyType == "once"{
            lblTodayFrequentDataShow.text = strDateee

           // lblTodayFrequentDataShow.text = date
        }else{
            lblTodayFrequentDataShow.text = "\(strDateee) to \(endDate)"

          //  lblTodayFrequentDataShow.text = "\(startdate) to \(enddate)"
        }
        
      //  tblView.separatorStyle = .none
        print(arrInvitedmember)
        
        
    }
    
    
    //MARK:- tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInvitedmember.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! manuallycell
        
        cell.lblname.text = (arrInvitedmember[indexPath.row] as!  NSMutableDictionary).value(forKey: "name") as? String
        cell.lblcontact.text = (arrInvitedmember[indexPath.row] as!  NSMutableDictionary).value(forKey: "contact") as? String
        
        cell.btndelete.tag = indexPath.row
        cell.btndelete.addTarget(self, action: #selector(deleteaction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func actioInviteguest(_ sender: Any) {
        
        if arrInvitedmember.count == 0{
            let alert = webservices.sharedInstance.AlertBuilder(title:"Frequent entry", message:"Please select at least guest to invite")
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = "Frequent entry"
            avc?.stckVw.isHidden = true
            avc?.lblline1.isHidden = true
            avc?.lblline2.isHidden = true
            avc?.btnOk.isHidden = false
            
                    avc?.subtitleStr = "Frequent entry added successfully"
                            avc?.yesAct = {
                                                            
                                            self.apicallFrequentEntry(id: "")

                                            }
                                avc?.noAct = {
                                                          
                                             }
                            present(avc!, animated: true)
            
        }
        
    }
    
    @objc func deleteaction(sender:UIButton)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                  let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                  avc?.titleStr = GeneralConstants.kAppName //"Communei"
                  avc?.subtitleStr = "Are you sure you want to delete this  contact?"
                  avc?.yesAct = {
                        
                           self.arrInvitedmember.removeObject(at: sender.tag)
                           self.tblView.reloadData()
                      }
                  avc?.noAct = {
                    
                  }
        
                  present(avc!, animated: true)
        
        
        
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to delete this record?" , preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
//            self.arrInvitedmember.removeObject(at: sender.tag)
//            self.tblView.reloadData()
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
        
    }
    
    func strChangeDateFormate(strDateeee:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let strDate = formatter.date(from: strDateeee)
        var str = ""
        if strDate != nil{
            formatter.dateFormat = "yyyy-MM-dd"
            str = formatter.string(from: strDate!)
        }else{
            str = strDateeee
        }
        
        
        return str
    }
    
    
    
    // MARK: - get Members
    
    func apicallFrequentEntry(id:String)
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            let SocietyId = UserDefaults.standard.value(forKey: USER_SOCIETY_ID) as! Int
            let strsocietyId = (SocietyId as NSNumber).stringValue
            
            //            type, contact_array, society_id, start_date, end_date, maxhour, time
            //            date format:- yyyy-mm-dd
            var string = ""
            
            do {
                //Convert to Data
                let jsonData = try JSONSerialization.data(withJSONObject: arrInvitedmember, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(JSONString)
                    string = JSONString
                }
                
            } catch {
                print("error")
            }
            
                        
            var strDateee = ""
            var endDate = ""
            
            if frequencyType == "once"{
                strDateee = strChangeDateFormate(strDateeee: date)
            }else{
                strDateee = strChangeDateFormate(strDateeee: startdate)
                endDate = strChangeDateFormate(strDateeee: enddate)
            }
            
            let param : Parameters = [
                "type":frequencyType,
                "contact_array":string,
                "society_id":strsocietyId,
                "start_date":strDateee,
                "end_date":endDate,
                "maxhour":validtill,
                "time":time
                
            ]
            
            webservices().StartSpinner()
            Apicallhandler().APIAddFrequentEntry(URL: webservices().baseurl + API_ADD_FREQUENTGUEST, param: param, token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                      //  let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                      //  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                        
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                   
                        navigationController.pushViewController(initialViewController, animated: true)
                        
                        self.appDelegate.window?.rootViewController = navigationController
                        
                        self.appDelegate.window?.makeKeyAndVisible()
                        
                      //  let nextViewController = self.pushViewController(withName:NewHomeVC.id(), fromStoryboard: "Main") as! NewHomeVC

                        
                      //  let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                    // self.navigationController?.pushViewController(nextViewController, animated: true)

                        
                        //                        // create the alert
                        //                        let alert = UIAlertController(title: Alert_Titel, message:"Entry Successfully." , preferredStyle: UIAlertController.Style.alert)
                        //                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                        //                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        //                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        //                            self.navigationController?.pushViewController(nextViewController, animated: true)
                        //                        }))
                        //                        // show the alert
                        //                        self.present(alert, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        
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
                        
                        return
                    }
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
        
    }
    
    
    
    
    
}
