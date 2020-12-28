//
//  UserActivityAllResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 26/11/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - UserActivityAllResponse
struct UserActivityAllResponse: Codable {
    let data: [UserActivityAll]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct UserActivityAll: Codable {
    let userActivityID, userActivityTypeID: Int?
    let guardActivityID: Int?
    let societyID: Int?
    let visitorEntryID, visitingFlatID, visitorEntryTypeID: Int?
    let propertyID: Int?
    let dateLastUpadted: String?
    let inTime: String?
    let isIn, isParent, userID: Int?
   // let parentActivityID: Int?
   // let isGuardActivity, estimatedTime: String?
    let activity: ActivityAll?

    enum CodingKeys: String, CodingKey {
        case userActivityID = "UserActivityID"
        case userActivityTypeID = "UserActivityTypeID"
        case guardActivityID = "GuardActivityID"
        case societyID = "SocietyID"
        case visitorEntryID = "VisitorEntryID"
        case visitingFlatID = "VisitingFlatID"
        case visitorEntryTypeID = "VisitorEntryTypeID"
        case propertyID = "PropertyID"
        case dateLastUpadted = "DateLastUpadted"
        case inTime = "InTime"
        case isIn = "IsIn"
        case isParent = "IsParent"
        case userID = "UserID"
      //  case parentActivityID = "ParentActivityID"
      //  case isGuardActivity = "IsGuardActivity"
      //  case estimatedTime = "EstimatedTime"
        case activity = "Activity"
    }
}

// MARK: - Activity
struct ActivityAll: Codable {
    let activityType: String?
    let name: String?
    let phone: String?
    let vendor: String?
    let profilePic: String?
    let vehicle: String?
    let vehicleTypeID: String?
    let creationDate: String?
    let numberOfPeopleAccompanying: String?
    let status, messageStatus, messageBy, emergencyAlertType, message, complaintType: String?
    let messageAttachment : String?
    let activityIn: String?
    let addedBy, cancelledBy: String?
    let removedBy: String?
    let out, leaveAtGate, vendorID, companyName: String?
    let allowedInTime,allowedOutTime : String?
    let companyLogoURL: String?
    let approvedBy: String?
    let societyName: String?
    let propertyFullName: String?
    let isMulti, entryType: String?
    let visitorPreApprovalID, activityID: Int?
    let qr: String?
    let qrURL: String?
    let vehicleNumber: String?

    enum CodingKeys: String, CodingKey {
        case activityType = "ActivityType"
        case name = "Name"
        case phone = "Phone"
        case vendor = "Vendor"
        case profilePic = "ProfilePic"
        case vehicle = "Vehicle"
        case vehicleTypeID = "VehicleTypeID"
        case creationDate = "CreationDate"
        case numberOfPeopleAccompanying = "NumberOfPeopleAccompanying"
        case status = "Status"
        case messageStatus = "MessageStatus"
        case messageBy = "MessageBy"
        case message = "Message"
        case emergencyAlertType = "EmergencyAlertType"
        case complaintType = "ComplaintType"
        case messageAttachment = "MessageAttachment"
        case activityIn = "In"
        case allowedInTime = "AllowedInTime"
        case allowedOutTime = "AllowedOutTime"
        case addedBy = "AddedBy"
        case cancelledBy = "CancelledBy"
        case removedBy = "RemovedBy"
        case out = "Out"
        case leaveAtGate = "LeaveAtGate"
        case vendorID = "VendorID"
        case companyName = "CompanyName"
        case companyLogoURL = "CompanyLogoURL"
        case approvedBy = "ApprovedBy"
        case societyName = "SocietyName"
        case propertyFullName = "PropertyFullName"
        case isMulti = "IsMulti"
        case entryType = "EntryType"
        case visitorPreApprovalID = "VisitorPreApprovalID"
        case activityID = "ActivityID"
        case qr = "QR"
        case qrURL = "QRUrl"
        case vehicleNumber = "VehicleNumber"
    }
}











