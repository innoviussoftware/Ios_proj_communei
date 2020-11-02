//
//  GetSettingsResp.swift
//  SocietyMangement
//
//  Created by Innovius on 22/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - GetSettings
struct GetSettings: Codable {
    let data: [getSettingData]
    let status: Int
    let message: String
}

// MARK: - Datum
struct getSettingData: Codable {
    let id, userID: Int?
    let receiverID: String?
    let event, notice, circular, contactDetails: Int?
    let familyDetails: Int?
    let mute_notification_status:Int?
    let reason_to_mute_notification :String?
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
        case mute_notification_status
        case reason_to_mute_notification
    }
}
