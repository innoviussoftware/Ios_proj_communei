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
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct AmenitiesListData: Codable {
    let amenityID, societyID: Int?
    let name, datumDescription, notes: String?
    let amount, status: Int?
    let likeCount, disLikeCount: Int?
    let attachments: [Attachment]?

    enum CodingKeys: String, CodingKey {
        case amenityID = "AmenityID"
        case societyID = "SocietyID"
        case name = "Name"
        case datumDescription = "Description"
        case notes = "Notes"
        case amount = "Amount"
        case status = "Status"
        case likeCount = "LikeCount"
        case disLikeCount = "DisLikeCount"
        case attachments = "Attachments"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let amenityID: Int?
    let attachment: String?

    enum CodingKeys: String, CodingKey {
        case amenityID = "AmenityID"
        case attachment = "Attachment"
    }
}



/*

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

*/
