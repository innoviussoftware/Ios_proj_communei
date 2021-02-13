//
//  DeliveryatGateResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 26/11/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - DeliveryatGateResponse
struct DeliveryatGateResponse: Codable {
    let data: DeliveryatGate?
    let status: Int?
    let message: String?
}

// MARK: - DeliveryatGate
struct DeliveryatGate: Codable {
    let userActivityID, userActivityTypeID: Int
    let guardActivityID: Int?
    let societyID, visitorEntryID, visitingFlatID, propertyID: Int
    let dateLastUpadted: String?
    let inTime: String
    let isIn, isParent, userID: Int
  //  let parentActivityID: Int
    let isGuardActivity, estimatedTime: String?
    let activity: ActivityGate?

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
        case isGuardActivity = "IsGuardActivity"
        case estimatedTime = "EstimatedTime"
        case activity = "Activity"
    }
}

// MARK: - ActivityGate
struct ActivityGate: Codable {
    let activityType, name, phone, status: String
    let leaveAtGate, vendorID, companyName: String
    let companyLogoURL: String
    let activityIn, addedBy, dBy, approvedBy: String
    let materialAtGateID, rackID, materialQR, numberOfBoxes: Int
    let recivedBy, recivedAt, familyMembers, dispatcedBy: String
    let collectedBy, collectedAt, rackName: String

    enum CodingKeys: String, CodingKey {
        case activityType = "ActivityType"
        case name = "Name"
        case phone = "Phone"
        case status = "Status"
        case leaveAtGate = "LeaveAtGate"
        case vendorID = "VendorID"
        case companyName = "CompanyName"
        case companyLogoURL = "CompanyLogoURL"
        case activityIn = "In"
        case addedBy = "AddedBy"
        case dBy = "DBy"
        case approvedBy = "ApprovedBy"
        case materialAtGateID = "MaterialAtGateID"
        case rackID = "RackID"
        case materialQR = "MaterialQR"
        case numberOfBoxes = "NumberOfBoxes"
        case recivedBy = "RecivedBy"
        case recivedAt = "RecivedAt"
        case familyMembers = "FamilyMembers"
        case dispatcedBy = "DispatcedBy"
        case collectedBy = "CollectedBy"
        case collectedAt = "CollectedAt"
        case rackName = "RackName"
    }
}
