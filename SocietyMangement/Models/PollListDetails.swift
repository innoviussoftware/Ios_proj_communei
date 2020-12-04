//
//  PollListDetails.swift
//  SocietyMangement
//
//  Created by Macmini on 04/12/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - PollListDetails
struct PollListDetails: Codable {
    let data: PollListData?
    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct PollListData: Codable {
    let noticeID, noticeTypeID: Int?
    let title, dataDescription, publishDate, visibleTill: String?
    let eventStartDate, eventEndDate: String?
    let creationDate, createdBy: String?
    let pollEnabled, multiPollEnable, societyID: Int?
    let readAt: String?
    let attachments: [String]?
    let pollOptions: [PollOptionData]?
    let pollTotalVotes, isAnswerSubmitted: Int?

    enum CodingKeys: String, CodingKey {
        case noticeID = "NoticeID"
        case noticeTypeID = "NoticeTypeID"
        case title = "Title"
        case dataDescription = "Description"
        case publishDate = "PublishDate"
        case visibleTill = "VisibleTill"
        case eventStartDate = "EventStartDate"
        case eventEndDate = "EventEndDate"
        case creationDate = "CreationDate"
        case createdBy = "CreatedBy"
        case pollEnabled = "PollEnabled"
        case multiPollEnable = "MultiPollEnable"
        case societyID = "SocietyID"
        case readAt = "ReadAt"
        case attachments, pollOptions, pollTotalVotes, isAnswerSubmitted
    }
}

// MARK: - PollOptionData
struct PollOptionData: Codable {
    let optionText: String?
    let votes, noticePollOptionID, noticeID, isAnswerSubmitted: Int?

    enum CodingKeys: String, CodingKey {
        case optionText = "OptionText"
        case votes = "Votes"
        case noticePollOptionID = "NoticePollOptionID"
        case noticeID = "NoticeID"
        case isAnswerSubmitted
    }
}
