//
//  AddNotice.swift
//  SocietyMangement
//
//  Created by Innovius on 08/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - AddNoticeResponse
struct AddNoticeResponse: Codable {
    let status: Int?
    let data: addNoticeData?
    let message: String?
}

// MARK: - DataClass
struct addNoticeData: Codable {
    let noticeID, noticeTypeID: Int?
    let title, datumDescription, publishDate, visibleTill: String?
    let createdBy, creationDate: String?
    let pollEnabled, multiPollEnable, societyID: Int?
    let attachments: [String]?

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

//// MARK: - AddNoticeResponse
//struct AddNoticeResponse: Codable {
//    let status: Int
//    let data: [addNoticeData]?
//    let message: String
//}
//
//// MARK: - addNoticeData
//struct addNoticeData: Codable {
//    let noticeID, noticeTypeID: Int?
//    let title, dataDescription: String?
//    let publishDate: String?
//    let visibleTill, createdBy, creationDate: String?
//    let pollEnabled, multiPollEnable, societyID: Int?
//    let attachments: [String?]
//
//    enum CodingKeys: String, CodingKey {
//        case noticeID = "NoticeID"
//        case noticeTypeID = "NoticeTypeID"
//        case title = "Title"
//        case dataDescription = "Description"
//        case publishDate = "PublishDate"
//        case visibleTill = "VisibleTill"
//        case createdBy = "CreatedBy"
//        case creationDate = "CreationDate"
//        case pollEnabled = "PollEnabled"
//        case multiPollEnable = "MultiPollEnable"
//        case societyID = "SocietyID"
//        case attachments  // temp comment 3/11/20.
//    }
//}

/*
// MARK: - AddNoticeResponse
struct AddNoticeResponse: Codable {
    let status: Bool
    let data: [addNoticeData]
    let message: String
}

// MARK: - DataClass
struct addNoticeData: Codable {
    let noticeID, noticeTypeID: Int?
    let title, dataDescription: String?
    let publishDate: String?
    let visibleTill, createdBy, creationDate: String?
    let pollEnabled, multiPollEnable, societyID: Int?
  //  let attachments: [String]?

    enum CodingKeys: String, CodingKey {
        case noticeID = "NoticeID"
        case noticeTypeID = "NoticeTypeID"
        case title = "Title"
        case dataDescription = "Description"
        case publishDate = "PublishDate"
        case visibleTill = "VisibleTill"
        case createdBy = "CreatedBy"
        case creationDate = "CreationDate"
        case pollEnabled = "PollEnabled"
        case multiPollEnable = "MultiPollEnable"
        case societyID = "SocietyID"
      //  case attachments
    }
}
 
 */

/*

// MARK: - AddNoticeResponse
struct AddNoticeResponse: Codable {
    let data: addNoticeData
    let status: Int
    let message: String
}

// MARK: - DataClass
struct addNoticeData: Codable {
    let societyID, buildingID: String?
    let userID: Int
    let title, dataDescription, viewTill, updatedAt: String?
    let createdAt: String?
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case societyID = "society_id"
        case buildingID = "building_id"
        case userID = "user_id"
        case title
        case dataDescription = "description"
        case viewTill = "view_till"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

*/

//// MARK: - AddNoticeResponse
//struct AddNoticeResponse: Codable {
//    let data: addNoticeData
//    let status, message: String
//}
//
//// MARK: - DataClass
//struct addNoticeData: Codable {
//    let societyID, buildingID: String?
//    let userID: Int
//    let title, dataDescription, viewTill, updatedAt: String?
//    let createdAt: String?
//    let id: Int
//
//    enum CodingKeys: String, CodingKey {
//        case societyID = "society_id"
//        case buildingID = "building_id"
//        case userID = "user_id"
//        case title
//        case dataDescription = "description"
//        case viewTill = "view_till"
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case id
//    }
//}
