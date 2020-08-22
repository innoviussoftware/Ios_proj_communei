//
//  DomesticHelpVC.swift
//  SocietyMangement
//
//  Created by Innovius on 29/07/1941 Saka.
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
class DomesticHelpVC: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var btnNotification: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var btnMenu: UIButton!
    
    var arrHelper = [HelperListData]()
    var arrFinal = [HelperListData]()
    
    var isfrom = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        if isfrom == 1{
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }else{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }
        
        lblNoDataFound.isHidden = true
        tblView.register(UINib(nibName: "DomesticHelpCell", bundle: nil), forCellReuseIdentifier: "DomesticHelpCell")
        tblView.separatorStyle = .none
        setUpView()
        apicallGetDomestichelperList()
        
        if(revealViewController() != nil)
        {
            btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
           
       }
       
    @available(iOS 13.0, *)
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
    
    
    
    func setUpView() {
        
        searchbar.layer.cornerRadius = 30
        searchbar.clipsToBounds = true
       // if #available(iOS 13.0, *) {
        searchbar.searchTextField.backgroundColor = UIColor.white
      //  }
        
        
        
    }
    @IBAction func actionMenu(_ sender: Any) {
        if isfrom == 1{
            self.navigationController?.popViewController(animated: true)
        }else{
            revealViewController()?.revealToggle(self)
        }
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
                
    }
    
    
    // MARK: - get Maid List
    
    func apicallGetDomestichelperList()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
            let strSociId  = (SociId as NSNumber).stringValue
            
            webservices().StartSpinner()
            Apicallhandler().GetHelperList(URL: webservices().baseurl + API_HELPER_LIST, societyid:strSociId) { JSON in
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.arrHelper = resp.data
                        self.arrFinal = resp.data
                        
                        if self.arrHelper.count > 0{
                            self.lblNoDataFound.isHidden = true
                            self.tblView.delegate = self
                            self.tblView.dataSource = self
                            self.tblView.reloadData()
                            
                        }else{
                            self.tblView.isHidden = true
                            self.lblNoDataFound.isHidden = false
                            
                        }
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                        self.present(alert, animated: true, completion: nil)
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
                }
                
                if self.arrHelper.count > 0{
                    self.tblView.isHidden = false

                    self.lblNoDataFound.isHidden = true
                    self.tblView.reloadData()
                }else{
                    self.tblView.isHidden = true
                    self.lblNoDataFound.isHidden = false
                }
                tblView.reloadData()

            }
            else
            {
                arrHelper = arrFinal
                self.tblView.isHidden = false
                self.lblNoDataFound.isHidden = true

                tblView.reloadData()
                
            }
            self.tblView.reloadData()
        }
        
      
    
    
    
}
@available(iOS 13.0, *)
extension DomesticHelpVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHelper.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DomesticHelpCell") as! DomesticHelpCell
        
        cell.selectionStyle = .none
        if arrHelper[indexPath.row].photos != nil
        {
            cell.imgUser.sd_setImage(with: URL(string:webservices().imgurl + arrHelper[indexPath.row].photos!), placeholderImage: UIImage(named: "vendor-1"))
        }
        
        cell.lblName.text = arrHelper[indexPath.row].name
        cell.lblProfession.text = arrHelper[indexPath.row].typename
        cell.lblRatingNumber.text = String(format: "%.1f", arrHelper[indexPath.row].averageRating!)
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MaidProfileDetailsVC") as! MaidProfileDetailsVC
        vc.HelperId = arrHelper[indexPath.row].id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
}
