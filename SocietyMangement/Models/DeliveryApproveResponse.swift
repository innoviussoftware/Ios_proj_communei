//
//  DeliveryApproveResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 08/02/21.
//  Copyright © 2021 MacMini. All rights reserved.
//

import Foundation

// MARK: - DeliveryApproveResponse
struct DeliveryApproveResponse: Codable {
    let data: [DeliveryApprove]?
    let status: Int?
    let message: String?
}

// MARK: - DeliveryApprove
struct DeliveryApprove: Codable {
    let userActivityID, userActivityTypeID, guardActivityID, societyID: Int?
    let visitorEntryID, visitingFlatID, propertyID: Int?
    let dateLastUpadted: String?
    let inTime: String?
    let isIn, isParent, userID: Int?
  //  let parentActivityID: JSONNull?
   // let isGuardActivity: Int
  //  let estimatedTime, messageID: JSONNull?
    let isWrongEntry, visitorEntryTypeID: Int?
    let creationDate: String?
    let activity: ActivityApprove?

    enum CodingKeys: String, CodingKey {
        case userActivityID = "UserActivityID"
        case userActivityTypeID = "UserActivityTypeID"
        case guardActivityID = "GuardActivityID"
        case societyID = "SocietyID"
        case visitorEntryID = "VisitorEntryID"
        case visitingFlatID = "VisitingFlatID"
        case propertyID = "PropertyID"
        case dateLastUpadted = "DateLastUpadted"
        case inTime = "InTime"
        case isIn = "IsIn"
        case isParent = "IsParent"
        case userID = "UserID"
      //  case parentActivityID = "ParentActivityID"
      //  case isGuardActivity = "IsGuardActivity"
      //  case estimatedTime = "EstimatedTime"
     //   case messageID = "MessageID"
        case isWrongEntry = "IsWrongEntry"
        case visitorEntryTypeID = "VisitorEntryTypeID"
        case creationDate = "CreationDate"
        case activity = "Activity"
    }
}

// MARK: - ActivityApprove
struct ActivityApprove: Codable {
    let activityType, name, phone: String?
    let profilePic: String?
  //let vehicle, shouldNotifyOnEntry: String?
    let status: String?
   //let dailyHelperID: String?
    let activityIn, addedBy, approvedBy, dBy: String?
    let vendorServiceTypeID: Int?
    let vendorServiceTypeName: String?

    enum CodingKeys: String, CodingKey {
        case activityType = "ActivityType"
        case name = "Name"
        case phone = "Phone"
        case profilePic = "ProfilePic"
       // case vehicle = "Vehicle"
       // case dailyHelperID = "DailyHelperID"
        case status = "Status"
      //  case shouldNotifyOnEntry = "ShouldNotifyOnEntry"
        case activityIn = "In"
        case addedBy = "AddedBy"
        case approvedBy = "ApprovedBy"
        case dBy = "DBy"
        case vendorServiceTypeID = "VendorServiceTypeID"
        case vendorServiceTypeName = "VendorServiceTypeName"
    }
}
