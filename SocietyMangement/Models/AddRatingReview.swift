//
//  AddRatingReview.swift
//  SocietyMangement
//
//  Created by MacMini on 02/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - AddRatingReviewResponse
struct AddRatingReviewResponse: Codable {
    let data: AddRatingReviewData
    let status: Int
    let message: String
}

// MARK: - DataClass
struct AddRatingReviewData: Codable {
    let userID: Int?
    let helperID, ratings, comment, updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case helperID = "helper_id"
        case ratings, comment
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

