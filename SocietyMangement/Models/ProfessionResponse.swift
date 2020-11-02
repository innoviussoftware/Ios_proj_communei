//
//  ProfessionResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 29/07/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved//
//   let professionResponse = try? newJSONDecoder().decode(ProfessionResponse.self, from: jsonData)

import Foundation


// MARK: - ProfessionResponse
struct ProfessionResponse: Codable {
    let data: [Profession]
    let status: Bool
    let message: String
}

// MARK: - Datum
struct Profession: Codable {
    let id: Int
    let name: String
    let datumDescription: String?
    let isPublic: Int

    enum CodingKeys: String, CodingKey {
        case id = "ProfessionID"
        case name = "Name"
        case datumDescription = "Description"
        case isPublic = "IsPublic"
    }
}


/*

// MARK: - ProfessionResponse
struct ProfessionResponse: Codable {
    let data: [Profession]
    let status: Int
    let message: String
}

// MARK: - Datum
struct Profession: Codable {
    let id: Int
    let name: String
}

 */

