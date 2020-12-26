//
//  webservices.swift
//  Walltones
//
//  Created by Ravi Dubey on 7/4/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import SystemConfiguration
import PKHUD
import ContactsUI
import Foundation
import Alamofire
import IHProgressHUD
class webservices: NSObject {

    
 // Mark : Live base url

  // var baseurl =  "http://18.190.94.153/api/"
  // var imgurl = "http://18.190.94.153/storage/app/"
   var BuySellImgUrl = "http://18.190.94.153/storage/app/icons/"
    
   
    // Mark : Communei Live base url
    
    //var baseurl =  "http://65.0.14.211/public/api/"
    // var imgurl = "http://65.0.14.211/storage/app/"

    
 // var baseurl =  "https://api.communei.com/api/"
    
    var baseurl =  "https://dev.communei.net/api/"
    
 //  var imgurl = "https://api.communei.com/storage/app/icons/"
    
    

    // Mark : Local base url
   // var baseurl =  "http://3.15.184.91/api/"
    //let imgurl = "http://3.15.184.91/storage/app/"
   // var BuySellImgUrl = "http://3.15.184.91/storage/app/icons/"
    
 
    // Mark : Client base url
   // val baseurl = "http://13.234.110.224/api/"
   // var imgurl = "http://13.234.110.224/storage/app/"
   // var BuySellImgUrl = "http://13.234.110.224/storage/app/icons/"


    
    static let sharedInstance : webservices = {
        let instance = webservices()
        return instance
    }()
    func nointernetconnection()
    {
        let button2Alert: UIAlertView = UIAlertView(title: nil, message: NSLocalizedString("Please check your internet connection", comment: ""),delegate: nil, cancelButtonTitle: NSLocalizedString("OK", comment: ""))
        button2Alert.show()
        
        
    }
    func AlertBuilder(title:String, message: String) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        return alert
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
    
    func setShadow(view: UIView)
    {
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        view.layer.shadowRadius = 4
    }
    
    func shadow(yourView: UIView) {
        yourView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.16).cgColor
        yourView.layer.shadowOpacity = 1
        yourView.layer.shadowOffset = .zero
        yourView.layer.shadowRadius = 10
    }
    
    func circularimage(imageview:UIImageView)
    {
        imageview.layer.masksToBounds = false
        imageview.layer.cornerRadius = imageview.frame.size.height/2
        imageview.clipsToBounds = true
        
    }
    
    func PaddingTextfiled(textfield:UITextField)
    {
        textfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textfield.frame.height))
        textfield.leftViewMode = .always
    }
    
      func StartSpinner() {
         if var topController = UIApplication.shared.keyWindow?.rootViewController {
             while let presentedViewController = topController.presentedViewController {
                 topController = presentedViewController
                 IHProgressHUD.set(viewForExtension:topController.view)

             }

             // topController should now be your topmost view controller
         }
        IHProgressHUD.set(defaultMaskType: .gradient)
         IHProgressHUD.set(defaultStyle: .light)
         IHProgressHUD.show()
     }

     func StopSpinner() {
         IHProgressHUD.dismiss()
     }

    func isValidated(_ password: String) -> Bool {
        var lowerCaseLetter: Bool = false
        var upperCaseLetter: Bool = false
        var digit: Bool = false
        var specialCharacter: Bool = false
        
        if password.characters.count  >= 8 {
            for char in password.unicodeScalars {
                if !lowerCaseLetter {
                    lowerCaseLetter = CharacterSet.lowercaseLetters.contains(char)
                }
                if !upperCaseLetter {
                    upperCaseLetter = CharacterSet.uppercaseLetters.contains(char)
                }
                if !digit {
                    digit = CharacterSet.decimalDigits.contains(char)
                }
                if !specialCharacter {
                    specialCharacter = CharacterSet.punctuationCharacters.contains(char)
                }
            }
            if specialCharacter || (digit && lowerCaseLetter && upperCaseLetter) {
                //do what u want
                return true
            }
            else {
                return false
            }
        }
        return false
    }
    
    func strChangeDateFormates(strDateeee:String) -> String {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd-MM-yyyy"
           let strDate = formatter.date(from: strDateeee)
           var str = ""
           if strDate != nil{
               formatter.dateFormat = "yyyy-MM-dd"
               str = formatter.string(from: strDate!)
           }else{
               str = strDateeee
           }
           
           
           return str
       }
}
struct AppColor {
    
    private struct Alphas {
        static let Opaque = CGFloat(1)
        static let SemiOpaque = CGFloat(0.8)
        static let SemiTransparent = CGFloat(0.5)
        static let Transparent = CGFloat(0.3)
    }
    
    static let appPrimaryColor =  UIColor.white.withAlphaComponent(Alphas.SemiOpaque)
    static let appSecondaryColor =  UIColor.blue.withAlphaComponent(Alphas.Opaque)
    static let graycolor =  UIColor.darkGray
    static let appcolor =  UIColor(red:0.12, green:0.49, blue:0.71, alpha:1.0)
    static let lightgray =  UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)

    static let txtbgColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)

    static let orangeColor = UIColor(red: 249.0/255.0, green: 164.0/255.0, blue: 49.0/255.0, alpha: 1)
    
    static let borderColor = UIColor(red: 242.0/255.0, green: 97.0/255.0, blue: 1.0/255.0, alpha: 1)
    
    static let cancelColor = UIColor(red: 187.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1)

    
    static let introlineColor = UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1)
    
    static let radioUncheckColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1)

    static let lineSingleColor = UIColor(red: 130.0/255.0, green: 142.0/255.0, blue: 165.0/255.0, alpha: 1.0)

    
    static let lblFilterSelect =  UIColor(red: 26.0/255.0, green: 54.0/255.0, blue: 82.0/255.0, alpha: 1)
    
    static let lblFilterUnselect =  UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 170.0/255.0, alpha: 1)

    static let pollborder =  UIColor(red: 247.0/255.0, green: 251.0/255.0, blue: 253.0/255.0, alpha: 1)
    
    static let pollborderSelect =  UIColor(red: 69.0/255.0, green: 191.0/255.0, blue: 85.0/255.0, alpha: 1)

    static let deniedColor =  UIColor(red: 246.0/255.0, green: 10.0/255.0, blue: 32.0/255.0, alpha: 1)


    // 828EA5
    static let ratingBorderColor = UIColor(red: 130.0/255.0, green: 142.0/255.0, blue: 165.0/255.0, alpha: 1)

    


    struct TextColors {
        static let Error = AppColor.appSecondaryColor
        static let Success = UIColor(red: 0.1303, green: 0.9915, blue: 0.0233, alpha: Alphas.Opaque)
    }
    
    struct TabBarColors{
        static let Selected = UIColor.white
        static let NotSelected = UIColor.black
    }
    
    struct OverlayColor {
        static let SemiTransparentBlack = UIColor.black.withAlphaComponent(Alphas.Transparent)
        static let SemiOpaque = UIColor.black.withAlphaComponent(Alphas.SemiOpaque)
        static let demoOverlay = UIColor.black.withAlphaComponent(0.6)
    }
}

class PaddingLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 5.0
    @IBInspectable var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

extension UIView {
    func fadeIn(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func fadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}
extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

extension UIViewController {

func ShowNoInternetAlert() {
    
    if isNointernetVCShown {
        return
    }
    
    let objVC = storyboard?.instantiateViewController(withIdentifier: "NoInternetVC") as! NoInternetVC
    isNointernetVCShown = true
    self.addChildViewController(objVC)
    self.view.addSubview(objVC.view)
    let height = self.view.bounds.height
    objVC.view.frame = CGRect(x: 0, y: height, width: self.view.bounds.width, height: height)
    
    UIView.animate(withDuration: 0.4, animations: {
        objVC.view.frame = self.view.bounds
    })
}
}


struct NetworkState {
    
    var isInternetAvailable:Bool
    {
//        return NetworkReachabilityManager(host: "https://www.google.com")!.isReachable
        return NetworkReachabilityManager()!.isReachable
    }
}

@available(iOS 13.0, *)
@available(iOS 13.0, *)
extension UIViewController {
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension String {
  
  // MARK:- ----------------Instance Methods----------
  // To Check Whether Email is valid
  func isEmail() -> Bool {
    
    let emailRegex: String = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
    let emailText = NSPredicate(format: "SELF MATCHES %@",emailRegex)
    return emailText.evaluate(with: self)
  }
  
  // To Check Whether String is valid or not
  func isValid() -> Bool {
    
    if self == "<null>" || self == "(null)"
    {
      return false
    }
    return true
  }
  
  // To Check Whether Name is valid
  func isName() -> Bool {
    
    let nameRegex = "[A-Za-z]{2,40}"
    let nameText  = NSPredicate(format:"SELF MATCHES %@", nameRegex)
    return nameText.evaluate(with: self)
  }
  
  // To Check Whether Phone Number is valid
  func isPhoneNumber() -> Bool {
    
    if self.isEmpty() {
      return false
    }
    let phoneRegex: String = "^\\d{3,10}$"
    let phoneText = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return phoneText.evaluate(with: self)
  }
  
  // To Check Whether URL is valid
  func isURL() -> Bool {
    
    let urlRegex: String = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    let urlText = NSPredicate(format: "SELF MATCHES %@", urlRegex)
    let isValid = urlText.evaluate(with: self) as Bool
    return isValid
  }
  
  // To Check Whether Image URL is valid
  func isImageURL() -> Bool {
    
    if self.isURL() {
      
      if self.range(of: ".png") != nil || self.range(of: ".jpg") != nil || self.range(of: ".jpeg") != nil {
        
        return true
      }
    }
    return false
  }
  
  // To get length of String
  func length() -> Int {
    
    return self.stringByTrimmingWhiteSpaceAndNewLine().count
  }
  
  // To Check Whether String is empty
  func isEmpty() -> Bool {
    
    return self.stringByTrimmingWhiteSpace().count == 0 ? true : false
  }
  
  // Get string by removing White Space & New Line
  func stringByTrimmingWhiteSpaceAndNewLine() -> String {
    
    return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
  }
  
  // Get string by removing White Space
  func stringByTrimmingWhiteSpace() -> String {
    
    return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
  }
  
  // Remove Substring from a string
  mutating func removeSubString(subString: String) -> String {
    
    if self.contains(subString) {
      guard let stringRange = self.range(of: subString) else { return self }
      return self.replacingCharacters(in: stringRange, with: "")
    }
    return self
  }
  
  //TODO:- ----------------This function is incomplete----------------
  // Get Substring between a range
  func getSubStringFrom(begin: NSInteger, to end: NSInteger) -> String {
    
    //var strRange = begin..<end
    //let str = self.substringWithRange(strRange)
    return ""
  }
  
  //MARK:- ----------------Static Methods----------
  static func getString(_ message: Any?) -> String {
    
    guard let strMessage = message as? String else {
      guard let doubleValue = message as? Double else {
        guard let intValue = message as? Int else {
          guard let int64Value = message as? Int64 else {
            return ""
          }
          return String(int64Value)
        }
        return String(intValue)
      }
      
      let formatter = NumberFormatter()
      formatter.minimumFractionDigits = 0
      formatter.maximumFractionDigits = 1
      formatter.minimumIntegerDigits = 1
      guard let formattedNumber = formatter.string(from: NSNumber(value: doubleValue)) else {
        return ""
      }
      return formattedNumber
    }
    return strMessage.stringByTrimmingWhiteSpaceAndNewLine()
  }
  
  /*
   // To check whether String contains Only Letters
   func stringContainsOnlyLetters() -> Bool
   {
   let characterSet = NSCharacterSet.letterCharacterSet()
   return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
   }
   
   // To check whether String contains Only Numbers
   func stringContainsOnlyNumbers() -> Bool
   {
   let characterSet = NSCharacterSet.decimalDigitCharacterSet()
   return self.rangeOfCharacterFromSet(characterSet) != nil ? true : false
   }
   */
  

}

extension UIViewController {
  
  static func id() -> String {
    
    return String(describing: self)
  }
  
  static func segueIdentifier() -> String {
    
    return "show" + String(describing: self)
  }
}
extension UIAlertController {
  
  static func didShowOkAlert(withMessage message: String) -> UIAlertController {
    
    let alert = UIAlertController(title: GeneralConstants.kAppName, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: AlertConstants.OK, style: .cancel, handler: nil)
    alert.addAction(okAction)
    return alert
  }
  
  static func didShowOkAlert(withCancelVisibility isVisible: Bool, alertMessage message: String, andHandler handler:@escaping () -> Void) -> UIAlertController {
    
    let alert = UIAlertController(title: GeneralConstants.kAppName, message: message, preferredStyle: .alert)
    let okAction =  UIAlertAction(title: AlertConstants.OK, style: .default) { (action) -> Void in
      return handler()
    }
    alert.addAction(okAction)
    
    if isVisible {
      let cancelAction = UIAlertAction(title: AlertConstants.CANCEL, style: .cancel) { (action) -> Void in }
      alert.addAction(cancelAction)
    }
    
    return alert
  }
  
  static func didShowTextFieldAlert(withMessage strMessage: String, placeholderText placeholder: String, textFieldText text: String, andHandler handler:@escaping (_ text: String) -> Void) -> UIAlertController {
    
    let alert = UIAlertController(title: GeneralConstants.kAppName, message: strMessage, preferredStyle: .alert)
    alert.addTextField { (textField: UITextField) in
      textField.placeholder = placeholder
      textField.text = text
    }
    let okAction =  UIAlertAction(title: AlertConstants.SUBMIT, style: .default) { (action) -> Void in
      guard let textField = alert.textFields?.first else { return }
      return handler(String.getString(textField.text))
    }
    let cancelAction = UIAlertAction(title: AlertConstants.CANCEL, style: .cancel) { (action) -> Void in }
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    return alert
  }
  
  static func didShowActionSheetStyleAlert(withTitle title: String?, alertMessage message: String?, selectionOptions options: [String], handler:@escaping (_ selectedIndex: Int) -> Void) -> UIAlertController {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
    for option in options {
      
      let anyAction =  UIAlertAction(title: option, style: .default) { (action) -> Void in
        guard let selectedIndex = options.firstIndex(of: option) else { return handler(-1) }
        return handler(selectedIndex)
      }
      alert.addAction(anyAction)
    }
    
    let cancelAction = UIAlertAction(title:AlertConstants.CANCEL, style: .cancel) { (action) -> Void in
    }
    
    alert.addAction(cancelAction)
    return alert
  }
}
