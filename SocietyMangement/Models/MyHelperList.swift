//
//  MyHelperList.swift
//  SocietyMangement
//
//  Created by MacMini on 14/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - MyHelperListResp
struct MyHelperListResp: Codable {
    let data: [MyHelperListData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct MyHelperListData: Codable {
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
