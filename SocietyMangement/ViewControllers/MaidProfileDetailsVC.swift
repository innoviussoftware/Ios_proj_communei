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
class MaidProfileDetailsVC: UIViewController , updateReviewView {

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
    
    @IBOutlet weak var btnAddHelper: UIButton!

    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var imgStar2: UIImageView!
    @IBOutlet weak var imgStar3: UIImageView!
    @IBOutlet weak var imgStar4: UIImageView!
    @IBOutlet weak var imgStar5: UIImageView!
    
    var isfrom = 1
    
    var arrRating = [Comment]()
    
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
        
        if isfrom == 1 {
            btnAddHelper.setTitle("Add Helper", for: .normal)
        }else{
            btnAddHelper.setTitle("Request Service", for: .normal)
        }
        
        tableHeightConstraint.constant = 0

        tblView.register(UINib(nibName: "RatingReviewCell", bundle: nil), forCellReuseIdentifier: "RatingReviewCell")
        
        tblView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)

        setUpView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        apicallHelperDetails()
    }
    
    func getupReviewView() {
        apicallHelperDetails()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblView.layer.removeAllAnimations()
        print("tblView contentSize height :- ",tblView.contentSize.height + 5)
        tableHeightConstraint.constant = tblView.contentSize.height + 5
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.view.layoutIfNeeded()
        }

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
    
    
    // MARK: - get Assign List
       
    func apicallUserDailyHelper_Assign_Details(dailyHelperID : Int,vendorServiceTypeID : Int)
       {
         if !NetworkState().isInternetAvailable {
                            ShowNoInternetAlert()
                            return
                        }
             
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)

                
            webservices().StartSpinner()
        
        Apicallhandler().GetHelperAssignDetail(URL: webservices().baseurl + API_DAILYHELPER_ASSIGN, dailyHelperID:dailyHelperID, vendorServiceTypeID: vendorServiceTypeID,token:token  as! String) { [self] JSON in
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if(JSON.response?.statusCode == 200)
                       {
                        
                        let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                        avc?.titleStr = "Communei"
                        avc?.isfrom = 0 // 4
                                    //    avc?.subtitleStr = "Are you sure you want to call?"
                        avc?.subtitleStr = "Helper added successfully"

                                        avc?.yesAct = {
                                            
                                            self.apicallHelperDetails()
                                            
                                            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewHomeVC") as! NewHomeVC
                                            
                                            self.navigationController?.pushViewController(nextViewController, animated: true)
                                        }

                                        avc?.noAct = {
                                          
                                        }
                                        present(avc!, animated: true)

                       
                       }
                       else
                       {
                            // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:(resp as AnyObject).message!)
                            //  self.present(alert, animated: true, completion: nil)
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
                      // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                     //  self.present(alert, animated: true, completion: nil)
                       print(err.asAFError!)
                       
                   }
               }
          
       }
    
    @IBAction func btnAddHelperPressed(_ sender: Any) {
        
        if isfrom == 1 {
            if self.dictHelperData != nil {

                let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                avc?.titleStr = "Communei"
               // avc?.isfrom = 3
                            //    avc?.subtitleStr = "Are you sure you want to call?"
                avc?.subtitleStr = "Are you sure you want to add this helper?"

                            avc?.yesAct = {
                                self.apicallUserDailyHelper_Assign_Details(dailyHelperID: self.dictHelperData.dailyHelperID, vendorServiceTypeID: self.dictHelperData.vendorServiceTypeID)
                            }

                            avc?.noAct = {
                              
                            }
                            present(avc!, animated: true)
            }

        }else{
            if self.dictHelperData != nil {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                 let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ParcelServiceEntryVC") as! ParcelServiceEntryVC
                
                nextViewController.dailyHelperID =  self.dictHelperData.dailyHelperID
                nextViewController.vendorServiceTypeID = self.dictHelperData.vendorServiceTypeID
                
                // nextViewController.isfrom_entry = 1
                 self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            
        }
        
       /* let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CabEntryVC") as! CabEntryVC
        nextViewController.isfrom_entry = 1
        self.navigationController?.pushViewController(nextViewController, animated: true) */
    
    }
    
    
    //MARK:- action method
    
    @IBAction func actionNoti(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        nextViewController.isfrom = 0
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionCall(_ sender: Any) {
        
      //  dialNumber(number: dictHelperData.mobile!)
        
        if dictHelperData != nil {

                let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                avc?.titleStr = "Call Helper"
                avc?.isfrom = 3
                               //    avc?.subtitleStr = "Are you sure you want to call?"
                avc?.subtitleStr = "Want to contact: \(dictHelperData.phoneNumber)"
        
                                   avc?.yesAct = {
                                    self.dialNumber(number: self.dictHelperData.phoneNumber)
                                            }
        
                                   avc?.noAct = {
                                     
                                   }
                                   present(avc!, animated: true)
        }
        
    }
    
    @IBAction func actionWorkingSince(_ sender: UIButton) {
        
    }
    
    @IBAction func actionViewAllWorkingWith(_ sender: Any) {
        
       // if dictHelperData.props != nil{
        if dictHelperData != nil {
             let popup = self.storyboard?.instantiateViewController(withIdentifier: "WorkingWithPopUpVC") as! WorkingWithPopUpVC
            popup.arrWorkingWith = dictHelperData.props!
             let navigationController = UINavigationController(rootViewController: popup)
             navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
             self.present(navigationController, animated: true)
        }
        
        
    }
    
    @IBAction func actionViewAllRatingReview(_ sender: UIButton) {
        if dictHelperData != nil{
            let popup = self.storyboard?.instantiateViewController(withIdentifier: "RatingReviewListVC") as! RatingReviewListVC
            popup.arrRatingReview = dictHelperData.comments
            popup.avgRating = dictHelperData.rating
            self.navigationController?.pushViewController(popup, animated: true)
        }
    }
    
    @IBAction func actionAddRatings(_ sender: UIButton) {
        
      //  if self.arrRating.count > 0  {
                    

            let popOverConfirmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddRatingReviewPopUpVC") as! AddRatingReviewPopUpVC
            
            popOverConfirmVC.delegate = self

            popOverConfirmVC.dailyHelperID = self.dictHelperData.dailyHelperID

            popOverConfirmVC.VendorServiceTypeID =  self.dictHelperData.vendorServiceTypeID // self.arrRating[sender.tag].vendorServiceTypeID
            
            if isfrom == 1 {
                popOverConfirmVC.dailyHelpPropertyID = self.arrRating[sender.tag].dailyHelpPropertyID // self.dictHelperData.dailyHelpPropertyID
            }else{
                popOverConfirmVC.dailyHelpPropertyID =  self.dictHelperData.dailyHelpPropertyID // self.arrRating[sender.tag].dailyHelpPropertyID
            }
            
            self.addChildViewController(popOverConfirmVC)
            popOverConfirmVC.view.frame = self.view.frame
            self.view.center = popOverConfirmVC.view.center
            self.view.addSubview(popOverConfirmVC.view)
            popOverConfirmVC.didMove(toParentViewController: self)
        
         // }
        
          /*  let navigationController = UINavigationController(rootViewController: popOverConfirmVC)
            navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(navigationController, animated: true) */
            
     //   }
        
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
    
    
    func strChangeDateFormate(strDateeee: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "dd MMMM yyyy"
            return  dateFormatter.string(from: date!)

        }
    
    
    // MARK: - get Maid List
       
       func apicallHelperDetails()
       {
         if !NetworkState().isInternetAvailable {
            ShowNoInternetAlert()
            return
         }
             
        
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)

            webservices().StartSpinner()
        
            Apicallhandler().GetHelperDetail(URL: webservices().baseurl + API_HELPER_DETAIL, helperID:"\(HelperId!)",token:token  as! String) { [self] JSON in
                   switch JSON.result{
                   case .success(let resp):
                       webservices().StopSpinner()
                       if(JSON.response?.statusCode == 200)
                       {
                        print("-----Helper Detail\(JSON)")
                        
                        self.dictHelperData = resp.data
                        
                        if self.dictHelperData.profilePicture == ""
                               {
                        }else{
                              //  self.imgUser.layer.cornerRadius =  self.imgUser.frame.size.height/2
                            
                             //   self.imgUser.clipsToBounds = true
                            self.imgUser.sd_setImage(with: URL(string: self.dictHelperData.profilePicture), placeholderImage: UIImage(named: "vendor-1"))
                               }
                        self.lblName.text = self.dictHelperData.name
                        self.lblProfession.text = self.dictHelperData.vendorServiceType
                        
                        if self.dictHelperData.comments.count > 0 {
                            print("comments")
                        }else{
                            print("comments 0")
                        }
                        
                            let rating = Double(self.dictHelperData.rating)
                         
                        
                            self.ratingView.rating = rating! // Double(self.dictHelperData.ratings!)
                                    self.ratingTopView.rating = rating! // Double(self.dictHelperData.ratings!)
                                                   self.lblTotalRating.text =  (self.dictHelperData.rating) // "\(Double(self.dictHelperData.ratings!))"
                                                   self.lblTotalRatingReview.text =  (self.dictHelperData.rating) // "\(Double(self.dictHelperData.ratings!))"
                     //   }
                        
                        if self.dictHelperData.comments.count > 0 {
                            self.arrRating = self.dictHelperData.comments
                        }
                         self.lblRatingReviewStatic.isHidden = false
                        self.btnAddRatings.isHidden = false

                        if isfrom == 1 {
                           // popOverConfirmVC.dailyHelpPropertyID = self.arrRating[sender.tag].dailyHelpPropertyID // self.dictHelperData.dailyHelpPropertyID
                            if self.dictHelperData.workingWithMe == 0 {
                                self.btnAddHelper.isHidden = false 
                            }else{
                                self.btnAddHelper.isHidden = true
                            }
                        }else{
                            if self.dictHelperData.workingWithMe == 0 {
                                self.btnAddHelper.isHidden = true
                            }else{
                                self.btnAddHelper.isHidden = false
                            }
                        }
                        
                        let lblin = self.dictHelperData.societyWorkingSince.components(separatedBy: " ")[0]
                       
                        let strIn = self.strChangeDateFormate(strDateeee: lblin)
                        
                        self.btnWorkingSince.setTitle(strIn, for: .normal)

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
                         //  let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message)
                         //  self.present(alert, animated: true, completion: nil)
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
                     // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                      // self.present(alert, animated: true, completion: nil)
                       print(err.asAFError!)
                       
                   }
               }
          
       }
    
    
     @objc func deleteRating(sender:UIButton) {
        
        
                   let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
                   avc?.titleStr = GeneralConstants.kAppName // "Society Buddy"
                   avc?.subtitleStr = "Are you sure you want to delete this review?"
                   avc?.yesAct = {
                         
                            let str = "\(self.arrRating[sender.tag].commentID)"
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
           
        cell.lblName.text = self.arrRating[indexPath.row].commentedBy
        cell.lblDiscription.text = self.arrRating[indexPath.row].comment
           
        
        let str = self.arrRating[indexPath.row].commentedBy
        let firstChar = Array(str)[0]
        cell.lblFirstLetter.text = "\(firstChar)"
        cell.lblFirstLetter.textColor = UIColor.white

        let rating = Double(self.arrRating[indexPath.row].rating)
     
        cell.ratingViews.rating = rating!
            
        if self.arrRating[indexPath.row].addedByMe == 1{
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
           return 120 // UITableViewAutomaticDimension
       }
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return  UITableViewAutomaticDimension
        }
    
    
}
