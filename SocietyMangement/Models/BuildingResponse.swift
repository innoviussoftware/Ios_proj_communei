//
//  BuildingResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation




// MARK: - City
struct BuildingResponse: Codable {
    let data: [Building]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Building: Codable {
    let id, societyID: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case name
    }
}



