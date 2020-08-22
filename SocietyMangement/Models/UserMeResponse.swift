//
//  UserMeResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 27/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//
import Foundation


// MARK: - GetFamilyMember
struct UserMeResponse: Codable {
    let data: UserMe?
    let status: Int?
    let message: String
}

// MARK: - DataClass
struct UserMe: Codable {
    let id, societyID: Int?
    let name, email, phone: String?
    let image, qrcode: String?
    let fcmToken, createdAt, updatedAt, role: String?
    let building: String?
    let buildingID: Int?
    let flats, flatType: String?
    let gender, profession, professionDetail, relation , profession_other,society_logo,occupancy: String?
    let dob, bloodgroup: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case name, email, phone, image, qrcode
        case fcmToken = "fcm_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case role, building
        case buildingID = "building_id"
        case flats, flatType, gender, profession
        case professionDetail = "profession_detail"
        case relation, dob, bloodgroup
        case profession_other
        case society_logo
        case occupancy
    }
}



//{
//    "data": {
//        "id": 73,
//        "society_id": 1,
//        "name": "Manish PATEL",
//        "email": "manish@gmail.com",
//        "phone": "9601483912",
//        "image": "user_profile/9t7OZRTrtYrA4RXnz2h31Ppz9vX2ovJSHH4gmY9E.png",
//        "fcm_token": null,
//        "created_at": "2019-10-10 18:58:34",
//        "updated_at": "2019-10-11 15:01:11",
//        "role": "Chairman,Member",
//        "building": "B",
//        "building_id": 2,
//        "flats": "302",
//        "flatType": "Owner",
//        "gender": null,
//        "profession": 0,
//        "profession_detail": "hens house",
//        "relation": null,
//        "dob": null,
//        "bloodgroup": null
//    },
//    "status": 1,
//    "message": "User profile detail."
//}
