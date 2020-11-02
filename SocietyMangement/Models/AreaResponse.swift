//
//  AreaResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - City
struct AreaResponse: Codable {
    let data: [Area]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Area: Codable {
    let AreaID, CityID: Int
    let AreaName: String
    
    enum CodingKeys: String, CodingKey {
        case AreaID
        case CityID    // = "city_id"
        case AreaName
    }
}


//// MARK: - AreaResponse
//struct AreaResponse: Codable {
//    let data: [Area]
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
//struct Area: Codable {
//    let id, cityID, name, status: String
//    let createdAt, updatedAt: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case cityID = "city_id"
//        case name, status
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
//}
