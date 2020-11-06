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
    let readAt: String?


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
        case readAt

    }
}


/*
 {
     "data": [
         {
             "NoticeID": 138,
             "NoticeTypeID": 1,
             "Title": "Test notice 20201030 03",
             "Description": "Test notice 20201030 01 description",
             "PublishDate": "2020-11-06 06:47:34",
             "VisibleTill": "2020-11-20 00:00:00",
             "CreatedBy": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
             "CreationDate": "2020-11-06 06:47:34",
             "PollEnabled": 0,
             "MultiPollEnable": 0,
             "SocietyID": 5,
             "attachments": [],
             "ReadAt": null
         }
     ],
     "status": 1,
     "message": "Get society notices done"
 }
 */
