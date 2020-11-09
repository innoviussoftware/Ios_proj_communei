//
//  CircularResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation


// MARK: - Welcome
struct CircularResponse: Codable {
    let data: [Circular]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct Circular: Codable {
    let noticeID, noticeTypeID: Int?
    let title, datumDescription, publishDate, visibleTill: String?
    let createdBy, creationDate: String?
    let pollEnabled, multiPollEnable, societyID: Int?
    let attachments: [String]?
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
        case readAt = "ReadAt"
    }
}

/*
 

// MARK: - GetFamilyMember
struct CircularResponse: Codable {
    let data: [Circular]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Circular: Codable {
    let id, userID, societyID: Int?
    let buildingID, title, datumDescription, pdffile, name: String?
    let createdAt, updatedAt: String?
    // 1/9/20.
   // let name: String

    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case societyID = "society_id"
        case buildingID = "building_id"
        case title
        case name
        case datumDescription = "description"
        case pdffile
        case createdAt = "created_at"
        case updatedAt = "updated_at"
       // case name
    }
}

*/
