//
//  GetHelpDesk.swift
//  SocietyMangement
//
//  Created by MacMini on 14/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - GetHelpDeskResponse
struct GetHelpDeskResponse: Codable {
    let data: [GetHelpDeskData]
    let status: Int
    let message: String
}

// MARK: - Datum
struct GetHelpDeskData: Codable {
    let id, societyID: Int?
    let societyName1, societyPhone1, societyName2, societyPhone2: String?
    let fire, police, policenumber, hostipalName: String?
    let hostipalPhone, ambulance, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case societyName1, societyPhone1, societyName2, societyPhone2, fire, police, policenumber, hostipalName, hostipalPhone, ambulance
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
