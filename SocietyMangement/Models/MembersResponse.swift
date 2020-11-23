//
//  MembersResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 04/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let memberResponse = try? newJSONDecoder().decode(MemberResponse.self, from: jsonData)



import Foundation



// MARK: - MembersResponse
struct MembersResponse: Codable {
    let data: [Members]?
    let status: Int?
    let message: String?
}

// MARK: - Datum
struct Members: Codable {
    let active, bloodGroupID, contactStatus: Int?
    let dateOfBirth, fcmToken: String?
    let gender: String?
    let memberStatus: Int?
    let phone: String?
    let professionDetails: String?
    let professionID: Int?
    let qr: String?
    let relation: String?
    let resident: Int?
    let role: String?
    let sinceDevice: String?
    let society: SocietyMembers?
    let userTypeName: String?
    let vehicles: [VehicleMembers]?
    let email, guid, name: String?
    let profilePhotoPath: String?
    let updatedAt: String?
    let bloodGroupName, professionName: String?

    enum CodingKeys: String, CodingKey {
        case active = "Active"
        case bloodGroupID = "BloodGroupID"
        case contactStatus = "ContactStatus"
        case dateOfBirth = "DateOfBirth"
        case fcmToken = "FCMToken"
        case gender = "Gender"
        case memberStatus = "MemberStatus"
        case phone = "Phone"
        case professionDetails = "ProfessionDetails"
        case professionID = "ProfessionID"
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
        case bloodGroupName = "BloodGroupName"
        case professionName = "ProfessionName"
    }
}





// MARK: - SocietyClass
struct SocietyMembers: Codable {
    let societyID, propertyID, parentPropertyID, propertyTypeID: Int?
    let isCommercial, userTypeID: Int?
    let society: String?
    let areaID, cityID: Int?
    let property: String?
    let parentProperty: String?

    enum CodingKeys: String, CodingKey {
        case societyID = "SocietyID"
        case propertyID = "PropertyID"
        case parentPropertyID = "ParentPropertyID"
        case propertyTypeID = "PropertyTypeID"
        case isCommercial = "IsCommercial"
        case userTypeID = "UserTypeID"
        case society = "Society"
        case areaID = "AreaID"
        case cityID = "CityID"
        case property = "Property"
        case parentProperty = "ParentProperty"
    }
}


// MARK: - Vehicle
struct VehicleMembers: Codable {
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




/*
// MARK: - GetFamilyMember
struct MembersResponse: Codable {
    let data: [Members]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Members: Codable {
    let id, userID, societyID, buildingID ,contact_status,member_status: Int?
    let flatID: Int
    let flatType, gender, profession, professionDetail: String?
    let relation, dob, bloodgroup: String?
    let name, phone: String
    let email: String?
    let image: String?
    let flatname, buildingname, role, createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case societyID = "society_id"
        case buildingID = "building_id"
        case flatID = "flat_id"
        case flatType, gender, profession
        case professionDetail = "profession_detail"
        case relation, dob, bloodgroup, name, phone, email, image, flatname, buildingname, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case contact_status
        case member_status
    }
}


*/
