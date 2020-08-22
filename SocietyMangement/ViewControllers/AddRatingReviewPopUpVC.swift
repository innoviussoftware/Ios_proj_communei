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
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var lbltotalRatings: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var txtViewComment: UITextView!
    
    var dictData : AddRatingReviewData!
    
    var helperId : Int!
    var strRatings = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
         ratingView.delegate = self
         ratingView.contentMode = UIView.ContentMode.scaleAspectFit
         ratingView.type = .halfRatings
        
        txtViewComment.layer.borderWidth = 1
        txtViewComment.layer.borderColor = AppColor.ratingBorderColor.cgColor // #828EA5

        txtViewComment.text = "Write comments"
        txtViewComment.textColor = UIColor.lightGray
        txtViewComment.layer.cornerRadius = 10.0
        
                
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        
    }

    @IBAction func actionSubmit(_ sender: Any) {
        if strRatings == ""{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please give your rating")
            self.present(alert, animated: true, completion: nil)
        }else if !txtViewComment.hasText{
            let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"Please write your comment")
            self.present(alert, animated: true, completion: nil)
        }else{
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
            let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
            
            
            let strHelperId = "\(helperId!)"
            let param : Parameters = [
                "helper_id" : strHelperId,
                "ratings" : strRatings,
                "comment" : txtViewComment.text!
            ]
          
            webservices().StartSpinner()
            Apicallhandler().APIAddReview(URL: webservices().baseurl + API_ADD_RATINGS_REVIEW, token:token as! String, params:param) { JSON in
                switch JSON.result{
                case .success(let resp):
                    webservices().StopSpinner()
                    if(JSON.response?.statusCode == 200)
                    {
                        
                        self.dictData = resp.data
                        
                        self.ratingView.rating = 0.0
                        self.txtViewComment.text = ""
                        
                                                // create the alert
                        let alert = UIAlertController(title: Alert_Titel, message: resp.message , preferredStyle: UIAlertController.Style.alert)
                                                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alert in
                                                    self.dismiss(animated: true, completion: nil)
                                                }))
                                                // show the alert
                                                self.present(alert, animated: true, completion: nil)
                    }
                    else
                    {
                        let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    webservices().StopSpinner()
                    if JSON.response?.statusCode == 401{
                        APPDELEGATE.ApiLogout(onCompletion: { int in
                            if int == 1{
                               let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                                                           let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                           let navController = UINavigationController(rootViewController: aVC)
                                                                           navController.isNavigationBarHidden = true
                                                              self.appDelegate.window!.rootViewController  = navController
                                                              
                            }
                        })
                        
                        return
                    }
                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError as Any as Any)
                    
                }
            }
    
        
    }
    
}



@available(iOS 13.0, *)
extension AddRatingReviewPopUpVC: FloatRatingViewDelegate {

    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
        strRatings = String(format: "%.1f", self.ratingView.rating)
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        strRatings = String(format: "%.1f", self.ratingView.rating)
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
            textView.text = "Write comments"
            textView.textColor = UIColor.lightGray
        }
    }
    
}
