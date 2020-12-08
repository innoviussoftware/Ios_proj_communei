//
//  GetDaysResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 08/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - GetDaysResponse
struct GetDaysResponse: Codable {
    let data: [GetDays]?
    let status: Int?
    let message: String?
}

// MARK: - GetDays
struct GetDays: Codable {
    let daysTypeID: Int?
    let daysName: String?
}
