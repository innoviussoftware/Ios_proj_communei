//
//  HelperDetailRespon.swift
//  SocietyMangement
//
//  Created by Innovius on 01/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


/*
// MARK: - HelperDetailsResponse
struct HelperDetailsResponse: Codable {
    let data: HelperDetailsData
    let status: Int
    let message: String
}

// MARK: - DataClass
struct HelperDetailsData: Codable {
    let id, societyID: Int?
    let name, pin, mobile, document: String?
    let photos, gender, typename, joinDate: String?
    let ratings: Double?
    let workWithData : [WorkWithDatum]
    let reveiws : [Reveiw]

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case name, pin, mobile, document, photos, gender, typename
        case joinDate = "join_date"
        case ratings
        case workWithData = "work_with_data"
        case reveiws
    }
}

// MARK: - Reveiw
struct Reveiw: Codable {
    let ratings: Double?
    let comment, username: String?
}

// MARK: - WorkWithDatum
struct WorkWithDatum: Codable {
    let name, buildingname, flatname: String?
}*/



// MARK: - AddRatingReviewResponse
struct HelperDetailsResponse: Codable {
    let data: HelperDetailsData
    let status: Int
    let message: String
}

// MARK: - DataClass
struct HelperDetailsData: Codable {
    let id, societyID: Int?
    let name, pin, mobile, document: String?
    let photos, gender, typename, joinDate: String?
    let ratings: Double?
    let workWithData: [WorkWithDatum]?
    let reveiws: [Reveiw]?
    let workWithLoggedInUser: String?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case name, pin, mobile, document, photos, gender, typename
        case joinDate = "join_date"
        case ratings
        case workWithData = "work_with_data"
        case reveiws, workWithLoggedInUser
    }
}

// MARK: - Reveiw
struct Reveiw: Codable {
    let id: Int?
    let ratings: Double?
    let comment, username: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case id, ratings, comment, username
        case userID = "user_id"
    }
}

// MARK: - WorkWithDatum
struct WorkWithDatum: Codable {
    let name, buildingname, flatname: String?
}
