//
//  SupportZendeskVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 08/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
// 28/11/20 app live process

/*
import MessagingAPI
import MessagingSDK
import SupportProvidersSDK
import SupportSDK
import ZDCChat
import ZDCChatAPI

import CommonUISDK

*/


class SupportZendeskVC: UIViewController {
    
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    var isfrom = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 28/11/20 app live process

       // CommonTheme.currentTheme.primaryColor = UIColor.orange
        
        isfrom = 1

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        self.navigationController?.isNavigationBarHidden = true

        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
      
      //  self.navigationController?.isNavigationBarHidden = true

        print("viewDidAppear true")
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Zendesk UiConfigurations
    
     /*  var articleConfig: ArticleUiConfiguration {
           let articleConfig = ArticleUiConfiguration()
           articleConfig.showContactOptions = true
           return articleConfig
       }
       
       var hcConfig: HelpCenterUiConfiguration {
           let hcConfig = HelpCenterUiConfiguration()
           hcConfig.showContactOptions = true
           hcConfig.labels = ["label"] // only hc articles with the label 'label' will appear
           return hcConfig
       }
       
       var requestConfig: RequestUiConfiguration {
           let config = RequestUiConfiguration()
           config.tags = ["tag_1","tag_2", "tag_3"]
           config.subject = "Support_API Sample"
           return config
       } */
    
   
    func setupSDKStyle() {

        // status bar
       // UIApplication.shared.statusBarStyle = .lightContent

        // nav bar
//        let navbarAttributes = [
//            //.foregroundColor : UIColor.white
//        ]
      //  UINavigationBar.appearance().titleTextAttributes = navbarAttributes
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0 / 255.0, green: 0.0 / 0.0, blue: 0.0 / 255.0, alpha: 1.0)

        // 28/11/20 app live process

       /* CommonTheme.currentTheme.primaryColor = UIColor(red: 0, green: 188.0 / 255.0, blue: 212.0 / 255.0, alpha: 1.0)
        // chat SDK
        ZDCChatOverlay.appearance().insets = NSValue(uiEdgeInsets: UIEdgeInsets(top: 75.0, left: 15.0, bottom: 70.0, right: 15.0)) */
        
    }
    
    @IBAction func showHelpCenter(_ sender: Any) {
        print("showHelpCenter Knowledge")
        
      //  setupSDKStyle()
        
       // let hcConfig = HelpCenterUiConfiguration()
        
      //  UINavigationBar.appearance().backgroundColor = UIColor(red: 0.37, green: 0.37, blue: 0.37, alpha: 1.0)
        
        // 28/11/20 app live process
        
      /*  self.navigationController?.isNavigationBarHidden = false
        
        let hcConfig = HelpCenterUiConfiguration()
        hcConfig.showContactOptions = true

        let vc: UIViewController = ZDKHelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [hcConfig])
        navigationController?.pushViewController(vc, animated: true) */
                

       // navigationController?.pushViewController(ZDKHelpCenterUi.buildHelpCenterOverviewUi(), animated: true)
        
//        let helpCenter = HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [])
        
 //       navigationController?.pushViewController(helpCenter, animated: true)

       // navigationController?.pushViewController(ZDKHelpCenterUi.buildHelpCenterOverviewUi(), animated: true)
    }
       
   @IBAction func contactSupport(_ sender: Any) {
    
        print("contactSupport contact us")
    
      //  let helpCenter = HelpCenterUi.buildHelpCenterOverviewUi(withConfigs: [hcConfig, requestConfig])
           
      //  navigationController?.pushViewController(helpCenter, animated: true)
    
//
//        navigationController?.modalPresentationStyle = .overCurrentContext
//
//        let config = setupSupportInformation()
//        var abEngine: ZDKAnswerBotEngine? = nil
//        do {
//            abEngine = try ZDKAnswerBotEngine.engine()
//        } catch {
//        }
//        var supportEngine: ZDKSupportEngine? = nil
//        do {
//            supportEngine = try ZDKSupportEngine.engine()
//        } catch {
//        }
//        let engines = [abEngine as? ZDKEngine?, supportEngine as? ZDKEngine?]
//        var requestController: UIViewController? = nil
//        do {
//            requestController = try ZDKMessaging.instance().buildUI(withEngines: engines, configs: [config])
//        } catch {
//        }
//
//        if let requestController = requestController {
//            navigationController?.pushViewController(requestController, animated: true)
//        }
   }
    

    @IBAction func showMyRequests(_ sender: Any) {
        print("showMyRequests MyTicketsButton")
        
       // let requestList = RequestUi.buildRequestList(with: [requestConfig])
         //       self.navigationController?.pushViewController(requestList, animated: true)

    }

    @IBAction func showChat(_ sender: Any) {
        print("showChat")
        
        // 28/11/20 app live process
        
      /*  CommonTheme.currentTheme.primaryColor = UIColor.orange

        
        ZDCChat.updateVisitor { [self] (user) in
            
            user?.name = UsermeResponse?.data!.name ?? ""

            // 22/10/20. temp comment
            user?.phone = UsermeResponse?.data!.phone //?? ""
            
            user?.email = UsermeResponse?.data!.email ?? ""
            
            let userid = UsermeResponse!.data!.guid
            
          //  let strUserId = (userid as NSNumber).stringValue

            if isfrom == 1 {
                
                isfrom = 2
            }
            user?.addNote("")
            // 22/10/20. temp comment
            
          //  user?.addNote(String(format: "Flat No: %@-%@ \nUser_id: %@", UsermeResponse!.data!.PropertyID ?? "" ,UsermeResponse!.data!.ParentProperty ?? "",userid))
       
        }
        
        ZDCChat.start(in: self.navigationController, withConfig: nil) */
    
    }
    
    
    
}
