//
//  AddCircularResponse.swift
//  SocietyMangement
//
//  Created by MacMini on 01/06/1941 Saka.
//  Copyright © 1941 MacMini. All rights reserved.
//

import Foundation

// MARK: - AddCircularResponse
struct AddCircularResponse: Codable {
    let data: [AddCircular]
    let errorCode: Int
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case errorCode = "error_code"
        case message
    }
}

// MARK: - Datum
struct AddCircular: Codable {
    let id, memberID, societyID, buildingID: String
    let title, datumDescription, pdffile, status: String
    let createdDate, updatedDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case memberID = "member_id"
        case societyID = "society_id"
        case buildingID = "building_id"
        case title
        case datumDescription = "description"
        case pdffile, status
        case createdDate = "created_date"
        case updatedDate = "updated_date"
}
}
