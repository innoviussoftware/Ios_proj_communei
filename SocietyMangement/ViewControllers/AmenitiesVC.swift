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

@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AmenitiesVC: BaseVC,ScrollPagerDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var tblBookingHistory: UITableView!
    
    @IBOutlet weak var pager: ScrollPager!
    @IBOutlet weak var tblFacilities: UITableView!
    @IBOutlet var viewBookingHistory: UIView!
    @IBOutlet var ViewFacilities: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var lblbooking: UILabel!

    @IBOutlet weak var lblAmenities: UILabel!
    
    @IBOutlet weak var txtSearchbar: UITextField!

    
    var arrFacilities = [AmenitiesListData]()
    var arrSearchFinal = [AmenitiesListData]()
    
    var arrBookings = [BookingsListData]()
    
    var isfrom = 1

    var searchActive = false

    
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
        
        txtSearchbar.delegate = self
      
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
                
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        apicallGetAmenities()

        apicallGetBookings()
        
        txtSearchbar.addTarget(self, action: #selector(searchRecordsAsPerText(_ :)), for: .editingChanged)

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
           txtSearchbar.text = ""
          apicallGetAmenities()
          view.endEditing(true)
        }else{
            txtSearchbar.text = ""
            apicallGetBookings()
            view.endEditing(true)
        }
        
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
        
        Apicallhandler().GetBookingsList(URL: webservices().baseurl + API_GET_BOOKINGS_LIST, token:strToken) { [self] JSON in
                switch JSON.result{
                case .success(let resp):

                    webservices().StopSpinner()
                    if(resp.status == 1)
                    {
                        self.arrBookings = resp.data!
                        
                        if self.arrBookings.count > 0{
                            
                            self.lblbooking.isHidden = true

                            self.tblBookingHistory.dataSource = self
                            self.tblBookingHistory.delegate = self
                            self.tblBookingHistory.reloadData()
                            
                        }else{
                            self.lblbooking.isHidden = false
                            self.tblBookingHistory.isHidden = true
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
                        self.lblbooking.isHidden = false

                        self.tblBookingHistory.isHidden = true
                    }

                    print(resp)
                case .failure(let err):

                    webservices().StopSpinner()

                   // let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                   // self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)

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
                            self.lblAmenities.isHidden = false

                        }

                    }else if JSON.response?.statusCode == 401{
                        
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
                    else
                    {
                        self.lblAmenities.isHidden = false

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
                                    
                            //    }
                          //  })
                        
                        return
                    }

                    let alert = webservices.sharedInstance.AlertBuilder(title:"", message:err.localizedDescription)
                    self.present(alert, animated: true, completion: nil)
                    print(err.asAFError!)

                }
            }
    }
    
    @objc func DeleteBookingEntry(sender:UIButton) {
        let strGuestId = arrBookings[sender.tag].amenitiesBookingID

           let avc = storyboard?.instantiateViewController(withClass: AlertBottomViewController.self)
           avc?.titleStr = "Delete Booking"
           avc?.subtitleStr = "Are you sure you want to delete this Booking?"
           avc?.yesAct = {
           
               self.ApiCallDeleteBookingEntry(booking_id: strGuestId!)
           }
           avc?.noAct = {
             
           }
           present(avc!, animated: true)
        
    }
    
    func ApiCallDeleteBookingEntry(booking_id : Int)
    {
       // let strGuestId = (guestId as NSNumber).stringValue
        let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
          if !NetworkState().isInternetAvailable {
                         ShowNoInternetAlert()
                         return
                     }
            webservices().StartSpinner()
        Apicallhandler().ApiDeletebookingEntry(URL: webservices().baseurl + API_DELETE_BOOKING_ENTRY, token: token as! String, booking_id: booking_id) { JSON in
                switch JSON.result{
                case .success(let resp):
                    
                    if(JSON.response?.statusCode == 200)
                    {
                        self.apicallGetBookings()
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
                        let alert = webservices.sharedInstance.AlertBuilder(title:"", message:"")
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    print(resp)
                case .failure(let err):
                    
                    webservices().StopSpinner()

                    print(err.asAFError!)
                    webservices().StopSpinner()
                    
                }
            }
    }
    
    func strChangeTimeFormate(strDateeee: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "hh:mm a"
            return  dateFormatter.string(from: date!)

        }
    
    @objc func actionViewDetailFacilities(sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AmenitiesClenderBookVC") as! AmenitiesClenderBookVC
        vc.isfrom = 1
        
        vc.amenityID = arrFacilities[sender.tag].amenityID!
        vc.strName = arrFacilities[sender.tag].name!
        vc.strNotes = arrFacilities[sender.tag].notes!
        vc.strDescription = arrFacilities[sender.tag].datumDescription!
        vc.amount = arrFacilities[sender.tag].amount!
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func actionAmenitiesBooking(sender:UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AmenitiesClenderBookVC") as! AmenitiesClenderBookVC
        
        vc.isfrom = 2
        let calendarSelectDate = arrBookings[sender.tag].startDate!.components(separatedBy:" ")[0]
        vc.strSelectCalendarDate = calendarSelectDate
        
        vc.amenityID = arrBookings[sender.tag].amenitiesBookingID!
        vc.strName = arrBookings[sender.tag].amenityName!
        vc.strNotes = arrBookings[sender.tag].bookingNotes!
        vc.amount = arrBookings[sender.tag].amount!
        
        let lblStartTime = arrBookings[sender.tag].startDate?.components(separatedBy: " ")[1]
        let strStartTime = strChangeTimeFormate(strDateeee: lblStartTime!)

        vc.strStartTime = strStartTime
        
        let lblEndTime = arrBookings[sender.tag].endDate?.components(separatedBy: " ")[1]
        let strEndTime = strChangeTimeFormate(strDateeee: lblEndTime!)

        vc.strEndTime = strEndTime
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    //MARK:- tableview delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblFacilities{
            if searchActive == false {
                return arrFacilities.count
            }else{
                return arrSearchFinal.count
            }
        }else{
            return arrBookings.count

        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         if tableView == tblFacilities{
            
            if searchActive == false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesFacilitiesCell") as! AmenitiesFacilitiesCell

                // let pdffile = Circularary[sender.tag].attachments![0]
                    
                    if arrFacilities[indexPath.row].attachments!.count > 0{
                          if arrFacilities[indexPath.row].attachments?[0].attachment != nil
                        {
                            cell.imgService.sd_setImage(with: URL(string: (arrFacilities[indexPath.row].attachments?[0].attachment!)!), placeholderImage: UIImage(named: "ic_Amenities"))
                        }
                                
                    }else{
                        cell.imgService.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_Amenities"))
                    }

                            
                cell.selectionStyle = .none
                cell.btnViewAll.tag = indexPath.row
                
                cell.lblNameType.text = arrFacilities[indexPath.row].name
                    
                cell.lblDescription.text = arrFacilities[indexPath.row].datumDescription

                cell.btnViewAll.addTarget(self, action: #selector(actionViewDetailFacilities(sender:)), for: .touchUpInside)
                
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesFacilitiesCell") as! AmenitiesFacilitiesCell

                // let pdffile = Circularary[sender.tag].attachments![0]
                    
                    if arrSearchFinal[indexPath.row].attachments!.count > 0{
                          if arrSearchFinal[indexPath.row].attachments?[0].attachment != nil
                        {
                            cell.imgService.sd_setImage(with: URL(string: (arrSearchFinal[indexPath.row].attachments?[0].attachment!)!), placeholderImage: UIImage(named: "ic_Amenities"))
                        }
                                
                    }else{
                        cell.imgService.sd_setImage(with: URL(string: ""), placeholderImage: UIImage(named: "ic_Amenities"))
                    }

                            
                cell.selectionStyle = .none
                cell.btnViewAll.tag = indexPath.row
                
                cell.lblNameType.text = arrSearchFinal[indexPath.row].name
                    
                cell.lblDescription.text = arrSearchFinal[indexPath.row].datumDescription

                cell.btnViewAll.addTarget(self, action: #selector(actionViewDetailFacilities(sender:)), for: .touchUpInside)
                
                return cell
            }
                    
      
         }else{
             let cell = tableView.dequeueReusableCell(withIdentifier: "AmenitiesPasstBookingCell") as! AmenitiesPasstBookingCell
            
            cell.btnCancel.tag = indexPath.row
            
            cell.btnEdit.tag = indexPath.row
            
            cell.lblNameType.text = arrBookings[indexPath.row].amenityName
                
            cell.lblStatus.text = arrBookings[indexPath.row].bookingStatusName
            
            cell.lblDateTimeBooked.text = "\("Create on: " + arrBookings[indexPath.row].createdAt!)"
            
            cell.lblDatetimeBlow.text = arrBookings[indexPath.row].startDate

            cell.btnCancel.addTarget(self, action: #selector(DeleteBookingEntry(sender:)), for: .touchUpInside)
            
            cell.btnEdit.addTarget(self, action: #selector(actionAmenitiesBooking(sender:)), for: .touchUpInside)

            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          if tableView == tblFacilities{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AmenitiesClenderBookVC") as! AmenitiesClenderBookVC
            
            vc.isfrom = 1
            
            vc.amenityID = arrFacilities[indexPath.row].amenityID!
            vc.strName = arrFacilities[indexPath.row].name!
            vc.strNotes = arrFacilities[indexPath.row].notes!
            vc.strDescription = arrFacilities[indexPath.row].datumDescription!
            vc.amount = arrFacilities[indexPath.row].amount!
            
            self.navigationController?.pushViewController(vc, animated: true)
            
            print("AmenitiesClenderBookVC")
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
    
    //MARK:- textfield delegate
    
    @objc func searchRecordsAsPerText(_ textfield:UITextField) {
        arrSearchFinal.removeAll()
        
        if textfield.text?.count != 0 {
            searchActive = true

            for strCountry in arrFacilities {
                let range = strCountry.name!.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                
                if range != nil {
                    arrSearchFinal.append(strCountry)
                }
            }
        }else if textfield.text?.count == 0 {
            searchActive = false
            
        }
        /*else if (arrSearchFinal.count == 0){
            // searchActive = false
            
            lblnoproperty.isHidden = false
            
            lblnoproperty.text  = "Member List Not Found"
         
         tblFacilities.isHidden = true

        }*/
        else {
              arrSearchFinal = arrFacilities
        }
        
        tblFacilities.reloadData()
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
