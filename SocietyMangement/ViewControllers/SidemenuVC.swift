//
//  SidemenuVC.swift
//  SocietyMangement
//
//  Created by MacMini on 29/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class SidemenuVC: UIViewController  , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var tblview: UITableView!
    
    var selectedindex:Int?
//    var cells = ["cell1","cell11","cell12","cell2","cell3","cell4","cell5","cell6","cell8","cell7","cell9","cell14","cell15","cell13","cell10"]
//
//    var imagesary = ["","ic_home","ic_profile","building grey","members grey","notification grey","circular grey","event grey","vendor grey","manage role grey","buy-sell grey","setting_gray","domestic_help_gray","logout",""]
//    var selectedimagesary = ["","ic_home_app","ic_profile_app","building-1","member-1","notice-2","circular-1","event-1","vendor-1","manage role","buy-sell","setting_blue","domestic help","logout blue",""]
    
    var cells = ["cell1","cell11","cell12","cell2","cell9","cell14","cell15","cell13","cell10"]
    
    var imagesary = ["","ic_home","ic_profile","building grey","ic_help_desk_menu_gray","setting_gray","domestic_help_gray","logout",""]
    var selectedimagesary = ["","ic_home_app","ic_profile_app","building-1","ic_help_desk_menu","setting_blue","domestic help","logout blue",""]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                               // Always adopt a light interface style.
                    overrideUserInterfaceStyle = .light
                  }
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        

                if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
                {
                    let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
                    
                    if(str.contains("Chairman"))
                    {

        //                 cells = ["cell1","cell11","cell12","cell2","cell14","cell15","cell13","cell10"]
        //
        //                 imagesary = ["","ic_home","ic_profile","building grey","setting_gray","domestic_help_gray","logout",""]
        //                 selectedimagesary = ["","ic_home_app","ic_profile_app","building-1","setting_blue","domestic help","logout blue",""]
        //
                        
                        cells = ["cell1","cell11","cell12","cell2","cell9","cell14","cell15","cell16","cell13","cell10"]
                           
                        imagesary = ["","ic_home","ic_profile","building grey","ic_help_desk_menu_gray","setting_gray","domestic_help_gray","ic_refer","logout",""]
                        selectedimagesary = ["","ic_home_app","ic_profile_app","building-1","ic_help_desk_menu","setting_blue","domestic help","ic_refer_app","logout blue",""]
                        
                        
                    }
                    else if(str.contains("Secretory"))
                    {
                        
        //                cells = ["cell1","cell11","cell12","cell2","cell14","cell15","cell13","cell10"]
        //
        //                imagesary = ["","ic_home","ic_profile","building grey","setting_gray","domestic_help_gray","logout",""]
        //                selectedimagesary = ["","ic_home_app","ic_profile_app","building-1","setting_blue","domestic help","logout blue",""]
        //
                        
                        
                         
                                          cells = ["cell1","cell11","cell12","cell2","cell9","cell14","cell15","cell16","cell13","cell10"]
                                             
                                          imagesary = ["","ic_home","ic_profile","building grey","ic_help_desk_menu_gray","setting_gray","domestic_help_gray","ic_refer","logout",""]
                                          selectedimagesary = ["","ic_home_app","ic_profile_app","building-1","ic_help_desk_menu","setting_blue","domestic help","ic_refer_app","logout blue",""]
                                          
                        

                    }
                    else
                    {
                        
                        cells = ["cell1","cell11","cell12","cell9","cell14","cell15","cell16","cell13","cell10"]
                                      
                                       imagesary = ["","ic_home","ic_profile","ic_help_desk_menu_gray","setting_gray","domestic_help_gray","ic_refer","logout",""]
                                       selectedimagesary = ["","ic_home_app","ic_profile_app","ic_help_desk_menu","setting_blue","domestic help","ic_refer_app","logout blue",""]
                        
                    
                    }
                }
                else
                {
        //            cells = ["cell1","cell11","cell12","cell14","cell15","cell13","cell10"]
        //
        //             imagesary = ["","ic_home","ic_profile","setting_gray","domestic_help_gray","logout",""]
        //             selectedimagesary = ["","ic_home_app","ic_profile_app","setting_blue","domestic help","logout blue",""]
                    
                   cells = ["cell1","cell11","cell12","cell9","cell14","cell15","cell16","cell13","cell10"]
                                                        
                                                         imagesary = ["","ic_home","ic_profile","ic_help_desk_menu_gray","setting_gray","domestic_help_gray","ic_refer","logout",""]
                                                         selectedimagesary = ["","ic_home_app","ic_profile_app","ic_help_desk_menu","setting_blue","domestic help","ic_refer_app","logout blue",""]

                }
                tblview.reloadData()
    }
    // MARK: - Tableview delegate and datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SidemenuCell = tableView.dequeueReusableCell(withIdentifier:cells[indexPath.row], for: indexPath) as! SidemenuCell
        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            if(str.contains("Chairman") || str.contains("Secretory"))
            {
                if(indexPath.row == 0 || indexPath.row == 9)
                {
                    
                    if(indexPath.row == 0)
                    {
                        cell.lblname.text = UsermeResponse?.data!.name
                        
                        if UsermeResponse!.data!.image != nil{
                            cell.imagview.sd_setImage(with: URL(string:webservices().imgurl + UsermeResponse!.data!.image!), placeholderImage: UIImage(named: "img_default"))
                        }
                        
                    }
                    if(indexPath.row == 9)
                                       {
                                           //cell.lblname.text = UsermeResponse?.data!.name
                                           if UsermeResponse!.data?.society_logo != nil{
                                               cell.imagview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse!.data?.society_logo!)!), placeholderImage: UIImage(named: "Society Buddy logo transperent"))
                                           }
                                           
                                           
                                       }
                    
                }else
                {
                    if(selectedindex == indexPath.row)
                    {
                        cell.imagview.image = UIImage(named: selectedimagesary[indexPath.row])
                        cell.lblname.textColor = AppColor.appcolor
                        cell.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha: 0.6)
                    }
                    else
                    {
                        print(indexPath.row)
                        print(imagesary[indexPath.row])
                        cell.imagview.image = UIImage(named: imagesary[indexPath.row])
                        cell.lblname.textColor = UIColor.black
                        cell.backgroundColor = UIColor.white
                        
                    }
                    
                }
            }
            else
            {
                
                if(indexPath.row == 0 || indexPath.row == 8)
                {
                    
                    if(indexPath.row == 0)
                    {
                        cell.lblname.text = UsermeResponse?.data!.name
                        
                        if UsermeResponse!.data?.image != nil {
                            cell.imagview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse!.data?.image!)!), placeholderImage: UIImage(named: "img_default"))
                        }
                        
                        
                    }
                    
                    if(indexPath.row == 8)
                    {
                        //cell.lblname.text = UsermeResponse?.data!.name
                        if UsermeResponse!.data?.society_logo != nil{
                            cell.imagview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse!.data?.society_logo!)!), placeholderImage: UIImage(named: "Society Buddy logo transperent"))
                        }
                        
                        
                    }                    
                    
                }else
                {
                    if(selectedindex == indexPath.row)
                    {
                        cell.imagview.image = UIImage(named: selectedimagesary[indexPath.row])
                        cell.lblname.textColor = AppColor.appcolor
                        cell.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha: 0.6)
                    }
                    else
                    {
                        cell.imagview.image = UIImage(named: imagesary[indexPath.row])
                        cell.lblname.textColor = UIColor.black
                        cell.backgroundColor = UIColor.white
                        
                    }
                    
                }
                
                
            }
        }
        else
        {
            
            if(indexPath.row == 0 || indexPath.row == 8)
            {
                
                if(indexPath.row == 0)
                {
                    cell.lblname.text = UsermeResponse?.data!.name
                    
                    if UsermeResponse!.data?.image != nil{
                        cell.imagview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse!.data?.image!)!), placeholderImage: UIImage(named: "img_default"))
                    }
                    
                }
                if(indexPath.row == 8)
                {
                    //cell.lblname.text = UsermeResponse?.data!.name
                    if UsermeResponse!.data?.society_logo != nil{
                        cell.imagview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse!.data?.society_logo!)!), placeholderImage: UIImage(named: "Society Buddy logo transperent"))
                    }
                    
                    
                }
                
            }else
            {
                if(selectedindex == indexPath.row)
                {
                    cell.imagview.image = UIImage(named: selectedimagesary[indexPath.row])
                    cell.lblname.textColor = AppColor.appcolor
                    cell.backgroundColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha: 0.6)
                }
                else
                {
                    cell.imagview.image = UIImage(named: imagesary[indexPath.row])
                    cell.lblname.textColor = UIColor.black
                    cell.backgroundColor = UIColor.white
                    
                }
                
            }
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedindex = indexPath.row
        tableView.reloadData()
        
        if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
        {
            let str = UserDefaults.standard.value(forKey:USER_ROLE) as! String
            
            if(str.contains("Chairman") || str.contains("Secretory"))
            {
//                if(indexPath.row == 6)
//                {
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
//                    nextViewController.isfrom = 1
//                    revealViewController()?.pushFrontViewController(nextViewController, animated: true)
//
//                }
//                if(indexPath.row == 7)
//                {
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
//                    nextViewController.isfrom = 1
//                    revealViewController()?.pushFrontViewController(nextViewController, animated: true)
//                }
                if(indexPath.row == 5)
                {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserSettingsVC") as! UserSettingsVC
                    revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                }
                if(indexPath.row == 6)
                {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
                    revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                }
                
                if(indexPath.row == 8)
                {

                       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                       avc?.titleStr = "Society Buddy"
                       avc?.subtitleStr = "Are you sure you want to logout?"
                       avc?.yesAct = {
                       
                           APPDELEGATE.ApiLogout(onCompletion: { int in
                                                      if int == 1{
                                                           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                                                     let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                                     let navController = UINavigationController(rootViewController: aVC)
                                                                                                     navController.isNavigationBarHidden = true
                                                                                        self.appDelegate.window!.rootViewController  = navController
                                                                                        
                                                      }
                                                  })
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
//                    present(refreshAlert, animated: true, completion: nil)
                    
                }
            }
            else
            {
                
//                if(indexPath.row == 5)
//                {
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
//                    nextViewController.isfrom = 1
//                    revealViewController()?.pushFrontViewController(nextViewController, animated: true)
//
//                }
//                if(indexPath.row == 6)
//                {
//                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
//                    nextViewController.isfrom = 1
//                    revealViewController()?.pushFrontViewController(nextViewController, animated: true)
//                }
                
                if(indexPath.row == 4)
                {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserSettingsVC") as! UserSettingsVC
                    revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                }
                if(indexPath.row == 5)
                           {
                               let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
                               revealViewController()?.pushFrontViewController(nextViewController, animated: true)
                    }
                
                if(indexPath.row == 7)
                {
                   
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                         let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                         avc?.titleStr = "Society Buddy"
                                         avc?.subtitleStr = "Are you sure you want to logout?"
                                         avc?.yesAct = {
                                         
                                             APPDELEGATE.ApiLogout(onCompletion: { int in
                                                                        if int == 1{
                                                                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                                                                       let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                                                       let navController = UINavigationController(rootViewController: aVC)
                                                                                                                       navController.isNavigationBarHidden = true
                                                                                                          self.appDelegate.window!.rootViewController  = navController
                                                                                                          
                                                                        }
                                                                    })
                                                                    print("Handle Ok logic here")
                                          
                                             }
                                         avc?.noAct = {
                                           
                                         }
                                         present(avc!, animated: true)
                    
                    
//                    let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
//
//                    refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
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
//                    present(refreshAlert, animated: true, completion: nil)
                    
                }
                
                
            }
        }
        else{
            
//            if(indexPath.row == 5)
//            {
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
//                nextViewController.isfrom = 1
//                revealViewController()?.pushFrontViewController(nextViewController, animated: true)
//
//            }
//            if(indexPath.row == 6)
//            {
//                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
//                nextViewController.isfrom = 1
//                revealViewController()?.pushFrontViewController(nextViewController, animated: true)
//            }
//
            if(indexPath.row == 4)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "UserSettingsVC") as! UserSettingsVC
                revealViewController()?.pushFrontViewController(nextViewController, animated: true)
            }
            if(indexPath.row == 5)
            {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
                revealViewController()?.pushFrontViewController(nextViewController, animated: true)
            }
            
            if(indexPath.row == 7)
            {
                
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                     let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                     avc?.titleStr = "Society Buddy"
                                     avc?.subtitleStr = "Are you sure you want to logout?"
                                     avc?.yesAct = {
                                     
                                         APPDELEGATE.ApiLogout(onCompletion: { int in
                                                                    if int == 1{
                                                                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                                                                   let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                                                                   let navController = UINavigationController(rootViewController: aVC)
                                                                                                                   navController.isNavigationBarHidden = true
                                                                                                      self.appDelegate.window!.rootViewController  = navController
                                                                                                      
                                                                    }
                                                                })
                                                                print("Handle Ok logic here")
                                      
                                         }
                                     avc?.noAct = {
                                       
                                     }
                                     present(avc!, animated: true)
                
                
//                let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to logout?", preferredStyle: UIAlertControllerStyle.alert)
//
//                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//
//                    APPDELEGATE.ApiLogout(onCompletion: { int in
//                        if int == 1{
//                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//                            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
//                            self.navigationController?.pushViewController(nextViewController, animated: true)
//                        }
//                    })
//                    print("Handle Ok logic here")
//                }))
//
//                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//                    print("Handle Cancel Logic here")
//                }))
//
//                present(refreshAlert, animated: true, completion: nil)
                
            }
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == cells.count - 1{
            return 150
        }else if indexPath.row == 0{
           return 144
        }else{
          return 60
        }
    }
    
    
    
}
