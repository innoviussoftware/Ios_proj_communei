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
        
    @IBOutlet weak var btncheckself: UIButton!
    
    @IBOutlet weak var bgViw: UIView!

}


class UserCell1: UICollectionViewCell {
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var cb: Checkbox!
        
    @IBOutlet weak var btncheckself: UIButton!


}


class UserSettingsVC: BaseVC {
    
    @IBOutlet weak var highcollection: NSLayoutConstraint!
    @IBOutlet weak var collectionmember: UICollectionView!
    
    @IBOutlet weak var cbself: Checkbox!
    
    @IBOutlet weak var btncbself: UIButton!
        
   // @IBOutlet weak var imgviewcheckself: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFlatNo: UILabel!
    @IBOutlet weak var lblFlatType: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    var ShareContactDetails = Int()
    var ShareFamilyMemberDetails = Int()
    
    var DoNotDisturb = Int()

    var DomesticNotifyOnEntry = Int()
    var DomesticNotifyOnExit = Int()
    
    var VisitorNotifyOnEntry = Int()
    var VisitorNotifyOnExit = Int()

    var OthersNotifyOnEntry = Int()
    var OthersNotifyOnExit = Int()

    var selectedCell = -1
    
    var arrGetSetting = [getSettingData]()
    
    var arrMemberSelected = [FamilyMember]()
    var arrSelectedMember = NSMutableArray()
    
    var strRecieverId = ""
    
    var arrDummy = NSMutableArray()
    var arrMemberID = NSMutableArray()
    
    @IBOutlet weak var btnMenu: UIButton!
    
   // @IBOutlet weak var DNDSwitch: PVSwitch!

   // @IBOutlet weak var switchNotice: PVSwitch!
   // @IBOutlet weak var switchEvent: PVSwitch!
  //  @IBOutlet weak var switchcircular: PVSwitch!
    
   // @IBOutlet weak var switchContactDetails: PVSwitch!
    
  //  @IBOutlet weak var switchFamily: PVSwitch!
    
    @IBOutlet weak var DNDSwitch: UISwitch!
    
    @IBOutlet weak var switchNotice: UISwitch!

  //  @IBOutlet weak var switchEvent: UISwitch!
    
    @IBOutlet weak var switchDailyNoticeEntry: UISwitch!
    
    @IBOutlet weak var switchDailyNoticeExit: UISwitch!

    @IBOutlet weak var switchContactDetails: UISwitch!
    
    @IBOutlet weak var switchFamily: UISwitch!
    
    @IBOutlet weak var switchVisitorOnEntry: UISwitch!
    
    @IBOutlet weak var switchVisitorOnExit: UISwitch!

    @IBOutlet weak var switchOtherEntry: UISwitch!
    
    @IBOutlet weak var switchOtherExit: UISwitch!
    
    @IBOutlet weak var lblDnd: UILabel!

    @IBOutlet weak var viewPopUp: UIView!
    
    @IBOutlet weak var viewMainPopUp: UIView!
    @IBOutlet weak var textViewReasion: UITextView!
    @IBOutlet weak var viewDND: UIView!
    
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var viewPrivacy: UIView!
    @IBOutlet weak var viewDomestic: UIView!
    @IBOutlet weak var viewVisitor: UIView!
    @IBOutlet weak var viewDelivery: UIView!
    @IBOutlet weak var viewRemoveActivate: UIView!

    @IBOutlet weak var lblTC: UILabel!

    @IBOutlet weak var lblPrivacyPolicy: UILabel!

    @IBOutlet weak var lblDNDStaic: UIButton!

    @IBOutlet weak var constraintHeightDND: NSLayoutConstraint!

    
    var strDNDStatus = "1"
    
    var isSelf : Bool!
    
    var nameary = ["raj","tanvi","Jiinalll","raj","tanvi","Jiinalll","raj","tanvi","Jiinalll","raj","tanvi","Jiinalll","raj","tanvi","Jiinalll"]
        
    @IBAction func actionSelfCheckMark(_ sender: UIButton) {
        
        if isSelf == true{
            
            let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
       
            if arrMemberID.contains((userId as NSNumber).stringValue){
               arrMemberID.remove((userId as NSNumber).stringValue)
            }
            
            
           // cbself.isChecked = false
            

            btncbself.setImage(UIImage(named: "ic_radiobutton"), for: UIControlState.normal)
            
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
            //cbself.isChecked = true
            
            btncbself.setImage(UIImage(named: "ic_radiobuttonselect"), for: UIControlState.normal)


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
        
        viewPopUp.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(viewPopUp)
        viewPopUp.isHidden = true
        
        textViewReasion.layer.borderWidth = 1.0
        textViewReasion.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5
        textViewReasion.layer.cornerRadius = 8.0
     
        if(revealViewController() != nil)
        {
            btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        webservices().shadow(yourView: viewProfile)
        webservices().shadow(yourView: viewPrivacy)
        webservices().shadow(yourView: viewDomestic)
        webservices().shadow(yourView: viewVisitor)
        webservices().shadow(yourView: viewDelivery)
        webservices().shadow(yourView: viewRemoveActivate)
        webservices().shadow(yourView: viewDND)

        
        // 31/10/20. temp comment
        
       /* let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
        arrMemberID.add((userId as NSNumber).stringValue)
        let strUserId = (userId as NSNumber).stringValue
        strRecieverId = strUserId */
        
        lblName.text = UsermeResponse?.data!.name
        if(UsermeResponse?.data!.profilePhotoPath != nil)
        {
            imgUser.sd_setImage(with: URL(string: (UsermeResponse?.data!.profilePhotoPath)!), placeholderImage: UIImage(named: "vendor-1"))
        }
        // 22/10/20 temp comment
        
      //  self.lblFlatNo.text = String(format: "Flat No: %@-%@", UsermeResponse!.data!.society?.propertyID!,UsermeResponse!.data!.society?.parentProperty!)
        
        self.lblFlatNo.text = "Flat No: \(UsermeResponse!.data!.society?.parentProperty ?? "")-\(UsermeResponse!.data!.society?.property ?? "")"

        lblFlatType.text = "Contact no: \(UsermeResponse!.data!.phone ?? "")"
        
        
        isSelf = true
       // cbself.isChecked = true

        btncbself.setImage(UIImage(named: "ic_radiobutton"), for: UIControlState.normal)

        
        apicallGetFamilyMembers(id: "")
        
       // apicallAddSettings()
        
       // apicallGetSettings()
     
        if UsermeResponse?.data?.settings?.shareContactDetails == 0 {
            switchContactDetails.isOn = false
            ShareContactDetails = 0
        }else {
            switchContactDetails.isOn = true
            ShareContactDetails = 1
        }
        
        if UsermeResponse?.data?.settings?.shareFamilyMemberDetails == 0 {
            switchFamily.isOn = false
            ShareFamilyMemberDetails = 0
        }else {
            switchFamily.isOn = true
            ShareFamilyMemberDetails = 1
        }
        
        if UsermeResponse?.data?.settings?.doNotDisturb == 0 {
            DNDSwitch.isOn = false
            DoNotDisturb = 0
        }else {
            DNDSwitch.isOn = true
            DoNotDisturb = 1
        }
        
        if UsermeResponse?.data?.settings?.domesticNotifyOnEntry == 0 {
            switchDailyNoticeEntry.isOn = false
            DomesticNotifyOnEntry = 0
        }else {
            switchDailyNoticeEntry.isOn = true
            DomesticNotifyOnEntry = 1
        }
        
        if UsermeResponse?.data?.settings?.domesticNotifyOnExit == 0 {
            switchDailyNoticeExit.isOn = false
            DomesticNotifyOnExit = 0
        }else {
            switchDailyNoticeExit.isOn = true
            DomesticNotifyOnExit = 1
        }
        
        if UsermeResponse?.data?.settings?.visitorNotifyOnEntry == 0 {
            switchVisitorOnEntry.isOn = false
            VisitorNotifyOnEntry = 0
        }else {
            switchVisitorOnEntry.isOn = true
            VisitorNotifyOnEntry = 1
        }
        
        
        if UsermeResponse?.data?.settings?.visitorNotifyOnExit == 0 {
            switchVisitorOnExit.isOn = false
            VisitorNotifyOnExit = 0
        }else {
            switchVisitorOnExit.isOn = true
            VisitorNotifyOnExit = 1
        }
        
        if UsermeResponse?.data?.settings?.othersNotifyOnEntry == 0 {
            switchOtherEntry.isOn = false
            OthersNotifyOnEntry = 0
        }else {
            switchOtherEntry.isOn = true
            OthersNotifyOnEntry = 1
        }
        
        if UsermeResponse?.data?.settings?.othersNotifyOnExit == 0 {
            switchOtherExit.isOn = false
            OthersNotifyOnExit = 0
        }else {
            switchOtherExit.isOn = true
            OthersNotifyOnExit = 1
        }
        
        
      /*  let alignedFlowLayout = AlignedCollectionViewFlowLayout(horizontalAlignment:.left,
                                                                verticalAlignment: .center)
        
        collectionmember.collectionViewLayout = alignedFlowLayout
        
        self.collectionmember.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil) */
        
       // checkbox(cb: cbself)
        
        // 31/10/20. Temp Comment
        
      /*  if UsermeResponse?.data?.role == "self"{
                constraintHeightDND.constant = 45
                lblDNDStaic.isHidden = false
                DNDSwitch.isHidden = false
            lblDnd.isHidden = false
        }else{
                constraintHeightDND.constant = 0
                lblDNDStaic.isHidden = true
                DNDSwitch.isHidden = true
            lblDnd.isHidden = true

        } */
        
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(taplblTC))
        
        lblTC.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer()
        tap1.addTarget(self, action: #selector(taplblPP))
        
        lblPrivacyPolicy.addGestureRecognizer(tap1)

    }
    
    @objc func taplblTC(sender: UITapGestureRecognizer)
    {
        let pdffile = "https://communei.com/terms-and-conditions/"
        guard let url = URL(string:pdffile) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func taplblPP(sender: UITapGestureRecognizer)
    {
        let pdffile = "https://communei.com/privacy-policy/"
        guard let url = URL(string:pdffile) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        apicallAddSettings()

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
    
    
    @IBAction func actionNotification(_ sender: Any) {
          let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
           vc.isfrom = 0
    }
       
    @IBAction func btnOpenQRCodePressed(_ sender: Any) {
           let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
           vc.isfrom = 0
    }
       
    @IBAction func actionSwitchContact(_ sender: UISwitch!) {
        
        if switchContactDetails.isOn == true
        {
            ShareContactDetails = 1
        }else{
            ShareContactDetails = 0
        }
        
        apicallAddSettings()
        
    }
    
    @IBAction func actionfamily(_ sender: UISwitch!) {
        
        if switchFamily.isOn == true
        {
            ShareFamilyMemberDetails = 1
        }else{
            ShareFamilyMemberDetails = 0
        }
        
        apicallAddSettings()
    }
    
    @IBAction func actionDNDSwitch(_ sender: UISwitch!) {
        
        if DNDSwitch.isOn == true{
           // viewPopUp.isHidden = false
            DoNotDisturb = 1 // Off
        }else{
           // viewPopUp.isHidden = true
            DoNotDisturb = 0 // ON
           // apicallAddSettings()
        }
        apicallAddSettings()

    }
    
    @IBAction func actionNoticeDailyEntry(_ sender: UISwitch!) {
        if switchDailyNoticeEntry.isOn == true
        {
            DomesticNotifyOnEntry = 1
        }else{
            DomesticNotifyOnEntry = 0
        }
        
        apicallAddSettings()
    }
    
    @IBAction func actionNoticeDailyExit(_ sender: UISwitch!) {
        if switchDailyNoticeExit.isOn == true
        {
            DomesticNotifyOnExit = 1
        }else{
            DomesticNotifyOnExit = 0
        }
        
        apicallAddSettings()
    }
    
    @IBAction func actionVisitorEntry(_ sender: UISwitch!) {
        if switchVisitorOnEntry.isOn == true
        {
            VisitorNotifyOnEntry = 1
        }else{
            VisitorNotifyOnEntry = 0
        }
        
        apicallAddSettings()
    }
    
    @IBAction func actionVisitorExit(_ sender: UISwitch!) {
        if switchVisitorOnExit.isOn == true
        {
            VisitorNotifyOnExit = 1
        }else{
            VisitorNotifyOnExit = 0
        }
        
        apicallAddSettings()
    }
    
    @IBAction func actionOtherEntry(_ sender: UISwitch!) {
        if switchOtherEntry.isOn == true
        {
            OthersNotifyOnEntry = 1
        }else{
            OthersNotifyOnEntry = 0
        }
        
        apicallAddSettings()
    }
    
    
    @IBAction func actionOtherExit(_ sender: UISwitch!) {
        if switchOtherExit.isOn == true
        {
            OthersNotifyOnExit = 1
        }else{
            OthersNotifyOnExit = 0
        }
        
        apicallAddSettings()
    }
    
    
    // 25/8/20.
    
    @IBAction func actionSubmitPopUp(_ sender: Any) {
           if !textViewReasion.hasText {
               let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"Please write reason")
               self.present(alert, animated: true, completion: nil)
           }else{
               DNDSwitch.isOn = true

               strDNDStatus = "2"
               apicallAddSettings()
           }
           
           
       }
    
       @IBAction func actionClosePopUp(_ sender: Any) {
           
           if !textViewReasion.hasText{
               DNDSwitch.isOn = false
           }
           
           viewPopUp.isHidden = true
       }
       
      
    @IBAction func btnDeactivateMyFlat(_ sender: UIButton!) {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr = "Delete My Account"
        
        avc?.isfrom = 5
        
       // avc?.subtitleStr = "Do you want to delete your account? If Yes, your account deletion process will be initiated."
        
        avc?.yesAct = {

        }
        avc?.noAct = {
          
        }
        present(avc!, animated: true)


    }
    
    // MARK: - User me Setting Switch

    func apicallUserMe()
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()

            let token = UserDefaults.standard.value(forKey: USER_TOKEN)

        
        Apicallhandler().ApiCallUserMe(URL: webservices().baseurl + "user", token: token as! String) { [self] JSON in
                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                   webservices().StopSpinner()
                    
                    if statusCode == 200{
                        
                        UsermeResponse = resp
                        
                        if UsermeResponse?.data?.settings?.shareContactDetails == 0 {
                            switchContactDetails.isOn = false
                            ShareContactDetails = 0
                        }else {
                            switchContactDetails.isOn = true
                            ShareContactDetails = 1
                        }
                        
                        if UsermeResponse?.data?.settings?.shareFamilyMemberDetails == 0 {
                            switchFamily.isOn = false
                            ShareFamilyMemberDetails = 0
                        }else {
                            switchFamily.isOn = true
                            ShareFamilyMemberDetails = 1
                        }
                        
                        if UsermeResponse?.data?.settings?.doNotDisturb == 0 {
                            DNDSwitch.isOn = false
                            DoNotDisturb = 0
                        }else {
                            DNDSwitch.isOn = true
                            DoNotDisturb = 1
                        }
                        
                        if UsermeResponse?.data?.settings?.domesticNotifyOnEntry == 0 {
                            switchDailyNoticeEntry.isOn = false
                            DomesticNotifyOnEntry = 0
                        }else {
                            switchDailyNoticeEntry.isOn = true
                            DomesticNotifyOnEntry = 1
                        }
                        
                        if UsermeResponse?.data?.settings?.domesticNotifyOnExit == 0 {
                            switchDailyNoticeExit.isOn = false
                            DomesticNotifyOnExit = 0
                        }else {
                            switchDailyNoticeExit.isOn = true
                            DomesticNotifyOnExit = 1
                        }
                        
                        if UsermeResponse?.data?.settings?.visitorNotifyOnEntry == 0 {
                            switchVisitorOnEntry.isOn = false
                            VisitorNotifyOnEntry = 0
                        }else {
                            switchVisitorOnEntry.isOn = true
                            VisitorNotifyOnEntry = 1
                        }
                        
                        
                        if UsermeResponse?.data?.settings?.visitorNotifyOnExit == 0 {
                            switchVisitorOnExit.isOn = false
                            VisitorNotifyOnExit = 0
                        }else {
                            switchVisitorOnExit.isOn = true
                            VisitorNotifyOnExit = 1
                        }
                        
                        if UsermeResponse?.data?.settings?.othersNotifyOnEntry == 0 {
                            switchOtherEntry.isOn = false
                            OthersNotifyOnEntry = 0
                        }else {
                            switchOtherEntry.isOn = true
                            OthersNotifyOnEntry = 1
                        }
                        
                        if UsermeResponse?.data?.settings?.othersNotifyOnExit == 0 {
                            switchOtherExit.isOn = false
                            OthersNotifyOnExit = 0
                        }else {
                            switchOtherExit.isOn = true
                            OthersNotifyOnExit = 1
                        }
                        
                        
                        print(resp)
                    }
                    
                    else if(JSON.response?.statusCode == 401)
                    {
                        
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
                                                              
                           
                        
                    }
                    
                case .failure(let err):
                    webservices().StopSpinner()
                    if statusCode == 401{
                        
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
    
    //  /////////////  //
    
    // MARK: - Add Settings
    
    func apicallAddSettings()
    {
          if !NetworkState().isInternetAvailable {
                ShowNoInternetAlert()
                return
          }
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)

         
             /*  if !textViewReasion.hasText {
                   textViewReasion.text = ""
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
                "family_details" : strFamilyDetailShow,
                "mute_notification_status":strDNDStatus,
                "reason_to_mute_notification":textViewReasion.text!
                
            ] */
        
        let param : Parameters = [
            "ShareContactDetails" : ShareContactDetails,
            "ShareFamilyMemberDetails" : ShareFamilyMemberDetails,
            "DoNotDisturb" : DoNotDisturb,
            "DomesticNotifyOnEntry" : DomesticNotifyOnEntry,
            "DomesticNotifyOnExit" : DomesticNotifyOnExit,
            "VisitorNotifyOnEntry" : VisitorNotifyOnEntry,
            "VisitorNotifyOnExit": VisitorNotifyOnExit,
            "OthersNotifyOnEntry": OthersNotifyOnEntry,
            "OthersNotifyOnExit": OthersNotifyOnExit
        ]
           
        print("param setting : ",param)
        
        
        Apicallhandler.sharedInstance.ApiCallAddSettings(token: token as! String, param: param) { [self] JSON in
                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                    //webservices().StopSpinner()
                    
                    print("--------->add settings \(resp)")
                    
                    if statusCode == 200 {
                        
                        self.apicallUserMe()
                        
                        
                      /*  UserDefaults.standard.set(resp.data.contactDetails, forKey: USER_SETTING_CONTACT_SHOW)
                        UserDefaults.standard.set(resp.data.familyDetails, forKey: USER_SETTING_FAMILY_SHOW)
                        UserDefaults.standard.set(resp.data.circular, forKey: USER_SETTING_CIRCULAR_SHOW)
                        UserDefaults.standard.set(resp.data.notice, forKey: USER_SETTING_NOTICE_SHOW)
                        UserDefaults.standard.set(resp.data.event, forKey: USER_SETTING_EVENT_SHOW)
                        UserDefaults.standard.synchronize() */
                        
                        // 2/9/20.
                        
                        self.viewPopUp.isHidden = true
                        

                        
                    }
                    
                case .failure(let err):
                    webservices().StopSpinner()
                    if statusCode == 401{
                        
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
    
    
    // MARK: - Get Settings
    
    func apicallGetSettings()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        
        /*
         
         
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
                    
                    
                    if self.arrGetSetting.count > 0{
                        if self.arrGetSetting[0].notice == 1{
                            self.switchNotice.isOn = true
                            
                            self.strNoticeShow = "1"
                        }else{
                            self.switchNotice.isOn = false
                        }
                        if self.arrGetSetting[0].mute_notification_status == 1{
                            self.DNDSwitch.isOn = false

                            self.strNoticeShow = "1"
                        }else{
                            self.DNDSwitch.isOn = true

                            self.strNoticeShow = "2"
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
                           // self.cbself.isChecked = true
                            self.btncbself.isSelected = true

                        }else
                        {
                            self.isSelf = false
                           // self.cbself.isChecked = false
                            self.btncbself.isSelected = false

                            
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
                print(err.asAFError!)
                
            }
        }
        
        */
        
    }
    
    
    func apicallGetFamilyMembers(id:String)
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            
        /*
         
        
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            webservices().StartSpinner()
            
            
            Apicallhandler().APIGetFamilyMember(URL: webservices().baseurl + API_GET_FAMAILY_MEMBER, token: token as! String) { JSON in
                
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
                           // self.collectionmember.reloadData()
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
                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
                
            }
            
      */
        
    }
    
    
   // @objc func getIndexSelectedCell(sender:Checkbox) {
        
    @objc func getIndexSelectedCell(sender:UIButton) {
        
        if arrMemberID.contains(arrMemberSelected[sender.tag].guid!){
                   //arrDummy.add("1")
                    arrMemberID.remove(arrMemberSelected[sender.tag].guid!)

               }else{
                    //arrDummy.add("0")
            
            if arrMemberID.count < 4{
                 arrMemberID.add(arrMemberSelected[sender.tag].guid!)
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

extension UserSettingsVC: UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
    
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:UserCell1 = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! UserCell1
        
        cell.lblname.sizeToFit()
       // cell.cb.tag = indexPath.row
        cell.btncheckself.tag = indexPath.row
        
        let tag = arrMemberSelected[indexPath.row].name
        cell.lblname.text = tag
      //  checkbox(cb: cell.cb)
        
        //New
        if arrMemberID.contains(arrMemberSelected[indexPath.row].guid!){
            // cell.cb.isChecked = true
            cell.btncheckself.setImage(UIImage(named: "ic_radiobuttonselect"), for: UIControlState.normal)


        }else{
           // cell.cb.isChecked = false
           // cell.btncheckself.image = UIImage(named: "ic_unchecked")
            cell.btncheckself.setImage(UIImage(named: "ic_radiobutton"), for: UIControlState.normal)

        }
       // cell.cb.isUserInteractionEnabled = false
        
        cell.btncheckself.isUserInteractionEnabled = false

        
//        if  selectedCell == arrMemberSelected[indexPath.row].id{
//            cell.cb.isChecked = true
//            cbself.isChecked = false
//        }else{
//            cell.cb.isChecked = false
//        }
        
       // cell.cb.addTarget(self, action: #selector(getIndexSelectedCell(sender:)), for: .valueChanged)
                
        cell.btncheckself.addTarget(self, action: #selector(getIndexSelectedCell(sender:)), for: .valueChanged)

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrMemberSelected.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
               
      //  if arrMemberID.contains((arrMemberSelected[indexPath.row].guid as NSNumber).stringValue){
                          //arrDummy.add("1")
                          // arrMemberID.remove((arrMemberSelected[indexPath.row].guid! as NSNumber).stringValue)
            if arrMemberID.contains(arrMemberSelected[indexPath.row].guid!)
            {

            arrMemberID.remove(arrMemberSelected[indexPath.row].guid!)


                      }else{
                           //arrDummy.add("0")
                   
                   if arrMemberID.count < 4{
                        arrMemberID.add(arrMemberSelected[indexPath.row].guid!)
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
        let contentNSString = arrMemberSelected[indexPath.row].name
        let expectedLabelSize = contentNSString!.boundingRect(with: maxLabelSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15.0)], context: nil)
        print("\(expectedLabelSize)")
        return CGSize(width:expectedLabelSize.size.width + 50, height: expectedLabelSize.size.height + 20)
        //return CGSize(width:collectionView.frame.size.width/3, height: expectedLabelSize.size.height + 20)
    }
    
    
}



