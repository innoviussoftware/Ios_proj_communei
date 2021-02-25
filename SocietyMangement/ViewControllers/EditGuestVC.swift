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



class EditGuestVC: BaseVC , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var lblSigle_Multiple: UILabel!

    var arrInvitedmember = NSMutableArray()
    
    @IBOutlet weak var lblTodayFrequentDataShow: UILabel!
    
    var arrActivityyy = [ActivityyyDatum]()

    var arrInvitationPop = NSMutableArray()

    
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
                lblSigle_Multiple.text = "Allow Single Visit"

                strDateee = strChangeDateFormate(strDateeee: date)
            }else{
                
                lblSigle_Multiple.text = "Allow Multiple Visits"
                strDateee = strChangeDateFormate(strDateeee: startdate)
                endDate = strChangeDateFormate(strDateeee: enddate)
            }
        
        if frequencyType == "once"{
            lblSigle_Multiple.text = "Allow Single Visit"

            lblTodayFrequentDataShow.text = strDateee

           // lblTodayFrequentDataShow.text = date
        }else{
            lblSigle_Multiple.text = "Allow Multiple Visits"

            lblTodayFrequentDataShow.text = "between \(strDateee) and \(endDate)"
            
            // Allow Multiple Visits between 25-08-2020 and 29-08-2020

          //  lblTodayFrequentDataShow.text = "\(startdate) to \(enddate)"
        }
        
      //  tblView.separatorStyle = .none
        print(arrInvitedmember)
        
        print("EditGuestVC")

    }
    
    //MARK:- tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrInvitedmember.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! manuallycell
        
        cell.lblname.text = (arrInvitedmember[indexPath.row] as!  NSMutableDictionary).value(forKey: "Name") as? String
        cell.lblcontact.text = (arrInvitedmember[indexPath.row] as!  NSMutableDictionary).value(forKey: "Mobile") as? String
        
        cell.btndelete.tag = indexPath.row
        cell.btndelete.addTarget(self, action: #selector(deleteaction(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func actioInviteguest(_ sender: UIButton) {
        
        if arrInvitedmember.count == 0{
            let alert = webservices.sharedInstance.AlertBuilder(title:"Frequent entry", message:"Please select at least guest to invite")
            self.present(alert, animated: true, completion: nil)
            
        }else{
            
            let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
            avc?.titleStr = "Frequent entry"
            avc?.isfrom = 0

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
    
    
    
    // MARK: - get Entry
    
    func apicallFrequentEntry(id:String)
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
         //  let SocietyId = UserDefaults.standard.value(forKey: USER_SOCIETY_ID) as! Int
          //  let strsocietyId = (SocietyId as NSNumber).stringValue
            
            //            type, contact_array, society_id, start_date, end_date, maxhour, time
            //            date format:- yyyy-mm-dd
            var string = ""
            
            do {
                //Convert to Data
                let jsonData = try JSONSerialization.data(withJSONObject: arrInvitedmember, options: JSONSerialization.WritingOptions.prettyPrinted)
                
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print("JSONString ",JSONString)
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
        
     
           /* let param : Parameters = [
                "type":frequencyType,
                "contact_array":string,
                "society_id":strsocietyId,
                "start_date":strDateee,
                "end_date":endDate,
                "maxhour":validtill,
                "time":time
            ] */
        
        var after_add_time = ""

        if validtill == "Day End" {
           /* validtill = time
            
           // let myInt = Int(validtill)!
            
            let dateFormatter = DateFormatter()
            
            let isoDate = time //strDateee //"2016-04-14T10:44:00+0000"

            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd" // h:mm"

          //  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let date = dateFormatter.date(from:isoDate)!
            
//            let date2 = strDateee
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            var date = dateFormatter.date(from: date2)
//
//            date = dateFormatter.date(from:isoDate)!
            
            let addminutes = date.addingTimeInterval(TimeInterval(24*60*60))
            after_add_time = dateFormatter.string(from: addminutes)
                print("after add time --> ",after_add_time) */
            
            after_add_time = "11:59 PM" //"23:59:00"

        }else{
            validtill.removeLast(3)
            
            let myInt = Int(validtill)!
            
            let dateFormatter = DateFormatter()
            
           // let valid =  time + ":00"
            
            let isoDate = time //validtill // valid  //"2016-04-14T10:44:00+0000"

            dateFormatter.dateFormat = "h:mm a" // "yyyy-MM-dd"  //h:mm"

          //  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            
          //  let formatter = DateFormatter()
          //  formatter.dateFormat = "yyyy-MM-dd"
          //  let date = formatter.date(from: strDateee)!
          
            let date = dateFormatter.date(from:isoDate)!
            
            
          //  let date2 = strDateee
          //  dateFormatter.dateFormat = "yyyy-MM-dd"
          //  let date = dateFormatter.date(from: date2)

        //   date = dateFormatter.date(from:isoDate)
            
            
            let addminutes = date.addingTimeInterval(TimeInterval(myInt*60*60))
            after_add_time = dateFormatter.string(from: addminutes)
            
            print("after add time 3 --> ",after_add_time)
        }
       
        var param = Parameters()
        
        if frequencyType == "once"{
            param  = [
                "VisitStartDate": strDateee,
                "FromTime": time, // start time
                "ToTime": after_add_time,  //validtill,  // to time
                "Visitors": string
            ]
        }else{
            param  = [
                "VisitStartDate": strDateee,
                "VisitEndDate": endDate,
                "Visitors": string
            ]
        }
        
        if frequencyType == "once"{
              print("param once : ",param)
        }else{
             print("param multi : ",param)
        }
            
            webservices().StartSpinner()
        Apicallhandler().APIAddFrequentEntryUserResponse(URL: webservices().baseurl + API_ADD_FREQUENTGUEST, param: param, token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.arrActivityyy = resp.data!

                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        // let initialViewController = storyboard.instantiateViewController(withIdentifier: "InvitationPopUpVC") as! InvitationPopUpVC


                        let popOverConfirmVC = storyboard.instantiateViewController(withIdentifier: "InvitationPopUpVC") as! InvitationPopUpVC
                        
                        popOverConfirmVC.isfrom = 1
                        
                            //  popOverConfirmVC.isfrom = 2

                        
                        for dic in self.arrActivityyy {
                           // initialViewController.strNamecard = dic.activity!.shareInviteURL
                            let shareURL = dic.activity!.shareInviteURL
                            self.arrInvitationPop.add(shareURL)
                        }
                        
                        popOverConfirmVC.strNamecard = self.arrActivityyy[0].activity!.shareInviteURL
                           
                       // initialViewController.getImage = ""
                        
                      /*  self.addChildViewController(popOverConfirmVC)
                        popOverConfirmVC.view.frame = self.view.frame
                        self.view.center = popOverConfirmVC.view.center
                        self.view.addSubview(popOverConfirmVC.view)
                        popOverConfirmVC.didMove(toParentViewController: self) */

                       self.navigationController?.pushViewController(popOverConfirmVC, animated: true)

                        
                     /*   let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                        
                        let initialViewController = storyboard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                   
                        navigationController.pushViewController(initialViewController, animated: true)
                        
                        self.appDelegate.window?.rootViewController = navigationController
                        
                        self.appDelegate.window?.makeKeyAndVisible()
                     
                        */
                    }
                    else
                    {
                        
                    }
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
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
       
        
    }
    
    
    
    
    
}
