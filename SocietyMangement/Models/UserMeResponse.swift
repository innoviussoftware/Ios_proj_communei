//
//  UserMeResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 27/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation

// MARK: - UserMeResponse
struct UserMeResponse: Codable {
    let data: UserMe?
    let status: Int
    let message: String
}

// MARK: - DataClass
struct UserMe: Codable {
    let active, bloodGroupID: Int?
    let bloodGroupName: String?
    let contactStatus: Int?
    let dateOfBirth: String?
    let fcmToken: String?
    let gender: String?
    let memberStatus: Int?
    let phone, professionDetails: String?
    let professionID: Int?
    let professionName, qr: String?
    let relation: String?
    let resident: Int?
    let role: String?
    let sinceDevice: String?
    let society: SocietyNew?
    let userTypeName: String?
    let vehicles: [Vehicle?]
    let email, guid, name, profilePhotoPath: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case active = "Active"
        case bloodGroupID = "BloodGroupID"
        case bloodGroupName = "BloodGroupName"
        case contactStatus = "ContactStatus"
        case dateOfBirth = "DateOfBirth"
        case fcmToken = "FCMToken"
        case gender = "Gender"
        case memberStatus = "MemberStatus"
        case phone = "Phone"
        case professionDetails = "ProfessionDetails"
        case professionID = "ProfessionID"
        case professionName = "ProfessionName"
        case qr = "Qr"
        case relation = "Relation"
        case resident = "Resident"
        case role = "Role"
        case sinceDevice = "SinceDevice"
        case society = "Society"
        case userTypeName = "UserTypeName"
        case vehicles = "Vehicles"
        case email, guid, name
        case profilePhotoPath = "profile_photo_path"
        case updatedAt = "updated_at"
    }
}

// MARK: - Society
struct SocietyNew: Codable {
    let societyID, propertyID, parentPropertyID, propertyTypeID: Int?
    let isCommercial, userTypeID: Int?
    let society, property, parentProperty: String?

    enum CodingKeys: String, CodingKey {
        case societyID = "SocietyID"
        case propertyID = "PropertyID"
        case parentPropertyID = "ParentPropertyID"
        case propertyTypeID = "PropertyTypeID"
        case isCommercial = "IsCommercial"
        case userTypeID = "UserTypeID"
        case society = "Society"
        case property = "Property"
        case parentProperty = "ParentProperty"
    }
}

// MARK: - Vehicle
struct Vehicle: Codable {
    let vehicleID: Int?
    let number: String?
    let numberDigits, vehicleTypeID: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case vehicleID = "VehicleID"
        case number = "Number"
        case numberDigits = "NumberDigits"
        case vehicleTypeID = "VehicleTypeID"
        case type = "Type"
    }
}
