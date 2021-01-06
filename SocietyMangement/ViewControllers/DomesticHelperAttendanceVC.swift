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
    
    @IBOutlet weak var lbldatePresent: UILabel!

    
    var arrAttendance : AttendanceSheet?

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
        
        calenderView.appearance.todayColor = UIColor.orange

        calenderView.appearance.todaySelectionColor = UIColor.orange
        
        let date = NSDate()
        let calendar = Calendar.current
        
         year =  calendar.component(.year, from: date as Date)
         month = calendar.component(.month, from: date as Date)
         day = calendar.component(.day, from: date as Date)
              
        print("year:month:day : ",year!,month!,day!)
        
        apicallCalendarAttendance()
        
    
        // Do any additional setup after loading the view.
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
        
        Apicallhandler().APIAttenceHelperList(URL: webservices().baseurl + API_HELPER_DETAIL_ATTENDANCE, param:param, token: token as! String) { JSON in
            switch JSON.result{
            case .success(let resp):
                webservices().StopSpinner()
                if(JSON.response?.statusCode == 200)
                {
                    self.arrAttendance = resp.data!
                    
                    let presentDays = self.arrAttendance?.presentDays
                    let totalDays = self.arrAttendance?.totalDays
                    
                    self.lbldatePresent.text = "total: \(presentDays!/totalDays!)"
                    
                    
                    if (self.arrAttendance?.attendanceData!.count)! > 0 {
                        
                        
                        
                    }else{
                        
                    }
                   
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
                    APPDELEGATE.ApiLogout1() // (onCompletion: { int in
                      //  if int == 1{
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        
                        let aVC = storyBoard.instantiateViewController(withIdentifier: "MobileNumberVC") as! MobileNumberVC
                                                                       let navController = UINavigationController(rootViewController: aVC)
                                                                       navController.isNavigationBarHidden = true
                                                          self.appDelegate.window!.rootViewController  = navController
                                                          
                     //   }
                   // })
                    
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

}


@available(iOS 13.0, *)
extension  DomesticHelperAttendanceVC:FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance
{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
      //  if monthPosition == .previous || monthPosition == .next {
            calendar.setCurrentPage(date, animated: true)
            let calendarnew = Calendar.current

            let year =  calendarnew.component(.year, from: date as Date)
               let month = calendarnew.component(.month, from: date as Date)
               let day = calendarnew.component(.day, from: date as Date)
            
            print("year:month:day :- ",year,month,day)
        
        let dot = "-"
        
        strSelectCalendarDate = "\(year)\(dot)\(month)\(dot)\(day)"
        
        print("SelectCalendarDate :- ",strSelectCalendarDate)

        
      //  }
    }

    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        
        let key = self.dateFormatter1.string(from: date)
            if(selecteddates.contains(key)) {
                   print("date is not selectable")
                   return false
            }else{
                print("date is selectable")
            }
               return true
    }
 
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderRadiusFor date: Date) -> CGFloat {
        return 1.0
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: strAddedCalendarDate)
        
        print("changed added date : ",date!)
    }
    
}
