//
//  BuildingsVC.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController

import Alamofire

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
class BuildingsVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,updateview{
  
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var btnMenu: UIButton!
    var buildingary = [Building]()
    
    @IBOutlet weak var tblview: UITableView!
    
    @IBOutlet var viewnoresult: UIView!
    
    var isFrom = 0

    
    @IBAction func backaction(_ sender: Any) {
        
        if isFrom == 1{
            self.navigationController?.popViewController(animated: true)
        }else{
            revealViewController()?.revealToggle(self)
        }
      
        
    }
    
    @IBAction func addaction(_ sender: Any) {
 
        self.view.endEditing(true)
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddBuildingPopup") as! AddBuildingPopup
        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.view.frame = self.view.frame
        popOverConfirmVC.delegate = self
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        if isFrom == 0{
            btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }else{
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal) //ic_backbutton
        }
      
        viewnoresult.center = self.view.center
        self.view.addSubview(viewnoresult)
        viewnoresult.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewnoresult.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        viewnoresult.heightAnchor.constraint(equalToConstant: 198).isActive = true
        
        viewnoresult.isHidden  = true
        if(revealViewController() != nil)
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
       
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
            else  if object.value(forKey: "notification_type") as! String == "Notice"{
                                   
                          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                        
                                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                                        nextViewController.isFrormDashboard = 0
                                        navigationController?.pushViewController(nextViewController, animated: true)
                                   
                                   
                               }else if object.value(forKey: "notification_type") as! String == "Circular"{
                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                                         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                                                        nextViewController.isfrom = 0
                                                                        navigationController?.pushViewController(nextViewController, animated: true)
                          
                                   
                                   
                               }else if object.value(forKey: "notification_type") as! String == "Event"{
                                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                                                                                     nextViewController.isfrom = 1
                                                                                     navigationController?.pushViewController(nextViewController, animated: true)
                          
                              
                                   
                               }
            
        }
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        apicallGetBuildings()
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)


    }
    // MARK: - protocol delegate methods

    func getupdate() {
        apicallGetBuildings()

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return buildingary.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
        
        
       // webservices.sharedInstance.setShadow(view:cell.innerview)
        
        cell.lblname.text =  self.buildingary[indexPath.row].PropertyName
        
        cell.btnedit.tag = indexPath.row
        cell.btndelete.tag = indexPath.row
        
        cell.btnedit.addTarget(self, action:#selector(editbuilding), for: .touchUpInside)
        cell.btndelete.addTarget(self, action:#selector(deletebuilding), for: .touchUpInside)
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2, height: collectionViewWidth/2
        + 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    @objc func editbuilding(sender:UIButton)
    {
        let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddBuildingPopup") as! AddBuildingPopup
        popOverConfirmVC.isfrom = 1
        popOverConfirmVC.dic = self.buildingary[sender.tag]
        self.addChildViewController(popOverConfirmVC)
        popOverConfirmVC.delegate = self
        popOverConfirmVC.view.frame = self.view.frame
        self.view.center = popOverConfirmVC.view.center
        self.view.addSubview(popOverConfirmVC.view)
        popOverConfirmVC.didMove(toParentViewController: self)
        
    }
    @objc func deletebuilding(sender:UIButton)
    {
      
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                             let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                                                             avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
                                                             avc?.subtitleStr = "Are you sure you want to delete \(self.buildingary[sender.tag].PropertyName)?"
                                                             avc?.yesAct = {
                                                                   
                                                                      self.apicallDeleteBuilding(id: (self.buildingary[sender.tag].PropertyID as NSNumber).stringValue)

                                                                 }
                                                             avc?.noAct = {
                                                               
                                                             }
                                                             present(avc!, animated: true)
        
        
//        let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to delete \(self.buildingary[sender.tag].name)?", preferredStyle: UIAlertControllerStyle.alert)
//
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//            self.apicallDeleteBuilding(id: (self.buildingary[sender.tag].id as NSNumber).stringValue)
//
//            print("Handle Ok logic here")
//        }))
//
//        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("Handle Cancel Logic here")
//        }))
//
//        present(refreshAlert, animated: true, completion: nil)
//
    }
    
    
    
    // MARK: - get GetBuildings
    
    func apicallGetBuildings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let SociId =  UserDefaults.standard.value(forKey:USER_SOCIETY_ID) as! Int
            let strSociId  = (SociId as NSNumber).stringValue
            
            webservices().StartSpinner()
          
        // Apicallhandler().GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, societyid:strSociId) { JSON in
                
                let secret = UserDefaults.standard.string(forKey: USER_SECRET)!
            
                 let param : Parameters = [
                     "Phone" : mobile!,
                     "Secret" : secret,
                     "Society" : strSociId
                 ]
                
                        
                Apicallhandler.sharedInstance.GetAllBuidldings(URL: webservices().baseurl + API_GET_BUILDING, param: param) { JSON in
                   
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.buildingary = resp.data
                        
                        if self.buildingary.count > 0{
                            self.collectionview.reloadData()
                        }else{
                            self.collectionview.isHidden = true
                            self.viewnoresult.isHidden = false
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
    
    // MARK: - Delete circulars
    
    func apicallDeleteBuilding(id:String)
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        webservices().StartSpinner()
            Apicallhandler().DeleteBuilding(URL: webservices().baseurl + "deleteBuilding", id:id) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        self.apicallGetBuildings()
                    }
                    
                    else if(JSON.response?.statusCode == 401)
                    {
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                              let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                            }
                        })
                        
                        
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
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

   

}
