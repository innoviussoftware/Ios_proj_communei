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
let USER_TOKEN = "user_token"
let USER_ID = "user_id"
let USER_NAME = "user_name"
let USER_EMAIL = "user_email"
let USER_PHONE = "user_phone"
let USER_SOCIETY_ID = "user_societyid"
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



let APILogin = "loginotp"
let APIRegister = "register"
let API_GET_CITY = "get/city"
let API_GET_AREA = "get/area"
let API_GET_SOCIETY = "get/society"
let API_GET_BUILDING = "get/building"
let API_GET_FLAT = "get/flat"
let API_EMAIL_VERIFY = "verifyemail"
let API_USER_ME = "user/me"

let API_USER_GET_CIRCULAR = "user/getcircular"
let API_ADD_NOTICE = "user/addnotice"
let API_GET_NOTICE = "user/getnotice"
let API_ACCEPT_DECLINE = "user/acceptreject"
let API_LOGOUT = "logout"
let API_GUEST_LIST = "user/guestlist"
let API_IN_OUT = "InOut"


let API_ADD_CIRCULAR = "user/addcircular"
let API_ADD_EVENT = "user/addevent"
let API_ADD_FAMILY_MEMBER = "user/addfamilymember"

let API_GET_EVENT = "user/getevent"
let API_GET_FAMAILY_MEMBER = "user/getfamilymember"
let API_MEMBER_LIST = "user/memberlist"

let API_DELETE_EVENT = "user/deleteevent"
let API_DELETE_CIRCULAR = "user/deletecircular"
let API_DELETE_NOTICE = "user/deletenotice"

let API_EDIT_CIRCULAR = "user/editcircular"
let API_EDIT_NOTICE = "user/editnotice"
let API_EDIT_EVENT = "user/editevent"


let API_UPDATE_FAMILY_MEMBER = "user/updatefamilymember"
let API_UPDATE_NOTICE = "user/editnotice"
let API_UPDATE_EVENT = "user/editevent"



let API_GET_VEHICLELIST = "user/vehicles/get"
let API_ADD_VEHICLE = "user/vehicles/store"



let API_UPDATE_PROFILE = "user/updateprofile"


let API_ADD_SETTING = "user/addsettings"

let API_GET_SETTING = "user/getsettings"

let API_GET_FREQUENTGUEST_LIST = "user/invitelist"



let API_ADD_FREQUENTGUEST = "user/addFrequentEntry"


let API_GET_MEMBERFAMILY_LIST = "user/memberfamily"

let API_DELETE_FREQUENTGUEST_ENTRY = "user/deletefrequent"

let API_HELPER_LIST = "helperslist"

let API_HELPER_DETAIL = "helpersdetails"

let API_ADD_RATINGS_REVIEW = "user/addreview"

let API_GET_REVIEWS = "user/review"

let API_DELETE_REVIEWS = "user/delreview"

let API_DELETE_GUEST = "deleteguest"


let API_NOTIFY_COUNT = "user/notify_count"

let API_UPDATE_NOTIFY_COUNT = "user/updatenotify"

let API_GET_HELP_DESK = "gethelpdesk"


let API_MY_HELPER_LIST = "user/myhelperslist"


let API_NOTIFICATION_LIST = "user/notificationlist"

let API_REMINDER = "user/reminder"


let API_DELETE_FAMILY_MEMBER = "user/deletefamilymember"



let API_SEND_OTP = "send_otp"

let API_DELETE_NOTIFICATION = "user/deletenotify"

let API_DELETE_VEHICLE = "user/vehicles/delete/"


let API_REFER_FRIEND = "sendref"

