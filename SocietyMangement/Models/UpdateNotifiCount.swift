//
//  UpdateNotifiCount.swift
//  SocietyMangement
//
//  Created by MacMini on 10/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - UpdateNotificationCount
struct UpdateNotificationCount: Codable {
    let data: UpdateNotificationData
    let status: Int
    let message: String
}

// MARK: - DataClass
struct UpdateNotificationData: Codable {
    let events, notices: String?
    let circulars: Int?
}
