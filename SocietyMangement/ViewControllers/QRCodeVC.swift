//
//  QRCodeVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 22/08/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

import SwiftSVG

import SDWebImage

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class QRCodeVC: BaseVC {
    
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var imgview: UIImageView!

    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var lblflatno: UILabel!

    @IBOutlet weak var lblflattype: UILabel!
    
    @IBOutlet weak var imgvwScaner: UIImageView!
    
    @IBOutlet weak var viewQrCode: UIView!

    
    var isfrom = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        apicallUserMe()
        
//        if isfrom == 0 {
            btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
//        }else{
          //  btnMenu.setImage(UIImage(named: "menu"), for: .normal)
       // }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
        vc.isfrom = 0
    }
       
    @IBAction func btnOpenQRCodePressed(_ sender: Any) {
        viewDidLoad()
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
            //Apicallhandler.sharedInstance.ApiCallUserMe(token: token as! String) { JSON in
             
        Apicallhandler().ApiCallUserMe(URL: webservices().baseurl + "user", token: token as! String) { [self] JSON in

                
                let statusCode = JSON.response?.statusCode
                
                switch JSON.result{
                case .success(let resp):
                   webservices().StopSpinner()
                    
                    if statusCode == 200{
                        UserDefaults.standard.set(resp.data!.society?.societyID, forKey: USER_SOCIETY_ID)
                        UserDefaults.standard.set(resp.data!.guid, forKey: USER_ID)
                        UserDefaults.standard.set(resp.data!.role, forKey: USER_ROLE)
                        UserDefaults.standard.set(resp.data!.society?.parentProperty, forKey: USER_BUILDING_ID)
                        UserDefaults.standard.synchronize()
                        
                        
                        UsermeResponse = resp
                      //  self.lbltitle.text = "Welcome, \(resp.data!.name!)"
                        
                      //  self.lbltitle.text = String(format: "%@-%@", UsermeResponse!.data!.building!,UsermeResponse!.data!.flats!)

                        
                        self.lblname.text = resp.data!.name
                        if(UsermeResponse?.data!.profilePhotoPath != nil)
                        {
                            self.imgview.sd_setImage(with: URL(string: (UsermeResponse!.data!.profilePhotoPath)!), placeholderImage: UIImage(named: "vendor-1"))
                        }
                        
                        
                        if(UsermeResponse?.data!.qr != nil)
                        {
                           // self.imgvwScaner.sd_setImage(with: URL(string: (UsermeResponse!.data!.qr)), placeholderImage: UIImage(named: ""))
                            
                          //  let svg = URL(string: (UsermeResponse!.data!.qr))!
                           // imgvwScaner.sd_setImage(with: svg, completed: nil)
                           // print("svg : ",svg)
                            
                            let svgURL = URL(string: (UsermeResponse!.data!.qr!))!
                            print("svgURL : ",svgURL)
                            let hammock = UIView(SVGURL: svgURL) { (svgLayer) in
                               // svgLayer.fillColor = UIColor(red:0.52, green:0.16, blue:0.32, alpha:1.00).cgColor
                               // svgLayer.resizeToFit(self.view.bounds)
                                
                                svgLayer.resizeToFit(self.viewQrCode.bounds)
                            }
                            self.imgvwScaner.addSubview(hammock)
                        
                          //  self.view.addSubview(hammock)
                        }
                        
                        //self.lblflatno.text = "Flat no: \(UsermeResponse!.data.flatNo!)"
                        
                        // 22/10/20. temp comment
                      //  self.lblflatno.text = String(format: "Flat No: %@ - %@", UsermeResponse!.data!.PropertyID!,UsermeResponse!.data!.ParentProperty!)
                        self.lblflattype.text = "Contact No: \(UsermeResponse!.data!.phone!)"
                        
                        
                       /* if UsermeResponse?.data?.relation == "self"{
                            self.btnAddFamily.isHidden = false
                            self.btnAddFamilyBottom.isHidden = false
                        }else{
                            self.btnAddFamily.isHidden = true
                            self.btnAddFamilyBottom.isHidden = true
                        } */
                        
                        print(resp)
                    }
                    
                case .failure(let err):
                    webservices().StopSpinner()
                    if statusCode == 401{
                      /*  APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                            }
                        })
                        
                        return */
                    }
                    
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError as Any)
                    
                }
            }
        
    }

}

