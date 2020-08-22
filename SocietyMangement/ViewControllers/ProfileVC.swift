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
class ProfileVC: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var familymeberary = [FamilyMember]()
    
    @IBOutlet weak var btnadd3: UIButton!
    
    @IBOutlet weak var btnadd1: UIButton!
    
    @IBOutlet weak var btnadd2: UIButton!
    
    @IBOutlet weak var btnNotification: UIButton!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblflatno: UILabel!
    
    @IBOutlet weak var lblflattype: UILabel!
    
    @IBOutlet weak var viewcollection: UIView!
    @IBOutlet weak var viewmembers: UIView!
    @IBOutlet weak var collectionmembers: UICollectionView!
    @IBOutlet weak var menuaction: UIButton!
    
    @IBOutlet weak var lblNoDataFound: UILabel!
    var member : Members?
    var isfrom = 0
    
    @objc func backaction(sender:UIButton)
    {
        self.navigationController?.popViewController(animated:true)
        
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
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
        
        
        
        if(isfrom == 0)
        {
            menuaction.setImage(UIImage(named:"menu"), for: .normal)
            btnadd1.isHidden = false
            btnadd2.isHidden = false
            btnadd3.isHidden = false
            
        }
        else
        {
            menuaction.setImage(UIImage(named:"ic_backbutton"), for: .normal)
            
            menuaction.addTarget(revealViewController(), action: #selector(backaction), for: .touchUpInside)
            
            btnadd1.isHidden = true
            btnadd2.isHidden = true
            btnadd3.isHidden = true
            
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
                
                menuaction.addTarget(revealViewController(), action: #selector(backaction), for: .touchUpInside)
            }
        }
        if(isfrom == 0)
        {
            lblname.text = UsermeResponse?.data!.name
            if(UsermeResponse?.data!.image != nil)
            {
                imgview.sd_setImage(with: URL(string:webservices().imgurl + (UsermeResponse?.data!.image)!), placeholderImage: UIImage(named: "vendor-1"))
            }
            //lblflatno.text = "Flat no: \(UsermeResponse!.data.fla)"
            self.lblflatno.text = String(format: "Flat No: %@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)
            lblflattype.text = "Contact no: \(UsermeResponse!.data!.phone!)"
            
            
            let strId = String(format: "%d", (UsermeResponse?.data?.id)!)
            apicallGetFamilyMembers(id:strId)
            
        }
        else
        {
            lblname.text = member?.name
            
            if(member?.image != nil)
            {
                imgview.sd_setImage(with: URL(string:webservices().imgurl + (member?.image)!), placeholderImage: UIImage(named: "vendor-1"))
            }
            
            lblflatno.text = "Flat No: \(member!.buildingname!)-\(member!.flatname!)"
            lblflattype.text = "Contact No: \(member!.phone)"
            
            let strId = String(format: "%d", (member?.userID)!)
             apicallGetFamilyMembers(id:strId)
            
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return familymeberary.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell: Buildingcell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell", for: indexPath) as! Buildingcell
        
        
        webservices.sharedInstance.setShadow(view:cell.innerview)
        
        cell.lblname.text =  familymeberary[indexPath.row].name
        cell.lblcontact.text = familymeberary[indexPath.row].phone
        cell.btnedit.tag = indexPath.row
        cell.btncll.tag = indexPath.row
        if familymeberary[indexPath.row].image != nil{
              cell.imgview.sd_setImage(with: URL(string:webservices().imgurl + familymeberary[indexPath.row].image!), placeholderImage: UIImage(named: "vendor-1"))
        }
        
        cell.btnedit.addTarget(self, action:#selector(editmember), for: .touchUpInside)
        
        cell.btncll.addTarget(self, action:#selector(callmember), for: .touchUpInside)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: 140, height:154)
    }
    
    
    @objc func callmember(sender:UIButton)
    {
        dialNumber(number:familymeberary[sender.tag].phone!)
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
                        
                        self.collectionmembers.reloadData()
                        if(resp.data!.count == 0)
                        {
                            self.lblNoDataFound.isHidden = false
                            self.viewcollection.isHidden = true
                            self.viewmembers.isHidden = true
                            self.view.bringSubview(toFront:self.viewmembers)
                        }
                        else
                        {
                            self.lblNoDataFound.isHidden = true
                            self.viewcollection.isHidden = false
                            self.viewmembers.isHidden = true
                            self.view.bringSubview(toFront:self.viewcollection)
                            
                        }
                    }
                        
                    else
                    {
                        if(resp.data!.count == 0)
                        {
                            self.viewcollection.isHidden = true
                            self.viewmembers.isHidden = false
                            self.view.bringSubview(toFront:self.viewmembers)
                        }
                        else
                        {
                            self.viewcollection.isHidden = false
                            self.viewmembers.isHidden = true
                            self.view.bringSubview(toFront:self.viewcollection)
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
