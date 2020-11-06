//
//  EventResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let evenetResponse = try? newJSONDecoder().decode(EvenetResponse.self, from: jsonData)

import Foundation

// MARK: - EvenetResponse
struct EvenetResponse: Codable {
    let status: Int?
    let data: Event?
    let message: String?
}

// MARK: - DataClass
struct Event: Codable {
    let noticeID, noticeTypeID: Int?
    let title, datumDescription, publishDate, visibleTill: String?
    let eventTypeID: Int?
    let eventStartDate, eventEndDate, creationDate, createdBy: String?
    let pollEnabled, multiPollEnable, societyID: Int?
    let attachments: [String]?

    enum CodingKeys: String, CodingKey {
        case noticeID = "NoticeID"
        case noticeTypeID = "NoticeTypeID"
        case title = "Title"
        case datumDescription = "Description"
        case publishDate = "PublishDate"
        case visibleTill = "VisibleTill"
        case eventTypeID = "EventTypeID"
        case eventStartDate = "EventStartDate"
        case eventEndDate = "EventEndDate"
        case creationDate = "CreationDate"
        case createdBy = "CreatedBy"
        case pollEnabled = "PollEnabled"
        case multiPollEnable = "MultiPollEnable"
        case societyID = "SocietyID"
        case attachments
    }
}

