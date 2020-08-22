//
//  UserSettingsVC.swift
//  SocietyMangement
//
//  Created by MacMini on 20/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import Alamofire
import SWRevealViewController

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var cb: Checkbox!
}


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class UserSettingsVC: UIViewController {
    
    @IBOutlet weak var highcollection: NSLayoutConstraint!
    @IBOutlet weak var collectionmember: UICollectionView!
    
    @IBOutlet weak var cbself: Checkbox!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFlatNo: UILabel!
    @IBOutlet weak var lblFlatType: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    var strNoticeShow = "0"
    var strCircularShow = "0"
    var strEventShow = "0"
    var strContactDetailShow = "0"
    var strFamilyDetailShow = "0"
    
    var selectedCell = -1
    
    var arrGetSetting = [getSettingData]()
    
    var arrMemberSelected = [FamilyMember]()
    var arrSelectedMember = NSMutableArray()
    
    var strRecieverId = ""
    
    var arrDummy = NSMutableArray()
    var arrMemberID = NSMutableArray()
    
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var switchNotice: PVSwitch!
    @IBOutlet weak var switchEvent: PVSwitch!
    @IBOutlet weak var switchcircular: PVSwitch!
    
    @IBOutlet weak var switchContactDetails: PVSwitch!
    
    @IBOutlet weak var switchFamily: PVSwitch!
    
    
    var isSelf : Bool!
    
    var nameary = ["raj","tanvi","Jiinalll","raj","tanvi","Jiinalll","raj","tanvi","Jiinalll","raj","tanvi","Jiinalll","raj","tanvi","Jiinalll"]
        
    @IBAction func actionSelfCheckMark(_ sender: Any) {
        
        if isSelf == true{
            
            let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
       
            if arrMemberID.contains((userId as NSNumber).stringValue){
               arrMemberID.remove((userId as NSNumber).stringValue)
            }
            
            
            cbself.isChecked = false
            
            let strUserId = (userId as NSNumber).stringValue
            
            
            strRecieverId = strUserId
            
            isSelf = false
//            selectedCell = -1
//            arrSelectedMember.removeAllObjects()
            //collectionmember.reloadData()
            
            if arrMemberID.count == 0{
                let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select at least one notification receiver")
                self.present(alert, animated: true, completion: nil)
                return
            }
            apicallAddSettings()
            
        }else{
            isSelf = true
            cbself.isChecked = true
            if arrMemberID.count < 4{
                let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
                arrMemberID.add((userId as NSNumber).stringValue)
                  
                       }else{
                           let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"You can select maximum 4 person as notification receiver")
                           self.present(alert, animated: true, completion: nil)
                
                     return
                }
            
          apicallAddSettings()
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
     
        if(revealViewController() != nil)
        {
            btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
        arrMemberID.add((userId as NSNumber).stringValue)
        let strUserId = (userId as NSNumber).stringValue
        strRecieverId = strUserId
        
        lblName.text = UsermeResponse?.data!.name
        if(UsermeResponse?.data!.image != nil)
        {
            imgUser.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse?.data!.image)!), placeholderImage: UIImage(named: "vendor-1"))
        }
        self.lblFlatNo.text = String(format: "Flat No: %@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)
        lblFlatType.text = "Contact no: \(UsermeResponse!.data!.phone!)"
        
        
        isSelf = true
        cbself.isChecked = true
        
        
        apicallGetFamilyMembers(id: "")
        //apicallGetSettings()
        
        let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                verticalAlignment: .center)
        
        collectionmember.collectionViewLayout = alignedFlowLayout
        self.collectionmember.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        checkbox(cb: cbself)
        
        
        
        
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
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        collectionmember.layer.removeAllAnimations()
        
        highcollection.constant = collectionmember.contentSize.height + 20

        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        
    }
    func checkbox(cb:Checkbox)
    {
        cb.borderStyle = .circle
        cb.checkmarkStyle = .circle
        cb.uncheckedBorderColor = AppColor.appcolor
        cb.borderWidth = 1
        cb.uncheckedBorderColor = AppColor.appcolor
        cb.checkedBorderColor = AppColor.appcolor
        cb.backgroundColor = .clear
        cb.checkboxBackgroundColor = UIColor.clear
        cb.checkmarkColor = AppColor.appcolor
        
    }
    @IBAction func actionSwitchContact(_ sender: Any) {
        
        if switchContactDetails.isOn == true
        {
            strContactDetailShow = "1"
        }else{
            strContactDetailShow = "2"
        }
        
        apicallAddSettings()
        
    }
    
    @IBAction func actiuonNotice(_ sender: Any) {
        if switchNotice.isOn == true
        {
            strNoticeShow = "1"
        }else{
            strNoticeShow = "2"
        }
        
        apicallAddSettings()
        
    }
    
    @IBAction func actionEvent(_ sender: Any) {
        
        if switchEvent.isOn == true
        {
            strEventShow = "1"
        }else{
            strEventShow = "2"
        }
        
        apicallAddSettings()
    }
    
    @IBAction func actioncircular(_ sender: Any) {
        
        if switchcircular.isOn == true
        {
            strCircularShow = "1"
        }else{
            strCircularShow = "2"
        }
        
        apicallAddSettings()
    }
    
    @IBAction func actionfamily(_ sender: Any) {
        
        if switchFamily.isOn == true
        {
            strFamilyDetailShow = "1"
        }else{
            strFamilyDetailShow = "2"
        }
        
        apicallAddSettings()
    }
    
    
    // MARK: - Add Settings
    
    func apicallAddSettings()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            
             print(arrMemberID)
            
            let strId = arrMemberID.componentsJoined(by: ",")
            print(strId)
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            
            //            1 = show detal
            //            2 = hide detail
            
            let param : Parameters = [
                "receiver_id" : strId,
                "event" : strEventShow,
                "notice" : strNoticeShow,
                "circular" : strCircularShow,
                "contact_details" : strContactDetailShow,
                "family_details" : strFamilyDetailShow
            ]
            
            
            Apicallhandler.sharedInstance.ApiCallAddSettings(token: token as! String, param: param) { JSON in
                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                    //webservices().StopSpinner()
                    
                    print("--------->add settings \(resp)")
                    
                    if statusCode == 200{
                        UserDefaults.standard.set(resp.data.contactDetails, forKey: USER_SETTING_CONTACT_SHOW)
                        UserDefaults.standard.set(resp.data.familyDetails, forKey: USER_SETTING_FAMILY_SHOW)
                        UserDefaults.standard.set(resp.data.circular, forKey: USER_SETTING_CIRCULAR_SHOW)
                        UserDefaults.standard.set(resp.data.notice, forKey: USER_SETTING_NOTICE_SHOW)
                        UserDefaults.standard.set(resp.data.event, forKey: USER_SETTING_EVENT_SHOW)
                        UserDefaults.standard.synchronize()
                        
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
    
    
    // MARK: - Get Settings
    
    func apicallGetSettings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            //            1 = show detal
            //            0 = hide detail
            
            webservices().StartSpinner()
            Apicallhandler.sharedInstance.ApiCallGetSettings(token: token as! String) { JSON in
                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if statusCode == 200{
                        self.arrGetSetting = resp.data
                        
//                        "receiver_id" : strId,
//                                       "event" : strEventShow,
//                                       "notice" : strNoticeShow,
//                                       "circular" : strCircularShow,
//                                       "contact_details" : strContactDetailShow,
//                                       "family_details" : strFamilyDetailShow
//
                        
                        if self.arrGetSetting.count > 0{
                            if self.arrGetSetting[0].notice == 1{
                                self.switchNotice.isOn = true
                                self.strNoticeShow = "1"
                            }else{
                                self.switchNotice.isOn = false
                            }
                            
                            
                            if self.arrGetSetting[0].event == 1{
                                self.switchEvent.isOn = true
                                self.strEventShow = "1"
                            }else{
                                self.switchEvent.isOn = false
                            }
                            
                            
                            if self.arrGetSetting[0].circular == 1{
                                self.switchcircular.isOn = true
                                self.strCircularShow = "1"
                            }else{
                                self.switchcircular.isOn = false
                            }
                            
                            
                            if self.arrGetSetting[0].contactDetails == 1{
                                self.switchContactDetails.isOn = true
                            }else{
                                self.switchContactDetails.isOn = false
                            }
                            
                            
                            if self.arrGetSetting[0].familyDetails == 1{
                                self.switchFamily.isOn = true
                            }else{
                                self.switchFamily.isOn = false
                            }
                            
                            //self.selectedCell = self.arrGetSetting[0].receiverID!
                            self.arrMemberID.removeAllObjects()
                            let strId = self.arrGetSetting[0].receiverID!
                            let arr = strId.components(separatedBy: ",")
                            for i in 0..<arr.count{
                                self.arrMemberID.add(arr[i])
                            }
                             let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
                            if(self.arrMemberID.contains((userId as NSNumber).stringValue))
                            {
                                self.isSelf = true
                                self.cbself.isChecked = true
                            }else
                            {
                                self.isSelf = false
                                self.cbself.isChecked = false

                            }
                            self.collectionmember.reloadData()
                        }
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
    
    
    func apicallGetFamilyMembers(id:String)
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            webservices().StartSpinner()
            
            
            Apicallhandler().APIGetFamilyMember(URL: webservices().baseurl + API_GET_FAMAILY_MEMBER, param: [:], token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.arrMemberSelected = resp.data!
                        
                        if self.arrMemberSelected.count > 0{
                            self.collectionmember.reloadData()
                            //self.highcollection.constant = CGFloat(self.arrMemberSelected.count) * 30
                        }else{
                            self.collectionmember.reloadData()
                            //self.highcollection.constant = 0
                        }
                        self.apicallGetSettings()
                    }
                        
                    else
                    {
                        
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
    
    
    @objc func getIndexSelectedCell(sender:Checkbox) {
        
        
        
        if arrMemberID.contains((arrMemberSelected[sender.tag].id! as NSNumber).stringValue){
                   //arrDummy.add("1")
                    arrMemberID.remove((arrMemberSelected[sender.tag].id! as NSNumber).stringValue)

               }else{
                    //arrDummy.add("0")
            
            if arrMemberID.count < 4{
                 arrMemberID.add((arrMemberSelected[sender.tag].id! as NSNumber).stringValue)
            }else{
                let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"You can select maximum 4 person as notification receiver")
                self.present(alert, animated: true, completion: nil)
                return
            }
                    
            }
        
        if arrMemberID.count == 0{
            let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select at least one notification receiver")
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.collectionmember.reloadData()

               apicallAddSettings()

               //collectionmember.reloadData()
        
        
//
//        let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
//        let strUserId = (userId as NSNumber).stringValue
//
//        if selectedCell == arrMemberSelected[sender.tag].id{
//            selectedCell = -1
//            arrSelectedMember.remove(arrMemberSelected[sender.tag].id)
//        }else{
//            cbself.isChecked = false
//            selectedCell = arrMemberSelected[sender.tag].id!
//            strRecieverId = String(format: "%d", arrMemberSelected[sender.tag].id!)
//            apicallAddSettings()
//
//        }
//
//        collectionmember.reloadData()
        
        
        
    }
    
    
}

@available(iOS 13.0, *)
extension UserSettingsVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
    
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UserCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! UserCell
        
        cell.lblname.sizeToFit()
        cell.cb.tag = indexPath.row
        
        let tag = arrMemberSelected[indexPath.row].name
        cell.lblname.text = tag
        checkbox(cb: cell.cb)
        //New
        if arrMemberID.contains((arrMemberSelected[indexPath.row].id! as NSNumber).stringValue){
             cell.cb.isChecked = true
        }else{
            cell.cb.isChecked = false
        }
        cell.cb.isUserInteractionEnabled = false
        
//        if  selectedCell == arrMemberSelected[indexPath.row].id{
//            cell.cb.isChecked = true
//            cbself.isChecked = false
//        }else{
//            cell.cb.isChecked = false
//        }
        
        cell.cb.addTarget(self, action: #selector(getIndexSelectedCell(sender:)), for: .valueChanged)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrMemberSelected.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
               
        if arrMemberID.contains((arrMemberSelected[indexPath.row].id! as NSNumber).stringValue){
                          //arrDummy.add("1")
                           arrMemberID.remove((arrMemberSelected[indexPath.row].id! as NSNumber).stringValue)

                      }else{
                           //arrDummy.add("0")
                   
                   if arrMemberID.count < 4{
                        arrMemberID.add((arrMemberSelected[indexPath.row].id! as NSNumber).stringValue)
                   }else{
                       let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"You can select maximum 4 person as notification receiver")
                       self.present(alert, animated: true, completion: nil)
                       return
                   }
                           
                   }
               
               if arrMemberID.count == 0{
                   let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please select at least one notification receiver")
                   self.present(alert, animated: true, completion: nil)
                   return
               }
               
               self.collectionmember.reloadData()

                      apicallAddSettings()

       
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxLabelSize: CGSize = CGSize(width: self.view.frame.size.width, height: CGFloat(9999))
        let contentNSString = arrMemberSelected[indexPath.row].name!
        let expectedLabelSize = contentNSString.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15.0)], context: nil)
        print("\(expectedLabelSize)")
        return CGSize(width:expectedLabelSize.size.width + 50, height: expectedLabelSize.size.height + 20)
        //return CGSize(width:collectionView.frame.size.width/3, height: expectedLabelSize.size.height + 20)
    }
    
    
}
