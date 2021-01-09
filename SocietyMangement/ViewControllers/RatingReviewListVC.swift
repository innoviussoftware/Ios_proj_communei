//
//  RatingReviewListVC.swift
//  SocietyMangement
//
//  Created by Innovius on 30/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import FloatRatingView

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class RatingReviewListVC: UIViewController {
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var lblavgRating: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var arrRatingReview = [Comment]()
    var avgRating = "" // : Double!
    var selectedIndex : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        tblView.register(UINib(nibName: "RatingReviewCell", bundle: nil), forCellReuseIdentifier: "RatingReviewCell")
        
        ratingView.isUserInteractionEnabled = false
        ratingView.type = .halfRatings
        
        let rating = Double(self.avgRating)
        ratingView.rating = rating!
       // ratingView.rating = avgRating
        lblavgRating.text =  String(format: "%.1f", rating!)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector:  #selector(AcceptRequest), name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
           NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Acceptnotification"), object: nil)
           
       }
    
    @IBAction func actionNotification(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        nextViewController.isfrom = 0

        self.navigationController?.pushViewController(nextViewController, animated: true)
                
    }
       
       @objc func AcceptRequest(notification: NSNotification) {
           
           let object = notification.object as! NSDictionary
           
           if let key = object.object(forKey: "notification_type")
           {
               let value = object.value(forKey: "notification_type") as! String
               
               if(value == "security")
               {
                   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   
                   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "GuestPopVC") as! GuestPopVC
                   nextViewController.guestdic = object
                   nextViewController.isfromnotification = 0
                   navigationController?.pushViewController(nextViewController, animated: true)
               }
                else if object.value(forKey: "notification_type") as! String == "Notice"{
                                     
                                                
                                            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                                 
                                                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NoticeVC") as! NoticeVC
                                                 nextViewController.isFrormDashboard = 0

                                            navigationController?.pushViewController(nextViewController, animated: true)

                                     
                                     
                                 }else if object.value(forKey: "notification_type") as! String == "Circular"{
                                     
                                              
                                     let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                          
                                          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CircularVC") as! CircularVC
                                          nextViewController.isfrom = 2

                                     navigationController?.pushViewController(nextViewController, animated: true)

                                     
                                     
                                 }else if object.value(forKey: "notification_type") as! String == "Event"{

                             
                             
                             let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                  
                                  let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SocietyEventsVC") as! SocietyEventsVC
                                  nextViewController.isfrom = 1

                             navigationController?.pushViewController(nextViewController, animated: true)
                                     
                                 }
           }
           
       }
    
    

    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteRating(sender:UIButton) {
        
        selectedIndex = sender.tag
        
       // let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                       let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                       avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
                       avc?.subtitleStr = "Are you sure you want to delete this review?"
                       avc?.yesAct = {
                                let str = "\(self.arrRatingReview[sender.tag].commentID)"
                                self.apicallDeleteRatings(strId: str)
                           }
                       avc?.noAct = {
                         
                       }
                       present(avc!, animated: true)
        
        
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to delete this review?" , preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
//            let str = "\(self.arrRatingReview[sender.tag].id!)"
//            self.apicallDeleteRatings(strId: str)
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alert, animated: true, completion: nil)
//
        
    }
    
    // MARK: - get Delete rating
    func apicallDeleteRatings(strId:String)
           {
                if !NetworkState().isInternetAvailable {
                                ShowNoInternetAlert()
                                return
                            }
        
                   let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
                   webservices().StartSpinner()
        
                Apicallhandler().DeleteReview(URL: webservices().baseurl + API_DELETE_REVIEWS, id:strId, token: token as! String) { JSON in
                       switch JSON.result{
                       case .success(let resp):
                           webservices().StopSpinner()
                           if(JSON.response?.statusCode == 200)
                           {
                            print("-----Delete\(JSON)")
                            self.arrRatingReview.remove(at: self.selectedIndex)
                            self.tblView.reloadData()
                           }
                           else if(JSON.response?.statusCode == 401)
                           {
                               
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
                                                                     
                               
                           }
                           else
                           {
                               let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:"")
                               self.present(alert, animated: true, completion: nil)
                           }
                           
                           print(resp)
                       case .failure(let err):
                           webservices().StopSpinner()
                           if JSON.response?.statusCode == 401{
                              
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
                           let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                           self.present(alert, animated: true, completion: nil)
                           print(err.asAFError!)
                           
                       }
                   }
              
               
           }
    
    
    
    
    
    
}


@available(iOS 13.0, *)
extension RatingReviewListVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRatingReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingReviewCell") as! RatingReviewCell
        
        cell.btnDelete.tag = indexPath.row
        cell.selectionStyle = .none
        
        cell.lblName.text = self.arrRatingReview[indexPath.row].commentedBy
        cell.lblDiscription.text = self.arrRatingReview[indexPath.row].comment
        
        let rating = Double(self.arrRatingReview[indexPath.row].rating)
     
        cell.ratingViews.rating = rating!
      
        let str = self.arrRatingReview[indexPath.row].commentedBy
        let firstChar = Array(str)[0]
        cell.lblFirstLetter.text = "\(firstChar)"
        cell.lblFirstLetter.textColor = UIColor.white
        
        if self.arrRatingReview[indexPath.row].addedByMe == 1{
            cell.btnDelete.isHidden = false
        }else{
             cell.btnDelete.isHidden = true
        }
        
        cell.btnDelete.addTarget(self, action: #selector(deleteRating(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
