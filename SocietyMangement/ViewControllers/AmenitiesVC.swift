//
//  AmenitiesVC.swift
//  SocietyMangement
//
//  Created by MacMini on 02/10/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import UIKit
import ScrollPager
import SWRevealViewController
import Alamofire

class AmenitiesVC: BaseVC,ScrollPagerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var tblBookingHistory: UITableView!
    
    @IBOutlet weak var pager: ScrollPager!
    @IBOutlet weak var tblFacilities: UITableView!
    @IBOutlet var viewBookingHistory: UIView!
    @IBOutlet var ViewFacilities: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var txtSearchbar: UITextField!

    
    var arrFacilities = [AmenitiesListData]()
    var arrSearchFinal = [AmenitiesListData]()
    
    var arrBookings = [BookingsListData]()

    
    var isfrom = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
        
        
        pager.delegate = self
        pager.tintColor  = AppColor.appcolor
        pager.addSegmentsWithTitlesAndViews(segments: [
                   ("Facilities", ViewFacilities),("Booking History", viewBookingHistory)])
        
        tblFacilities.register(UINib(nibName: "AmenitiesFacilitiesCell", bundle: nil), forCellReuseIdentifier: "AmenitiesFacilitiesCell")
        
        tblBookingHistory.register(UINib(nibName: "AmenitiesPasstBookingCell", bundle: nil), forCellReuseIdentifier: "AmenitiesPasstBookingCell")
        
        txtSearchbar.layer.borderColor = UIColor.clear.cgColor
        
        txtSearchbar.borderStyle = .none
      
        if isfrom == 1{
                btnMenu.setImage(UIImage(named: "ic_back-1"), for: .normal)
        }else{
                btnMenu.setImage(UIImage(named: "menu"), for: .normal)
        }
        
        if isfrom == 0{

                if(revealViewController() != nil) {
                   btnMenu.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
                   self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                   self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
               }
        }
        
        apicallGetAmenities()
        
       // apicallGetBookings()
        
    }
    
    @IBAction func backaction(_ sender: Any) {

           if isfrom == 1{
               self.navigationController?.popViewController(animated: true)
           }else{
           }
           
       }
    
    //MARK:- action method
    
    @IBAction func actionQRCode(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = self.pushViewController(withName:QRCodeVC.id(), fromStoryboard: "Main") as! QRCodeVC
            vc.isfrom = 0

        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func actionNotification(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let vc = self.pushViewController(withName:NotificationVC.id(), fromStoryboard: "Main") as! NotificationVC
            vc.isfrom = 0

        } else {
            // Fallback on earlier versions
        }
    }
    
    
    //MARK:- ScrollPager delegate
    func scrollPager(scrollPager: ScrollPager, changedIndex: Int) {
        
        if changedIndex == 0{//facilities
          apicallGetAmenities()
            
            
        }else{
            self.tblBookingHistory.reloadData()
            apicallGetBookings()
            
        }
        
    }
    
    @objc func actionViewDetailFacilities(sender:UIButton)
    {
        print("actionViewDetailFacilities")
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AmenitiesClenderBookVC") as! AmenitiesClenderBookVC
        //vc = arrFacilities
        self.navigationController?.pushViewController(vc, animated: true)

       // self.present(vc, animated: true, completion: nil)
        
      //  self.dialNumber(number:self.arrHelperList[sender.tag].mobile!)

    }
    
    // MARK: - get Bookings

    func apicallGetBookings()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
          }
        
        let strToken = UserDefaults.standard.value(forKey: USER_TOKEN)! as! String

        
            webservices().StartSpinner()
        Apicallhandler().GetBookingsList(URL: webservices().baseurl + API_GET_BOOKINGS_LIST, token:strToken) { JSON in
                switch JSON.result{
                case .success(let resp):

                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        self.arrBookings = resp.data!
                        
                        if self.arrBookings.count > 0{
                            self.tblBookingHistory.dataSource = self
                            self.tblFacilities.delegate = self
                            self.tblFacilities.reloadData()
                            
                        }else{
                            
                        }

                    }
                    else
                    {

                    }

                    print(resp)
                case .failure(let err):

                    webservices().StopSpinner()
                    if JSON.response?.statusCode == 401{
                        if #available(iOS 13.0, *) {
                            APPDELEGATE.ApiLogout(onCompletion: { int in
                                if int == 1{
                                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                    let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                    let navController = UINavigationController(rootViewController: aVC)
                                    navController.isNavigationBarHidden = true
                                    self.appDelegate.window!.rootViewController  = navController
                                    
                                }
                            })
                        } else {
                            // Fallback on earlier versions
                        }

                        return
                    }

                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)

                }
            }
    }
    
    
    // MARK: - get Amenities

    func apicallGetAmenities()
    {
         if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
          }
        
        let strToken = UserDefaults.standard.value(forKey: USER_TOKEN)! as! String

        
            webservices().StartSpinner()
        Apicallhandler().GetAmenitiesList(URL: webservices().baseurl + API_GET_AMENITIES_LIST, token:strToken) { JSON in
                switch JSON.result{
                case .success(let resp):

                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        self.arrFacilities = resp.data!
                        self.arrSearchFinal = resp.data!
                        
                        if self.arrFacilities.count > 0{
                            self.tblFacilities.dataSource = self
                            self.tblFacilities.delegate = self
                            self.tblFacilities.reloadData()
                            
                        }else{
                            
                        }

                    }
                    else
                    {

                    }

                    print(resp)
                case .failure(let err):

                    webservices().StopSpinner()
                    if JSON.response?.statusCode == 401{
                        if #available(iOS 13.0, *) {
                            APPDELEGATE.ApiLogout(onCompletion: { int in
                                if int == 1{
                                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                                    let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                    let navController = UINavigationController(rootViewController: aVC)
                                    navController.isNavigationBarHidden = true
                                    self.appDelegate.window!.rootViewController  = navController
                                    
                                }
                            })
                        } else {
                            // Fallback on earlier versions
                        }

                        return
                    }

                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError)

                }
            }
    }
    
    
    
    //MARK:- tableview delegate
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblFacilities{
            return arrFacilities.count

        }else{
            return arrBookings.count

        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if tableView == tblFacilities{
                    
        let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesFacilitiesCell") as! AmenitiesFacilitiesCell

        
          /*  if arrFacilities[indexPath.row].attachments != nil{
           cell.imgService.sd_setImage(with: URL(string:webservices().imgurl + arrFacilities[indexPath.row].images!), placeholderImage: UIImage(named: "ic_Amenities"))
        } */
        
        cell.selectionStyle = .none
        cell.btnViewAll.tag = indexPath.row
        
        cell.lblNameType.text = arrFacilities[indexPath.row].name
            
        cell.lblDescription.text = arrFacilities[indexPath.row].datumDescription

        cell.btnViewAll.addTarget(self, action: #selector(actionViewDetailFacilities(sender:)), for: .touchUpInside)
        
        return cell
         }else{
             let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesPasstBookingCell") as! AmenitiesPasstBookingCell
            
            cell.lblNameType.text = arrBookings[indexPath.row].amenityName
                
            cell.lblStatus.text = arrBookings[indexPath.row].bookingStatusName
            
            cell.lblDateTimeBooked.text = "\("Create on:" + arrBookings[indexPath.row].createdAt!)"
            
            cell.lblDatetimeBlow.text = arrBookings[indexPath.row].startDate

          //  cell.btnCancel.addTarget(self, action: #selector(actionViewDetailFacilities(sender:)), for: .touchUpInside)
            
          //  cell.btnEdit.addTarget(self, action: #selector(actionViewDetailFacilities(sender:)), for: .touchUpInside)

            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          if tableView == tblFacilities{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AmenitiesClenderBookVC") as! AmenitiesClenderBookVC
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    
    //MARK:- textfield delegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        //searchActive = true
        arrFacilities  = arrSearchFinal
        self.tblFacilities.reloadData()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //searchActive = false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        arrFacilities  = arrSearchFinal
        self.tblFacilities.reloadData()
        return true
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
               
        if(string != "")
               {
                   
                   arrFacilities.removeAll()
                   
                   for dic in arrSearchFinal
                   {
                       var profession = ""
                       if(dic.name?.lowercased() != nil)
                       {
                           profession = (dic.name?.lowercased())!
                       }
                    if((dic.name?.lowercased().contains(string.lowercased()))! || (profession.contains(string.lowercased())))
                       {
                           
                           arrFacilities.append(dic)
                           
                           
                       }
                       if (arrFacilities.count == 0){
                           // searchActive = false
                           
                           //lblnoproperty.isHidden = false
                           //lblnoproperty.text  = "No Members Found for \(searchText)"
                       }
                       else{
                           //searchActive = true
                           
                           //lblnoproperty.isHidden = true
                           
                       }
                       self.tblFacilities.reloadData()
                       
                   }
                   
               }
               else
               {
                  // searchActive = false
                   tblFacilities.reloadData()
                   
              //  textField.resignFirstResponder()
                   
                   
                   
               }
               
               
               return true
               
               
           
    }
    
    //MARK:- searchView delegate
    
   /* func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
       
        //searchActive = true
        arrFacilities  = arrSearchFinal
        self.tblFacilities.reloadData()
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        //searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        arrFacilities  = arrSearchFinal
        self.tblFacilities.reloadData()
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           
           if(searchText != "")
           {
               
               arrFacilities.removeAll()
               
               for dic in arrSearchFinal
               {
                   var profession = ""
                   if(dic.name?.lowercased() != nil)
                   {
                       profession = (dic.name?.lowercased())!
                   }
                if((dic.name?.lowercased().contains(searchText.lowercased()))! || (profession.contains(searchText.lowercased())))
                   {
                       
                       arrFacilities.append(dic)
                       
                       
                   }
                   if (arrFacilities.count == 0){
                       // searchActive = false
                       
                       //lblnoproperty.isHidden = false
                       //lblnoproperty.text  = "No Members Found for \(searchText)"
                   }
                   else{
                       //searchActive = true
                       
                       //lblnoproperty.isHidden = true
                       
                   }
                   self.tblFacilities.reloadData()
                   
               }
               
           }
           else
           {
              // searchActive = false
               tblFacilities.reloadData()
               
               searchBar.resignFirstResponder()
               
               
               
               
           }
           
           
           
           
           
       }  */

    
    
}
