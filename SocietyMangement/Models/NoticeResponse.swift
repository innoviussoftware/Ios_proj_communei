//
//  NoticeResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - NoticesResponse
struct NoticesResponse: Codable {
    let status: Int?
    let data: [Notice]?
    let message: String?
}

// MARK: - DataClass
struct Notice: Codable {
    let noticeID, noticeTypeID: Int
    let title, datumDescription, publishDate, visibleTill: String
    let createdBy, creationDate: String
    let pollEnabled, multiPollEnable, societyID: Int
    let attachments: [String?]

    enum CodingKeys: String, CodingKey {
        case noticeID = "NoticeID"
        case noticeTypeID = "NoticeTypeID"
        case title = "Title"
        case datumDescription = "Description"
        case publishDate = "PublishDate"
        case visibleTill = "VisibleTill"
        case createdBy = "CreatedBy"
        case creationDate = "CreationDate"
        case pollEnabled = "PollEnabled"
        case multiPollEnable = "MultiPollEnable"
        case societyID = "SocietyID"
        case attachments
    }
}

