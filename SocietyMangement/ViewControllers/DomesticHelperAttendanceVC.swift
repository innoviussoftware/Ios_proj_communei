//
//  DomesticHelperAttendanceVC.swift
//  SocietyMangement
//
//  Created by prakash soni on 25/09/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire

@available(iOS 13.0, *)
@available(iOS 13.0, *)

class DomesticHelperAttendanceVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var calenderView: FSCalendar!
    
    @IBOutlet weak var lbldatePresentTotal: UILabel!

    @IBOutlet weak var lblPresent: UILabel!
    @IBOutlet weak var lblAbsent: UILabel!
    
    @IBOutlet weak var lbldateSelectDateCalendar: UILabel!

    @IBOutlet weak var btnPresent: UIButton!
    @IBOutlet weak var btnAbsent: UIButton!
    
    var arrAttendance : AttendanceSheet?
    
    var arrAttendanceData = [AttendanceDatum]()
    
    var arrPresentAttendance = NSMutableArray()
    var arrAbsentAttendance = NSMutableArray()

    var year : Int?
    var month : Int?
    var day : Int?
          
    var dailyHelperID : Int?
    
    var strlbl = String()
    
    var strAddedCalendarDate = ""
    
    var strSelectCalendarDate = ""
    
    var selecteddates = [String]()
    
       fileprivate let gregorian: Calendar = Calendar(identifier: .gregorian)
       fileprivate lazy var dateFormatter1: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd" //"dd-MM-yyyy"
           return formatter
       }()
       fileprivate lazy var dateFormatter2: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd" // "dd-MM-yyyy"
           return formatter
       }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lblName.text = strlbl + "'s Attendance"
        
        calenderView.placeholderType = .none
        
        calenderView.allowsMultipleSelection = false
        calenderView.swipeToChooseGesture.isEnabled = true
        calenderView.backgroundColor = UIColor.white
        
       // calenderView.appearance.todayColor = UIColor.orange

       // calenderView.appearance.todaySelectionColor = UIColor.orange
        
        let date = NSDate()
        let calendar = Calendar.current
        
         year =  calendar.component(.year, from: date as Date)
         month = calendar.component(.month, from: date as Date)
         day = calendar.component(.day, from: date as Date)
              
        print("year:month:day : ",year!,month!,day!)
        
        lblPresent.isHidden = true
        lblAbsent.isHidden = true
        lbldateSelectDateCalendar.isHidden = true
        btnPresent.isHidden = true
        btnAbsent.isHidden = true
        
        
       /* let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date111 = dateFormatter.date(from: strAddedCalendarDate)
        
        print("date111",date111!)
        
       // showRange(between: date111!, and: date as Date) */
        
        apicallCalendarAttendance()
        
    
        // Do any additional setup after loading the view.
    }
    
    func strChangeDateFormate(strDateeee: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return  dateFormatter.string(from: date!)

        }
    
    func strChangeDateFormate1(strDateeee: String) -> String
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: strDateeee)
            dateFormatter.dateFormat = "dd MMM,yyyy"
            return  dateFormatter.string(from: date!)

        }
    
   
    func apicallCalendarAttendance() {
        
        if !NetworkState().isInternetAvailable {
             ShowNoInternetAlert()
             return
         }
 
         let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        let param : Parameters = [
            "DailyHelperID" : dailyHelperID!,
            "Year" : year!,
            "Month" : month!
         ]
        
        print("calendar Attendance param", param)

        webservices().StartSpinner()
        
        Apicallhandler().APIAttenceHelperList(URL: webservices().baseurl + API_HELPER_DETAIL_ATTENDANCE, param:param, token: token as! String) { [self] JSON in
            switch JSON.result{
            case .success(let resp):
                
                arrPresentAttendance.removeAllObjects()
                arrAbsentAttendance.removeAllObjects()
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.arrAttendance = resp.data!
                    self.arrAttendanceData = resp.data!.attendanceData!
                    print("Attendance date :",self.arrAttendanceData)
                    for dic in self.arrAttendanceData
                    {
                        if(dic.isPresent == 1)
                        {
                            let meetingStartDate = self.strChangeDateFormate(strDateeee: dic.daysAttended!)
                            arrPresentAttendance.add(meetingStartDate)
                        }else{
                            let meetingStartDate = self.strChangeDateFormate(strDateeee: dic.daysAttended!)
                            arrAbsentAttendance.add(meetingStartDate)
                        }
                    }
            
                    print("arrPresentAttendance : ",arrPresentAttendance)
                    print("arrAbsentAttendance : ",arrAbsentAttendance)

                    let presentDays = (self.arrAttendance?.presentDays)!
                    let totalDays = (self.arrAttendance?.totalDays)!
                                        
                    self.lbldatePresentTotal.text = "total: \(presentDays)/\(totalDays)"
                    
                    if (self.arrAttendance?.attendanceData?.count)! > 0 {
                        print("self.arrAttendance?.attendanceData : ",self.arrAttendance?.attendanceData! ?? "")
                    }
                    
                    calenderView.dataSource = self
                    calenderView.delegate = self
                    calenderView.reloadData()
                   
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
                   // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
                   // self.present(alert, animated: true, completion: nil)
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
              //  print(err.asAFError!)
                
            }
        }
    }
    
    func apicallCalendarAttendanceAbsent() {
        
        if !NetworkState().isInternetAvailable {
             ShowNoInternetAlert()
             return
         }
 
         let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        let param : Parameters = [
            "DailyHelperID" : dailyHelperID!,
            "DatePresent" : strSelectCalendarDate
         ]
        
        print("calendar Attendance Absent param", param)

        webservices().StartSpinner()
        
       // Apicallhandler().APIAttenceHelperList(URL: webservices().baseurl + API_HELPER_DETAIL_ATTENDANCE_ABSENT, param:param, token: token as! String) { [self] JSON in
            
        Apicallhandler.sharedInstance.LogoutAPI(URL: webservices().baseurl + API_HELPER_DETAIL_ATTENDANCE_ABSENT, token: token  as! String) { [self] JSON in

            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    
                    lblPresent.isHidden = true
                    lblAbsent.isHidden = true
                    lbldateSelectDateCalendar.isHidden = true
                    btnPresent.isHidden = true
                    btnAbsent.isHidden = true
                    
                    apicallCalendarAttendance()
                    
                    print("calendar Attendance Absent ")

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
                   // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
                   // self.present(alert, animated: true, completion: nil)
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
              //  print(err.asAFError!)
                
            }
        }
    }
    
    func apicallCalendarAttendancePresent() {
        
        if !NetworkState().isInternetAvailable {
             ShowNoInternetAlert()
             return
         }
 
         let token = UserDefaults.standard.value(forKey: USER_TOKEN)
        
        let param : Parameters = [
            "DailyHelperID" : dailyHelperID!,
            "DatePresent" : strSelectCalendarDate
         ]
        
        print("calendar Attendance Present param", param)

        webservices().StartSpinner()
        
       // Apicallhandler().APIAttenceHelperList(URL: webservices().baseurl + API_HELPER_DETAIL_ATTENDANCE_PRESENT, param:param, token: token as! String) { [self] JSON in
        Apicallhandler.sharedInstance.LogoutAPI(URL: webservices().baseurl + API_HELPER_DETAIL_ATTENDANCE_PRESENT, token: token  as! String) { [self] JSON in

            switch JSON.result{
            case .success(let resp):
                
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    
                    lblPresent.isHidden = true
                    lblAbsent.isHidden = true
                    lbldateSelectDateCalendar.isHidden = true
                    btnPresent.isHidden = true
                    btnAbsent.isHidden = true
                    
                    apicallCalendarAttendance()
                    
                    print("calendar Attendance Present ")
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
                   // let alert = webservices.sharedInstance.AlertBuilder(title:Alert_Titel, message:resp.message!)
                   // self.present(alert, animated: true, completion: nil)
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
              //  print(err.asAFError!)
                
            }
        }
    }

    @IBAction func actionMenu(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAbsentPressed(_ sender: UIButton) {
        
            lblPresent.isHidden = false
            lblAbsent.isHidden = true
            lbldateSelectDateCalendar.isHidden = false
            btnPresent.isHidden = true
            btnAbsent.isHidden = false

          apicallCalendarAttendanceAbsent()
        
    }

    @IBAction func btnPresentPressed(_ sender: UIButton) {
        
        lblPresent.isHidden = true
        lblAbsent.isHidden = false
        lbldateSelectDateCalendar.isHidden = false
        btnPresent.isHidden = false
        btnAbsent.isHidden = true
        
        apicallCalendarAttendancePresent()
            
       // "user/daily-helper/attendance/present"
    }
    
    
}


@available(iOS 13.0, *)
extension  DomesticHelperAttendanceVC:FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance
{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
      //  if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
            let calendarnew = Calendar.current

           /* let year =  calendarnew.component(.year, from: date as Date)
               let month = calendarnew.component(.month, from: date as Date)
               let day = calendarnew.component(.day, from: date as Date) */
        
           let formatter = DateFormatter()
           formatter.dateFormat = "yyyy-MM-dd"
           
           formatter.dateFormat = "yyyy"
           let year = formatter.string(from: date)
           formatter.dateFormat = "MM"
           let month = formatter.string(from: date)
           formatter.dateFormat = "dd"
           let day = formatter.string(from: date)
           print(year, month, day) // 2018 12 24
            
            print("year:month:day :- ",year,month,day)
        
        let dot = "-"
        
        strSelectCalendarDate = "\(year)\(dot)\(month)\(dot)\(day)"
        
        print("SelectCalendarDate :- ",strSelectCalendarDate)
        
        let meetingStartDate = self.strChangeDateFormate1(strDateeee: strSelectCalendarDate)

        lbldateSelectDateCalendar.text = meetingStartDate
        
        print("lbldateSelectDateCalendar :- ",meetingStartDate)

        
      //  }
    }

    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        let key = self.dateFormatter1.string(from: date)
           
                if(arrPresentAttendance.contains(key))
                {
                   /* lblPresent.isHidden = true
                    lblAbsent.isHidden = false
                    lbldateSelectDateCalendar.isHidden = false
                    btnPresent.isHidden = true
                    btnAbsent.isHidden = false */
                    
                    lblPresent.isHidden = false
                    lblAbsent.isHidden = true
                    lbldateSelectDateCalendar.isHidden = false
                    btnPresent.isHidden = true
                    btnAbsent.isHidden = false
                    
                    print("date is selectable Green")

                }else{
                   /* lblPresent.isHidden = false
                    lblAbsent.isHidden = true
                    lbldateSelectDateCalendar.isHidden = false
                    btnPresent.isHidden = false
                    btnAbsent.isHidden = true */
                    
                    lblPresent.isHidden = true
                    lblAbsent.isHidden = false
                    lbldateSelectDateCalendar.isHidden = false
                    btnPresent.isHidden = false
                    btnAbsent.isHidden = true
                    
                    print("date is selectable Red")

                }
            
               return true
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
         let key = self.dateFormatter1.string(from: date)
         print("key",key)
         if(arrPresentAttendance.contains(key))
         {
            return AppColor.pollborderSelect
         }else if(arrAbsentAttendance.contains(key))
         {
            return UIColor.systemRed
         }
         else
         {
             return nil
         }
     }
    
    
 
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 1.0
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: strAddedCalendarDate)
        
        return date!
    }
    
  /* func maximumDate(for calendar: FSCalendar) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: strAddedCalendarDate)

        let myString = formatter.string(from: date!) // Date())
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "yyyy-MM-dd"
        let strCurrentDate = formatter.string(from: yourDate!)
        return self.dateFormatter2.date(from: strCurrentDate)!
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: strAddedCalendarDate)
        
        print("changed added date : ",date!)
    } */
    
}

extension Date
{
    func stringWithFormat(format: String) -> String {
      
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = format
      return dateFormatter.string(from: self)
    }
    
}
