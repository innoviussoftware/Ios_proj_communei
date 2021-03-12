//
//  DomesticHelpVC.swift
//  SocietyMangement
//
//  Created by Innovius on 29/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
import ScrollPager




class DomesticHelpVC: UIViewController, UITextFieldDelegate , ScrollPagerDelegate {
        
    @IBOutlet weak var btnNotification: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var lblNoDataFound1: UILabel!

    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var tblView_OnDemand: UITableView!

    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var txtSearchbar: UITextField!

    @IBOutlet weak var txtSearchbar1: UITextField!

    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var pager: ScrollPager!
    
    @IBOutlet var viewDaily: UIView!
    
    @IBOutlet var ViewOnDemand: UIView!

    var arrHelper = [HelperListData]()
    var arrFinal = [HelperListData]()
    
    var arrOnDemandHelper = [HelperListData]()
    var arrOnDemandFinal = [HelperListData]()
    
    var isfrom = 1

    var isfromStr = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        self.navigationController?.isNavigationBarHidden = true
        
        pager.delegate = self
        
        pager.tintColor  = AppColor.appcolor
        
        txtSearchbar.layer.borderColor = UIColor.clear.cgColor
        
        txtSearchbar.borderStyle = .none
        
        txtSearchbar1.layer.borderColor = UIColor.clear.cgColor
        
        txtSearchbar1.borderStyle = .none
        
        txtSearchbar.delegate = self
        
        txtSearchbar1.delegate = self

              
       // pager.frame = view.frame
       
        pager.addSegmentsWithTitlesAndViews(segments: [
            ("Daily", viewDaily),("On Demand", ViewOnDemand)
        ])
        
        

        if(isfromStr == ""){  // Daily
            pager.setSelectedIndex(index: 0, animated: true)
        }
              
        if(isfromStr == "Daily"){  // Daily
            pager.setSelectedIndex(index: 0, animated: true)
        }
              
        if(isfromStr == "On Demand"){  // On Demand
            pager.setSelectedIndex(index: 1, animated: true)
           // pager.frame = CGRect(x: view.frame.size.width, y: 59, width: view.frame.size.width, height: 60)
        }
        
        if isfrom == 1{
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }else{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }
        
        lblNoDataFound.isHidden = true
        lblNoDataFound1.isHidden = true
        
        tblView.register(UINib(nibName: "DomesticHelpCell", bundle: nil), forCellReuseIdentifier: "DomesticHelpCell")
        tblView.separatorStyle = .none
        tblView.frame = CGRect(x: 0, y: 86, width: view.frame.size.width, height: tblView.frame.size.height)
        
        
        tblView_OnDemand.register(UINib(nibName: "DomesticHelpCell", bundle: nil), forCellReuseIdentifier: "DomesticHelpCell")
        tblView_OnDemand.separatorStyle = .none
        tblView_OnDemand.frame = CGRect(x: view.frame.size.width, y: 86, width: view.frame.size.width, height: tblView_OnDemand.frame.size.height)

       // viewDaily.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: viewDaily.frame.size.height)
               
      //  ViewOnDemand.frame = CGRect(x: view.frame.size.width, y: 0, width: view.frame.size.width, height: ViewOnDemand.frame.size.height)
        
        
        /*
         if(revealViewController() != nil)
        {
            btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            
            print("fvdf")
        } */
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        apicallGetDailyhelperList()

        apicallGetOnDemandhelperList()
        
        txtSearchbar.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)

        txtSearchbar1.addTarget(self, action: #selector(searchRecordsAsPerTextOnDemand(_ :)), for: .editingChanged)

        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
           
       }
    
    //MARK:- textfield delegate
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        arrHelper.removeAll()
        
        if textfield.text?.count != 0 {
           // searchActive = true

            for strCountry in arrFinal {
                let range = strCountry.name!.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                
                if range != nil {
                    arrHelper.append(strCountry)
                }
            }
        }else if textfield.text?.count == 0 {
           // searchActive = false
            
        }
        /*else if (arrSearchFinal.count == 0){
            // searchActive = false
            
            lblnoproperty.isHidden = false
            
            lblnoproperty.text  = "Member List Not Found"
         
         tblFacilities.isHidden = true

        }*/
        else {
            arrHelper = arrFinal
        }
        
        tblView.reloadData()
    }
    
    @objc func searchRecordsAsPerTextOnDemand(_ textfield:UITextField) {
        arrOnDemandHelper.removeAll()
        
        if textfield.text?.count != 0 {
           // searchActive = true

            for strCountry in arrOnDemandFinal {
                let range = strCountry.name!.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                
                if range != nil {
                    arrOnDemandHelper.append(strCountry)
                }
            }
        }else if textfield.text?.count == 0 {
           // searchActive = false
            
        }
        /*else if (arrSearchFinal.count == 0){
            // searchActive = false
            
            lblnoproperty.isHidden = false
            
            lblnoproperty.text  = "Member List Not Found"
         
         tblFacilities.isHidden = true

        }*/
        else {
            arrOnDemandHelper = arrOnDemandFinal
        }
        
        tblView_OnDemand.reloadData()
    }
    
    
    //MARK:- ScrollPager delegate
    
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        
        if changedIndex == 0{//Daily
            apicallGetDailyhelperList()
            view.endEditing(true)
        }else{
            apicallGetOnDemandhelperList()
            view.endEditing(true)
        }
        
        
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
    
    
    
   
    @IBAction func actionMenu(_ sender: UIButton) { // back
        if isfrom == 1{
            self.navigationController?.popViewController(animated: true)
        }else{
            revealViewController()?.revealToggle(self)
        }
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        nextViewController.isfrom = 0

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
    
    // MARK: - get Daily helper List
    
    func apicallGetDailyhelperList()
    {
          if !NetworkState().isInternetAvailable {
                ShowNoInternetAlert()
                return
            }
            
           let token = UserDefaults.standard.value(forKey:USER_TOKEN) as! String

            webservices().StartSpinner()
        
            Apicallhandler().GetHelperList(URL: webservices().baseurl + API_HELPER_LIST, token:token) { JSON in
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.arrHelper = resp.data!
                        self.arrFinal = resp.data!
                        
                        if self.arrHelper.count > 0{
                            self.lblNoDataFound.isHidden = true
                            self.lblNoDataFound1.isHidden = true
                            self.tblView.delegate = self
                            self.tblView.dataSource = self
                            self.tblView.reloadData()
                        }else{
                            self.tblView.isHidden = true
                            
                            self.lblNoDataFound.isHidden = false
                            self.lblNoDataFound1.isHidden = true

                        }
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    webservices().StopSpinner()
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
                  //  self.present(alert, animated: true, completion: nil)
                  //  print(err.asAFError!)
                    
                }
            }
      
        
    }
    
    
    // MARK: - get On Demand List
    
    func apicallGetOnDemandhelperList()
    {
          if !NetworkState().isInternetAvailable {
                ShowNoInternetAlert()
                return
            }
            
           let token = UserDefaults.standard.value(forKey:USER_TOKEN) as! String

            webservices().StartSpinner()
        
            Apicallhandler().GetHelperList(URL: webservices().baseurl + API_HELPER_ONDEMANDLIST, token:token) { JSON in
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.arrOnDemandHelper = resp.data!
                        self.arrOnDemandFinal = resp.data!
                        
                        if self.arrOnDemandHelper.count > 0{
                            self.lblNoDataFound.isHidden = true
                            self.lblNoDataFound1.isHidden = true

                            self.tblView_OnDemand.delegate = self
                            self.tblView_OnDemand.dataSource = self
                            self.tblView_OnDemand.reloadData()
                        }else{
                            
                            self.tblView_OnDemand.isHidden = true
                            
                            self.lblNoDataFound.isHidden = true
                            self.lblNoDataFound1.isHidden = false

                        }
                    }
                    else
                    {
                      //  let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
                      //  self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    webservices().StopSpinner()
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
                  //  self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                }
            }
      
        
    }
    
    
    /*
     
     
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print("searchText \(searchBar.text)")
            searchBar.resignFirstResponder()
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if(searchText != "")
            {
                arrHelper.removeAll()
                for value in arrFinal
                {
                    let namenew = value.name
                    if(namenew!.lowercased().contains(searchText.lowercased()))
                            {
                                arrHelper.append(value)

                    }
                            tblView.reloadData()
                   
                            tblView_OnDemand.reloadData()
                }
                
                if self.arrHelper.count > 0{
                    self.tblView.isHidden = false
                    
                    self.lblNoDataFound.isHidden = true
                    self.tblView.reloadData()
                    
                    self.tblView_OnDemand.isHidden = false
                    self.tblView_OnDemand.reloadData()

                }else{
                    self.tblView.isHidden = true
                    self.lblNoDataFound.isHidden = false
                    
                    self.tblView_OnDemand.isHidden = true

                }
                tblView.reloadData()

                self.tblView_OnDemand.reloadData()

            }
            else
            {
                arrHelper = arrFinal
                self.tblView.isHidden = false
                self.lblNoDataFound.isHidden = true

                tblView.reloadData()
                
                self.tblView_OnDemand.isHidden = false
                self.tblView_OnDemand.reloadData()

                
            }
            self.tblView.reloadData()
            
            self.tblView_OnDemand.reloadData()

        }
        
      */
    
    
}

extension DomesticHelpVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblView {
            return arrHelper.count
        }else{
            return arrOnDemandHelper.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if tableView == tblView {
//            
//        }else{
//
//        }
        
        if tableView == tblView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DomesticHelpCell") as! DomesticHelpCell
            
            cell.selectionStyle = .none
            if arrHelper[indexPath.row].profilePicture != nil
            {
                cell.imgUser.sd_setImage(with: URL(string: arrHelper[indexPath.row].profilePicture!), placeholderImage: UIImage(named: "vendor-1"))
            }
            
            cell.lblName.text = arrHelper[indexPath.row].name
            cell.lblProfession.text = arrHelper[indexPath.row].vendorServiceType
            if arrHelper[indexPath.row].rating != nil {
                
                cell.lblRatingNumber.text = (arrHelper[indexPath.row].rating![0..<3])
                //String(format: "%.1f", arrHelper[indexPath.row].rating!)
            }else{
                cell.lblRatingNumber.text = "0.0"
            }
            
            return cell
            
        }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DomesticHelpCell") as! DomesticHelpCell
            
            cell.selectionStyle = .none
            if arrOnDemandHelper[indexPath.row].profilePicture != nil
            {
                cell.imgUser.sd_setImage(with: URL(string: arrOnDemandHelper[indexPath.row].profilePicture!), placeholderImage: UIImage(named: "vendor-1"))
            }
            
            cell.lblName.text = arrOnDemandHelper[indexPath.row].name
            cell.lblProfession.text = arrOnDemandHelper[indexPath.row].vendorServiceType
            
            if arrOnDemandHelper[indexPath.row].rating != nil {
                cell.lblRatingNumber.text = (arrOnDemandHelper[indexPath.row].rating![0..<3])
                //String(format: "%.1f", arrOnDemandHelper[indexPath.row].rating!)
            }else{
                cell.lblRatingNumber.text = "0.0"
            }
            
            
            return cell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tblView {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MaidProfileDetailsVC") as! MaidProfileDetailsVC
            vc.HelperId = arrHelper[indexPath.row].dailyHelperID
            vc.vendorServiceTypeID = arrHelper[indexPath.row].vendorServiceTypeID
            vc.isfrom = 1
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MaidProfileDetailsVC") as! MaidProfileDetailsVC
            vc.HelperId = arrOnDemandHelper[indexPath.row].dailyHelperID
            vc.vendorServiceTypeID = arrOnDemandHelper[indexPath.row].vendorServiceTypeID
            vc.isfrom = 2
            self.navigationController?.pushViewController(vc, animated: true)
        }
                
        print("MaidProfileDetailsVC")
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
