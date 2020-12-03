//
//  GetRecentContactResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 03/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation

// MARK: - GetRecentContactResponse
struct GetRecentContactResponse: Codable {
    let data: [GetRecentEntryList]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct GetRecentEntryList: Codable {
    let name, phone: String?

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case phone = "Phone"
    }
}
