//
//  HelperListResponse.swift
//  SocietyMangement
//
//  Created by Innovius on 01/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

//
//// MARK: - HelperListResp
//struct HelperListResp: Codable {
//    let data: [HelperListData]
//    let status: Int
//    let message: String
//}
//
//// MARK: - Datum
//struct HelperListData: Codable {
//    let id: Int
//    let name, pin, mobile, photos: String?
//    let memberID, gender, createdAt: String?
//    let averageRating: [String]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, pin, mobile, photos
//        case memberID = "Member_id"
//        case gender
//        case createdAt = "created_at"
//        case averageRating = "average_rating"
//    }
//}



// MARK: - HelperListResp
struct HelperListResp: Codable {
    let data: [HelperListData]
    let status: Int
    let message: String
}

// MARK: - Datum
struct HelperListData: Codable {
    let id: Int?
    let name, pin, mobile, photos: String?
    let memberID, gender, createdAt, typename: String?
    let averageRating: Double?

    enum CodingKeys: String, CodingKey {
        case id, name, pin, mobile, photos
        case memberID = "Member_id"
        case gender
        case createdAt = "created_at"
        case typename
        case averageRating = "average_rating"
    }
}


