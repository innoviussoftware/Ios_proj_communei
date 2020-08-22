//
//  TabbarVC.swift
//  SocietyMangement
//
//  Created by innoviussoftware on 16/07/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class TabbarVC: UITabBarController, UITabBarControllerDelegate {
    
   /* var homeViewController: NewHomeVC!
    var secondViewController: ActivityTabVC!
    var actionViewController: QuickActionVC!
    var thirdViewController: MyUnitVC!
    var fourthViewController: CommunityVC! */

   // @available(iOS 13.0, *)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self


        // Do any additional setup after loading the view.
        
      //  self.tabBarItem.items[2].enabled = false
        
         // let items = tabBarController?.tabBar.items
               //items.forEach { $2.isEnabled = false }
         // items![2].isEnabled = false
        
       /* if let items = tabBar.items {
          if items.count > 0 {
            let itemToDisable = items[items.count - 3]
           // itemToDisable.isEnabled = false
            itemToDisable.accessibilityRespondsToUserInteraction = false
          }
        } */
        

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
    

    // UITabBarControllerDelegate
    
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

      /*  let storyboard = UIStoryboard(name: "Main", bundle: nil)

           let firstViewController = NewHomeVC()
           let navigationController = UINavigationController(rootViewController: firstViewController)
          viewControllers = [navigationController] */

           
      /*  if tabBarIndex == 0 {
            
            if viewController.isKind(of: NewHomeVC.self) {
                let vc =  NewHomeVC()
             //   vc.modalPresentationStyle = .overFullScreen
             //   self.present(vc, animated: true, completion: nil)
                
                self.navigationController?.pushViewController(vc, animated: true)

            }
                
          //  let vc = self.storyboard?.instantiateViewController(withIdentifier: NewHomeVC.id()) as! NewHomeVC
          //  self.navigationController?.pushViewController(vc, animated: true)
            print("Selected view controller 0")
        }else if tabBarIndex == 1 {
            
            if viewController.isKind(of: ActivityTabVC.self) {
                      let vc =  ActivityTabVC()
                   //   vc.modalPresentationStyle = .overFullScreen
                   //   self.present(vc, animated: true, completion: nil)
                      
                      self.navigationController?.pushViewController(vc, animated: true)

                  }
            
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: ActivityTabVC.id()) as! ActivityTabVC
          //  self.navigationController?.pushViewController(vc, animated: true)
            print("Selected view controller 1")
        }else if tabBarIndex == 2 {
            
            if viewController.isKind(of: QuickActionVC.self) {
                             let vc =  QuickActionVC()
                          //   vc.modalPresentationStyle = .overFullScreen
                          //   self.present(vc, animated: true, completion: nil)
                             
                             self.navigationController?.pushViewController(vc, animated: true)

                         }
         //   let vc = self.storyboard?.instantiateViewController(withIdentifier: QuickActionVC.id()) as! QuickActionVC
         //   self.navigationController?.pushViewController(vc, animated: true)
            print("Selected view controller 2")
        }else if tabBarIndex == 3 {
            
            if viewController.isKind(of: MyUnitVC.self) {
                    let vc =  MyUnitVC()
                                     //   vc.modalPresentationStyle = .overFullScreen
                                     //   self.present(vc, animated: true, completion: nil)
                                        
                    self.navigationController?.pushViewController(vc, animated: true)

                }
            
           // let vc = self.storyboard?.instantiateViewController(withIdentifier: MyUnitVC.id()) as! MyUnitVC
          //  self.navigationController?.pushViewController(vc, animated: true)
            print("Selected view controller 3")
        }else if tabBarIndex == 4 {
            
            if viewController.isKind(of: CommunityVC.self) {
                               let vc =  CommunityVC()
                                                //   vc.modalPresentationStyle = .overFullScreen
                                                //   self.present(vc, animated: true, completion: nil)
                                                   
                               self.navigationController?.pushViewController(vc, animated: true)

                           }
          //  let vc = self.storyboard?.instantiateViewController(withIdentifier: CommunityVC.id()) as! CommunityVC
          //  self.navigationController?.pushViewController(vc, animated: true)
            print("Selected view controller 4")
        }


    } */

  
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
