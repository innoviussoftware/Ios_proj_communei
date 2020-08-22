//
//  RoleResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 28/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - GetRoleResponse
struct GetRoleResponse: Codable {
    let data: [Role]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

// MARK: - Datum
struct Role: Codable {
    let id, name, status: String
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
