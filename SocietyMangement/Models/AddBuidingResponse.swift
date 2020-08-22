//
//  AddBuidingResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - BuidingResponse
struct BuidingResponse: Codable {
    let data: [AddBuilding]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

// MARK: - Datum
struct AddBuilding: Codable {
    let id, societyID, buildingName, buildingDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case buildingName = "building_name"
        case buildingDescription = "building_description"
    }
}
