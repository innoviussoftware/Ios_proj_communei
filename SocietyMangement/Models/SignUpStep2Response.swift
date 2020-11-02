//
//  SignUpStep2Response.swift
//  SocietyMangement
//
//  Created by MacMini on 26/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation



// MARK: - City
struct SignUpStep2Response: Codable {
    let data: Signup2?
    let status: Int?
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
