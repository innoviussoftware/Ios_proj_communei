//
//  constant.swift
//  E-clinical
//
//  Created by APS on 25/05/19.
//  Copyright © 2019 MacMini. All rights reserved.
//

import Foundation
import UIKit


let Alert_Titel = "Communei"
let Role_Doctor = "doctor"

@available(iOS 13.0, *)
let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate

struct FunctionsConstants {
   
   static let kSharedUserDefaults = UserDefaults.standard
    @available(iOS 13.0, *)
    static let kSharedAppDelegate = UIApplication.shared.delegate as! AppDelegate
   static let kScreenWidth = UIScreen.main.bounds.width
   static let kScreenHeight = UIScreen.main.bounds.height
 }

struct GeneralConstants {
  
  static let kAppName = "Communei"
  static let kDeviceType = "1"
}

struct AlertConstants {
  
  static let PLEASE_SELECT_COUNTRY = "Choose Country"
  static let OK = "Ok"
  static let CANCEL = "Cancel"
  static let DONE = "Done"
  static let SUBMIT = "Submit"
    
}

let USER_ROLE = "role"

let USER_SECRET = "Secret"

let USER_TOKEN = "token"
let USER_ID = "user_id"
let USER_NAME = "user_name"
let USER_EMAIL = "user_email"
let USER_PHONE = "user_phone"
let USER_SOCIETY_ID =  "Society"   // "user_societyid" // "SocietyID" //
let USER_PROFILE_PIC = "profile_img"

let USER_BUILDING_ID = "building_id"


//For setting

let USER_SETTING_CIRCULAR_SHOW = "user_setting_circular_show"
let USER_SETTING_NOTICE_SHOW = "user_setting_notice_show"
let USER_SETTING_EVENT_SHOW = "user_setting_event_show"
let USER_SETTING_CONTACT_SHOW = "user_setting_contact_show"
let USER_SETTING_FAMILY_SHOW = "user_setting_family_show"

let USER_MEMBER_SHOW = "user_member_show"



//API Name

// post

let APILogin =  "user/signin/otp"      //"loginotp"
let APIRegister = "user/register"      //"register"
let API_GET_CITY = "communei/cities"   //"get/city"
let API_GET_AREA = "communei/areas"    //"get/area"
let API_GET_SOCIETY = "communei/societies"     //"get/society"
let API_GET_BUILDING = "communei/properties"  //"get/building"
let API_GET_FLAT = "communei/properties"   //"get/flat"
let API_EMAIL_VERIFY = "verifyemail"
let API_USER_ME = "user"   //  "user/me"

let API_GET_BUILDING_SOCIETY = "society/properties"  //"get/building"


let API_USER_GET_CIRCULAR = "user/notices/2"  //"user/getcircular"
let API_ADD_NOTICE = "society/notices/1/add"  // "user/addnotice"
let API_GET_NOTICE =  "user/notices/1" //  "user/getnotice"  // "society/notices/1" // 
let API_ACCEPT_DECLINE = "user/acceptreject"

let API_ACTIVITY_CANCEL = "user/pre-approved/cancel"

let API_ACTIVITY_EXIT_OUT = "user/pre-approved/exit"

let API_ACTIVITY_WRONG_ENTRY  = "user/pre-approved/wrong-entry"

let API_LOGOUT = "user/signout" //"logout"
let API_IN_OUT = "InOut"

let API_DELIVERY_LEAVE_GATE = "user/pre-approved/2/leave-at-gate"


let API_ADD_CIRCULAR = "society/notices/2/add" //"user/addcircular"
let API_ADD_EVENT = "society/notices/3/add" // "user/addevent"
let API_ADD_FAMILY_MEMBER = "user/family/add"  // "user/addfamilymember"

let API_GET_EVENT = "user/notices/3" //"society/notices/3" //"user/getevent"
let API_GET_FAMAILY_MEMBER = "user/family"  // "user/getfamilymember"
let API_MEMBER_LIST =  "user/society-members/" //"user/memberlist"

let API_MEMBER_LIST_SEARCH =  "user/search" //"user/society-members/" //"user/memberlist"


let API_GET_FAMAILY_MEMBER_PROFILE = "society/family/"  // "user/getfamilymember"


let API_DELETE_EVENT =  "society/notices/3/delete" // "user/deleteevent"
let API_DELETE_CIRCULAR = "society/notices/2/delete" //"user/deletecircular"
let API_DELETE_NOTICE = "society/notices/1/delete"  //"user/deletenotice"

let API_EDIT_CIRCULAR = "society/notices/2/edit" //"user/editcircular"
let API_EDIT_NOTICE = "user/editnotice"
let API_EDIT_EVENT = "user/editevent"

let API_GUEST_LIST = "user/activity" //"user/guestlist"

let API_USER_ACTIVITY_LIST = "user/activity" //"user/guestlist"

let API_USER_ACTIVITY_LIST_FILTER_SEARCH = "user/activity/"

let API_USER_ACTIVITYTYPES = "user/activity-types"


// GetAllCompanySelectDetails

let API_USER_COMPANY_SELECT = "user/vendors/2"



let API_UPDATE_FAMILY_MEMBER = "user/family/edit" // "user/updatefamilymember"
let API_UPDATE_NOTICE = "society/notices/1/edit" // "user/editnotice"
let API_UPDATE_EVENT = "society/notices/3/edit" // "user/editevent"

let API_USER_RECENT_ENTRY = "user/visitors/recent"


let API_GET_VEHICLELIST = "user/vehicles"   // "user/vehicles/get"

let API_GET_VEHICLELISTTYPE = "communei/vehicles/types"

let API_ADD_VEHICLE = "user/vehicle/add" // "user/vehicles/store"

let API_GET_EVENTLISTTYPE = "society/notices/3/types"



let API_UPDATE_PROFILE = "user/profile"  // "user/updateprofile"


let API_ADD_SETTING = "user/addsettings"

let API_GET_SETTING = "user/getsettings"

let API_GET_FREQUENTGUEST_LIST = "user/invitelist"



let API_ADD_FREQUENTGUEST = "user/pre-approved/1/add" //"user/addFrequentEntry"

let API_ADD_DELIVERYENTRY = "user/pre-approved/2/add" //"user/addFrequentEntry"

let API_GET_WEEKDAYD = "communei/weekdays"

let API_ADD_CABENTRY = "user/pre-approved/3/add"

let API_GET_MEMBERFAMILY_LIST = "user/memberfamily"

let API_DELETE_FREQUENTGUEST_ENTRY = "user/deletefrequent"

let API_HELPER_LIST = "helperslist"

let API_HELPER_DETAIL = "helpersdetails"

let API_ADD_RATINGS_REVIEW = "user/addreview"

let API_GET_REVIEWS = "user/review"

let API_DELETE_REVIEWS = "user/delreview"

let API_DELETE_GUEST = "deleteguest"


let API_NOTIFY_COUNT = "user/notice/details"  // "user/notify_count"

let API_UPDATE_NOTIFY_COUNT = "user/updatenotify"

let API_GET_HELP_DESK = "gethelpdesk"


let API_MY_HELPER_LIST = "user/myhelperslist"


let API_NOTIFICATION_LIST = "user/notificationlist"

let API_REMINDER = "user/reminder"


let API_DELETE_FAMILY_MEMBER =  "user/family/delete" // "user/deletefamilymember"

let API_SEND_OTP = "send_otp"

let API_DELETE_NOTIFICATION = "user/deletenotify"

let API_DELETE_VEHICLE = "user/vehicles/delete"


let API_REFER_FRIEND = "sendref"


// 25/8/20.

let API_BUY_SELL_LIST = "categorieslist"

let API_BUY_SELL_PRODUCT = "user/getproduct"

let API_BUY_SELL_PRODUCT_DELETE = "user/deleteproduct"

let API_BUY_SELL_PRODUCT_EDIT = "user/editproduct"


let API_RELATED_PRODUCT = "user/relatedproduct"



let API_ADD_PRODUCT = "user/addproduct"




let API_GET_POLL_LIST =  "user/notices/4" // "user/pollslist"

let API_GET_POLL_LIST_VOTE =  "user/notices/4/vote"


let API_POLL_DETAIL = "user/pollsresult"


let API_GET_AMENITIES_LIST = "society/amenities"  //"amenties"

let API_GET_BOOKINGS_LIST = "user/amenity/bookings"  

let API_DELETE_BOOKING_ENTRY = "user/amenity/bookings/delete"
