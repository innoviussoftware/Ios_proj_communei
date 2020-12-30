//
//  HelperDetailRespon.swift
//  SocietyMangement
//
//  Created by Innovius on 01/08/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - HelperDetailsResponse
struct HelperDetailsResponse: Codable {
    let data: HelperDetailsData
    let status: Int
    let message: String
}

// MARK: - DataClass
struct HelperDetailsData: Codable {
    let name, phoneNumber: String
    let profilePicture: String
    let comments: [Comment]
    let societyWorkingSince: String
    let visitorEntryTypeID: Int
    let rating, punctual, regular, clean: String
    let attitude, skilled, vendorServiceType: String
    let vendorServiceTypeID: Int
    let dailyHelpPropertyID: String
    let dailyHelperID: Int
    let props: [Prop]?
    let workingWithMe: Int

    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case phoneNumber = "PhoneNumber"
        case profilePicture = "ProfilePicture"
        case comments = "Comments"
        case societyWorkingSince = "SocietyWorkingSince"
        case visitorEntryTypeID = "VisitorEntryTypeID"
        case rating = "Rating"
        case punctual = "Punctual"
        case regular = "Regular"
        case clean = "Clean"
        case attitude = "Attitude"
        case skilled = "Skilled"
        case vendorServiceType = "VendorServiceType"
        case vendorServiceTypeID = "VendorServiceTypeID"
        case dailyHelpPropertyID = "DailyHelpPropertyID"
        case dailyHelperID = "DailyHelperID"
        case props = "Props"
        case workingWithMe = "WorkingWithMe"
    }
}

// MARK: - Comment
struct Comment: Codable {
    let vendorServiceTypeID, vendorServiceType, propertyID, commentedByID: String
    let commentedBy, comment, commentID, canEdit: String
    let rating, dailyHelpPropertyID, propertyFullName: String
    let addedByMe: Int

    enum CodingKeys: String, CodingKey {
        case vendorServiceTypeID = "VendorServiceTypeID"
        case vendorServiceType = "VendorServiceType"
        case propertyID = "PropertyID"
        case commentedByID = "CommentedByID"
        case commentedBy = "CommentedBy"
        case comment = "Comment"
        case commentID = "CommentID"
        case canEdit = "CanEdit"
        case rating = "Rating"
        case dailyHelpPropertyID = "DailyHelpPropertyID"
        case propertyFullName = "PropertyFullName"
        case addedByMe = "AddedByMe"
    }
}

// MARK: - Prop
struct Prop: Codable {
    let vendorServiceTypeID, vendorServiceType, propertyID, addedBy: String
    let numberOfTimesRecruited, propertyWorkingSince, propertyFullName: String

    enum CodingKeys: String, CodingKey {
        case vendorServiceTypeID = "VendorServiceTypeID"
        case vendorServiceType = "VendorServiceType"
        case propertyID = "PropertyID"
        case addedBy = "AddedBy"
        case numberOfTimesRecruited = "NumberOfTimesRecruited"
        case propertyWorkingSince = "PropertyWorkingSince"
        case propertyFullName = "PropertyFullName"
    }
}



/*
 

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

 
 */
