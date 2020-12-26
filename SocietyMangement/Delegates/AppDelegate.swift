//
//  AppDelegate.swift
//  SocietyMangement
//
//  Created by MacMini on 29/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import UserNotifications
import Alamofire
import SWRevealViewController

import FirebaseMessaging
// 28/11/20 app live process

/*
import ZDCChat

import SupportSDK
import ZendeskCoreSDK
*/

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate, SWRevealViewControllerDelegate  {

    var window: UIWindow?
       class var shared : AppDelegate {
           return UIApplication.shared.delegate as! AppDelegate
       }
           
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barStyle = .blackTranslucent        

        // 28/11/20 app live process

       /* Zendesk.initialize(appId: "4ea1392aac888121afe024b8597d9914d9729120dd2f4219", clientId: "mobile_sdk_client_9d81559f360d1c9fc80b", zendeskUrl: "https://communei.zendesk.com")
        
        let ident = Identity.createAnonymous()
        Zendesk.instance?.setIdentity(ident)

        Support.initialize(withZendesk: Zendesk.instance)

        ZDCChat.initialize(withAccountKey: "vmJD9mg6iui0rWzxNcR5jfb1gLLEjBll") */


        IQKeyboardManager.shared.enable = true
        
        
        FirebaseApp.configure()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
            Messaging.messaging().delegate = self
            
        }
        
        
        application.registerForRemoteNotifications()
       // NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification(notification:)), name: NSNotification.Name.InstanceIDTokenRefresh, object: nil)
        
      //  Notification.Name.MessagingRegistrationTokenRefreshed
        //  6/8/20.
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.tokenRefreshNotification(notification:)), name: NSNotification.Name.MessagingRegistrationTokenRefreshed, object: nil)
                
        let snoozeAction = UNNotificationAction(
            identifier: "snooze.action",
            title: "Accept",
            options: [.foreground])
        
        let snoozeAction1 = UNNotificationAction(
            identifier: "snooze.action",
            title: "Reject",
            options: [.foreground])
        
        let pizzaCategory = UNNotificationCategory(
            identifier: "notification.category",
            actions: [snoozeAction,snoozeAction1],
            intentIdentifiers: [],
            options: [])
      
        UNUserNotificationCenter.current().setNotificationCategories(
            [pizzaCategory])
        
        
         if launchOptions != nil {
            // opened from a push notification when the app is closed
            let userInfo = launchOptions![.remoteNotification] as? [AnyHashable: Any]
            if userInfo != nil {
                let dic: NSDictionary = userInfo! as NSDictionary
                
                if dic.value(forKey: "notification_type") as! String == "alert"{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "DeliveryWaitingPopupVC") as! DeliveryWaitingPopupVC
                    
                   initialViewController.deliverydic = dic
                    
                    let navigationController = UINavigationController.init(rootViewController: initialViewController)
                    navigationController.navigationBar.isHidden = true
                    
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                    
                    print("DeliveryWaitingPopupVC")
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: dic)
                    
                }

               else if dic.value(forKey: "notification_type") as! String == "SocietyNotice"{
                         
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                         let initialViewController = storyboard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                         //let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                         let navigationController = UINavigationController.init(rootViewController: initialViewController)
                         navigationController.navigationBar.isHidden = true
                         initialViewController.isFrormDashboard = 0
                         //navigationController.pushViewController(initialViewController, animated: true)
                         self.window?.rootViewController = navigationController
                         self.window?.makeKeyAndVisible()
                         
                         
                     }else if dic.value(forKey: "notification_type") as! String == "Circular"{
                         
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                         //let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                         let initialViewController = storyboard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                         let navigationController = UINavigationController.init(rootViewController: initialViewController)
                         navigationController.navigationBar.isHidden = true
                         initialViewController.isfrom = 2
                        // navigationController.pushViewController(initialViewController, animated: true)
                         self.window?.rootViewController = navigationController
                         self.window?.makeKeyAndVisible()
                         
                         
                         
                     }else if dic.value(forKey: "notification_type") as! String == "Event"{
                         
                         let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    //let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                                    let initialViewController = storyboard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                         let navigationController = UINavigationController.init(rootViewController: initialViewController)
                         navigationController.navigationBar.isHidden = true
                                    initialViewController.isfrom = 1
                                   // navigationController.pushViewController(initialViewController, animated: true)
                                    self.window?.rootViewController = navigationController
                                   self.window?.makeKeyAndVisible()
                         
                     }
                
                else
                {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "GuestPopVC") as! GuestPopVC
                initialViewController.guestdic = dic
                initialViewController.isfromnotification = 1
                navigationController.pushViewController(initialViewController, animated: true)
                self.window?.rootViewController = navigationController
                self.window?.makeKeyAndVisible()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Acceptnotification"), object: dic)
                }
            }
        
        }
     else
        {
            
             if(UserDefaults.standard.object(forKey:USER_ROLE) != nil)
                           {
                            
                            
                           /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            var rearNavigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                            
                            let frontNavigationController:UINavigationController
                             //  let rearNavigationController:UINavigationController
                               let revealController = SWRevealViewController()
                               var mainRevealController = SWRevealViewController()

                               frontNavigationController =  UINavigationController(rootViewController: TabbarVC())
                               rearNavigationController = UINavigationController(rootViewController: TabbarVC())

                               frontNavigationController.navigationBar.isHidden = true
                               rearNavigationController.navigationBar.isHidden = true

                               revealController.frontViewController = frontNavigationController
                               revealController.rearViewController = rearNavigationController
                               revealController.delegate = self
                               mainRevealController  = revealController

                               window = UIWindow(frame: UIScreen.main.bounds)
                               self.window?.rootViewController = mainRevealController
                               self.window?.makeKeyAndVisible() */
                            
                            // in method
                            
                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                            
                            let navigationController:UINavigationController = storyBoard.instantiateInitialViewController() as! UINavigationController

                                               
                                               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                                               
                                               navigationController.pushViewController(nextViewController, animated: true)
                                               
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                
                            //  26/8/20.

                             /*  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                               let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                            
                            let initialViewController = storyboard.instantiateViewController(withIdentifier: TabbarVC.id()) as! TabbarVC
                            
                          //  let revealController = SWRevealViewController()

                          //  revealController.pushFrontViewController(initialViewController, animated: true)
                            
                              navigationController.pushViewController(initialViewController, animated: true)
                            
                               self.window?.rootViewController = navigationController
                               self.window?.makeKeyAndVisible() */
          
        } //
            else
             {
                
                if(UserDefaults.standard.object(forKey:"launchCount") != nil)
                {
                
                let currentCount = UserDefaults.standard.integer(forKey: "launchCount")

                // increment received number by one
                UserDefaults.standard.set(currentCount+1, forKey:"launchCount")
                    UserDefaults.standard.synchronize()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                   let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                    
                    let initialViewController = storyboard.instantiateViewController(withIdentifier: IntroScreenVC.id()) as! IntroScreenVC
                    
                   navigationController.pushViewController(initialViewController, animated: true)
                   self.window?.rootViewController = navigationController
                   self.window?.makeKeyAndVisible()
                }
                else
                {
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                              let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                    
                           let initialViewController = storyboard.instantiateViewController(withIdentifier: "IntroScreenVC") as! IntroScreenVC

                              navigationController.pushViewController(initialViewController, animated: true)
                              self.window?.rootViewController = navigationController
                              self.window?.makeKeyAndVisible()
                    
    
                                // increment received number by one
                        UserDefaults.standard.set(1, forKey:"launchCount")
                    UserDefaults.standard.synchronize()
                                
                }
                
            }
        }
        // Override point for customization after application launch.
        return true
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //print("APNs token retrieved: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        //   print("Firebase registration token: \(fcmToken)")
        let user = UserDefaults.standard
        user.set(fcmToken,forKey:"FcmToken")
        user.synchronize()
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    @objc func tokenRefreshNotification(notification: NSNotification) {
        // NOTE: It can be nil here
       // let refreshedToken = InstanceID.instanceID().token()
        //  print("InstanceID token: \(String(describing: refreshedToken))")
        
        connectToFcm()
    }
    func connectToFcm() {
//        Messaging.messaging().connect { (error) in
//            if (error != nil) {
//                Messaging.messaging().shouldEstablishDirectChannel = true
//
//                print("Unable to connect with FCM. \(String(describing: error))")
//            } else {
//                print("Connected to FCM.")
//            }
//        }
    }
    
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        print(userInfo as NSDictionary)
//
//        completionHandler(.newData)
//
//
//        let state:UIApplicationState = application.applicationState
//        let dic: NSDictionary = userInfo as NSDictionary
//
//        if(UIApplication.shared.applicationState == .background)
//        {
//       // reDirect(dict: dic)
//         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Acceptnotification"), object: dict)
//
//        }
//
//    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//                print(userInfo as NSDictionary)
//
//                let state:UIApplicationState = application.applicationState
//                let dic: NSDictionary = userInfo as NSDictionary
//
//          if(UIApplication.shared.applicationState == .active && dic.value(forKey:"notification_type") as! String == "security")
//         {
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Acceptnotification"), object: dic)
//             }
//                 if(UIApplication.shared.applicationState == .background)
//                {
//               // reDirect(dict: dic)
//                // NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Acceptnotification"), object: dic)
//
//               }
//
//
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
           print(userInfo as NSDictionary)
        
                  completionHandler(.newData)
                        let state:UIApplicationState = application.applicationState
                        let dic: NSDictionary = userInfo as NSDictionary
        
        
                if(state == .active && dic.value(forKey:"notification_type") as! String == "alert")
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: dic)
                }
               else if(state == .active && dic.value(forKey:"notification_type") as! String == "security")
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Acceptnotification"), object: dic)
                } else if(state == .active && dic.value(forKey:"notification_type") as! String == "SocietyNotice")
                {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Acceptnotification"), object: dic)
                }
                
                
              //  else{
                  //  NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Acceptnotification"), object: dic)
              //  }
            
        
        }
    
    
    
    func reDirect(dict:NSDictionary) {
        
        if dict.value(forKey: "notification_type") as! String == "alert"{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "DeliveryWaitingPopupVC") as! DeliveryWaitingPopupVC
            
            initialViewController.deliverydic = dict
            
            let navigationController = UINavigationController.init(rootViewController: initialViewController)
            navigationController.navigationBar.isHidden = true
            
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
            print("DeliveryWaitingPopupVC")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DeliveryWaiting"), object: dict)
            
        }
        
       else if dict.value(forKey: "notification_type") as! String == "Notice"{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
            //let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let navigationController = UINavigationController.init(rootViewController: initialViewController)
            navigationController.navigationBar.isHidden = true
            initialViewController.isFrormDashboard = 0
            //navigationController.pushViewController(initialViewController, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
            
        }else if dict.value(forKey: "notification_type") as! String == "Circular"{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
            let navigationController = UINavigationController.init(rootViewController: initialViewController)
            navigationController.navigationBar.isHidden = true
            initialViewController.isfrom = 2
           // navigationController.pushViewController(initialViewController, animated: true)
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
            
            
            
        }else if dict.value(forKey: "notification_type") as! String == "Event"{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       //let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
                       let initialViewController = storyboard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
            let navigationController = UINavigationController.init(rootViewController: initialViewController)
            navigationController.navigationBar.isHidden = true
                       initialViewController.isfrom = 1
                      // navigationController.pushViewController(initialViewController, animated: true)
                       self.window?.rootViewController = navigationController
                      self.window?.makeKeyAndVisible()
            
        }
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .badge, .sound])
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //MARK:- Logout API
    
    func ApiLogout(onCompletion: @escaping ((_ response: Int) -> Void))
    {
        
        if(webservices().isConnectedToNetwork())
        {
            
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            print("Bearer token : ",token as! String)
            
            Apicallhandler.sharedInstance.LogoutAPI(URL: webservices().baseurl + API_LOGOUT, token: token  as! String) { [self] response in
                switch(response.result) {
                case .success(let resp):
                    if resp.status == 1{
                        
                     onCompletion(1)
                        
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)

                    }else{
                         print("\(resp.message)")
                        onCompletion(0)
                    }
                    
                    break
                case .failure(let err):
                    self.ApiLogout1()
                    
                    print(err.localizedDescription)
                }
            }
        }
        else
        {
            webservices.sharedInstance.nointernetconnection()
        }
        
    }
    
    func ApiLogout1()//(onCompletion: @escaping ((_ response: Int) -> Void))
    {
        
        if(webservices().isConnectedToNetwork())
        {
            
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
            print("Bearer token : ",token as! String)
            
            Apicallhandler.sharedInstance.LogoutAPI(URL: webservices().baseurl + API_LOGOUT, token: token  as! String) { response in
                switch(response.result) {
                case .success(let resp):
                    if resp.status == 1{
                        
                    // onCompletion(1)
                        
                        UserDefaults.standard.removeObject(forKey:USER_TOKEN)
                        UserDefaults.standard.removeObject(forKey:USER_ID)
                        UserDefaults.standard.removeObject(forKey:USER_SOCIETY_ID)
                        UserDefaults.standard.removeObject(forKey:USER_ROLE)
                        UserDefaults.standard.removeObject(forKey:USER_PHONE)
                        UserDefaults.standard.removeObject(forKey:USER_EMAIL)
                        UserDefaults.standard.removeObject(forKey:USER_NAME)
                        UserDefaults.standard.removeObject(forKey:USER_SECRET)
                        UserDefaults.standard.removeObject(forKey:USER_BUILDING_ID)

                        
                        
                    }else{
                         print("\(resp.message)")
                       // onCompletion(0)
                    }
                    
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
        else
        {
            webservices.sharedInstance.nointernetconnection()
        }
        
    }
    
    
    
    func apicallUpdateNotificationCount(strType:String)
           {
               if(webservices().isConnectedToNetwork())
               {

                 let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                 let param : Parameters = [
                    "type" : strType
                 ]

                //webservices().StartSpinner()
                Apicallhandler.sharedInstance.GetUpdateNotifyCount(URL: webservices().baseurl + API_UPDATE_NOTIFY_COUNT, param: param, token: token as! String) { JSON in

                      print("----->Update Notification Response \(JSON)")
                       let statusCode = JSON.response?.statusCode
                       switch JSON.result{
                       case .success(let resp):
                           webservices().StopSpinner()
                           if statusCode == 200{
                           
                           }
                        break
                       case .failure(let _): break

                       }
                   }

               }
               else
               {
                   webservices.sharedInstance.nointernetconnection()
               }

           }

    func apicallNoticeReminder(strType:String)
           {
               if(webservices().isConnectedToNetwork())
               {
                
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                webservices().StartSpinner()
                Apicallhandler.sharedInstance.APINoticeReminder(URL: webservices().baseurl + strType, token: token as! String) { JSON in

                      print("----->Reminder Notification Response\(JSON)")
                       let statusCode = JSON.response?.statusCode
                       switch JSON.result{
                       case .success(let resp):
                           webservices().StopSpinner()
                           if statusCode == 200{
                           
                            print("successfully Reminder sent")
                            
                            
                           }
                        break
                       case .failure(let _): break

                       }
                   }

               }
               else
               {
                   webservices.sharedInstance.nointernetconnection()
               }

           }
    
    
    func apicallReminder(strType:String,id:String)
           {
               if(webservices().isConnectedToNetwork())
               {
                let token = UserDefaults.standard.value(forKey: USER_TOKEN)
                let societyID = UserDefaults.standard.value(forKey: USER_SOCIETY_ID)
                let strSocietyID = "\(societyID!)"

                 let param : Parameters = [
                    "type" : strType,
                    "id" : id,
                    "society_id":strSocietyID
                 ]

                webservices().StartSpinner()
                Apicallhandler.sharedInstance.APIReminder(URL: webservices().baseurl + API_REMINDER, param: param, token: token as! String) { JSON in

                      print("----->Reminder Notification Response\(JSON)")
                       let statusCode = JSON.response?.statusCode
                       switch JSON.result{
                       case .success(let resp):
                           webservices().StopSpinner()
                           if statusCode == 200{
                           
                            print("successfully Reminder sent")
                            
                            
                           }
                        break
                       case .failure(let _): break

                       }
                   }

               }
               else
               {
                   webservices.sharedInstance.nointernetconnection()
               }

           }

    
}

