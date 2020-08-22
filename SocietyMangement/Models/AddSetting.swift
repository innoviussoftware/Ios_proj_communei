//
//  AddSetting.swift
//  SocietyMangement
//
//  Created by Innovius on 22/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

//
//// MARK: - add setting
//struct AddSettingResponse: Codable {
//    let data: AddSettingData
//    let status: Int
//    let message: String
//}
//
//// MARK: - DataClass
//struct AddSettingData: Codable {
//    let userID: Int
//    let receiverID, event, notice, circular: String?
//    let contactDetails, familyDetails, updatedAt, createdAt: String?
//    let id: Int
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "user_id"
//        case receiverID = "receiver_id"
//        case event, notice, circular
//        case contactDetails = "contact_details"
//        case familyDetails = "family_details"
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case id
//    }
//}


// MARK: - GetSettings
struct AddSettingResponse: Codable {
    let data: AddSettingData
    let status: Int
    let message: String
}

// MARK: - DataClass
struct AddSettingData: Codable {
    let id, userID: Int?
    let receiverID: String?
    let event, notice, circular, contactDetails: Int?
    let familyDetails: Int?
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case receiverID = "receiver_id"
        case event, notice, circular
        case contactDetails = "contact_details"
        case familyDetails = "family_details"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
