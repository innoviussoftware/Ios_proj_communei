//
//  GuestPopVC.swift
//  SocietyMangement
//
//  Created by MacMini on 29/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import SDWebImage
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

class GuestPopVC: UIViewController {

    
    
    var isfromnotification = 0
    
    var guestdic = NSDictionary()
    @IBAction func cancelaction(_ sender: Any) {
        if(isfromnotification == 0)
        { self.navigationController?.popViewController(animated: true)
        }
        else
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            
        }
    }
    
    @IBOutlet weak var lblflatno: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    @IBAction func callaction(_ sender: Any) {
    }
    @IBAction func acceptaction(_ sender: Any) {
        
        ApiCallAccepGuest(type:1)
    }
    
    @IBAction func denyaction(_ sender: Any) {
        
        ApiCallAccepGuest(type:2)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        

        //NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
        lblname.text = guestdic.value(forKey:"guest_name") as? String
        let image = guestdic.value(forKey:"guest_image") as! String
        imgview.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "vendor-1"))
        lblflatno.text = "\(guestdic.value(forKey:"building_no") as! String) \(guestdic.value(forKey:"flat_no") as! String),\(guestdic.value(forKey:"socity_name") as! String)"
        //(guestdic.value(forKey:"building_no") as! String) \(guestdic.value(forKey:"flat_no") as! String),\(guestdic.value(forKey:"guest_name") as! String)"
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapimage))
        imgview.addGestureRecognizer(tap)
        imgview.isUserInteractionEnabled = true
        
    }
    @objc func tapimage(sender:UITapGestureRecognizer)
    {
    let image = guestdic.value(forKey:"guest_image") as! String

       let otpVC = self.storyboard?.instantiateViewController(withIdentifier: "ImagePopUP") as! ImagePopUP
    otpVC.imgurl = image
       self.addChildViewController(otpVC)
              self.view.addSubview(otpVC.view)
              let height = self.view.bounds.height
              otpVC.view.frame = CGRect(x: 0, y: height, width: self.view.bounds.width, height: height)
              
              UIView.animate(withDuration: 0.4, animations: {
                  otpVC.view.frame = self.view.bounds
              })
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
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
                lblname.text = object.value(forKey: "guest_name") as? String
                let image = object.value(forKey: "guest_image") as! String
                 imgview.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "vendor-1"))
                lblflatno.text = "\(object.value(forKey:"building_no") as! String) \(object.value(forKey:"flat_no") as! String),\(object.value(forKey:"socity_name") as! String)"
            }
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
    
    // MARK: - Delete circulars
    func ApiCallAccepGuest(type:Int)
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            webservices().StartSpinner()
            Apicallhandler().ApiAcceptGuestRequest(URL: webservices().baseurl + API_ACCEPT_DECLINE,token: token as! String, type: type, guest_id: guestdic.value(forKey:"guest_id") as! String) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        
                    if(self.isfromnotification == 0)
                    {
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        }
                        
                    }else if (resp.status == 0){
                        
                        let alert = UIAlertController(title: Alert_Titel, message:resp.message , preferredStyle: UIAlertController.Style.alert)
                                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { alert in
                                       let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                       self.navigationController?.pushViewController(nextViewController, animated: true)
                                        
                                      }))
                                      self.present(alert, animated: true, completion: nil)
                        
//                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
//                        self.present(alert, animated: true, completion: nil)
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
    
    
   
}
