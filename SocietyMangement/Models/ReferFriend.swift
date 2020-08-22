//
//  ReferFriend.swift
//  SocietyMangement
//
//  Created by MacMini on 27/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - ReferFriendModel
struct ReferFriendModel: Codable {
    let data: ReferFriendModelData?
    let status: Int?
    let message: String?
}

// MARK: - DataClass
struct ReferFriendModelData: Codable {
    let userID, societyName, contact, updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case societyName = "society_name"
        case contact
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
