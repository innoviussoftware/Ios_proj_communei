//
//  AmenitiesModel.swift
//  SocietyMangement
//
//  Created by MacMini on 03/10/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - AmenitiesList
struct AmenitiesList: Codable {
    let data: [AmenitiesListData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct AmenitiesListData: Codable {
    let id, societyID: Int?
    let userID: String?
    let name, address, images,description: String?
    let bookingDate: String?
    let apporve, isBook, status: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case userID = "user_id"
        case name, address, images, description
        case bookingDate = "booking_date"
        case apporve
        case isBook = "is_book"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

