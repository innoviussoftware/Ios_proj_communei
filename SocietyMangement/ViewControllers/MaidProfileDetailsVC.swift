//
//  MaidProfileDetailsVC.swift
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
class MaidProfileDetailsVC: UIViewController {

    @IBOutlet weak var lblRatingReviewStatic: UILabel!
    @IBOutlet weak var ratingTopView: FloatRatingView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var btnNotificataion: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblProfession: UILabel!
    @IBOutlet weak var lblTotalRating: UILabel!
    
    @IBOutlet weak var btnCall: UIButton!
    
    @IBOutlet weak var btnWorkingSince: UIButton!
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnWorkingWithViewAll: UIButton!
    @IBOutlet weak var lblTotalRatingReview: UILabel!
    
    @IBOutlet weak var btnViewAllRatings: UIButton!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    var arrRating = [Reveiw]()
    
    @IBOutlet weak var btnAddRatings: UIButton!
    
    var dictHelperData : HelperDetailsData!
    
    
    var HelperId : Int!
    var helperRating : Double!
    var userId : Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
                     // Always adopt a light interface style.
          overrideUserInterfaceStyle = .light
        }
        
        
        tblView.register(UINib(nibName: "RatingReviewCell", bundle: nil), forCellReuseIdentifier: "RatingReviewCell")
        setUpView()
        apicallHelperDetails()
        
        
    }
    
    func setUpView() {
        btnWorkingSince.layer.cornerRadius = 8
        btnWorkingSince.clipsToBounds = true
        
        btnAddRatings.layer.cornerRadius = 8
        btnAddRatings.clipsToBounds = true
        
        btnWorkingWithViewAll.layer.borderColor = UIColor.orange.cgColor
        btnWorkingWithViewAll.layer.borderWidth = 1.0
        btnWorkingWithViewAll.layer.cornerRadius = 10.0

        
        btnViewAllRatings.layer.borderColor = UIColor.orange.cgColor
        btnViewAllRatings.layer.borderWidth = 1.0
        btnViewAllRatings.layer.cornerRadius = 10.0

        
    }
    
    //MARK:- action method
    
    @IBAction func actionNoti(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionCall(_ sender: Any) {
        
        dialNumber(number: dictHelperData.mobile!)
        
    }
    
    @IBAction func actionWorkingSince(_ sender: Any) {
    }
    
    @IBAction func actionViewAllWorkingWith(_ sender: Any) {
        
        print("\(dictHelperData.workWithData)")
        
        if dictHelperData.workWithData != nil{
             let popup = self.storyboard?.instantiateViewController(withIdentifier: "WorkingWithPopUpVC") as! WorkingWithPopUpVC
            popup.arrWorkingWith = dictHelperData.workWithData!
             let navigationController = UINavigationController(rootViewController: popup)
             navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
             self.present(navigationController, animated: true)
        }
        
        
    }
    
    @IBAction func actionViewAllRatingReview(_ sender: Any) {
            let popup = self.storyboard?.instantiateViewController(withIdentifier: "RatingReviewListVC") as! RatingReviewListVC
            popup.arrRatingReview = dictHelperData.reveiws!
        popup.avgRating = dictHelperData.ratings
            self.navigationController?.pushViewController(popup, animated: true)
    }
    
    @IBAction func actionAddRatings(_ sender: Any) {
        let popup = self.storyboard?.instantiateViewController(withIdentifier: "AddRatingReviewPopUpVC") as! AddRatingReviewPopUpVC
                   popup.helperId = HelperId
                   let navigationController = UINavigationController(rootViewController: popup)
                   navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                   self.present(navigationController, animated: true)
        
    }
    func dialNumber(number : String) {
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    
    
    // MARK: - get Maid List
       
       func apicallHelperDetails()
       {
         if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
              let userid = UserDefaults.standard.value(forKey: USER_ID) as! Int
            
            let strId = "\(userid)"
                
               webservices().StartSpinner()
            Apicallhandler().GetHelperDetail(URL: webservices().baseurl + API_HELPER_DETAIL, helperID:"\(HelperId!)",userId:strId) { JSON in
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if(JSON.response?.statusCode == 200)
                       {
                        print("-----Helper Detail\(JSON)")
                        
                        self.dictHelperData = resp.data
                        
                        if self.dictHelperData.photos != nil
                               {
                                self.imgUser.layer.cornerRadius =  self.imgUser.frame.size.height/2
                                self.imgUser.clipsToBounds = true
                                self.imgUser.sd_setImage(with: URL(string:webservices().imgurl + self.dictHelperData.photos!), placeholderImage: UIImage(named: "vendor-1"))
                               }
                        self.lblName.text = self.dictHelperData.name
                        self.lblProfession.text = self.dictHelperData.typename
                        
                        if self.dictHelperData.ratings != nil{
                            self.ratingView.rating = Double(self.dictHelperData.ratings!)
                                                   self.ratingTopView.rating = Double(self.dictHelperData.ratings!)
                                                   self.lblTotalRating.text =  "\(Double(self.dictHelperData.ratings!))"
                                                   self.lblTotalRatingReview.text =  "\(Double(self.dictHelperData.ratings!))"
                        }
                        
                        if self.dictHelperData.reveiws != nil {
                           self.arrRating = self.dictHelperData.reveiws!
                        }
                         self.lblRatingReviewStatic.isHidden = true
                        if self.dictHelperData.workWithLoggedInUser == "true"{
                            self.btnAddRatings.isHidden = false
                            self.lblRatingReviewStatic.isHidden = false
                        }else{
                            self.btnAddRatings.isHidden = true
                        }
                    
                        
                        self.btnWorkingSince.setTitle(self.dictHelperData.joinDate, for: .normal)

                        if self.arrRating.count > 2{
                            self.btnViewAllRatings.isHidden = false
                        }else{
                            self.btnViewAllRatings.isHidden = true
                        }
                        
                        if self.arrRating.count > 0{
                            self.lblRatingReviewStatic.isHidden = false
                            
//                               lblNoDataFound.isHidden = ture
                               self.tblView.isHidden = false
                               self.tblView.delegate = self
                               self.tblView.dataSource = self
                               self.tblView.reloadData()

                           }else{
                            
                               self.tblView.isHidden = true
//                               lblNoDataFound.isHidden = false
                           }
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
                       print(err.asAFError)
                       
                   }
               }
          
       }
    
    
     @objc func deleteRating(sender:UIButton) {
        
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                   let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = "Society Buddy"
                   avc?.subtitleStr = "Are you sure you want to delete this review?"
                   avc?.yesAct = {
                         
                            let str = "\(self.arrRating[sender.tag].id!)"
                                           self.apicallDeleteRatings(strId: str)
                       }
                   avc?.noAct = {
                     
                   }
                   present(avc!, animated: true)
         
        
//
//        let alert = UIAlertController(title: Alert_Titel, message:"Are you sure you want to delete this review?" , preferredStyle: UIAlertController.Style.alert)
//               alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { alert in
//                let str = "\(self.arrRating[sender.tag].id!)"
//                self.apicallDeleteRatings(strId: str)
//               }))
//               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//               self.present(alert, animated: true, completion: nil)
        
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
                                self.apicallHelperDetails()
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
                              print(err.asAFError)
                              
                          }
                      }
                 
              }
       

    
    
}


@available(iOS 13.0, *)
extension MaidProfileDetailsVC : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  self.arrRating.count == 1{
            return 1
        }else{
            return 2
        }
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "RatingReviewCell") as! RatingReviewCell
        
        cell.selectionStyle = .none
        cell.btnDelete.tag = indexPath.row
           
        cell.lblName.text = self.arrRating[indexPath.row].username
        cell.lblDiscription.text = self.arrRating[indexPath.row].comment
           
        
        let str = self.arrRating[indexPath.row].username!
        let firstChar = Array(str)[0]
        cell.lblFirstLetter.text = "\(firstChar)"
        cell.lblFirstLetter.textColor = UIColor.white
        cell.ratingViews.rating = self.arrRating[indexPath.row].ratings!
        
        let userId = UserDefaults.standard.value(forKey: USER_ID) as! Int
        
        if self.arrRating[indexPath.row].userID == userId{
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
