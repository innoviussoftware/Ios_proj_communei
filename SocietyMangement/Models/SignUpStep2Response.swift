//
//  SignUpStep2Response.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation



// MARK: - City
struct SignUpStep2Response: Codable {
    let data: Signup2
    let status: Int
    let message: String
}

// MARK: - DataClass
struct Signup2: Codable {
    let id, societyID: Int?
    let name, email, phone, image: String?
    let fcmToken: String?
    let createdAt, updatedAt, role, token: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case name, email, phone, image
        case fcmToken = "fcm_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case role, token
    }
}



