//
//  AddSetting.swift
//  SocietyMangement
//
//  Created by Innovius on 22/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - AddSettingResponse
struct AddSettingResponse: Codable {
    let data: AddSettingData?
    let status: Int
    let message: String
}

// MARK: - DataClass
struct AddSettingData: Codable {
    let doNotDisturb, visitorNotifyOnEntry, domesticNotifyOnEntry, shareContactDetails: Int
    let shareFamilyMemberDetails, domesticNotifyOnExit, visitorNotifyOnExit, othersNotifyOnEntry: Int
    let othersNotifyOnExit: Int

    enum CodingKeys: String, CodingKey {
        case doNotDisturb = "DoNotDisturb"
        case visitorNotifyOnEntry = "VisitorNotifyOnEntry"
        case domesticNotifyOnEntry = "DomesticNotifyOnEntry"
        case shareContactDetails = "ShareContactDetails"
        case shareFamilyMemberDetails = "ShareFamilyMemberDetails"
        case domesticNotifyOnExit = "DomesticNotifyOnExit"
        case visitorNotifyOnExit = "VisitorNotifyOnExit"
        case othersNotifyOnEntry = "OthersNotifyOnEntry"
        case othersNotifyOnExit = "OthersNotifyOnExit"
    }
}

/*
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

 */
