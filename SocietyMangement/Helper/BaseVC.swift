//
//  KonnectBaseViewC.swift
//  Konnect
//
//  Created by MacBook 1 on 19/11/19.
//  Copyright © 2019 Honey Patel. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
class BaseVC: UIViewController {
  
  //MARK:- --------------View Controller Life Cycle-------------- -
  override func viewDidLoad() {
    
    super.viewDidLoad()
  }
  
  //  override var preferredStatusBarStyle: UIStatusBarStyle {
  //    return .lightContent
  //  }
  
  //MARK:- --------------UIAlertController-------------- -
  func showOkAlert(withMessage message: String) {
    
    let alert = UIAlertController.didShowOkAlert(withMessage: message)
    present(alert, animated: true, completion: nil)
  }
  
  func showOkAlert(withMessage message: String, andHandler handler:@escaping () -> Void) {
    
    let alert = UIAlertController.didShowOkAlert(withCancelVisibility: false, alertMessage: message) {
      return handler()
    }
    present(alert, animated: true, completion: nil)
  }
  
  func showOkAndCancelAlert(withMessage message: String, andHandler handler:@escaping () -> Void) {
    
    let alert = UIAlertController.didShowOkAlert(withCancelVisibility: true, alertMessage: message) {
      return handler()
    }
    present(alert, animated: true, completion: nil)
  }
  
  func showTextFieldAlert(withMessage message: String, placeholderText placeholder: String, textFieldText text: String, andHandler handler:@escaping (_ string: String) -> Void) {
    
    let alert = UIAlertController.didShowTextFieldAlert(withMessage: message, placeholderText: placeholder, textFieldText: text) { (_ string: String) in
      return handler(string)
    }
    present(alert, animated: true, completion: nil)
  }
  
  func showActionSheetStyleAlert(withTitle title: String?, withAlertMessage message: String?, selectionOptions options: [String], handler:@escaping (_ selectedIndex: Int) -> Void) {
    
    let alert = UIAlertController.didShowActionSheetStyleAlert(withTitle: title, alertMessage: message, selectionOptions: options) { (_ selectedIndex: Int) in
      return handler(selectedIndex)
    }
    present(alert, animated: true, completion: nil)
  }
  
  func pushViewController(withName name: String, fromStoryboard storyboard: String) -> UIViewController {
    
    let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: name)
    self.navigationController?.pushViewController(viewController, animated: true)
    return viewController
  }
  
  func presentViewController(withName name: String, fromStoryboard storyboard: String) -> UIViewController {
    
    let storyboard = UIStoryboard.init(name: storyboard, bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: name)
    self.present(viewController, animated: true, completion: nil)
    return viewController
  }
    
    

    func isConnectedToNetwork() -> Bool {
           
           var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
           zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
           zeroAddress.sin_family = sa_family_t(AF_INET)
           
           let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
               $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                   SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
               }
           }
           
           var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
           if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
               return false
           }
           
           /* Only Working for WIFI
            let isReachable = flags == .reachable
            let needsConnection = flags == .connectionRequired
            
            return isReachable && !needsConnection
            */
           
           // Working for Cellular and WIFI
           let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
           let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
           let ret = (isReachable && !needsConnection)
           
           return ret
           
       }
}
