//
//  AcceptRejectResponse.swift
//  SocietyMangement
//
//  Created by Innovius on 08/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation



// MARK: - Acce
struct AcceptReject: Codable {
    let data: AcceptRejectData?
    let status: Int
    let message: String
}

// MARK: - DataClass
struct AcceptRejectData: Codable {
    let id, guardID, societyID, buildingID: Int?
    let flatID: Int?
    let name, photos: String?
    let flag: Int?
    let intime, outtime: String?
    let inOutFlag: Int?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case guardID = "guard_id"
        case societyID = "society_id"
        case buildingID = "building_id"
        case flatID = "flat_id"
        case name, photos, flag, intime, outtime, inOutFlag
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


