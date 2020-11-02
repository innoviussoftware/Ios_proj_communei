//
//  TabbarVC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 16/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

import SWRevealViewController

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class TabbarVC: UITabBarController, UITabBarControllerDelegate {
    
   /* var homeViewController: NewHomeVC!
    var secondViewController: ActivityTabVC!
    var actionViewController: QuickActionVC!
    var thirdViewController: MyUnitVC!
    var fourthViewController: CommunityVC! */
    var selectedtabindex :Int = 0
    
    var isfrom = 1

   // @available(iOS 13.0, *)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = selectedtabindex
               
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // You can replace the UINavigationController with your Setting's Navigation Controller class.
        if (viewController is UINavigationController) {
            let nav = viewController as? UINavigationController
            nav?.popToRootViewController(animated: false)
        }

        return true
    }
    
    
    // UITabBarDelegate
    
    /* func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print("Selected item")
        
        let tabBarIndex = tabBarController!.selectedIndex
        if tabBarIndex == 0 {
            //do your stuff
            print("Selected item 0")
        }else if tabBarIndex == 1 {
            print("Selected item 1")
        }else if tabBarIndex == 2 {
            print("Selected item 2")
        }
    } */
    

    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
        let tabBarIndex = tabBarController.selectedIndex
        
        print("Selected tabBarIndex : ",tabBarIndex)
        
        let rootView = self.viewControllers![self.selectedIndex] as! UINavigationController
        
        rootView.popViewController(animated: false)
        
      //  rootView.popToRootViewController(animated: false)
        
     //   navigationController?.popToRootViewController(animated: true)


        if tabBarIndex == 0 {
            
          /*  let navigationController:UINavigationController = self.storyboard?.instantiateInitialViewController() as! UINavigationController
            let initialViewController = self.storyboard?.instantiateViewController(withIdentifier: NewHomeVC.id()) as! NewHomeVC
            navigationController.pushViewController(initialViewController, animated: true)
            appDelegate.window?.rootViewController = navigationController
            appDelegate.window?.makeKeyAndVisible() */
            
            if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as? NewHomeVC {
                
                   let navgitaionCon = UINavigationController(rootViewController: homeViewController)
                
               // revealViewController()?.pushFrontViewController(navgitaionCon, animated: true)

                  navgitaionCon.popViewController(animated: true)

                 //  self.navigationController?.pushViewController(navgitaionCon, animated: true)

               }
            
        }else if tabBarIndex == 1 {
            if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "ActivityTabVC") as? ActivityTabVC {

                let navgitaionCon = UINavigationController(rootViewController: homeViewController)
                
                navgitaionCon.popViewController(animated: true)
              //  self.navigationController?.pushViewController(navgitaionCon, animated: true)

            }
        }else if tabBarIndex == 2 {
            if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuickActionVC") as? QuickActionVC {

                let navgitaionCon = UINavigationController(rootViewController: homeViewController)
                navgitaionCon.popViewController(animated: true)

              // self.navigationController?.pushViewController(navgitaionCon, animated: true)

            }
        }else if tabBarIndex == 3 {
            if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyUnitVC") as? MyUnitVC {

                let navgitaionCon = UINavigationController(rootViewController: homeViewController)
                navgitaionCon.popViewController(animated: true)

               // self.navigationController?.pushViewController(navgitaionCon, animated: true)

            }
        }else if tabBarIndex == 4 {
            if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommunityVC") as? CommunityVC {

                let navgitaionCon = UINavigationController(rootViewController: homeViewController)
                navgitaionCon.popViewController(animated: true)

               // self.navigationController?.pushViewController(navgitaionCon, animated: true)
            }
        }

    }

  /*  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
     // if viewController.isKind(of: QuickActionVC.self) {
         let vc =  QuickActionVC()
       //  vc.modalPresentationStyle = .overFullScreen
        // self.present(vc, animated: true, completion: nil)
         self.navigationController?.pushViewController(vc, animated: true)

      //   return false
     // }
      return true
    } */

}
