//
//  NoticeResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 31/05/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

//// MARK: - NoticesResponse
//struct NoticesResponse: Codable {
//    let data: [Notice]
//    let errorCode: Int
//    let message: String
//
//    enum CodingKeys: String, CodingKey {
//        case data
//        case errorCode = "error_code"
//        case message
//    }
//}
//
//// MARK: - Datum
//struct Notice: Codable {
//    let id, societyID, buildingID, memberID: String?
//    let title, datumDescription, viewTill, createdAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case societyID = "society_id"
//        case buildingID = "building_id"
//        case memberID = "member_id"
//        case title
//        case datumDescription = "description"
//        case viewTill = "view_till"
//        case createdAt = "created_at"
//    }
//}


//
//// MARK: - GetNoticeListResponse
//struct NoticesResponse: Codable {
//    let data: [Notice]?
//    let status : Int
//    let message: String
//}
//
//// MARK: - Datum
//struct Notice: Codable {
//    let id, societyID, buildingID, userID: Int?
//    let title, datumDescription, viewTill, createdAt: String?
//    let updatedAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case societyID = "society_id"
//        case buildingID = "building_id"
//        case userID = "user_id"
//        case title
//        case datumDescription = "description"
//        case viewTill = "view_till"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}

// MARK: - NoticesResponse
struct NoticesResponse: Codable {
    let data: [Notice]
    let status: Bool
    let message: String
}

// MARK: - Datum
struct Notice: Codable {
    let noticeID, noticeTypeID: Int?
    let title, datumDescription: String?
    let publishDate: String?
    let visibleTill, createdBy, creationDate: String?
    let pollEnabled, multiPollEnable, societyID: Int?
  //  let attachments: String?
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
       // case attachments
        case readAt = "ReadAt"
    }
}


/* // 27/10/20.
// MARK: - NoticesResponse
struct NoticesResponse: Codable {
    let data: [Notice]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Notice: Codable {
    let id, societyID: Int?
    let buildingID: String?
    let userID: Int?
    let title, datumDescription, viewTill, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case buildingID = "building_id"
        case userID = "user_id"
        case title
        case datumDescription = "description"
        case viewTill = "view_till"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

*/
