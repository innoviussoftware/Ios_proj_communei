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
