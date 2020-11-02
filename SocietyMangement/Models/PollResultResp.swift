//
//  PollResultResp.swift
//  SocietyMangement
//
//  Created by MacMini on 25/09/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - PollResultResponse
struct PollResultResponse: Codable {
    let data: PollResultData?
    let status: Int?
    let message: String
}

// MARK: - DataClass
struct PollResultData: Codable {
    let id, societyID: Int?
    let question, a1, a2, a3: String?
    let a4, a1Userid, a2Userid, a3Userid: String?
    let a4Userid, expiresOn: String?
    let active: Int?
    let createdAt, updatedAt: String?
    let percentage1, percentage2, percentage3, percentage4: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case societyID = "society_id"
        case question, a1, a2, a3, a4
        case a1Userid = "a1_userid"
        case a2Userid = "a2_userid"
        case a3Userid = "a3_userid"
        case a4Userid = "a4_userid"
        case expiresOn = "expires_on"
        case active
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case percentage1, percentage2, percentage3, percentage4
    }
}
