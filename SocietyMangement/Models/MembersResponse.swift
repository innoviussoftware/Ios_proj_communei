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


