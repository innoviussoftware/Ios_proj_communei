//
//  UserNewResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 25/01/21.
//  Copyright © 2021 MacMini. All rights reserved.
//

import Foundation


// MARK: - UserNewResponse
struct UserNewResponse: Codable {
    let data: [ActivityyyDatum]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct ActivityyyDatum: Codable {
    let userActivityID, userActivityTypeID: Int
    let guardActivityID: Int?
    let societyID: Int?
    let visitorEntryID, visitingFlatID: Int?
    let propertyID: Int
    let dateLastUpadted, inTime: String?
    let isIn, isParent, userID: Int
    let parentActivityID: Int?
    let isGuardActivity: Int
  //  let estimatedTime: String?
    let messageID: Int?
    let isWrongEntry, visitorEntryTypeID: Int
    let creationDate: String
    let visitorID: Int
    let activity: Activityyy?

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
        case parentActivityID = "ParentActivityID"
        case isGuardActivity = "IsGuardActivity"
       // case estimatedTime = "EstimatedTime"
        case messageID = "MessageID"
        case isWrongEntry = "IsWrongEntry"
        case visitorEntryTypeID = "VisitorEntryTypeID"
        case creationDate = "CreationDate"
        case visitorID = "VisitorID"
        case activity = "Activity"
    }
}

// MARK: - Activity
struct Activityyy: Codable {
    let activityType, name, phone, activityIn: String
    let out, societyName, daysOfWeek, validFor: String
    let propertyFullName, isMulti, profilePic, status: String
    let approvedBy, addedBy: String
    let visitorPreApprovalID, activityID: Int
    let qr: String
    let qrURL: String
    let shareInviteURL: String

    enum CodingKeys: String, CodingKey {
        case activityType = "ActivityType"
        case name = "Name"
        case phone = "Phone"
        case activityIn = "In"
        case out = "Out"
        case societyName = "SocietyName"
        case daysOfWeek = "DaysOfWeek"
        case validFor = "ValidFor"
        case propertyFullName = "PropertyFullName"
        case isMulti = "IsMulti"
        case profilePic = "ProfilePic"
        case status = "Status"
        case approvedBy = "ApprovedBy"
        case addedBy = "AddedBy"
        case visitorPreApprovalID = "VisitorPreApprovalID"
        case activityID = "ActivityID"
        case qr = "QR"
        case qrURL = "QRUrl"
        case shareInviteURL = "ShareInviteUrl"
    }
}
