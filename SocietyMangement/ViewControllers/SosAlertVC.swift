//
//  SosAlertVC.swift
//  SocietyMangement
//
//  Created by Macmini on 03/03/21.
//  Copyright © 2021 MacMini. All rights reserved.
//

import UIKit


class SosAlertVC: UIViewController {
    
    @IBOutlet weak var lblNumber: UILabel!

    var isfrom = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isfrom = 1
            
        self.lblNumber.text = "5"

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.lblNumber.text = "4"
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.lblNumber.text = "3"
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.lblNumber.text = "2"
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4) {
            self.lblNumber.text = "1"
        }
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            if self.isfrom == 1 {
                self.apiCallSosAlert()
            }else{
                print("Stop")
            }
        }
        
    }
    
    func apiCallSosAlert() {
        
        if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
        }
        webservices().StartSpinner()
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        print("apiCallSosAlert token : ",token!)
       

        Apicallhandler().apiCallSosAlert(URL: webservices().baseurl + API_SOS_ALERT, token: token as! String) { JSON in
            
            let statusCode = JSON.response?.statusCode
            
            switch JSON.result{
            case .success(let resp):
               
               print(resp)

                webservices().StopSpinner()
                
                if statusCode == 200{
                 
                    self.messageClicked()
                 
                }
                
            case .failure(let err):
                webservices().StopSpinner()
                if statusCode == 401{
                    
                   UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                   UserDefaults.standard.removeObject(forKey:USER_ID)
                   UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                   UserDefaults.standard.removeObject(forKey:USER_ROLE)
                   UserDefaults.standard.removeObject(forKey:USER_PHONE)
                   UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                   UserDefaults.standard.removeObject(forKey:USER_NAME)
                   UserDefaults.standard.removeObject(forKey:USER_SECRET)
                   UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)
                   
                             let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                       let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                       let navController = UINavigationController(rootViewController: aVC)
                                                                       navController.isNavigationBarHidden = true
                                                          self.appDelegate.window!.rootViewController  = navController
                                                          
                    
                    return
                }
                
               // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
              //  self.present(alert, animated: true, completion: nil)
                print(err.asAFError!)
                
            }
        }
        
    }
    
    func messageClicked() {
        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
        avc?.titleStr =  "Communei"
        avc?.subtitleStr = "Alert sent to all respective departments"
        avc?.isfrom = 4

        avc?.yesAct = {
           
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
                                         
        }
        avc?.noAct = {
            
        }
        
        present(avc!, animated: true)
    }
    
    @IBAction func btnStopPressed(_ sender: UIButton) {
        isfrom = 0
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
