//
//  GetFrequentEntryList.swift
//  SocietyMangement
//
//  Created by Innovius on 23/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - GetFrequentEntryList
struct GetFrequentEntryList: Codable {
    let data: [GetFrequentEntryListData]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct GetFrequentEntryListData: Codable {
    let visitorID: Int?
    let activity: Activity?

    enum CodingKeys: String, CodingKey {
        case visitorID = "VisitorID"
        case activity = "Activity"
    }
}

// MARK: - Activity
struct Activity: Codable {
    let activityType, name, phone, activityIn: String?
    let out, societyName, propertyFullName, isMulti: String?
    let entryType, pic, status, addedBy: String?
    let visitorPreApprovalID, activityID: Int?
    let qr: String?
    let qrURL: String?

    enum CodingKeys: String, CodingKey {
        case activityType = "ActivityType"
        case name = "Name"
        case phone = "Phone"
        case activityIn = "In"
        case out = "Out"
        case societyName = "SocietyName"
        case propertyFullName = "PropertyFullName"
        case isMulti = "IsMulti"
        case entryType = "EntryType"
        case pic = "Pic"
        case status = "Status"
        case addedBy = "AddedBy"
        case visitorPreApprovalID = "VisitorPreApprovalID"
        case activityID = "ActivityID"
        case qr = "QR"
        case qrURL = "QRUrl"
    }
}

/*
// MARK: - GetFrequentEntryList
struct GetFrequentEntryList: Codable {
    let data: [GetFrequentEntryListData]
    let status: Int
    let message: String
}

// MARK: - Datum
struct GetFrequentEntryListData: Codable {
    let id, userID, societyID: Int?
    let type, time, maxhour, startDate ,code: String?
    let endDate, contactName, contactNumber, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case societyID = "society_id"
        case type, time, maxhour
        case startDate = "start_date"
        case endDate = "end_date"
        case contactName = "contact_name"
        case contactNumber = "contact_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case code
         
    }
}

 */
