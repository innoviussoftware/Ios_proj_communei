//
//  SignUpStep2Response.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - SignUpStep2Response
struct SignUpStep2Response: Codable {
    let data: Signup2?
    let status: Int
    let message: String
}

// MARK: - DataClass
struct Signup2: Codable {
    let active: Int?
    let bloodGroupID: Int?
    let dateOfBirth, fcmToken, gender: String?
    let phone: String?
    let professionDetails: String?
    let professionID: Int?
    let qr: String?
    let relation, resident: String?
    let role: String?
    let sinceDevice: String?
    let email, guid, name: String?
    let profilePhotoPath: String?
    let updatedAt, token: String?
    let property: Property?
    let adminNotify: Bool?

    enum CodingKeys: String, CodingKey {
        case active = "Active"
        case bloodGroupID = "BloodGroupID"
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
        case email, guid, name
        case profilePhotoPath = "profile_photo_path"
        case updatedAt = "updated_at"
        case token, property
        case adminNotify = "admin_notify"
    }
}

// MARK: - Property
struct Property: Codable {
    let success: Bool
    let message: String
}

 
/*
// MARK: - City
struct SignUpStep2Response: Codable {
    let data: Signup2?
    let status: String? // Int? // 2/11/20. temp comment
    let message: String?
}

// MARK: - DataClass
struct Signup2: Codable {
    let id, societyID: Int?
    let name, email, Phone, image: String?
    let fcmToken: String?
    let createdAt, updatedAt, role, token: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case name, email, Phone, image
        case fcmToken = "fcm_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case role, token
    }
}

 */


/*
 {
     "data": {
         "0": "Phone already registered with communei"
     },
     "status": 0,
     "message": "Please enter valid data."
 }
 
 */

/*
 
 {
     "data": [],
     "status": 0,
     "message": "You provided invalied data, Please validate your phone number with OTP once again"
 }
 
 */


/*
 
 {
     "data": {
         "Active": 0,
         "BloodGroupID": null,
         "DateOfBirth": null,
         "FCMToken": null,
         "Gender": null,
         "Phone": 9998099631,
         "ProfessionDetails": "Working on backend",
         "ProfessionID": null,
         "Qr": "99f56346-d6ac-4811-bb3d-99eb9a6f2761.svg",
         "Resident": null,
         "Role": "resident",
         "SinceDevice": null,
         "email": "prakash.innovius@gmail.com",
         "guid": "c37b6dad-f1f9-4bca-a523-6ae91c5d7c39",
         "name": "prakash",
         "profile_photo_path": null,
         "updated_at": "2020-10-21T09:19:21.000000Z",
         "token": "BhRP4cIVrtYqgvzoJKNNeZulOo6zfNoHij09hIPh",
         "property": {
             "success": false,
             "message": "Unable to set property, Property is not empty"
         },
         "admin_notify": true
     },
     "status": 1,
     "message": "Successfully signed up for communei, please contact your society admin to activate your account"
 }
 
 */
