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

//// MARK: - EvenetResponse
//struct EvenetResponse: Codable {
//    let data: [Event]
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
//struct Event: Codable {
//    let id, societyID, buildingID, memberID: String
//    let eventType, title, datumDescription, eventStartDate: String
//    let eventStartTime, eventEndDate, eventEndTime, eventAttachment: String
//    let createdAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case societyID = "society_id"
//        case buildingID = "building_id"
//        case memberID = "member_id"
//        case eventType = "event_type"
//        case title
//        case datumDescription = "description"
//        case eventStartDate = "event_start_date"
//        case eventStartTime = "event_start_time"
//        case eventEndDate = "event_end_date"
//        case eventEndTime = "event_end_time"
//        case eventAttachment = "event_attachment"
//        case createdAt = "created_at"
//    }
//}



// MARK: - GetFamilyMember
struct EvenetResponse: Codable {
    let data: [Event]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Event: Codable {
    let id, societyID: Int?
    let buildingID: String?
    let userID: Int?
    let eventType, title, datumDescription, eventStartDate: String?
    let eventStartTime, eventEndDate, eventEndTime, eventAttachment: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case buildingID = "building_id"
        case userID = "user_id"
        case eventType = "event_type"
        case title
        case datumDescription = "description"
        case eventStartDate = "event_start_date"
        case eventStartTime = "event_start_time"
        case eventEndDate = "event_end_date"
        case eventEndTime = "event_end_time"
        case eventAttachment = "event_attachment"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
