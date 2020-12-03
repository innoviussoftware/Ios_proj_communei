//
//  PollList.swift
//  SocietyMangement
//
//  Created by MacMini on 23/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


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
    let isanswerSubmit:Int?

    enum CodingKeys: String, CodingKey {
        case optionText = "OptionText"
        case votes = "Votes"
        case noticePollOptionID = "NoticePollOptionID"
        case noticeID = "NoticeID"
        case isanswerSubmit = "isAnswerSubmitted"
    }
}
