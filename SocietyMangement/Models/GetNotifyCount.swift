//
//  GetNotifyCount.swift
//  SocietyMangement
//
//  Created by MacMini on 09/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//


import Foundation


// MARK: - NotificationCount
struct NotificationCount: Codable {
    let data: [NotificationCountData]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct NotificationCountData: Codable {
    let noticeTypeID: Int?
    let name: String?
    let count: Int?

    enum CodingKeys: String, CodingKey {
        case noticeTypeID = "NoticeTypeID"
        case name = "Name"
        case count = "Count"
    }
}


/*


// MARK: - NotificationCount
struct NotificationCount: Codable {
    let data: [NotificationCountData]
    let status: Int
    let message: String
}

// MARK: - Datum
struct NotificationCountData: Codable {
    let title: String?
    let count: Int?
}

 */
