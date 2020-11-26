//
//  UserActivityTypeResponse.swift
//  SocietyMangement
//
//  Created by Macmini on 26/11/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - UserActivityTypeResponse
struct UserActivityTypeResponse: Codable {
    let data: [UserActivityType]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct UserActivityType: Codable {
    let userActivityTypeID: Int?
    let activityName: String?

    enum CodingKeys: String, CodingKey {
        case userActivityTypeID = "UserActivityTypeID"
        case activityName = "ActivityName"
    }
}
