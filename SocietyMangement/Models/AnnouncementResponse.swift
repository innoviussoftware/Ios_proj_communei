//
//  AnnouncementResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 05/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - AnnouncementResponse
struct AnnouncementResponse: Codable {
    let data: [Announcement]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

// MARK: - Datum
struct Announcement: Codable {
    let id, memberID, societyID, buildingID: String
    let title, datumDescription, status, viewTill: String
    let createdDate, updatedDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case memberID = "member_id"
        case societyID = "society_id"
        case buildingID = "building_id"
        case title
        case datumDescription = "description"
        case status
        case viewTill = "view_till"
        case createdDate = "created_date"
        case updatedDate = "updated_date"
    }
}
