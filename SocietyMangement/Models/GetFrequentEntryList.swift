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
