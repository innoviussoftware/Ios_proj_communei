//
//  GuestListResp.swift
//  SocietyMangement
//
//  Created by Innovius on 09/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation



//// MARK: - GetGuestList
//struct GuestListResponse: Codable {
//    let data: [guestData]?
//    let status: Int
//    let message: String
//}
//
//// MARK: - Datum
//struct guestData: Codable {
//    let id: Int?
//    let name, photos, flatname: String?
//    let buildingname: String?
//    let flag: Int?
//    let intime, outtime: String?
//    let inOutFlag: Int?
//    let createAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, photos, flatname, buildingname, flag
//        case intime = "Intime"
//        case outtime = "Outtime"
//        case inOutFlag
//        case createAt = "create_at"
//    }
//}
//


// MARK: - Welcome
struct GuestListResponse: Codable {
    let data: [guestData]?
    let status: Int
    let message: String
}

// MARK: - Datum
struct guestData: Codable {
    let id: Int?
    let name, photos, code, flatname: String?
    let buildingname: String?
    let flag: Int?
    let guard_id: Int?
    let intime, outtime: String?
    let inOutFlag: Int?
    let type: String?
    let createAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, photos, code, flatname, buildingname, flag
        case intime = "intime"
        case outtime = "Outtime"
        case inOutFlag, type
        case createAt = "create_at"
        case guard_id
    }
}


