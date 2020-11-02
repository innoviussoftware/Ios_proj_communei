//
//  ProfileVC.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SWRevealViewController
import SDWebImage
import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class ProfileVC: BaseVC, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    var familymeberary = [FamilyMember]()
    
  //  @IBOutlet weak var btnadd3: UIButton!
    
  //  @IBOutlet weak var btnadd1: UIButton!
    
  //  @IBOutlet weak var btnadd2: UIButton!
    
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblflatno: UILabel!
    
    @IBOutlet weak var lblflattype: UILabel!
    
    @IBOutlet weak var lblprofession: UILabel!

    @IBOutlet weak var lblBloodGroup: UILabel!
    
    @IBOutlet weak var lblBloodGroupName: UILabel!
    
  //  @IBOutlet weak var viewcollection: UIView!
    @IBOutlet weak var viewmembers: UIView!
    @IBOutlet weak var viewVehiclemembers: UIView!

    @IBOutlet weak var collectionVehicle: UICollectionView!
    @IBOutlet weak var menuaction: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    
    @IBOutlet weak var tblview: UITableView!
    
   // @IBOutlet weak var tableViewHeight: NSLayoutConstraint!


    var member : Members?
    var isfrom = 0
    
    var arrVehicleList = [VehicleData]()

    
    @objc func backaction(sender:UIButton)
    {
        self.navigationController?.popViewController(animated:true)

    }
    
    @IBAction func btn_backaction(_ sender: Any) {
           
           if isfrom == 0{
               revealViewController()?.revealToggle(self)
           }else{
               
               self.navigationController?.popViewController(animated: true)
           }
           
           
       }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        nextViewController.isfrom = 0

        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func nextaction(_ sender: Any) {
        
        if isfrom == 0{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfiledetailVC") as! ProfiledetailVC
            nextViewController.isfrom = self.isfrom
           // nextViewController.member = self.member
            navigationController?.pushViewController(nextViewController, animated: true)
        }else{
            let userID = UserDefaults.standard.value(forKey: USER_ID) as! Int
            if userID == member?.id{
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfiledetailVC") as! ProfiledetailVC
                nextViewController.isfrom = self.isfrom
                nextViewController.member = self.member
                navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        tblview.register(UINib(nibName: "ResidentFamilymembersCell", bundle: nil), forCellReuseIdentifier: "ResidentFamilymembersCell")
               
        tblview.separatorStyle = .none
               
        
        if(isfrom == 0)
        {
            menuaction.setImage(UIImage(named:"menu"), for: .normal)
//            btnadd1.isHidden = false
//            btnadd2.isHidden = false
//            btnadd3.isHidden = false
            
        }
        else
        {
            menuaction.setImage(UIImage(named:"ic_back-1"), for: .normal)
            
          //  menuaction.addTarget(revealViewController(), action: #selector(backaction), for: .touchUpInside)
            
//            btnadd1.isHidden = true
//            btnadd2.isHidden = true
//            btnadd3.isHidden = true
            
        }
        
        if(revealViewController() != nil)
        {
            if(isfrom == 0)
            {
                menuaction.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            }
            else{
                
               // menuaction.addTarget(revealViewController(), action: #selector(backaction), for: .touchUpInside)
                
            }
        }
        
        
        if(isfrom == 0)
        {
            lblname.text = UsermeResponse?.data!.name
            if(UsermeResponse?.data!.profilePhotoPath != nil)
            {
                imgview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse?.data!.profilePhotoPath)!), placeholderImage: UIImage(named: "vendor profile"))
            }
            //lblflatno.text = "Flat no: \(UsermeResponse!.data.fla)"
           // self.lblflatno.text = String(format: "Flat No: %@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)
            // Orchid Block A - FLAT 105
            
            // 22/10/20. temp comment
            
          //  self.lblflatno.text = String(format: "%@ - Flat %@", UsermeResponse!.data!.PropertyID!,UsermeResponse!.data!.ParentProperty!)

            lblflattype.text = (member!.flatType)
               // "Contact no: \(UsermeResponse!.data!.phone!)"
            
            lblprofession.text = (member!.profession)

            if member!.bloodgroup != nil{
                lblBloodGroupName.text = (member!.bloodgroup)
            }
                        
            let strId = String(format: "%d", (UsermeResponse?.data?.guid)!)
            apicallGetFamilyMembers(id:strId)
            
            apicallGetVehicleList(id:strId)

            
        }
        else
        {
            lblname.text = member?.name
            
            if(member?.image != nil)
            {
                imgview.sd_setImage(with: URL(string:webservices().imgurl + (member?.image)!), placeholderImage: UIImage(named: "vendor profile"))
            }
            
            lblflatno.text = "\(member!.buildingname!) - FLAT \(member!.flatname!)"
          //  lblflattype.text = "Contact No: \(member!.phone)"
            
            lblflattype.text = (member!.flatType)

            lblprofession.text = (member!.profession)
            
            if member!.bloodgroup != nil{
                lblBloodGroupName.text = (member!.bloodgroup)
            }
                        
            let strId = String(format: "%d", (member?.userID)!)
             apicallGetFamilyMembers(id:strId)
            
            apicallGetVehicleList(id:strId)

            
        }
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    
    @IBAction func callmembers(_ sender: Any) {
   
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
         if(self.isfrom == 0) {
            avc?.subtitleStr = "Are you sure you want to call: \(UsermeResponse!.data!.phone)"
         }else{
            avc?.subtitleStr = "Are you sure you want to call: \(member!.phone)"
        }
        avc?.isfrom = 3

                                avc?.yesAct = {
                                        if(self.isfrom == 0) {
                                            self.dialNumber(number:  UsermeResponse!.data!.phone!)

                                        }else{
                                            self.dialNumber(number:  self.member!.phone)
                                        }

                                    }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
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
    
    @IBAction func btnOpenQRCodePressed(_ sender: Any) {
           let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
           vc.isfrom = 0
       }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    //MARK:- tableview delegate
          
          
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return familymeberary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "ResidentFamilymembersCell") as! ResidentFamilymembersCell
        
        cell.selectionStyle = .none
          //  webservices.sharedInstance.setShadow(view:cell.innerview)
                   
                   cell.lblname.text =  familymeberary[indexPath.row].name
                   cell.lblmember.text = familymeberary[indexPath.row].relation
                   cell.btncll.tag = indexPath.row
                   if familymeberary[indexPath.row].profilePhotoPath != nil{
                         cell.imgview.sd_setImage(with: URL(string:webservices().imgurl + familymeberary[indexPath.row].profilePhotoPath!), placeholderImage: UIImage(named: "vendor profile"))
                   }
                   
                
        cell.btncll.addTarget(self, action:#selector(callmember), for: .touchUpInside)
        
        return cell
            
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
      //  return 100
    }
       

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("willDisplay :- ",cell.frame.size.height)
       // self.tableViewHeight += cell.frame.size.height
        
       // self.tableViewHeight.constant += cell.frame.size.height

    }
    
    
    //MARK:- collectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrVehicleList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"VehicleCollectionCell", for: indexPath) as! VehicleCollectionCell
                              
                              if arrVehicleList[indexPath.row].type == "Two Wheeler"{
                                  cell.imgVehicle.image = #imageLiteral(resourceName: "Group 271")
                              }else{
                              
                             // if arrVehicleList[indexPath.row].type == "Four Wheeler"{
                                  cell.imgVehicle.image = #imageLiteral(resourceName: "cab")
                              }
                              
                              cell.lblVehicleType.text = arrVehicleList[indexPath.row].type
                              cell.lblVehicleNumber.text = arrVehicleList[indexPath.row].dClass
                              
                              return cell
      
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145, height:135)

    }
    
    
    @objc func callmember(sender:UIButton)
    {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Call" // GeneralConstants.kAppName // "Society Buddy"
        avc?.subtitleStr = "Are you sure you want to call: \(familymeberary[sender.tag].phone)"
                        
                        avc?.isfrom = 3

                                   avc?.yesAct = {
                                    self.dialNumber(number:  self.familymeberary[sender.tag].phone!)

                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
      //  dialNumber(number:familymeberary[sender.tag].phone!)
    }
    @objc func editmember(sender:UIButton)
    {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddFamilyMemberVC") as! AddFamilyMemberVC
        nextViewController.isfrom = 1
        nextViewController.member = familymeberary[sender.tag]
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    // MARK: - get Vehicle

    func apicallGetVehicleList(id:String)
    {
        if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        let param : Parameters = [
            "user_id" : id
        ]
        
        // 8/9/20.
        
        Apicallhandler().GetVehicleList_1(URL: webservices().baseurl + API_GET_VEHICLELIST, param: param, token: token as! String) { JSON in

            
          //  Apicallhandler().GetVehicleList(URL: webservices().baseurl + API_GET_VEHICLELIST, token:token as! String) { JSON in
                switch JSON.result{
                    
                case .success(let resp):
                    
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.arrVehicleList = resp.data
                        if self.arrVehicleList.count > 0{
                            self.collectionVehicle.isHidden = false
                            self.viewVehiclemembers.isHidden = true
                            self.collectionVehicle.dataSource = self
                            self.collectionVehicle.delegate = self
                            self.collectionVehicle.reloadData()
                        }else{
                            self.viewVehiclemembers.isHidden = false
                            self.collectionVehicle.isHidden = true
                        }
                        
                    }
                    else
                    {
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    self.viewVehiclemembers.isHidden = false
                    self.collectionVehicle.isHidden = true
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
     
    }
    
    // MARK: - get Members
    
    func apicallGetFamilyMembers(id:String)
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            webservices().StartSpinner()
            
            let param : Parameters = [
                "user_id" : id
            ]
            
            Apicallhandler().APIGetMemberFamilyList(URL: webservices().baseurl + API_GET_MEMBERFAMILY_LIST, param: param, token: token as! String) { JSON in
                
                print(JSON)
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    var nameary = NSMutableArray()
                    if(JSON.response?.statusCode == 200)
                    {
                        self.familymeberary = resp.data!
                        
                        self.tblview.reloadData()
                        if(resp.data!.count == 0)
                        {
                           // self.lblNoDataFound.isHidden = false
                            self.tblview.isHidden = true
                            self.viewmembers.isHidden = false
                           // self.view.bringSubview(toFront:self.viewmembers)
                        }
                        else
                        {
                           // self.lblNoDataFound.isHidden = true
                            self.tblview.isHidden = false
                            self.viewmembers.isHidden = true
                           // self.view.bringSubview(toFront:self.tblview)
                            
                        }
                    }
                        
                    else
                    {
                        if(resp.data!.count == 0)
                        {
                            self.tblview.isHidden = true
                            self.viewmembers.isHidden = false
                           // self.view.bringSubview(toFront:self.viewmembers)
                        }
                        else
                        {
                            self.tblview.isHidden = false
                            self.viewmembers.isHidden = true
                          //  self.view.bringSubview(toFront:self.tblview)
                        }
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)
                    webservices().StopSpinner()
                    
                }
                
            }
            
      
        
    }
    
    
    
    
    
}
