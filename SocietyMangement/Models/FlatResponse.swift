//
//  FlatResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation


//// MARK: - City
//struct FlatResponse: Codable {
//    let data: [Flat]
//    let status: Int
//    let message: String
//}
//
//// MARK: - Datum
//struct Flat: Codable {
//    let id, buildingID: Int
//    let name: String
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case buildingID = "building_id"
//        case name
//    }
//}


// MARK: - AddRatingReviewResponse
struct FlatResponse: Codable {
    let data: [Flat]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct Flat: Codable {
    let id: Int?
    let name: String?
    let buildingID: Int?
    let booked, bookType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case buildingID = "building_id"
        case booked
        case bookType = "book_type"
    }
}




