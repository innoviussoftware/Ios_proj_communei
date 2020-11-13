//
//  PollList.swift
//  SocietyMangement
//
//  Created by MacMini on 23/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


//// MARK: - PollListResponse
//struct PollListResponse: Codable {
//    let data: [PollListResponseData]?
//    let status: Int
//    let message: String
//}
//
//// MARK: - Datum
//struct PollListResponseData: Codable {
//    let id, societyID: Int?
//    let question, a1, a2, a3: String?
//    let a4, a1Userid, a2Userid: String?
//    let a3Userid, a4Userid: String?
//    let expiresOn: String?
//    let active: Int?
//    let createdAt, updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case societyID = "society_id"
//        case question, a1, a2, a3, a4
//        case a1Userid = "a1_userid"
//        case a2Userid = "a2_userid"
//        case a3Userid = "a3_userid"
//        case a4Userid = "a4_userid"
//        case expiresOn = "expires_on"
//        case active
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}


// MARK: - PollListResponse
struct PollListResponse: Codable {
    let data: [PollListResponseData]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct PollListResponseData: Codable {
    let noticeID, noticeTypeID: Int?
    let title, datumDescription, publishDate, visibleTill: String?
    let eventStartDate, eventEndDate: String?
    let creationDate, createdBy: String?
    let pollEnabled, multiPollEnable, societyID: Int?
    let attachments: [String]?
    let pollOptions: [PollOption]?
    let pollTotalVotes: Int?
    let readAt: String?

    enum CodingKeys: String, CodingKey {
        case noticeID = "NoticeID"
        case noticeTypeID = "NoticeTypeID"
        case title = "Title"
        case datumDescription = "Description"
        case publishDate = "PublishDate"
        case visibleTill = "VisibleTill"
        case eventStartDate = "EventStartDate"
        case eventEndDate = "EventEndDate"
        case creationDate = "CreationDate"
        case createdBy = "CreatedBy"
        case pollEnabled = "PollEnabled"
        case multiPollEnable = "MultiPollEnable"
        case societyID = "SocietyID"
        case attachments, pollOptions, pollTotalVotes
        case readAt = "ReadAt"
    }
}

// MARK: - PollOption
struct PollOption: Codable {
    let optionText: String?
    let votes, noticePollOptionID, noticeID: Int?

    enum CodingKeys: String, CodingKey {
        case optionText = "OptionText"
        case votes = "Votes"
        case noticePollOptionID = "NoticePollOptionID"
        case noticeID = "NoticeID"
    }
}



/*
// MARK: - PollListResponse
struct PollListResponse: Codable {
    let data: [PollListResponseData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct PollListResponseData: Codable {
    let id, societyID: Int?
    let question, a1, a2, a3: String?
    let a4, a1Userid, a2Userid, a3Userid: String?
    let a4Userid: String?
    let expiresOn: String?
    let active: Int?
    let createdAt, updatedAt: String?
    let percentage1, percentage2, percentage3, percentage4: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case question, a1, a2, a3, a4
        case a1Userid = "a1_userid"
        case a2Userid = "a2_userid"
        case a3Userid = "a3_userid"
        case a4Userid = "a4_userid"
        case expiresOn = "expires_on"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case percentage1, percentage2, percentage3, percentage4
    }
}

*/
