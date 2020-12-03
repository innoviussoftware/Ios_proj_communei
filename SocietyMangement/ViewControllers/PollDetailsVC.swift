//
//  PollDetailsVC.swift
//  SocietyMangement
//
//  Created by MacMini on 22/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire

class PollListDetailsCell: UITableViewCell {
    
    @IBOutlet weak var lblOptionText: UILabel!
    @IBOutlet weak var lblVotes: UILabel!
    
    @IBOutlet weak var bgView: UIView!

}


class PollDetailsVC: BaseVC,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var ViewBg: UIView!
    @IBOutlet weak var lblDemo: UILabel!
    @IBOutlet weak var lblTitel: UILabel!
    
    @IBOutlet weak var lblExpireDate: UILabel!
    
 //  var arrPollData : PollListResponseData?
    
    var arrPollData = [PollListResponseData]()
    
    var arrSelectionCheck = NSMutableArray()
    
    var indexPoll = Int()


    var selectedIndex : Int! = -5
    var arrPollDetail = NSMutableArray()
    var selectedtType = ""
    var selectedOption = ""
    
    @IBOutlet weak var viewAns1: UIView!
    @IBOutlet weak var viewAns2: UIView!
    @IBOutlet weak var viewAns3: UIView!
    @IBOutlet weak var viewAns4: UIView!
    
    @IBOutlet weak var lblAns1: UILabel!
    @IBOutlet weak var lblAns2: UILabel!
    @IBOutlet weak var lblAns3: UILabel!
    @IBOutlet weak var lblAns4: UILabel!
    
    @IBOutlet weak var lblAnsPer1: UILabel!
    @IBOutlet weak var lblAnsPer2: UILabel!
    @IBOutlet weak var lblAnsPer3: UILabel!
    @IBOutlet weak var lblAnsPer4: UILabel!
    
    @IBOutlet weak var lblMessage: UILabel!

    @IBOutlet weak var btnSubmit: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

        
        ViewBg.layer.cornerRadius = 12
        ViewBg.clipsToBounds = true
        
       /* if (arrPollData[indexPoll].pollOptions?[indexPoll].isanswerSubmit! == 0 ) {
            btnSubmit.isHidden = false
        }else{
            btnSubmit.isHidden = true
        } */
        
        // tblView.register(UINib(nibName: "PollDetailCell", bundle: nil), forCellReuseIdentifier: "PollDetailCell")
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblView.layer.removeAllAnimations()
        print("tblView contentSize height :- ",tblView.contentSize.height + 5)
        tableHeightConstraint.constant = tblView.contentSize.height + 5
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.view.layoutIfNeeded()
        }

    }
    
    @IBAction func actionNotification(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
            vc.isfrom = 0
        } else {
            // Fallback on earlier versions
        }
     }
     
     @IBAction func actionQRCode(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
            vc.isfrom = 0

        } else {
            // Fallback on earlier versions
        }
     }
    
    func setData() {
        
        // 12/11/20. temp comment
        
       
        lblDemo.text = arrPollData[indexPoll].title
        
        if arrPollData[indexPoll].visibleTill != nil{
            lblExpireDate.isHidden = false
            let date = NSDate()
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "dd/MM/yyyy"
            let strdate = dateFormatterGet.string(from: date as Date)
            
            let strOURDate = dateFormateChangeNEW(str: (arrPollData[indexPoll].visibleTill!))
            
            if strdate == strOURDate{
                dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let TodayDate = dateFormatterGet.date(from: (arrPollData[indexPoll].visibleTill!))
                dateFormatterGet.dateFormat = "HH:mm a"
                if TodayDate != nil{
                    let strDtae = dateFormatterGet.string(from: TodayDate!)
                    lblExpireDate.text = "Expire On: Today \(strDtae)"
                }
               
            }else{
                lblExpireDate.text = "Expire On: \(dateFormateChange(str: (arrPollData[indexPoll].visibleTill!)))"
            }
            
        }else{
            lblExpireDate.isHidden = true
        }
        
        if (arrPollData != nil) {
            tblView.delegate = self
            tblView.dataSource = self
            tblView.reloadData()
        }else{
            tblView.isHidden = true
        }
        
        /*
        
        viewAns1.layer.cornerRadius = 8
        viewAns1.clipsToBounds = true
        viewAns2.layer.cornerRadius = 8
        viewAns2.clipsToBounds = true
        viewAns3.layer.cornerRadius = 8
        viewAns3.clipsToBounds = true
        viewAns4.layer.cornerRadius = 8
        viewAns4.clipsToBounds = true
        
        
        
        let userId = (UserDefaults.standard.value(forKey: USER_ID) as! NSNumber).stringValue
        
        if arrPollData.a1Userid != nil {
            let strID = arrPollData.a1Userid
                   let arrID1 = strID?.components(separatedBy: ",")
                   if (arrID1?.contains(userId))!{
                       viewAns1.backgroundColor = AppColor.appcolor
                   }
        }
       
        if arrPollData.pollOptions. != nil {
        let strID2 = arrPollData.a2Userid
        let arrID2 = strID2?.components(separatedBy: ",")
        if  (arrID2?.contains(userId))!{
            viewAns2.backgroundColor = AppColor.appcolor
        }
        }
        
         if arrPollData.a3Userid != nil {
        let strID3 = arrPollData.a3Userid
        let arrID3 = strID3?.components(separatedBy: ",")
        if (arrID3?.contains(userId))!{
            viewAns3.backgroundColor = AppColor.appcolor
        }
        }
        
         if arrPollData.a4Userid != nil {
        let strID4 = arrPollData.a4Userid
        let arrID4 = strID4?.components(separatedBy: ",")
        if (arrID4?.contains(userId))!{
            viewAns4.backgroundColor = AppColor.appcolor
            
        }
        }
                
        
        
        if arrPollData.a1 != nil{
            lblAns1.text = arrPollData.a1
        }else{
            viewAns1.isHidden = true
        }
        
        if arrPollData.a2 != nil{
            lblAns2.text = arrPollData.a2
        }else{
            viewAns2.isHidden = true
        }
        
        if arrPollData.a3 != nil{
            lblAns3.text = arrPollData.a3
        }else{
            viewAns3.isHidden = true
        }
        
        if arrPollData.a4 != nil{
            lblAns4.text = arrPollData.a4
        }else{
            viewAns4.isHidden = true
        }
        
                
        lblAnsPer1.text = String(format: "%d %%",arrPollData.percentage1!)
        lblAnsPer2.text = String(format: "%d %%",arrPollData.percentage2!)
        lblAnsPer3.text = String(format: "%d %%",arrPollData.percentage3!)
        lblAnsPer4.text = String(format: "%d %%",arrPollData.percentage4!)
        
        */
        
        //
        //
        //
        //        let dict = NSMutableDictionary()
        //        dict.setValue(arrPollData.a1!, forKey: "ans")
        //        dict.setValue(arrPollData.percentage1, forKey: "per")
        //        dict.setValue("2", forKey: "isSelcted")
        //        arrPollDetail.add(dict)
        //
        //        let dict1 = NSMutableDictionary()
        //               dict1.setValue(arrPollData.a2!, forKey: "ans")
        //               dict1.setValue(arrPollData.percentage2, forKey: "per")
        //               dict1.setValue("2", forKey: "isSelcted")
        //               arrPollDetail.add(dict1)
        //
        //
        //        let dict2 = NSMutableDictionary()
        //               dict2.setValue(arrPollData.a3!, forKey: "ans")
        //               dict2.setValue(arrPollData.percentage3, forKey: "per")
        //               dict2.setValue("2", forKey: "isSelcted")
        //               arrPollDetail.add(dict2)
        //
        //
        //        let dict3 = NSMutableDictionary()
        //               dict3.setValue(arrPollData.a4!, forKey: "ans")
        //               dict3.setValue(arrPollData.percentage4, forKey: "per")
        //               dict3.setValue("2", forKey: "isSelcted")
        //               arrPollDetail.add(dict3)
        
        
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
    
    
    
    //MARK:- action method
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func actionAns1(_ sender: UIButton) {
        
        if sender.isSelected == true{
            
            sender.isSelected = false
            
            viewAns1.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns4.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns3.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns2.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            lblAns1.textColor = UIColor.black
            lblAns2.textColor = UIColor.black
            lblAns3.textColor = UIColor.black
            lblAns4.textColor = UIColor.black
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = ""
            
        }else{
            sender.isSelected = true
            
            viewAns1.backgroundColor = AppColor.appcolor
            viewAns4.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns3.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns2.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            
            lblAns1.textColor = UIColor.white
            lblAns2.textColor = UIColor.black
            lblAns3.textColor = UIColor.black
            lblAns4.textColor = UIColor.black
            
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = "1"
            apicallPollDetails(strOption: "1", strType: "1")
        }
        
        
        
    }
    
    @IBAction func actionAns2(_ sender: UIButton) {
        
        if sender.isSelected == true{
            
            sender.isSelected = false
            
            
            viewAns2.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns1.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns3.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns4.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            
            lblAns1.textColor = UIColor.black
            lblAns2.textColor = UIColor.black
            lblAns3.textColor = UIColor.black
            lblAns4.textColor = UIColor.black
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = ""
            
            
        }else{
            sender.isSelected = true
            
            viewAns2.backgroundColor = AppColor.appcolor
            viewAns1.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns3.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns4.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            
            lblAns1.textColor = UIColor.black
            lblAns2.textColor = UIColor.white
            lblAns3.textColor = UIColor.black
            lblAns4.textColor = UIColor.black
            
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = "2"
            apicallPollDetails(strOption: "2", strType: "1")
            
            
        }
        
        
        
    }
    
    @IBAction func actionAns3(_ sender: UIButton) {
        
        if sender.isSelected == true{
            
            sender.isSelected = false
            
            viewAns3.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns1.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns2.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns4.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            
            
            lblAns1.textColor = UIColor.black
            lblAns2.textColor = UIColor.black
            lblAns3.textColor = UIColor.black
            lblAns4.textColor = UIColor.black
            
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = ""
            //apicallPollDetails(strOption: "3", strType: "1")
            
            
            
        }else{
            sender.isSelected = true
            
            viewAns3.backgroundColor = AppColor.appcolor
            viewAns1.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns2.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns4.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            
            
            lblAns1.textColor = UIColor.black
            lblAns2.textColor = UIColor.black
            lblAns3.textColor = UIColor.white
            lblAns4.textColor = UIColor.black
            
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = "3"
            apicallPollDetails(strOption: "3", strType: "1")
            
            
        }
        
        
        
    }
    
    @IBAction func actionAns4(_ sender: UIButton) {
        
        if sender.isSelected == true{
            
            sender.isSelected = false
            
            viewAns4.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns1.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns2.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns3.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            
            lblAns1.textColor = UIColor.black
            lblAns2.textColor = UIColor.black
            lblAns3.textColor = UIColor.black
            lblAns4.textColor = UIColor.black
            
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = ""
            //apicallPollDetails(strOption: "4", strType: "1")
            
            
        }else{
            sender.isSelected = true
            
            viewAns4.backgroundColor = AppColor.appcolor
            viewAns1.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns2.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            viewAns3.backgroundColor = UIColor.init(red: 236.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1)
            
            
            lblAns1.textColor = UIColor.black
            lblAns2.textColor = UIColor.black
            lblAns3.textColor = UIColor.black
            lblAns4.textColor = UIColor.white
            
            
            apicallPreviusPollDetails(strOption: selectedOption, strType: "2")
            selectedOption = "4"
            apicallPollDetails(strOption: "4", strType: "1")
            
            
        }
        
        
    }
    
    @IBAction func btnSubmitPressed(_ sender: UIButton) {
        print("btnSubmitPressed : ")
    }
    
    
    // MARK: - get Notices
    
    func apicallPollDetails(strOption:String,strType:String)
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        
        let param:Parameters = [
            "id":((arrPollData[indexPoll].noticeID!) as NSNumber).stringValue,
            "options":strOption,
            "type":strType,
        ]
        
        // webservices().StartSpinner()
        Apicallhandler().APIPollDetails(URL: webservices().baseurl + API_POLL_DETAIL, param: param, token:UserDefaults.standard.value(forKey: USER_TOKEN)! as! String) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(resp.status == 1)
                {
                    self.lblAnsPer1.text = String(format: "%d %%",(resp.data?.percentage1)!)
                    self.lblAnsPer2.text = String(format: "%d %%",(resp.data?.percentage2)!)
                    self.lblAnsPer3.text = String(format: "%d %%",(resp.data?.percentage3)!)
                    self.lblAnsPer4.text = String(format: "%d %%",(resp.data?.percentage4)!)
                    
                }
                else
                {
                    
                }
                
                print(resp)
            case .failure(let err):
                
                //webservices().StopSpinner()
                if JSON.response?.statusCode == 401{
                    if #available(iOS 13.0, *) {
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                let navController = UINavigationController(rootViewController: aVC)
                                navController.isNavigationBarHidden = true
                                self.appDelegate.window!.rootViewController  = navController
                                
                            }
                        })
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    return
                }
                
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError)
                
            }
        }
    }
    
    
    
    
    func apicallPreviusPollDetails(strOption:String,strType:String)
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        
        let param:Parameters = [
            "id":((arrPollData[indexPoll].noticeID!) as NSNumber).stringValue,
            "options":strOption,
            "type":strType,
        ]
        
        
        
        //webservices().StartSpinner()
        Apicallhandler().APIPollDetails(URL: webservices().baseurl + API_POLL_DETAIL, param: param, token:UserDefaults.standard.value(forKey: USER_TOKEN)! as! String) { JSON in
            switch JSON.result{
            case .success(let resp):
                
                // webservices().StopSpinner()
                if(resp.status == 1)
                {
                    self.lblAnsPer1.text = String(format: "%d %%",(resp.data?.percentage1)!)
                    self.lblAnsPer2.text = String(format: "%d %%",(resp.data?.percentage2)!)
                    self.lblAnsPer3.text = String(format: "%d %%",(resp.data?.percentage3)!)
                    self.lblAnsPer4.text = String(format: "%d %%",(resp.data?.percentage4)!)
                    
                }
                else
                {
                    
                }
                
                print(resp)
            case .failure(let err):
                
                webservices().StopSpinner()
                if JSON.response?.statusCode == 401{
                    if #available(iOS 13.0, *) {
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                let navController = UINavigationController(rootViewController: aVC)
                                navController.isNavigationBarHidden = true
                                self.appDelegate.window!.rootViewController  = navController
                                
                            }
                        })
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    return
                }
                
                let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPollData[indexPoll].pollOptions!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! PollListDetailsCell
        
        if (arrPollData[indexPoll].multiPollEnable == 0) {
            if(selectedIndex == indexPath.row){
                
                cell.bgView.layer.borderColor = AppColor.pollborderSelect.cgColor
                cell.bgView.layer.borderWidth = 3.0

                //userActIndex = arrActivity[indexPath.row].userActivityTypeID
            }else{
                
                cell.bgView.layer.borderColor = AppColor.pollborder.cgColor
                cell.bgView.layer.borderWidth = 1.0
                
              //  userActIndex = 0
            }
        }else{
            if arrSelectionCheck.contains(arrPollData[indexPoll].pollOptions?[indexPath.row].optionText! ?? "")
            {
                cell.bgView.layer.borderColor = AppColor.pollborderSelect.cgColor
                cell.bgView.layer.borderWidth = 3.0
            }else{
                cell.bgView.layer.borderColor = AppColor.pollborder.cgColor
                cell.bgView.layer.borderWidth = 1.0
            }
        }
          
       
        
        cell.lblOptionText.text = arrPollData[indexPoll].pollOptions?[indexPath.row].optionText
        
        let lblVote = String(format: "%d",(arrPollData[indexPoll].pollOptions?[indexPath.row].votes)! as Int)
        
        cell.lblVotes.text = lblVote
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrPollData[indexPoll].multiPollEnable == 0 {
            selectedIndex = indexPath.row
        }else{
            if arrSelectionCheck.contains(arrPollData[indexPoll].pollOptions?[indexPath.row].optionText! ?? ""){
                arrSelectionCheck.remove(arrPollData[indexPoll].pollOptions?[indexPath.row].optionText! ?? "")
            }else{
                arrSelectionCheck.add(arrPollData[indexPoll].pollOptions?[indexPath.row].optionText! ?? "")
            }
        }
       
       /* let cell = tableView.cellForRow(at: indexPath)
               
        if cell!.isSelected == true{
            selectedIndex = indexPath.row
            // cell!.accessoryType = UITableViewCellAccessoryType.checkmark
        }else{
            selectedIndex = indexPath.row
            //cell!.accessoryType = UITableViewCellAccessoryType.none
        } */
                  
      //  selectedIndex = indexPath.row

        tblView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50  // UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


//extension PollDetailsVC : UITableViewDelegate,UITableViewDataSource{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrPollDetail.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "PollDetailCell") as! PollDetailCell
//
//
//        if selectedIndex == indexPath.row{
//            cell.bgView.backgroundColor = AppColor.appcolor
//        }else{
//            cell.bgView.backgroundColor = .white
//        }
//
//
//        cell.lblTopic.text = (arrPollDetail[indexPath.row] as! NSMutableDictionary).value(forKey: "ans") as? String
//
//        cell.lblPercentage.text = (arrPollDetail[indexPath.row] as! NSMutableDictionary).value(forKey: "per") as? String
//
//
//
//
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        selectedIndex = indexPath.row
//        apicallPollDetails(strOption: String(format: "%d", indexPath.row + 1), strType: "1")
//
//        tblView.reloadData()
//
//    }
//
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        apicallPollDetails(strOption: String(format: "%d", indexPath.row + 1), strType: "2")
//    }
//
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
//
//
//
//
//}


/*
 
 {{url}}/user/notices/4/vote
 
 NoticeID  = 192
 
 OptionID  =  34
 
 {
     "data": {
         "NoticeID": 192,
         "NoticeTypeID": 4,
         "Title": "My poll 20201030 002",
         "Description": "My poll 20201030 002 description",
         "PublishDate": "2020-11-20 15:22:58",
         "VisibleTill": "2020-12-12 00:00:00",
         "EventStartDate": null,
         "EventEndDate": null,
         "CreationDate": "2020-11-20 15:22:58",
         "CreatedBy": "39e34b3e-d7e1-412b-a565-f23bc0babd59",
         "PollEnabled": 1,
         "MultiPollEnable": 0,
         "SocietyID": 5,
         "ReadAt": "2020-11-20 15:22:58",
         "attachments": [],
         "pollOptions": [
             {
                 "OptionText": "Option 20201030 0021",
                 "Votes": 33,
                 "NoticePollOptionID": 33,
                 "NoticeID": 192
             },
             {
                 "OptionText": "Option 20201030 0022",
                 "Votes": 33,
                 "NoticePollOptionID": 34,
                 "NoticeID": 192
             },
             {
                 "OptionText": "Option 20201030 0023",
                 "Votes": 16,
                 "NoticePollOptionID": 35,
                 "NoticeID": 192
             },
             {
                 "OptionText": "Option 20201030 0024",
                 "Votes": 16,
                 "NoticePollOptionID": 36,
                 "NoticeID": 192
             }
         ],
         "pollTotalVotes": 6
     },
     "status": 1,
     "message": "Submitted your vote successfully"
 }
 
 */
