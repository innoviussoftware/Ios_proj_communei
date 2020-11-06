//
//  FamilyMemberResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 27/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation


// MARK: - GetFamilyMember
struct GetFamilyMember: Codable {
    let data: [FamilyMember]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct FamilyMember: Codable {
    let active, bloodGroupID: Int?
    let bloodGroupName, dateOfBirth: String?
    let fcmToken: String?
    let gender, phone, professionDetails: String?
    let professionID: Int?
    let professionName, qr, relation, resident: String?
    let role: String?
    let sinceDevice: String?
    let email, guid, name: String?
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
        case email, guid, name
        case profilePhotoPath = "profile_photo_path"
        case updatedAt = "updated_at"
    }
}


/*
// MARK: - GetFamilyMember
struct GetFamilyMember: Codable {
    let data: [FamilyMember]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct FamilyMember: Codable {
    let id: Int?
    let name, phone, gender: String?
    let profession: String?
    let relation, dob, bloodgroup ,image: String?
}

*/
