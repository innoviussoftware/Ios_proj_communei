//
//  NotificationList.swift
//  SocietyMangement
//
//  Created by MacMini on 15/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - NotificationListResp
struct NotificationListResp: Codable {
    let data: [NotificationListData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct NotificationListData: Codable {
    let text: String?
    let id, type, isread: Int?
}
