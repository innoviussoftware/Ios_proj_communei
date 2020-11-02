//
//  MemberdetailVC.swift
//  SocietyMangement
//
//  Created by MacMini on 30/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
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
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class MemberdetailVC: UIViewController {

    @IBOutlet weak var innerview: UIView!

    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblcontact: UILabel!
    
    @IBAction func backaction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var lblname1: UILabel!
    
    @IBOutlet weak var lblgmail: UILabel!
    
    @IBOutlet weak var lbladdress: UILabel!
    
    @IBOutlet weak var txtfiletype: UILabel!
    
    
    @IBOutlet weak var lblprofession: UILabel!
    
    
    @IBOutlet weak var lbldes: UILabel!
    
    @IBOutlet weak var lblrole: UILabel!
    
    var dic:Members?
    
    var selectedindexary = NSMutableArray()
    
    @IBAction func EditAction(_ sender: Any) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddMemberVC") as! AddMemberVC
        nextViewController.isfrom = 1
        nextViewController.dic = self.dic
        navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    
    @IBAction func deleteaction(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
               avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
               avc?.subtitleStr = "Are you sure you want to delete \(dic!.name)?"
               avc?.yesAct = {
                     
                        self.apicallDeleteMember(id:(self.dic!.id as! NSNumber).stringValue)

                   }
               avc?.noAct = {
                 
               }
               present(avc!, animated: true)
        
        
//
//        let refreshAlert = UIAlertController(title:nil, message: "Are you sure you want to delete \(dic!.name)?", preferredStyle: UIAlertControllerStyle.alert)
//
//        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//            self.apicallDeleteMember(id:(self.dic!.id as! NSNumber).stringValue)
//
//            print("Handle Ok logic here")
//        }))
//
//        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("Handle Cancel Logic here")
//        }))
//
//        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        

        webservices.sharedInstance.setShadow(view: innerview)
        
//        lblname.text = "Name :\(dic!.memberName)"
//
//        lblcontact.text = "Contact No :\(dic!.memberPhone)"
//
//        imgview.sd_setImage(with: URL(string: webservices().imgurl + dic!.memberPhoto), placeholderImage: UIImage(named: "vendor profile"))
//
//        lblname1.text = dic!.memberName
//        lblgmail.text = dic!.memberEmail
//        lbladdress.text = dic!.memberHouseNo + "Satva Appartment , Nea Shantivan Bus Stop, Paldi , Ahmedabad"
//
//        lblrole.text = dic!.memberRole
//        lblprofession.text = dic!.memberProfession
//        lbldes.text = dic?.memberProfessionDetail
//        txtfiletype.text = dic!.memberHouseType
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        
        
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
    
    // MARK: - Delete circulars
    
    func apicallDeleteMember(id:String)
    {
      if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
            Apicallhandler().DeleteMember(URL: webservices().baseurl + "deleteMember", id:id) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if((JSON.result.value as! NSDictionary).value(forKey:"error_code") as! NSNumber == 0)
                    {
                        
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:(JSON.result.value as! NSDictionary).value(forKey:"message") as! String)
                        self.present(alert, animated: true, completion: nil)
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

    
  
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
