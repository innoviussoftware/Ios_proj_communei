//
//  CircularResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation

//
//// MARK: - GetCircularResponse
//struct CircularResponse: Codable {
//    let data: [Circular]
//    let status: Int
//    let message: String
//}
//
//// MARK: - Datum
//struct Circular: Codable {
//    let id, userID, societyID: Int
//    let buildingID, title, datumDescription, pdffile: String?
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case societyID = "society_id"
//        case buildingID = "building_id"
//        case title
//        case datumDescription = "description"
//        case pdffile
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}


// MARK: - GetFamilyMember
struct CircularResponse: Codable {
    let data: [Circular]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Circular: Codable {
    let id, userID, societyID: Int?
    let buildingID, title, datumDescription, pdffile: String?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case societyID = "society_id"
        case buildingID = "building_id"
        case title
        case datumDescription = "description"
        case pdffile
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
