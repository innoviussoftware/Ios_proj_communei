//
//  MyHelperList.swift
//  SocietyMangement
//
//  Created by MacMini on 14/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - MyHelperListResp
struct MyHelperListResp: Codable {
    let data: [MyHelperListData]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct MyHelperListData: Codable {
    let dailyHelpPropertyID, dailyHelperID, propertyID, societyID: Int?
    let vendorServiceTypeID, createdBy, updatedBy: Int?
    let createdAt, updatedAt: String?
    let isServing, shouldNotifyOnEntry, holdService: Int?
    let dailyHelperCard: DailyHelperCard?

    enum CodingKeys: String, CodingKey {
        case dailyHelpPropertyID = "DailyHelpPropertyID"
        case dailyHelperID = "DailyHelperID"
        case propertyID = "PropertyID"
        case societyID = "SocietyID"
        case vendorServiceTypeID = "VendorServiceTypeID"
        case createdBy = "CreatedBy"
        case updatedBy = "UpdatedBy"
        case createdAt = "Created_At"
        case updatedAt = "Updated_At"
        case isServing = "IsServing"
        case shouldNotifyOnEntry = "ShouldNotifyOnEntry"
        case holdService = "HoldService"
        case dailyHelperCard = "DailyHelperCard"
    }
}

// MARK: - DailyHelperCard
struct DailyHelperCard: Codable {
    let name, phone: String?
    let profilePic: String?
    let status, dailyHelperID: String?
    let dailyHelpPropertyID: Int?
    let vendorServiceTypeName, averageRating: String?
    let shouldNotifyOnEntry, holdService: Int?
    let isServing, addedOn, addedBy: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case phone = "Phone"
        case profilePic = "ProfilePic"
        case status = "Status"
        case dailyHelperID = "DailyHelperID"
        case dailyHelpPropertyID = "DailyHelpPropertyID"
        case vendorServiceTypeName = "VendorServiceTypeName"
        case averageRating = "AverageRating"
        case shouldNotifyOnEntry = "ShouldNotifyOnEntry"
        case holdService = "HoldService"
        case isServing = "IsServing"
        case addedOn = "AddedOn"
        case addedBy = "AddedBy"
    }
}



/*
 
 
// MARK: - MyHelperListResp
struct MyHelperListResp: Codable {
    let data: [MyHelperListData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct MyHelperListData: Codable {
    let id: Int?
    let name, pin, mobile, photos: String?
    let memberID, gender, createdAt, typename: String?
    let averageRating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, pin, mobile, photos
        case memberID = "Member_id"
        case gender
        case createdAt = "created_at"
        case typename
        case averageRating = "average_rating"
    }
}
 
*/
