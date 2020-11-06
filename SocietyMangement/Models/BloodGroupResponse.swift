//
//  BloodGroupResponse.swift
//  SocietyMangement
//
//  Created by prakash soni on 22/10/20.
//  Copyright © 2020 MacMini. All rights reserved.
//

import Foundation


// MARK: - Welcome
struct BloodGroupResponse: Codable {
    let data: [BloodGroup]
    let status: Int
    let message: String
}

// MARK: - Datum
struct BloodGroup: Codable {
    let id: Int
    let name: String
    let datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id = "BloodGroupID"
        case name = "Name"
        case datumDescription = "Description"
    }
}
