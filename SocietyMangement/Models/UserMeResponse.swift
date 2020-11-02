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
    let status: Bool
    let message: String
}

// MARK: - DataClass
struct UserMe: Codable {
    let active, bloodGroupID: Int?
    let bloodGroupName, dateOfBirth: String?
    let fcmToken: String?
    let gender, phone, professionDetails: String?
    let professionID, resident: Int?
    let professionName: String?
    let qr: String?
    let relation: String?
    let role: String?
    let sinceDevice: String?
    let society: SocietyNew?
    let userTypeName, guid: String?
    let name, email: String?
    let profilePhotoPath, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case active = "Active"
        case bloodGroupID = "BloodGroupID"
        case bloodGroupName = "BloodGroupName"
        case dateOfBirth = "DateOfBirth"
        case fcmToken = "FCMToken"
        case gender = "Gender"
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


/*

struct UserMeResponse: Codable {
    let data: UserMe?
    let status: Bool
    let message: String
}

// MARK: - DataClass
struct UserMe: Codable {
    let active: Int?
    let bloodGroupID: Int?
    let bloodGroupName: String?
    let dateOfBirth, fcmToken, gender: String?
    let phone: String
    let professionDetails: String?
    let professionID: Int  // String
    let qr: String
    let relation: String?
    let resident: String?
    let role: String?
    let sinceDevice: String?
    let society: SocietyNew?
    let userTypeName, guid: String?
    let name, email: String
    let profilePhotoPath: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case active = "Active"
        case bloodGroupID = "BloodGroupID"
        case bloodGroupName = "BloodGroupName"
        case dateOfBirth = "DateOfBirth"
        case fcmToken = "FCMToken"
        case gender = "Gender"
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
        case email, guid, name
        case profilePhotoPath = "profile_photo_path"
        case updatedAt = "updated_at"
    }
}

// MARK: - Society
struct SocietyNew: Codable {
    let societyID, propertyID, parentPropertyID, propertyTypeID: Int
    let isCommercial, userTypeID: Int
    let society, property, parentProperty: String

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

*/

/*
 
 {
     "data": {
         "Active": 1,
         "BloodGroupID": 2,
         "BloodGroupName": "A-",
         "DateOfBirth": "2020-10-08 00:00:00",
         "FCMToken": null,
         "Gender": "Male",
         "Phone": "9988888888",
         "ProfessionDetails": "Cenima actor",
         "ProfessionID": 5,
         "ProfessionName": "Actor",
         "Qr": "public/qrs/users/01896d22-8efe-4761-8d2c-938fe578235e.svg",
         "Relation": null,
         "Resident": null,
         "Role": "resident",
         "SinceDevice": null,
         "Society": {
             "SocietyID": 5,
             "PropertyID": 842,
             "ParentPropertyID": 10,
             "PropertyTypeID": 7,
             "IsCommercial": 1,
             "UserTypeID": 1,
             "Society": "Vasantha Valley",
             "Property": "1",
             "ParentProperty": "Common Area 1"
         },
         "UserTypeName": "Resident Owner",
         "email": "pd@gmail.com",
         "guid": "69c6200c-3d8d-47e1-bcea-2771422ccc79",
         "name": "prince",
         "profile_photo_path": "public/profile-photos/0e33f907-4dad-4670-9935-6880b3fecf21.png",
         "updated_at": "2020-10-28T05:06:06.000000Z"
     },
     "status": true,
     "message": "User profile details"
 }
 
 */
