//
//  SidemenuVC.swift
//  SocietyMangement
//
//  Created by MacMini on 29/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit



class SidemenuVC: UIViewController  , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var tblview: UITableView!
    
    var selectedindex:Int?
    
    var cells = ["cell1","cell11","cell12","cell9","cell14","cell15","cell2","cell3","cell16","cell5","cell13","cell10"]
    
    var imagesary = ["","ic_home_selected","ic_profile","ic_help_desk_menu_gray","ic-actions-settings","domestic_help_gray","ic-shopping-bag","ic-sport-yard","ic_referfriend","ic_Amenities","logout",""]
    
    var selectedimagesary = ["","ic_home_selected","ic_profile","ic_help_desk_menu_gray","ic-actions-settings","domestic_help_gray","ic-shopping-bag","ic-sport-yard","ic_referfriend","ic_Amenities","logout",""]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        print("viewDidLoad Side Menu")
        
        selectedindex = 1
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
                
         cells = ["cell1","cell11","cell12","cell9","cell14","cell15","cell2","cell3","cell16","cell5","cell13","cell10"]
           
        imagesary = ["","ic_home_selected","ic_profile","ic_help_desk_menu_gray","ic-actions-settings","domestic_help_gray","ic-shopping-bag","ic-sport-yard","ic_referfriend","ic_Amenities","logout",""]
        
        selectedimagesary = ["","ic_home_selected","ic_profile","ic_help_desk_menu_gray","ic-actions-settings","domestic_help_gray","ic-shopping-bag","ic-sport-yard","ic_referfriend","ic_Amenities","logout",""]
           
        if UsermeResponse?.data != nil {
            tblview.isHidden = false
            tblview.reloadData()
        }else{
            tblview.isHidden = true
        }
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
    
        
    // MARK: - Tableview delegate and datasource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SidemenuCell = tableView.dequeueReusableCell(withIdentifier:cells[indexPath.row], for: indexPath) as! SidemenuCell
        
        if(indexPath.row == 11) {
            cell.backgroundColor = UIColor.clear
            let tap = UITapGestureRecognizer()
            tap.addTarget(self, action:#selector(taplblTC))
            cell.lblTC.addGestureRecognizer(tap)
            cell.lblTC.isUserInteractionEnabled = true
            
            let tap1 = UITapGestureRecognizer()
            tap1.addTarget(self, action:#selector(taplblPP))
            cell.lblPrivacyPolicy.addGestureRecognizer(tap1)
            cell.lblPrivacyPolicy.isUserInteractionEnabled = true

        }
        
        if(indexPath.row != 0 && indexPath.row != 11)
        {
                if(selectedindex == indexPath.row) {
                    cell.imagview.image = UIImage(named: selectedimagesary[indexPath.row])
                    cell.lblname.textColor = AppColor.orangeColor
                    cell.backgroundColor = UIColor(red:247.0/255.0, green:251.0/255.0, blue:253.0/255.0, alpha: 1.0)
                }else {
          
                    cell.imagview.image = UIImage(named: imagesary[indexPath.row])
                    cell.lblname.textColor = UIColor.black
                    cell.backgroundColor = UIColor.white
                            
                }
        }
        
        
        if(indexPath.row == 0 || indexPath.row == 10)
        {
            if(indexPath.row == 0)
            {
                if UsermeResponse?.data != nil {
                    
                    if UsermeResponse?.data?.name != nil {
                        cell.lblname.text = UsermeResponse?.data!.name
                    }
                    
                   // if ((UsermeResponse!.data!.profilePhotoPath as? NSNull) != nil)  {
                    if UsermeResponse!.data!.profilePhotoPath != nil{
                        cell.imagview.sd_setImage(with: URL(string: UsermeResponse!.data!.profilePhotoPath!), placeholderImage: UIImage(named: "vendor profile"))
                    }else{
                        cell.imagview.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "vendor profile"))
                    }
                }else{
                    cell.lblname.text = ""
                    cell.imagview.sd_setImage(with: URL(string: "vendor profile"), placeholderImage: UIImage(named: "vendor profile"))
                }

            }
           
        }

        return cell

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedindex = indexPath.row
        tableView.reloadData()
        
        
        if(indexPath.row == 1) {
            
           let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
            nextViewController.selectedtabindex = 0
                          // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

            revealViewController()?.pushFrontViewController(nextViewController, animated: true)
        }
        
        if(indexPath.row == 2) {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfiledetailVC") as! ProfiledetailVC
            
            nextViewController.isfrom = 3 //1
                           
            // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

            revealViewController()?.pushFrontViewController(nextViewController, animated: true)

        }
        
      // live app 26/11/20.
        
        if(indexPath.row == 3) {
      
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
           
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HelpDeskVC") as! HelpDeskVC
            
           // let nextViewController = storyBoard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC

         //   nextViewController.selectedtabindex = 0
            
            nextViewController.isfrom = 0

            revealViewController()?.pushFrontViewController(nextViewController, animated: true)
        }
        
        if(indexPath.row == 4) {
              let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserSettingsVC") as! UserSettingsVC
                revealViewController()?.pushFrontViewController(nextViewController, animated: true)
        }
        
        if(indexPath.row == 5)
        {
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: DomesticHelpVC.id()) as! DomesticHelpVC
            
            nextViewController.isfrom = 0

            revealViewController()?.pushFrontViewController(nextViewController, animated: true)
            
           // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
          //  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
        //    nextViewController.isfrom = 0

         //   navigationController!.pushViewController(nextViewController, animated: true)

         //   revealViewController()?.pushFrontViewController(nextViewController, animated: true)
            

                                     //  tabBarController.selectedIndex = (indexPath as NSIndexPath).row
            
            
         /*   let tabBarController = revealViewController().frontViewController as! UITabBarController
            
            let obj = storyBoard.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC


                   let navController = UINavigationController.init(rootViewController: obj)
               //            tabBarController.selectedIndex = 1
                  
              tabBarController.tabBar.isHidden = false
                   self.revealViewController().pushFrontViewController(navController, animated: true) */
                                       
            
            
        }
        
        if(indexPath.row == 6)
                               {
                              
                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                              //  let tabBarController = revealViewController().frontViewController as! UITabBarController
                                           
                                           let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BuySellVC") as! BuySellVC


                                              //    let navController = UINavigationController.init(rootViewController: obj)
                                              //            tabBarController.selectedIndex = 1
                                                 
                                           //  tabBarController.tabBar.isHidden = false
                                                  self.revealViewController().pushFrontViewController(nextViewController, animated: true)
                                
        }
        
        if(indexPath.row == 7)
        {
            print("Active")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PollVC") as! PollVC

                           revealViewController()?.pushFrontViewController(nextViewController, animated: true)


        }
        if(indexPath.row == 8)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ReferAFriendVC") as! ReferAFriendVC

                revealViewController()?.pushFrontViewController(nextViewController, animated: true)

        }
        
        if(indexPath.row == 9) {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AmenitiesVC") as! AmenitiesVC
                
                nextViewController.isfrom = 0

                               revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                   print("amenities")
               }
        
        if(indexPath.row == 10)
            {


                 let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                               avc?.titleStr = "Communei"  //"Society Buddy"
                               avc?.subtitleStr = "Are you sure you want to logout?"
                               avc?.yesAct = {
                                
                                
                                
                                APPDELEGATE.ApiLogout(onCompletion: { int in
                                                         //  if int == 1{
                                                                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                                                          let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                            
                                                aVC.isfrom = 1
                                                                                                          let navController = UINavigationController(rootViewController: aVC)
                                                                                                          navController.isNavigationBarHidden = true
                                                                                             self.appDelegate.window!.rootViewController  = navController
                                                         
                                                print("logout")

                                                     //      }
                                                       })
                                                                
                                
                              /*  let token = UserDefaults.standard.value(forKey: USER_TOKEN)
                                
                                print("Bearer token : ",token as! String)
                                
                               // Apicallhandler.sharedInstance.LogoutAPI(URL: webservices().baseurl + API_LOGOUT, token: token  as! String) { response in

                                    
                                Apicallhandler.sharedInstance.LogoutAPI(URL: webservices().baseurl + API_LOGOUT, token: token  as! String) { JSON in
                                   // let statusCode = JSON.response?.statusCode
                                    switch JSON.result {
                                    case .success(let resp):
                                        webservices().StopSpinner()
                                      //  self.refreshControl.endRefreshing()
                                      //  if statusCode == 200{
                                            
                                            if resp.status == true
                                            {
                                                
                                                UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                                                UserDefaults.standard.removeObject(forKey:USER_ID)
                                                UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                                                UserDefaults.standard.removeObject(forKey:USER_ROLE)
                                                UserDefaults.standard.removeObject(forKey:USER_PHONE)
                                                UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                                                UserDefaults.standard.removeObject(forKey:USER_NAME)
                                                UserDefaults.standard.removeObject(forKey:USER_SECRET)

                                            
                                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                                      let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                      let navController = UINavigationController(rootViewController: aVC)
                                                                                      navController.isNavigationBarHidden = true
                                                                         self.appDelegate.window!.rootViewController  = navController
                                            
                                        }
                                    case .failure(let err):
                                        
                                        if JSON.response?.statusCode == 401{
                                            webservices().StopSpinner()
                                            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                                            self.present(alert, animated: true, completion: nil)
                                            print(err.asAFError as Any)
                                            
                                            
                                        }
                                    }
                                }
                                
                                                          } */
                                    
                                                          print("Handle Ok logic here")
                                
                               }
                               avc?.noAct = {
                                 
                               }
                               present(avc!, animated: true)
                            
                            
                            
        //
        //                    let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
        //
        //                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
        //                        APPDELEGATE.ApiLogout(onCompletion: { int in
        //                            if int == 1{
        //                                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //                                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
        //                                self.navigationController?.pushViewController(nextViewController, animated: true)
        //                            }
        //                        })
        //                        print("Handle Ok logic here")
        //                    }))
        //
        //                    refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        //                        print("Handle Cancel Logic here")
        //                    }))
        //
        // present(refreshAlert, animated: true, completion: nil)
                            
                        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == cells.count - 1{
            return 85
        }else if indexPath.row == 0{
           return 128
        }else{
          return 50
        }
    }
    
    
    
}
