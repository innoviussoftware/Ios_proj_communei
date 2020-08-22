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
    let id: Int?
    let name, phone, gender: String?
    let profession: String?
    let relation, dob, bloodgroup ,image: String?
}

