//
//  AddRatingReviewPopUpVC.swift
//  SocietyMangement
//
//  Created by MacMini on 02/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import FloatRatingView
import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AddRatingReviewPopUpVC: UIViewController {
    @IBOutlet weak var bgView: UIView!
    
   // @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var ratingViewPunctual: FloatRatingView!
    @IBOutlet weak var ratingViewRegular: FloatRatingView!
    @IBOutlet weak var ratingViewClean: FloatRatingView!
    @IBOutlet weak var ratingViewAttitude: FloatRatingView!
    @IBOutlet weak var ratingViewSkilled: FloatRatingView!

    
    @IBOutlet weak var lbltotalRatings: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtViewComment: UITextView!
    
    var dictData : AddRatingReviewData!
    
    var dailyHelperID : Int!
    
    var VendorServiceTypeID = ""
    
    var dailyHelpPropertyID = ""
    
    var strRatingsPunctual : Int!
    var strRatingsRegular : Int!
    var strRatingsClean : Int!
    var strRatingsAttitude : Int!
    var strRatingsSkilled : Int!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        ratingViewPunctual.delegate = self
        ratingViewPunctual.contentMode = UIView.ContentMode.scaleAspectFit
        ratingViewPunctual.type = .halfRatings
        
        ratingViewRegular.delegate = self
        ratingViewRegular.contentMode = UIView.ContentMode.scaleAspectFit
        ratingViewRegular.type = .halfRatings
        
        ratingViewClean.delegate = self
        ratingViewClean.contentMode = UIView.ContentMode.scaleAspectFit
        ratingViewClean.type = .halfRatings
        
        ratingViewAttitude.delegate = self
        ratingViewAttitude.contentMode = UIView.ContentMode.scaleAspectFit
        ratingViewAttitude.type = .halfRatings
        
        ratingViewSkilled.delegate = self
        ratingViewSkilled.contentMode = UIView.ContentMode.scaleAspectFit
        ratingViewSkilled.type = .halfRatings
        
         strRatingsPunctual = 3
         strRatingsRegular = 3
         strRatingsClean = 3
         strRatingsAttitude = 3
         strRatingsSkilled = 3
        
        txtViewComment.layer.borderWidth = 1
        txtViewComment.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5

       // txtViewComment.text = "Write comments"
        txtViewComment.textColor = UIColor.lightGray
        txtViewComment.layer.cornerRadius = 10.0
        
                
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        
    }
    
    // MARK: - get Maid Helper List
       
       func apicallHelperDetails()
       {
        
         if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
             
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                
            webservices().StartSpinner()
        
        Apicallhandler().GetHelperDetail(URL: webservices().baseurl + API_HELPER_DETAIL, helperID:"\(dailyHelperID!)",token:token  as! String) { [self] JSON in
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if(JSON.response?.statusCode == 200)
                       {
                            print("-----Helper Detail\(JSON)")
                        
                           // self.dictHelperData = resp.data
                        
                       }
                    
                       else if(JSON.response?.statusCode == 401)
                       {
                           APPDELEGATE.ApiLogout(onCompletion: { int in
                               if int == 1{
                                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                 let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                              let navController = UINavigationController(rootViewController: aVC)
                                                                              navController.isNavigationBarHidden = true
                                                                 self.appDelegate.window!.rootViewController  = navController
                                                                 
                               }
                           })
                           
                           
                       }
                        
                       print(resp)
                   case .failure(let err):
                       webservices().StopSpinner()
                       if JSON.response?.statusCode == 401{
                           APPDELEGATE.ApiLogout1() // (onCompletion: { int in
                             // if int == 1{
                                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                              let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                              let navController = UINavigationController(rootViewController: aVC)
                                                                              navController.isNavigationBarHidden = true
                                                                 self.appDelegate.window!.rootViewController  = navController
                                                                 
                             //  }
                         //  })
                           
                           return
                       }
                       let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                       self.present(alert, animated: true, completion: nil)
                       print(err.asAFError!)
                       
                   }
               }
          
       }

    @IBAction func actionSubmit(_ sender: Any) {
       /* if strRatings == ""{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please give your rating")
            self.present(alert, animated: true, completion: nil)
        }else */ if txtViewComment.text == "" {
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please write your comment")
            self.present(alert, animated: true, completion: nil)
        }
        else{
            apicallAddRatings()
        }
    }
    
    @IBAction func btnclosePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - get Add Ratings
    func apicallAddRatings()
    {
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
        
            let token = UserDefaults.standard.value(forKey: USER_TOKEN)
            
          //  let strHelperId = "\(dailyHelperID!)"
        
        let vendor = (VendorServiceTypeID as NSString).integerValue
        let dailyHelp = (dailyHelpPropertyID as NSString).integerValue

            let param : Parameters = [
                "DailyHelperID" : dailyHelperID!,
                "VendorServiceTypeID" : vendor,
                "DailyHelpPropertyID" : dailyHelp,
                "Punctual" : strRatingsPunctual!,
                "Regular" : strRatingsRegular!,
                "Clean" : strRatingsClean!,
                "Attitude" : strRatingsAttitude!,
                "Skilled" : strRatingsSkilled!,
                "Comments" : txtViewComment.text!
            ]
        
        print("param review : ",param)
          
            webservices().StartSpinner()
            Apicallhandler().APIAddReview(URL: webservices().baseurl + API_ADD_RATINGS_REVIEW, token:token as! String, params:param) { JSON in
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        
                      //  self.dictData = (resp as AnyObject).data
                        
                      /*  self.ratingViewPunctual.rating = 3.0
                        self.ratingViewRegular.rating = 3.0
                        self.ratingViewClean.rating = 3.0
                        self.ratingViewAttitude.rating = 3.0
                        self.ratingViewSkilled.rating = 3.0 */

                        self.txtViewComment.text = ""
                        
                                                // create the alert
                        let alert = UIAlertController(title: Alert_Titel, message: "Review added successfully" , preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                                    
                                                    self.apicallHelperDetails()

                                                    self.dismiss(animated: true, completion: nil)
                                                }))
                                                // show the alert
                                                self.present(alert, animated: true, completion: nil)
                    }
                    
                    else if(JSON.response?.statusCode == 401)
                    {
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                                 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                              let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                            }
                        })
                        
                        
                    }
                    else
                    {
                        
                    }
                    
                    print(resp)
                case .failure(let err):
                    webservices().StopSpinner()
                    if JSON.response?.statusCode == 401{
                        APPDELEGATE.ApiLogout1() // (onCompletion: { int in
                           // if int == 1{
                               let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                         //   }
                      //  })
                        
                        return
                    }
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)
                    
                }
            }
    
        
    }
    
}



@available(iOS 13.0, *)
extension AddRatingReviewPopUpVC: FloatRatingViewDelegate {

    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        strRatingsPunctual =  Int(self.ratingViewPunctual.rating)
        strRatingsRegular =  Int(self.ratingViewRegular.rating)
        strRatingsClean = Int(self.ratingViewClean.rating)
        strRatingsAttitude =  Int(self.ratingViewAttitude.rating)
        strRatingsSkilled = Int(self.ratingViewSkilled.rating)

    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        strRatingsPunctual = Int(self.ratingViewPunctual.rating)
        strRatingsRegular =  Int(self.ratingViewRegular.rating)
        strRatingsClean =  Int(self.ratingViewClean.rating)
        strRatingsAttitude =  Int(self.ratingViewAttitude.rating)
        strRatingsSkilled =  Int(self.ratingViewSkilled.rating)
    }
    
}



@available(iOS 13.0, *)
extension AddRatingReviewPopUpVC : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
           // textView.text = "Write comments"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
