//
//  NewHomeVC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 16/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

import SWRevealViewController


@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class NewHomeVC: BaseVC, Invite {
    
    @IBOutlet weak var lblflatno: UILabel!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var menuaction: UIButton!
    
    @IBOutlet weak var message: UILabel!

    @IBOutlet weak var collectionactivity: UICollectionView!
    
    @IBOutlet weak var collectionshortcut: UICollectionView!
    var shortcutary = ["Add Visitor","Buy/Sell","Help Desk","Amenities Booking","Domestic Helper"]
    var iconary =
        [UIImage(named:"ic_user"),UIImage (named:"ic_buysell"),UIImage (named:"ic_helpdesk"),UIImage (named:"ic_aminities"),UIImage (named:"ic_domestic")]
    
    var arrGuestList = [guestData]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionshortcut.layer.shadowColor = UIColor.lightGray.cgColor
        collectionshortcut.layer.shadowOffset = CGSize(width:0, height: 1)
        collectionshortcut.layer.shadowOpacity = 1
        collectionshortcut.layer.shadowRadius = 1.0
        collectionshortcut.clipsToBounds = false
        collectionshortcut.layer.masksToBounds = false
        
        if(revealViewController() != nil)
        {
            menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        apicallUserMe()
        apicallGuestList()
    }
    
    
    
    @IBAction func btnMenuActionPressed(_ sender: Any) {
        revealViewController()?.revealToggle(self)
    }
    
    @IBAction func actionNotification(_ sender: Any) {
       let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
        vc.isfrom = 0
     }
    
    @IBAction func btnOpenQRCodePressed(_ sender: Any) {
        let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
        vc.isfrom = 0
    }
    
    @IBAction func btnViewAllPressed(_ sender: Any) {
        _ = self.pushViewController(withName:ActivityTabVC.id(), fromStoryboard: "Main") as! ActivityTabVC

    }

    
    // MARK: - User me
    
    func apicallUserMe()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        webservices().StartSpinner()
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        Apicallhandler.sharedInstance.ApiCallUserMe(token: token as! String) { JSON in
            
            let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
                
                if statusCode == 200{
                    UserDefaults.standard.set(resp.data!.societyID, forKey: USER_SOCIETY_ID)
                    UserDefaults.standard.set(resp.data!.id, forKey: USER_ID)
                    UserDefaults.standard.set(resp.data!.role, forKey: USER_ROLE)
                    UserDefaults.standard.set(resp.data!.buildingID, forKey: USER_BUILDING_ID)
                    UserDefaults.standard.synchronize()
                    UsermeResponse = resp
                    self.lblname.text = "Welcome, \(resp.data!.name!)"
                    
                    self.lblname.text = resp.data!.name
                    if(UsermeResponse?.data!.image != nil)
                    {
                        
                    }
                    //self.lblflatno.text = "Flat no: \(UsermeResponse!.data.flatNo!)"
                    self.lblflatno.text = String(format: "Flat No: %@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)
                    
                    
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
    
    // MARK: - Guest List
    
    func apicallGuestList()
    {
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        webservices().StartSpinner()
        Apicallhandler.sharedInstance.ApiCallGuestList(type:1, token: token as! String) { JSON in
            
            let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
              //  self.refreshControl.endRefreshing()
                if statusCode == 200{
                    
                    self.arrGuestList = resp.data!
                    if self.arrGuestList.count > 0{
                        self.collectionactivity.dataSource = self
                        self.collectionactivity.delegate = self
                        self.collectionactivity.reloadData()
                        
                        self.message.isHidden = true
                        
                        self.collectionactivity.isHidden = false
                    }else{
                        self.message.isHidden = false
                        self.collectionactivity.isHidden = true
                        
                    }
                    
                }
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
                    webservices().StopSpinner()
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError as Any)
                    
                    
                }
            }
            
            
            
        }
    }
    
    
    func inviteaction(from: String) {
          let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
          
          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "InviteVC") as! InviteVC
          nextViewController.isfrom = from
          navigationController?.pushViewController(nextViewController, animated: true)
      }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
@available(iOS 13.0, *)
extension NewHomeVC:UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
    
{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == collectionactivity)
        {
            let cell:LatestActivityCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! LatestActivityCell
            
          //  let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath)

            
            cell.lblname.text = arrGuestList[indexPath.row].name
            
            cell.lblVisitor.text = "Frequent Visitor"
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let date = dateFormatterGet.date(from: arrGuestList[indexPath.row].createAt!)
            dateFormatterGet.dateFormat = "dd-MM-yyyy hh:mm a"
            
            cell.lbltime.text = dateFormatterGet.string(from: date!)
            
            cell.imgview.sd_setImage(with: URL(string: webservices().imgurl + arrGuestList[indexPath.row].photos!), placeholderImage: UIImage(named: "vendor-1"))
            
            return cell
        }
        else
        {
            
            let cell:ShortCutCell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! ShortCutCell
            cell.imgview.image = iconary[indexPath.row]
            cell.lblname.text = shortcutary[indexPath.row]
            
            return cell
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == collectionactivity)
        {
            return arrGuestList.count
          //  return 10
        }
        else
        {
            return shortcutary.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == collectionactivity)
        {
            print("Latest Activity")
        }else
        {
            if indexPath.item == 0{ // "Add Visitor"
                
                let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddguestPopup") as! AddguestPopup
                popOverConfirmVC.delegate = self
                self.addChildViewController(popOverConfirmVC)
                popOverConfirmVC.view.frame = self.view.frame
                self.view.center = popOverConfirmVC.view.center
                self.view.addSubview(popOverConfirmVC.view)
                popOverConfirmVC.didMove(toParentViewController: self)
                print("Add Visitor")

            }else if indexPath.item == 1 { // "Buy/Sell"
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BuySellVC") as! BuySellVC
                vc.isfrom = 1
                self.navigationController?.pushViewController(vc, animated: true)
                print("Buy/Sell")
                
            }else if indexPath.item == 2 { // "Help Desk"
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpDeskVC") as! HelpDeskVC
                vc.isfrom = 1
                self.navigationController?.pushViewController(vc, animated: true)
                print("Help Desk")
                
            }else if indexPath.item == 3 { // "Amenities Booking"
                print("Amenities Booking")
            }else if indexPath.item == 4 { // "Domestic Helper"
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DomesticHelpVC") as! DomesticHelpVC
                vc.isfrom = 1
                self.navigationController?.pushViewController(vc, animated: true)
                print("Domestic Helper")
            }
            
            
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if(collectionView == collectionactivity)
        {
            return CGSize(width: 196, height: 86)
            
        }
        else
        {
            return CGSize(width: 84, height: 92)
            
        }
                
    }
    
    
}
